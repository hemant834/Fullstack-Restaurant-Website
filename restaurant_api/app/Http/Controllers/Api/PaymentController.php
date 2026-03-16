<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use Razorpay\Api\Api;
use App\Models\Order;

class PaymentController extends Controller
{
    private $api;

    public function __construct()
    {
        $this->api = new Api(env('RAZORPAY_KEY_ID'), env('RAZORPAY_KEY_SECRET'));
    }

    public function createOrder(Request $request)
    {
        try {
            $amount = $request->input('amount');
            $currency = $request->input('currency', 'INR');
            
            $orderData = [
                'receipt'         => 'receipt_order_' . rand(1000, 9999),
                'amount'          => $amount * 100, // exact amount in paise
                'currency'        => $currency,
                'payment_capture' => 1 // auto capture
            ];

            $razorpayOrder = $this->api->order->create($orderData);

            return response()->json([
                'success' => true,
                'order' => [
                    'id' => $razorpayOrder['id'],
                    'amount' => $razorpayOrder['amount'],
                    'currency' => $razorpayOrder['currency'],
                    'receipt' => $razorpayOrder['receipt']
                ]
            ]);
        } catch (\Exception $e) {
            \Log::error('Razorpay Order Create Error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Server error'
            ], 500);
        }
    }

    public function verifyPayment(Request $request)
    {
        try {
            $attributes = [
                'razorpay_order_id' => $request->input('razorpay_order_id'),
                'razorpay_payment_id' => $request->input('razorpay_payment_id'),
                'razorpay_signature' => $request->input('razorpay_signature')
            ];

            $this->api->utility->verifyPaymentSignature($attributes);

            $orderAmount = $request->input('amount', 0);

            // Save to DB
            $order = Order::create([
                'order_id' => $attributes['razorpay_order_id'],
                'payment_id' => $attributes['razorpay_payment_id'],
                'signature' => $attributes['razorpay_signature'],
                'status' => 'paid',
                'amount' => $orderAmount,
                'delivery_type' => $request->input('delivery_type', 'dine-in'),
                'address' => $request->input('address', null),
                'delivery_status' => 'pending',
                'items' => json_decode($request->input('items', '[]'), true)
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Payment verified successfully',
                'order' => $order
            ]);

        } catch (\Razorpay\Api\Errors\SignatureVerificationError $e) {
            return response()->json([
                'success' => false,
                'message' => 'Invalid signature sent!'
            ], 400);
        } catch (\Exception $e) {
            \Log::error('Razorpay Verify Error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Server error'
            ], 500);
        }
    }

    public function trackOrder($orderId)
    {
        $order = Order::where('order_id', $orderId)->first();
        if (!$order) {
            return response()->json(['success' => false, 'message' => 'Order not found'], 404);
        }
        return response()->json(['success' => true, 'order' => $order]);
    }

    public function rateOrder(Request $request, $orderId)
    {
        $order = Order::where('order_id', $orderId)->first();
        if (!$order) {
            return response()->json(['success' => false, 'message' => 'Order not found'], 404);
        }

        $request->validate([
            'rating' => 'required|integer|min:1|max:5',
            'feedback' => 'nullable|string'
        ]);

        $order->update([
            'rating' => $request->rating,
            'feedback' => $request->feedback
        ]);

        // Send email to Admin
        try {
            $adminEmail = env('ADMIN_EMAIL', 'admin@restaurantos.com');
            $subject = "New Order Feedback Received - Order #" . $order->order_id;
            $body = "Order ID: " . $order->order_id . "\n"
                  . "Rating: " . $request->rating . " / 5 Stars\n"
                  . "Feedback: " . ($request->feedback ?: 'No written feedback provided.') . "\n"
                  . "Amount: ₹" . $order->amount . "\n";

            \Illuminate\Support\Facades\Mail::raw($body, function ($message) use ($adminEmail, $subject) {
                $message->to($adminEmail)
                        ->subject($subject);
            });
        } catch (\Exception $e) {
            \Log::error('Feedback Mail Error: ' . $e->getMessage());
        }

        return response()->json(['success' => true, 'message' => 'Thank you for your feedback!']);
    }
}
