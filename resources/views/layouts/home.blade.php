<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>@yield('title')</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css" rel="stylesheet">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        .product-card {
            margin-bottom: 20px;
        }
        .cart-icon {
            font-size: 24px;
        }
        .cart-badge {
            position: absolute;
            top: 0;
            right: 0;
            transform: translate(50%, -50%);
            background-color: red;
            color: white;
            border-radius: 50%;
            padding: 2px 6px;
            font-size: 12px;
        }
        #loginModal .modal-body {
            max-height: 500px;
            overflow-y: auto;
        }
    </style>
    @stack('styles')
</head>
<body>
    <header>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid">
                <a class="navbar-brand" href="{{ route('home') }}">E-Commerce</a>
                <div class="d-flex justify-content-end w-100">
                    @auth
                        <span class="navbar-text me-3">Hello, {{ Auth::user()->name }}!</span>
                    @endauth
                    <a href="{{ route('cart.show') }}" class="btn btn-outline-dark position-relative">
                        <i class="fas fa-shopping-cart cart-icon"></i>
                        <span id="cart-count" class="cart-badge">{{ count(Session::get('cart', [])) }}</span>
                    </a>
                </div>
            </div>
        </nav>
    </header>

    <main class="container mt-4">
        @yield('content')
    </main>

    <!-- Modal -->
    <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="loginModalLabel">Login / Register</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div id="loginFormContainer">
                        <form id="loginForm">
                            @csrf
                            <div class="mb-3">
                                <label for="loginEmail" class="form-label">Email address</label>
                                <input type="email" class="form-control" id="loginEmail" required>
                            </div>
                            <div class="mb-3">
                                <label for="loginPassword" class="form-label">Password</label>
                                <input type="password" class="form-control" id="loginPassword" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Login</button>
                        </form>
                        <hr>
                        <p>Don't have an account? <a href="#" id="showRegisterForm">Register here</a></p>
                    </div>
                    <div id="registerFormContainer" style="display: none;">
                        <form id="registerForm">
                            @csrf
                            <div class="mb-3">
                                <label for="registerName" class="form-label">Name</label>
                                <input type="text" class="form-control" id="registerName" required>
                            </div>
                            <div class="mb-3">
                                <label for="registerEmail" class="form-label">Email address</label>
                                <input type="email" class="form-control" id="registerEmail" required>
                            </div>
                            <div class="mb-3">
                                <label for="registerPassword" class="form-label">Password</label>
                                <input type="password" class="form-control" id="registerPassword" required>
                            </div>
                            <input type="hidden" id="registerRole" value="customer">
                            <button type="submit" class="btn btn-primary btn-register">Register</button>
                        </form>
                        <hr>
                        <p>Already have an account? <a href="#" id="showLoginForm">Login here</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"></script>
    <script>
        function updateCartCount() {
            $.ajax({
                url: "{{ route('cart.count') }}",
                type: 'GET',
                success: function(response) {
                    $('#cart-count').text(response.cart_count);
                },
                error: function(xhr) {
                    console.log(xhr.responseText);
                    alert('Error: ' + xhr.responseText);
                }
            });
        }

        $(document).ready(function() {
            updateCartCount();

            $('#showRegisterForm').click(function(e) {
                e.preventDefault();
                $('#loginFormContainer').hide();
                $('#registerFormContainer').show();
            });

            $('#showLoginForm').click(function(e) {
                e.preventDefault();
                $('#registerFormContainer').hide();
                $('#loginFormContainer').show();
            });

            $('#loginForm').submit(function(e) {
                e.preventDefault();

                $.ajax({
                    url: "{{ route('login') }}",
                    type: 'POST',
                    data: {
                        email: $('#loginEmail').val(),
                        password: $('#loginPassword').val(),
                        _token: $('meta[name="csrf-token"]').attr('content')
                    },
                    success: function(response) {
                        if (response.success) {
                            $('#loginModal').modal('hide');
                            updateCartCount();
                            Swal.fire({
                                icon: 'success',
                                title: 'Logged in successfully',
                                showConfirmButton: false,
                                timer: 1500
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Oops...',
                                text: response.message,
                            });
                        }
                    },
                    error: function(xhr) {
                        console.log(xhr.responseText);
                        alert('Error: ' + xhr.responseText);
                    }
                });
            });

            $('#registerForm').submit(function(e) {
                e.preventDefault();

                $.ajax({
                    url: "{{ route('register') }}",
                    type: 'POST',
                    data: {
                        name: $('#registerName').val(),
                        email: $('#registerEmail').val(),
                        password: $('#registerPassword').val(),
                        role: $('#registerRole').val(),
                        _token: $('meta[name="csrf-token"]').attr('content')
                    },
                    success: function(response) {
                        if (response.success) {
                            $('#registerFormContainer').hide();
                            $('#loginFormContainer').show();
                            Swal.fire({
                                icon: 'success',
                                title: 'Registered successfully',
                                showConfirmButton: false,
                                timer: 1500
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Oops...',
                                text: response.message,
                            });
                        }
                    },
                    error: function(xhr) {
                        console.log(xhr.responseText);
                        alert('Error: ' + xhr.responseText);
                    }
                });
            });

            // Event listener untuk tombol "Add to Cart"
            $(document).on('click', '.add-to-cart', function(e) {
                e.preventDefault();

                var productId = $(this).data('product-id');
                var quantity = $(this).siblings('.input-group').find('.quantity-input').val();

                $.ajax({
                    url: "{{ route('cart.add') }}",
                    type: 'POST',
                    data: {
                        product_id: productId,
                        quantity: quantity,
                        _token: $('meta[name="csrf-token"]').attr('content')
                    },
                    success: function(response) {
                        if (response.success) {
                            updateCartCount();
                            Swal.fire({
                                icon: 'success',
                                title: 'Product added to cart',
                                showConfirmButton: false,
                                timer: 1500
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Oops...',
                                text: response.message,
                            });
                        }
                    },
                    error: function(xhr) {
                        console.log(xhr.responseText);
                        alert('Error: ' + xhr.responseText);
                    }
                });
            });

            // Event listener untuk tombol "Decrement" quantity
            $(document).on('click', '.decrement-qty', function() {
                var $input = $(this).siblings('.quantity-input');
                var quantity = parseInt($input.val());
                if (quantity > 1) {
                    $input.val(quantity - 1);
                }
            });

            // Event listener untuk tombol "Increment" quantity
            $(document).on('click', '.increment-qty', function() {
                var $input = $(this).siblings('.quantity-input');
                var maxQty = parseInt($input.attr('max'));
                var quantity = parseInt($input.val());
                if (quantity < maxQty) {
                    $input.val(quantity + 1);
                }
            });
        });
    </script>
    @stack('scripts')
</body>
</html>
