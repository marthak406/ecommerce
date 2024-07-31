@extends('layouts.app')

@section('title', 'Data Products')

@section('content')
<div class="card border-0 shadow-sm rounded">
    <div class="card-body">
        <a href="{{ route('products.create') }}" class="btn btn-md btn-success mb-3">ADD PRODUCT</a>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th scope="col">IMAGE</th>
                    <th scope="col">Name</th>
                    <th scope="col">PRICE</th>
                    <th scope="col">STOCK</th>
                    <th scope="col">STATUS</th>
                    <th scope="col" style="width: 20%">ACTIONS</th>
                </tr>
            </thead>
            <tbody>
                @forelse ($products as $product)
                    <tr>
                        <td class="text-center">
                            <img src="{{ asset('/storage/products/'.$product->image) }}" class="rounded" style="width: 150px">
                        </td>
                        <td>{{ $product->name }}</td>
                        <td>{{ "Rp " . number_format($product->price,2,',','.') }}</td>
                        <td>{{ $product->stock }}</td>
                        <td>{{ $product->status }}</td>
                        <td class="text-center">
                            <form onsubmit="return confirm('Are you sure ?');" action="{{ route('products.destroy', $product->id) }}" method="POST">
                                <a href="{{ route('products.edit', $product->id) }}" class="btn btn-sm btn-primary">EDIT</a>
                                @csrf
                                @method('DELETE')
                                <button type="submit" class="btn btn-sm btn-danger">DELETE</button>
                            </form>
                        </td>
                    </tr>
                @empty
                    <div class="alert alert-danger">
                        Data Products is not available.
                    </div>
                @endforelse
            </tbody>
        </table>
        {{ $products->links() }}
    </div>
</div>
@endsection
