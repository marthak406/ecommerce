@extends('layouts.home')

@section('title', 'Payment')

@section('content')
<div class="container">
    <h2>Checkout</h2>
    <hr>

    <div class="mb-4">
        <h4>Shipping Address</h4>
        <p><strong>Name:</strong> {{ Auth::user()->name }}</p>
        <p><strong>Email:</strong> {{ Auth::user()->email }}</p>
    </div>

    <h4>Cart Items</h4>
    <table class="table">
        <thead>
            <tr>
                <th>Product</th>
                <th>Qty</th>
                <th class="text-center">Price</th>
                <th class="text-center">Total</th>
            </tr>
        </thead>
        <tbody>
            @foreach($cartItems as $item)
                <tr>
                    <td>{{ $item->product->name }}</td>
                    <td>{{ $item->qty }}</td>
                    <td class="text-end">Rp {{ number_format($item->product->price, 2, ',', '.') }}</td>
                    <td class="text-end">Rp {{ number_format($item->total, 2, ',', '.') }}</td>
                </tr>
            @endforeach
            <tr>
                <td colspan="3" ><strong>Total Payment</strong></td>
                <td class="text-end"><strong>Rp {{ number_format($totalAmount, 2, ',', '.') }}</strong></td>
            </tr>
        </tbody>
    </table>

    <div class="mb-4">
        <h4>Delivery Service</h4>
        <p><strong>JNE</strong></p>
    </div>

    <form id="payment-form">
        <input type="hidden" id="snap-token" value="{{ $snapToken }}">
        <button type="button" id="pay-button" class="btn btn-success">Pay Now</button>
    </form>
</div>

@push('scripts')
<script src="https://app.sandbox.midtrans.com/snap/snap.js" data-client-key="{{ config('services.midtrans.client_key') }}"></script>
<script type="text/javascript">
    var payButton = document.getElementById('pay-button');
    payButton.addEventListener('click', function () {
        var snapToken = document.getElementById('snap-token').value;
        snap.pay(snapToken, {
            onSuccess: function(result){
                console.log(result);
            },
            onPending: function(result){
                console.log(result);
            },
            onError: function(result){
                console.log(result);
            },
            onClose: function(){
                console.log('customer closed the popup without finishing the payment');
            }
        });
    });
</script>
@endpush

@endsection
