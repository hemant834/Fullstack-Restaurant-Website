<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    protected $fillable = [
        'order_id',
        'payment_id',
        'signature',
        'status',
        'amount',
        'delivery_type',
        'address',
        'delivery_status',
        'rating',
        'feedback',
        'items'
    ];

    protected $casts = [
        'items' => 'array',
    ];
}
