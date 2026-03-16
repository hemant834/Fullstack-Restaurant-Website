@extends('layouts.admin')

@section('content')
<div class="flex justify-between items-center mb-8">
    <div>
        <h2 class="text-3xl font-bold text-white">Orders</h2>
        <p class="text-gray-400 mt-1">View recently placed orders via Razorpay</p>
    </div>
</div>

<div class="bg-gray-800 rounded-lg shadow-xl overflow-hidden border border-gray-700">
    <div class="overflow-x-auto">
        <table class="w-full text-left border-collapse">
            <thead>
                <tr class="bg-gray-900 text-gray-400 text-sm uppercase tracking-wider">
                    <th class="p-4 font-semibold border-b border-gray-700">ID</th>
                    <th class="p-4 font-semibold border-b border-gray-700">Order ID</th>
                    <th class="p-4 font-semibold border-b border-gray-700">Payment ID</th>
                    <th class="p-4 font-semibold border-b border-gray-700">Type</th>
                    <th class="p-4 font-semibold border-b border-gray-700">Track Status</th>
                    <th class="p-4 font-semibold border-b border-gray-700">Feedback</th>
                    <th class="p-4 font-semibold border-b border-gray-700">Amount</th>
                    <th class="p-4 font-semibold border-b border-gray-700">Actions</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-gray-700">
                @foreach($orders as $order)
                <tr class="hover:bg-gray-750 transition-colors duration-150 group">
                    <td class="p-4 text-white">#{{ $order->id }}</td>
                    <td class="p-4">
                        <div class="text-sm font-medium text-white">{{ $order->order_id }}</div>
                        <div class="text-xs text-gray-500 mt-1">{{ $order->created_at->format('M d, h:i A') }}</div>
                    </td>
                    <td class="p-4 text-gray-300">
                        @if($order->status === 'paid')
                            <span class="inline-flex items-center px-2 py-1 rounded text-xs font-medium bg-green-500/10 text-green-400">Paid</span>
                        @else
                            <span class="inline-flex items-center px-2 py-1 rounded text-xs font-medium bg-yellow-500/10 text-yellow-400">{{ ucfirst($order->status) }}</span>
                        @endif
                    </td>
                    <td class="p-4">
                        @if($order->delivery_type === 'home-delivery')
                            <span class="inline-flex items-center px-2 py-1 rounded text-xs font-medium bg-blue-500/10 text-blue-400 border border-blue-500/20">Home Delivery</span>
                            <span class="block text-xs text-gray-400 mt-1 max-w-[150px] truncate" title="{{ $order->address }}">{{ $order->address }}</span>
                        @else
                            <span class="inline-flex items-center px-2 py-1 rounded text-xs font-medium bg-purple-500/10 text-purple-400 border border-purple-500/20">Dine In</span>
                        @endif
                    </td>
                    <td class="p-4">
                        @php
                            $statusColors = [
                                'pending' => 'text-yellow-500 bg-yellow-500/10',
                                'preparing' => 'text-orange-500 bg-orange-500/10',
                                'out_for_delivery' => 'text-blue-500 bg-blue-500/10',
                                'delivered' => 'text-green-500 bg-green-500/10'
                            ];
                            $labels = [
                                'pending' => 'Pending',
                                'preparing' => 'Preparing',
                                'out_for_delivery' => 'Out for Delivery',
                                'delivered' => 'Delivered'
                            ];
                        @endphp
                        <span class="inline-flex items-center px-2 py-1 rounded text-xs font-medium {{ $statusColors[$order->delivery_status] ?? 'text-gray-400' }}">
                            {{ $labels[$order->delivery_status] ?? ucfirst($order->delivery_status) }}
                        </span>
                    </td>
                    <td class="p-4">
                        @if($order->rating)
                            <div class="flex items-center text-yellow-500 mb-1">
                                <span class="font-bold mr-1">{{ $order->rating }}</span>
                                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" /></svg>
                            </div>
                            @if($order->feedback)
                                <p class="text-xs text-gray-400 italic mb-2 line-clamp-2" title="{{ $order->feedback }}">"{{ $order->feedback }}"</p>
                            @endif
                            <form action="{{ route('admin.orders.clearFeedback', $order->id) }}" method="POST" onsubmit="return confirm('Are you sure you want to delete this feedback?');">
                                @csrf
                                @method('DELETE')
                                <button type="submit" class="text-xs text-red-500 hover:text-red-400 underline transition-colors">
                                    Delete
                                </button>
                            </form>
                        @elseif($order->delivery_status === 'delivered')
                            <span class="text-xs text-gray-500 text-center block">Not rated yet</span>
                        @else
                            <span class="text-xs text-gray-600">-</span>
                        @endif
                    </td>
                    <td class="p-4 text-white font-semibold flex items-center h-full pt-8">
                        ₹{{ number_format($order->amount, 2) }}
                    </td>
                    <td class="p-4 text-right">
                        <form action="{{ route('admin.orders.update', $order->id) }}" method="POST" class="flex items-center gap-2 justify-end">
                            @csrf
                            @method('PUT')
                            <select name="delivery_status" class="bg-gray-700 text-white text-xs border border-gray-600 rounded px-2 py-1 focus:outline-none focus:border-yellow-500">
                                <option value="pending" {{ $order->delivery_status == 'pending' ? 'selected' : '' }}>Pending</option>
                                <option value="preparing" {{ $order->delivery_status == 'preparing' ? 'selected' : '' }}>Preparing</option>
                                <option value="out_for_delivery" {{ $order->delivery_status == 'out_for_delivery' ? 'selected' : '' }}>Out for Delivery</option>
                                <option value="delivered" {{ $order->delivery_status == 'delivered' ? 'selected' : '' }}>Delivered</option>
                            </select>
                            <button type="submit" class="bg-yellow-600 hover:bg-yellow-700 text-white px-2 py-1 rounded text-xs font-medium transition-colors">
                                Update
                            </button>
                        </form>
                    </td>
                </tr>
                @endforeach
                
                @if($orders->isEmpty())
                <tr>
                    <td colspan="8" class="p-8 text-center text-gray-500">
                        No orders found yet.
                    </td>
                </tr>
                @endif
            </tbody>
        </table>
    </div>
</div>
<!-- Pagination -->
<div class="mt-4">
    {{ $orders->links() }}
</div>
@endsection
