<script setup>
import { ref, reactive } from 'vue'
import { useCartStore } from '../stores/cart'
import { useUserStore } from '../stores/user'
import { RouterLink, useRouter } from 'vue-router'

const cartStore = useCartStore()
const userStore = useUserStore()
const router = useRouter()

// Delivery Logic
const deliveryType = ref('dine-in') // 'dine-in' | 'home-delivery'

const address = reactive({
  street: '',
  city: '',
  pincode: '',
  landmark: ''
})

const errors = reactive({
  street: false,
  city: false,
  pincode: false
})

function validateAddress() {
  let isValid = true

  // Reset errors
  errors.street = false
  errors.city = false
  errors.pincode = false

  if (!address.street.trim()) {
    errors.street = true
    isValid = false
  }
  if (!address.city.trim()) {
    errors.city = true
    isValid = false
  }
  if (!address.pincode.trim()) {
    errors.pincode = true
    isValid = false
  }

  return isValid
}

const loadRazorpay = () => {
  return new Promise((resolve) => {
    const script = document.createElement('script')
    script.src = 'https://checkout.razorpay.com/v1/checkout.js'
    script.onload = () => resolve(true)
    script.onerror = () => resolve(false)
    document.body.appendChild(script)
  })
}

async function handleCheckout() {
  if (cartStore.items.length === 0) return

  // Validate if Home Delivery
  if (deliveryType.value === 'home-delivery') {
    if (!validateAddress()) {
      // Create a visual shake effect or scroll to error
      const formElement = document.getElementById('delivery-form')
      if (formElement) formElement.scrollIntoView({ behavior: 'smooth', block: 'center' })
      return
    }
  }

  const res = await loadRazorpay()

  if (!res) {
    alert('Razorpay SDK failed to load. Are you online?')
    return
  }

  const deliveryFee = deliveryType.value === 'home-delivery' ? 80 : 0
  const amountToPay = cartStore.totalPrice + deliveryFee

  try {
    // 1. Create order on your backend
    const orderData = await fetch('http://127.0.0.1:8000/api/payment/create-order', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        amount: amountToPay,
        currency: 'INR'
      })
    }).then((t) => t.json())

    if (!orderData.success) {
      alert('Failed to create order on server')
      return
    }

    // 2. Initialize Razorpay Checkout
    const options = {
      key: 'rzp_test_RhAm1mwY2iFNYf', // Your Razorpay Key ID
      amount: orderData.order.amount,
      currency: orderData.order.currency,
      name: 'Secret Garden',
      description: 'Food Ordering Transaction',
      order_id: orderData.order.id,
      handler: async function (response) {
        // 3. Verify Payment
        const verifyData = await fetch('http://127.0.0.1:8000/api/payment/verify-payment', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            razorpay_payment_id: response.razorpay_payment_id,
            razorpay_order_id: response.razorpay_order_id,
            razorpay_signature: response.razorpay_signature,
            amount: amountToPay,
            delivery_type: deliveryType.value,
            address: deliveryType.value === 'home-delivery' ? `${address.street}, ${address.city}, ${address.pincode} ${address.landmark ? '('+address.landmark+')' : ''}` : null,
            items: JSON.stringify(cartStore.items)
          })
        }).then((t) => t.json())

        if (verifyData.success) {
          userStore.addOrder(cartStore.totalItems)

          const successMessage = deliveryType.value === 'home-delivery'
            ? 'Payment Successful! Your food is on the way.'
            : 'Payment Successful! Please wait at your table.'

          // Save to recent orders in browser
          const recentOrders = JSON.parse(localStorage.getItem('recent_orders') || '[]')
          recentOrders.unshift({
            id: response.razorpay_order_id,
            date: new Date().toLocaleString(),
            items: cartStore.items.map(i => `${i.quantity}x ${i.name}`).join(', '),
            amount: amountToPay,
            deliveryType: deliveryType.value
          })
          localStorage.setItem('recent_orders', JSON.stringify(recentOrders))

          // Reset cart
          cartStore.items = []
          localStorage.setItem('latestOrderId', response.razorpay_order_id)
          router.push(`/track/${response.razorpay_order_id}`)
        } else {
          alert('Payment verification failed!')
        }
      },
      prefill: {
        name: userStore.user?.name || 'Customer',
        email: userStore.user?.email || 'customer@example.com',
        contact: '9999999999'
      },
      theme: {
        color: '#f59e0b' // Matches primary color
      }
    }

    const paymentObject = new window.Razorpay(options)
    paymentObject.open()
  } catch (err) {
    console.error(err)
    alert('Something went wrong!')
  }
}
</script>

<template>
  <div class="min-h-screen pt-24 pb-12 bg-dark">
    <div class="container mx-auto px-4">
      <h1 class="text-4xl font-bold text-primary font-serif mb-8 text-center lg:text-left">Your Dining Cart</h1>

      <div v-if="cartStore.items.length === 0" class="text-center py-20 bg-card rounded-xl border border-gray-custom">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-20 w-20 mx-auto text-gray-500 mb-6" fill="none"
          viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
            d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
        </svg>
        <p class="text-xl text-gray-400 mb-8">Your cart is currently empty.</p>
        <RouterLink to="/menu"
          class="px-8 py-3 bg-primary text-dark font-bold rounded-full hover:bg-primary-hover transition-colors inline-block">
          Browse Menu
        </RouterLink>
      </div>

      <div v-else class="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <!-- Main Content Column -->
        <div class="lg:col-span-2 space-y-8">

          <!-- Cart Items List -->
          <div class="space-y-6">
            <div v-for="item in cartStore.items" :key="item.id"
              class="bg-card p-4 rounded-xl flex flex-col sm:flex-row items-center gap-6 border border-gray-custom">
              <div class="w-full sm:w-32 h-32 flex-shrink-0 bg-gray-700 rounded-lg overflow-hidden">
                <img :src="item.image" :alt="item.name" class="w-full h-full object-cover" />
              </div>

              <div class="flex-grow text-center sm:text-left">
                <h3 class="text-xl font-bold text-white mb-1">{{ item.name }}</h3>
                <p class="text-primary font-medium mb-4">₹{{ item.price }}</p>

                <div class="flex items-center justify-center sm:justify-start gap-4">
                  <div class="flex items-center bg-dark-lighter rounded-lg border border-gray-custom">
                    <button @click="cartStore.decrementQuantity(item.id)"
                      class="px-3 py-1 text-gray-400 hover:text-white transition-colors">-</button>
                    <span class="px-2 text-white font-medium">{{ item.quantity }}</span>
                    <button @click="cartStore.incrementQuantity(item.id)" :disabled="item.quantity >= 20"
                      class="px-3 py-1 text-gray-400 hover:text-white transition-colors disabled:opacity-50 disabled:cursor-not-allowed">
                      +
                    </button>
                  </div>

                  <button @click="cartStore.removeFromCart(item.id)"
                    class="text-red-500 hover:text-red-400 transition-colors text-sm underline">
                    Remove
                  </button>
                </div>
              </div>

              <div class="text-xl font-bold text-white">
                ₹{{ item.price * item.quantity }}
              </div>
            </div>
          </div>

          <!-- Delivery Options Section -->
          <div class="bg-card p-6 rounded-xl border border-gray-custom" id="delivery-form">
            <h2 class="text-2xl font-bold text-white mb-6 font-serif">Dining Preference</h2>

            <!-- Type Selector -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-8">
              <label
                class="relative flex flex-col items-center p-6 rounded-xl border-2 cursor-pointer transition-all duration-300 group"
                :class="deliveryType === 'dine-in' ? 'border-primary bg-primary/10' : 'border-gray-700 hover:border-gray-500 bg-dark-lighter'">
                <input type="radio" v-model="deliveryType" value="dine-in" class="absolute opacity-0 w-0 h-0" />
                <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10 mb-3 transition-colors"
                  :class="deliveryType === 'dine-in' ? 'text-primary' : 'text-gray-400 group-hover:text-gray-200'"
                  fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                    d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                </svg>
                <span class="text-lg font-bold transition-colors"
                  :class="deliveryType === 'dine-in' ? 'text-white' : 'text-gray-400 group-hover:text-gray-200'">Dine
                  In</span>
                <span class="text-sm text-gray-500 mt-1">Serve at Table</span>

                <!-- Checkmark -->
                <div v-if="deliveryType === 'dine-in'" class="absolute top-3 right-3 text-primary animate-fade-in">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                    stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                  </svg>
                </div>
              </label>

              <label
                class="relative flex flex-col items-center p-6 rounded-xl border-2 cursor-pointer transition-all duration-300 group"
                :class="deliveryType === 'home-delivery' ? 'border-primary bg-primary/10' : 'border-gray-700 hover:border-gray-500 bg-dark-lighter'">
                <input type="radio" v-model="deliveryType" value="home-delivery" class="absolute opacity-0 w-0 h-0" />
                <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10 mb-3 transition-colors"
                  :class="deliveryType === 'home-delivery' ? 'text-primary' : 'text-gray-400 group-hover:text-gray-200'"
                  fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                    d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
                </svg>
                <span class="text-lg font-bold transition-colors"
                  :class="deliveryType === 'home-delivery' ? 'text-white' : 'text-gray-400 group-hover:text-gray-200'">Home
                  Delivery</span>
                <span class="text-sm text-gray-500 mt-1">Doorstep Service</span>

                <!-- Checkmark -->
                <div v-if="deliveryType === 'home-delivery'"
                  class="absolute top-3 right-3 text-primary animate-fade-in">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                    stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                  </svg>
                </div>
              </label>
            </div>

            <!-- Address Form -->
            <div v-if="deliveryType === 'home-delivery'" class="border-t border-gray-custom pt-6 animate-fade-in">
              <h3 class="text-lg font-bold text-white mb-4">Delivery Address</h3>

              <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <!-- Full Address -->
                <div class="md:col-span-2">
                  <label class="block text-gray-400 mb-2 text-sm">Full Address <span
                      class="text-red-500">*</span></label>
                  <textarea v-model="address.street" rows="3"
                    class="w-full bg-dark-lighter border rounded-lg px-4 py-3 text-white focus:outline-none focus:border-primary transition-colors"
                    :class="errors.street ? 'border-red-500' : 'border-gray-custom'"
                    placeholder="House/Flat No, Street, Area"></textarea>
                  <p v-if="errors.street" class="text-red-500 text-xs mt-1">Address is required.</p>
                </div>

                <!-- City -->
                <div>
                  <label class="block text-gray-400 mb-2 text-sm">City <span class="text-red-500">*</span></label>
                  <input type="text" v-model="address.city"
                    class="w-full bg-dark-lighter border rounded-lg px-4 py-3 text-white focus:outline-none focus:border-primary transition-colors"
                    :class="errors.city ? 'border-red-500' : 'border-gray-custom'" placeholder="Enter City" />
                  <p v-if="errors.city" class="text-red-500 text-xs mt-1">City is required.</p>
                </div>

                <!-- Pincode -->
                <div>
                  <label class="block text-gray-400 mb-2 text-sm">Pincode <span class="text-red-500">*</span></label>
                  <input type="text" v-model="address.pincode"
                    class="w-full bg-dark-lighter border rounded-lg px-4 py-3 text-white focus:outline-none focus:border-primary transition-colors"
                    :class="errors.pincode ? 'border-red-500' : 'border-gray-custom'" placeholder="ZIP/Postal Code" />
                  <p v-if="errors.pincode" class="text-red-500 text-xs mt-1">Pincode is required.</p>
                </div>

                <!-- Landmark -->
                <div class="md:col-span-2">
                  <label class="block text-gray-400 mb-2 text-sm">Landmark <span
                      class="text-gray-500">(Optional)</span></label>
                  <input type="text" v-model="address.landmark"
                    class="w-full bg-dark-lighter border border-gray-custom rounded-lg px-4 py-3 text-white focus:outline-none focus:border-primary transition-colors"
                    placeholder="Near famous place, etc." />
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Order Summary -->
        <div class="lg:col-span-1">
          <div class="bg-card p-6 rounded-xl border border-gray-custom sticky top-24">
            <h2 class="text-2xl font-bold text-white mb-6">Order Summary</h2>

            <!-- Unlimited Plan Offer Section -->
            <div class="mb-8 p-4 rounded-xl border border-dashed transition-all duration-300"
              :class="cartStore.isUnlimitedPlan ? 'bg-primary/10 border-primary' : 'bg-dark-lighter border-gray-600'">
              <div class="flex justify-between items-start mb-2">
                <div>
                  <h3 class="font-bold text-lg" :class="cartStore.isUnlimitedPlan ? 'text-primary' : 'text-gray-300'">
                    Unlimited Food Plan</h3>
                  <p class="text-sm text-gray-400">Eat all you want for just ₹299!</p>
                </div>
                <!-- Toggle Switch -->
                <button @click="cartStore.toggleUnlimitedPlan"
                  class="relative w-12 h-6 rounded-full transition-colors duration-300 focus:outline-none"
                  :class="cartStore.isUnlimitedPlan ? 'bg-primary' : 'bg-gray-600'">
                  <span
                    class="absolute top-1 left-1 bg-white w-4 h-4 rounded-full transition-transform duration-300 transform"
                    :class="cartStore.isUnlimitedPlan ? 'translate-x-6' : 'translate-x-0'"></span>
                </button>
              </div>
              <p v-if="cartStore.isUnlimitedPlan" class="text-xs text-primary mt-2 flex items-center gap-1">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24"
                  stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
                Offer Applied!
              </p>
            </div>

            <!-- Totals -->
            <div class="space-y-3 mb-6">
              <div class="flex justify-between text-gray-300">
                <span>Subtotal ({{ cartStore.totalItems }} items)</span>
                <span :class="{ 'line-through text-gray-500': cartStore.isUnlimitedPlan }">
                  ₹{{cartStore.items.reduce((t, i) => t + (i.price * i.quantity), 0)}}
                </span>
              </div>

              <div v-if="cartStore.isUnlimitedPlan" class="flex justify-between text-primary font-medium">
                <span>Unlimited Plan Fixed Price</span>
                <span>₹299</span>
              </div>

              <div v-if="deliveryType === 'home-delivery'"
                class="flex justify-between text-primary font-medium animate-fade-in">
                <span>Delivery Charge</span>
                <span>₹80</span>
              </div>

              <div class="h-px bg-gray-custom my-4"></div>

              <div class="flex justify-between items-center">
                <span class="text-xl font-bold text-white">Total</span>
                <span class="text-2xl font-bold text-primary">₹{{ cartStore.totalPrice + (deliveryType === 'home-delivery' ? 80 : 0) }}</span>
              </div>
            </div>

            <button @click="handleCheckout"
              class="w-full py-4 bg-primary text-dark font-bold text-lg rounded-xl hover:bg-primary-hover transition-colors shadow-lg shadow-primary/20">
              {{ deliveryType === 'home-delivery' ? 'Deliver to Address' : 'Proceed to Pay' }}
            </button>
            <p class="text-center text-xs text-gray-500 mt-4">
              Secure Checkout • 100% Satisfaction
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
@keyframes fade-in {
  from {
    opacity: 0;
    transform: translateY(10px);
  }

  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.animate-fade-in {
  animation: fade-in 0.3s ease-out forwards;
}
</style>
