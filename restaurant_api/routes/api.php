<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\MenuController;
use App\Http\Controllers\Api\PaymentController;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::get('menus', [MenuController::class, 'index']);

Route::post('/payment/create-order', [PaymentController::class, 'createOrder']);
Route::post('/payment/verify-payment', [PaymentController::class, 'verifyPayment']);
Route::get('/payment/track-order/{orderId}', [PaymentController::class, 'trackOrder']);
Route::post('/payment/rate-order/{orderId}', [PaymentController::class, 'rateOrder']);
