<?php

use Illuminate\Support\Facades\Route;

Route::prefix('admin')->name('admin.')->group(function () {
    Route::resource('menus', \App\Http\Controllers\Admin\MenuController::class);
    Route::resource('orders', \App\Http\Controllers\Admin\OrderController::class)->only(['index', 'update']);
    Route::delete('orders/{order}/clear-feedback', [\App\Http\Controllers\Admin\OrderController::class, 'clearFeedback'])->name('orders.clearFeedback');
});
