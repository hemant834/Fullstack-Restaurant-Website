<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Models\Order;

class OrderController extends Controller
{
    public function index()
    {
        $orders = Order::latest()->paginate(10);
        return view('admin.orders.index', compact('orders'));
    }

    public function update(Request $request, Order $order)
    {
        $request->validate([
            'delivery_status' => 'required|in:pending,preparing,out_for_delivery,delivered'
        ]);

        $order->update(['delivery_status' => $request->delivery_status]);

        return redirect()->route('admin.orders.index')->with('success', 'Order status updated successfully!');
    }

    public function clearFeedback(Order $order)
    {
        $order->update([
            'rating' => null,
            'feedback' => null
        ]);

        return redirect()->route('admin.orders.index')->with('success', 'Feedback has been permanently deleted.');
    }
}
