@php
use Illuminate\Support\Str;
@endphp

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .product-card {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <header>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="{{ route('home') }}">E-Commerce</a>
        </nav>
    </header>

    <main class="container mt-4">
        <h1>Available Products</h1>
        <div class="row">
            @forelse($products as $product)
                <div class="col-md-4">
                    <div class="card product-card">
                        <img src="{{ asset('/storage/products/'.$product->image) }}" class="card-img-top" alt="{{ $product->name }}">
                        <div class="card-body">
                            <h5 class="card-title">{{ $product->name }}</h5>
                            <code>
                                <p class="card-text">{{ Str::limit(strip_tags($product->description), 100) }}</p>
                            </code>
                            <p class="card-text"><strong>Price:</strong> {{ "Rp " . number_format($product->price,2,',','.') }}</p>
                            <p class="card-text"><strong>Stock:</strong> {{ $product->stock }}</p>
                            @if($product->stock == 0)
                                <button type="button" class="btn btn-primary" disabled>Add to Cart</button>
                            @else
                                <a href="#" class="btn btn-primary" >Add to Cart</a>
                            @endif
                            <a href="{{ route('show', $product->id) }}" class="btn btn-dark">Show</a>
                        </div>
                    </div>
                </div>
            @empty
                <p>No products available.</p>
            @endforelse
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"></script>
</body>
</html>
