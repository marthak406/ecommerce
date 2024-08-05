<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Admin\Auth\LoginController as AdminLoginController;
use App\Http\Controllers\Admin\DashboardController;
use App\Http\Controllers\Admin\ProductController;
use App\Http\Controllers\CartController;
use App\Http\Controllers\AuthController;
use App\Http\Middleware\CheckRole;


Route::get('/', [ProductController::class, 'home'])->name('home');
Route::get('/products/{id}', [ProductController::class, 'show'])->name('show');

//cart
Route::get('/cart/count', [CartController::class, 'getCartCount'])->name('cart.count');
Route::get('/cart', [CartController::class, 'showCart'])->name('cart.show');
Route::post('/cart/add', [CartController::class, 'addToCart'])->name('cart.add');
Route::delete('/cart/remove/{id}', [CartController::class, 'removeFromCart'])->name('cart.remove');

//login | register customer
Route::post('/signin', [AuthController::class, 'login'])->name('signin'); // untuk customer
Route::post('/register', [AuthController::class, 'register'])->name('register');

// untuk admin
Route::prefix('admin')->group(function () {
    Route::get('/', [AdminLoginController::class, 'showLoginForm'])->name('login');
    Route::post('/login', [AdminLoginController::class, 'login'])->name('admin.login.submit');
    Route::post('/logout', [AdminLoginController::class, 'logout'])->name('admin.logout');

    Route::middleware(['auth:admin',CheckRole::class.':admin'])->group(function () {
        Route::get('/dashboard', [DashboardController::class, 'index'])->name('admin.dashboard');
        Route::resource('/products', ProductController::class);
    });
});