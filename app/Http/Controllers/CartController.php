<?php 

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\CartItem;
use App\Models\Product;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Midtrans\Snap;
use Midtrans\Config;

class CartController extends Controller
{
    public function getCartCount()
    {
        $userId = Auth::id();
        $cartCount = CartItem::where('user_id', $userId)->where('status', 'unpaid')->sum('qty');
        return response()->json(['cart_count' => $cartCount]);
    }

    public function addToCart(Request $request)
    {
        if (!Auth::check()) {
            return response()->json(['error' => 'User not authenticated'], 401);
        }
        
        $user = Auth::user();
        $product = Product::find($request->product_id);
        $quantity = $request->quantity;
        $total = $product->price * $quantity;

        CartItem::create([
            'user_id' => $user->id,
            'product_id' => $request->product_id,
            'qty' => $quantity,
            'total' => $total,
            'status' => 'unpaid'
        ]);

        $cartCount = CartItem::where('user_id', $user->id)->where('status', 'unpaid')->count();

        return response()->json(['success' => true, 'cart_count' => $cartCount]);
    }

    public function showCart()
    {
        $user = Auth::user();
        
        if (!$user) {
            return redirect()->route('home')->with('error', 'You need to login to view the cart.');
        }

        $cartItems = CartItem::where('user_id', $user->id)->where('status', 'unpaid')->get();
        $totalPayment = $cartItems->sum('total');

        return view('cart.show', compact('cartItems', 'totalPayment'));
    }

    public function removeFromCart(Request $request, $id) 
    {
        $user = Auth::user();

        $cartItem = CartItem::where('user_id', $user->id)
                             ->where('id', $id) 
                             ->where('status', 'unpaid')
                             ->first();

        if ($cartItem) {
            $cartItem->delete();
            
            $cartCount = CartItem::where('user_id', $user->id)
                                 ->where('status', 'unpaid')
                                 ->count();

            return response()->json(['success' => true, 'cart_count' => $cartCount]);
        }

        return response()->json(['success' => false], 404);
    }

    public function checkout(Request $request)
    {
        // Set konfigurasi Midtrans
        Config::$serverKey = config('services.midtrans.server_key');
        Config::$isProduction = config('services.midtrans.is_production');
        Config::$isSanitized = true;
        Config::$is3ds = true;

        $user = Auth::user();
        $cartItems = CartItem::where('user_id', $user->id)->where('status', 'unpaid')->get();

        $totalAmount = $cartItems->sum('total');
        $transactionDetails = [
            'order_id' => uniqid(),
            'gross_amount' => $totalAmount,
        ];

        $itemDetails = $cartItems->map(function ($item) {
            return [
                'id' => $item->product_id,
                'price' => $item->product->price,
                'quantity' => $item->qty,
                'name' => $item->product->name,
            ];
        })->toArray();

        $customerDetails = [
            'first_name' => $user->name,
            'email' => $user->email,
        ];

        $transaction = [
            'transaction_details' => $transactionDetails,
            'item_details' => $itemDetails,
            'customer_details' => $customerDetails,
        ];

        try {
            $snapToken = Snap::getSnapToken($transaction);
            return view('cart.checkout', compact('cartItems', 'totalAmount', 'snapToken'));
        } catch (\Exception $e) {
            return back()->with('error', 'Something went wrong. Please try again.');
        }
    }

    public function handleNotification(Request $request)
    {
        $notification = $request->all();

        Log::info('Midtrans notification: ', $notification);

        $orderId = $notification['order_id'];
        $transactionStatus = $notification['transaction_status'];

        if (in_array($transactionStatus, ['capture', 'settlement'])) {
            $cartItems = CartItem::where('order_id', $orderId)
                                ->where('status', 'unpaid')
                                ->get();

            foreach ($cartItems as $cartItem) {
                $cartItem->update(['status' => 'paid']);

                // Reduce the product stock
                $product = Product::find($cartItem->product_id);
                if ($product) {
                    $product->stock -= $cartItem->qty;
                    $product->save();
                }
            }
        } elseif (in_array($transactionStatus, ['deny', 'expire', 'cancel'])) {
            CartItem::where('order_id', $orderId)
                    ->where('status', 'unpaid')
                    ->update(['status' => 'unpaid']);
        }

        return response()->json(['status' => 'success']);
    }
}
