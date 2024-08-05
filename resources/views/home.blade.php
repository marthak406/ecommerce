@extends('layouts.home')

@section('title', 'Home')

@section('content')
    <h1>Available Products</h1>
    <div class="row">
        @forelse($products as $product)
            <div class="col-md-4">
                <div class="card product-card">
                    <img src="{{ asset('/storage/products/'.$product->image) }}" class="card-img-top" alt="{{ $product->name }}" style="max-height: 200px; object-fit: cover;">
                    <div class="card-body">
                        <h5 class="card-title">{{ $product->name }}</h5>
                        <p class="card-text">{{ Str::limit(strip_tags($product->description), 100) }}</p>
                        <p class="card-text"><strong>{{ "Rp " . number_format($product->price,2,',','.') }}</strong></p>
                        <p class="card-text"><strong>Stock:</strong> {{ $product->stock }}</p>
                        <div class="input-group mb-3">
                            <button class="btn btn-outline-secondary decrement-qty" type="button">-</button>
                            <input type="number" class="form-control quantity-input" value="1" min="1" max="{{ $product->stock }}">
                            <button class="btn btn-outline-secondary increment-qty" type="button">+</button>
                        </div>
                        @if($product->stock == 0)
                            <button type="button" class="btn btn-primary" disabled>Add to Cart</button>
                        @else
                            <a href="#" class="btn btn-primary add-to-cart" data-product-id="{{ $product->id }}">Add to Cart</a>
                        @endif
                        <a href="{{ route('show', $product->id) }}" class="btn btn-dark">Show</a>
                    </div>
                </div>
            </div>
        @empty
            <p>No products available.</p>
        @endforelse
    </div>
@endsection


