<?php 

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\CartItem;
use App\Models\Product;
use Illuminate\Support\Facades\Auth;

class CartController extends Controller
{
    public function addToCart(Request $request)
    {
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
        $cartItems = CartItem::where('user_id', $user->id)->where('status', 'unpaid')->get();
        return view('cart.show', compact('cartItems'));
    }

    public function removeFromCart(Request $request)
    {
        $user = Auth::user();
        $cartItem = CartItem::where('user_id', $user->id)
                             ->where('id', $request->cart_item_id)
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

    public function checkout()
    {
        // Integrasi dengan Midtrans akan dilakukan di sini
    }
}
