@extends('layouts.home')

@section('title', 'Cart')

@section('content')
<div class="container">
    <h2>Shopping Cart</h2>
    <table class="table">
        <thead>
            <tr>
                <th>Product</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Total</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            @forelse($cartItems as $item)
                <tr>
                    <td>{{ $item->product->name }}</td>
                    <td>{{ $item->qty }}</td>
                    <td>Rp {{ number_format($item->product->price, 2, ',', '.') }}</td>
                    <td>Rp {{ number_format($item->product->price * $item->qty, 2, ',', '.') }}</td>
                    <td>
                        <form action="{{ route('cart.remove', $item->id) }}" method="POST" class="remove-form">
                            @csrf
                            @method('DELETE')
                            <button type="submit" class="btn btn-danger remove-from-cart" data-cart-item-id="{{ $item->id }}">Remove</button>
                        </form>
                    </td>
                </tr>
            @empty
                <tr>
                    <td colspan="5">Your cart is empty</td>
                </tr>
            @endforelse
        </tbody>
    </table>
    <div class="row">
        <div class="col-md-6 offset-md-6">
            <h3>Total Payment: Rp {{ number_format($totalPayment, 2, ',', '.') }}</h3>
        </div>
    </div>
    <a href="{{ route('cart.checkout') }}" class="btn btn-warning">Checkout</a>
</div>
@endsection
@push('scripts')
    <script>
        $(document).on('submit', '.remove-form', function(e) {
            e.preventDefault();

            var form = $(this);
            var cartItemId = form.find('.remove-from-cart').data('cart-item-id');

            $.ajax({
                url: form.attr('action'),
                type: 'POST',
                data: form.serialize(),
                success: function(response) {
                    if (response.success) {
                        $('#cart-item-' + cartItemId).remove();
                        
                        updateCartCount();

                        Swal.fire({
                            icon: 'success',
                            title: 'Item removed from cart',
                            showConfirmButton: false,
                            timer: 1500
                        }).then(() => {
                            window.location.href = "{{ route('cart.show') }}";
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Oops...',
                            text: 'Item could not be removed',
                        });
                    }
                },
                error: function(xhr) {
                    console.log(xhr.responseText);
                    alert('Error: ' + xhr.responseText);
                }
            });
        });

        // function updateCartCount() {
        //     // Update cart count logic here
        // }
    </script>
@endpush