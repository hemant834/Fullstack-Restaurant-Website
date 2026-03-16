<script setup>
import { ref, onMounted, onUnmounted, watch, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'

const route = useRoute()
const router = useRouter()

const routeOrderId = computed(() => route.params.orderId)
const orderIdInput = ref('')
const order = ref(null)
const loading = ref(!!routeOrderId.value)
const error = ref(null)

const userRating = ref(0)
const userFeedback = ref('')
const isRatingSubmitted = ref(false)
const isSubmittingRating = ref(false)

const recentOrders = ref(JSON.parse(localStorage.getItem('recent_orders') || '[]'))
const searchQuery = ref('')
const filteredOrders = computed(() => {
  if (!searchQuery.value) return recentOrders.value
  return recentOrders.value.filter(o => o.items.toLowerCase().includes(searchQuery.value.toLowerCase()))
})

let pollingInterval = null

const fetchOrder = async (idToFetch) => {
  if (!idToFetch) return
  loading.value = true
  try {
    const res = await fetch(`http://127.0.0.1:8000/api/payment/track-order/${idToFetch}`)
    const data = await res.json()
    if (data.success) {
      order.value = data.order
      error.value = null
    } else {
      error.value = 'Order not found'
      order.value = null
    }
  } catch (err) {
    console.error(err)
    error.value = 'Failed to load order details'
    order.value = null
  } finally {
    loading.value = false
  }
}

const submitTracking = () => {
  if (!orderIdInput.value.trim()) return
  // Save it as latest so they don't have to enter it again if they refresh
  localStorage.setItem('latestOrderId', orderIdInput.value.trim())
  router.push(`/track/${orderIdInput.value.trim()}`)
}

const trackAnother = () => {
  localStorage.removeItem('latestOrderId')
  router.push('/track')
}

const submitRating = async () => {
  if (userRating.value === 0 || !order.value) return
  isSubmittingRating.value = true
  
  try {
    const res = await fetch(`http://127.0.0.1:8000/api/payment/rate-order/${order.value.order_id}`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        rating: userRating.value,
        feedback: userFeedback.value
      })
    })
    
    const data = await res.json()
    if (data.success) {
      isRatingSubmitted.value = true
      order.value.rating = userRating.value
      order.value.feedback = userFeedback.value
    } else {
      alert(data.message || 'Failed to submit rating')
    }
  } catch (err) {
    console.error(err)
    alert('Something went wrong!')
  } finally {
    isSubmittingRating.value = false
  }
}

// Watch for route definition changes since component is reused
watch(() => route.params.orderId, (newId) => {
  if (pollingInterval) clearInterval(pollingInterval)
  
  if (newId) {
    loading.value = true
    fetchOrder(newId)
    pollingInterval = setInterval(() => fetchOrder(newId), 10000)
  } else {
    order.value = null
    error.value = null
    loading.value = false
  }
})

onMounted(() => {
  if (routeOrderId.value) {
    fetchOrder(routeOrderId.value)
    // Poll every 10 seconds for live updates
    pollingInterval = setInterval(() => fetchOrder(routeOrderId.value), 10000)
  } else {
    // If no route ID, check if we have a recent one saved
    const savedOrderId = localStorage.getItem('latestOrderId')
    if (savedOrderId) {
      router.replace(`/track/${savedOrderId}`)
    }
  }
})

onUnmounted(() => {
  if (pollingInterval) clearInterval(pollingInterval)
})

const getStatusIndex = (status) => {
  const statuses = ['pending', 'preparing', 'out_for_delivery', 'delivered']
  return statuses.indexOf(status)
}

const getStatusLabel = (status) => {
  const map = {
    pending: 'Order Received',
    preparing: 'Preparing Food',
    out_for_delivery: 'Out for Delivery',
    delivered: 'Delivered'
  }
  return map[status] || status
}

const getStatusIcon = (status) => {
  const map = {
    pending: '<svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"></path></svg>',
    preparing: '<svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.242-4.243a8 8 0 1111.314 0z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"></path></svg>',
    out_for_delivery: '<svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"></path></svg>',
    delivered: '<svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg>'
  }
  return map[status] || map.pending
}
</script>

<template>
  <div class="min-h-screen pt-24 pb-12 bg-dark">
    <div class="container mx-auto px-4 max-w-3xl">

      <!-- Display recent orders and search if no order route parameter -->
      <div v-if="!routeOrderId" class="bg-card p-6 sm:p-10 rounded-2xl border border-gray-custom shadow-xl">
        <h1 class="text-3xl sm:text-4xl font-bold text-white font-serif mb-6 text-center">Your Recent Orders</h1>
        
        <div v-if="recentOrders.length > 0">
          <div class="mb-8 relative max-w-lg mx-auto">
            <input 
              v-model="searchQuery" 
              type="text" 
              placeholder="Search by food item name (e.g. Pizza)..." 
              class="w-full bg-dark-lighter border border-gray-600 rounded-xl px-4 py-3 pl-12 text-white focus:outline-none focus:border-primary transition-colors"
            />
            <svg class="w-5 h-5 text-gray-400 absolute left-4 top-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
          </div>

          <div class="grid gap-4 max-w-2xl mx-auto">
            <div v-for="ro in filteredOrders" :key="ro.id" 
                 class="p-4 rounded-xl border border-gray-700 bg-dark hover:border-primary hover:bg-dark-lighter transition-all cursor-pointer flex justify-between items-center group" 
                 @click="router.push(`/track/${ro.id}`)">
              <div>
                <p class="text-xs sm:text-sm text-gray-400">{{ ro.date }}</p>
                <p class="text-white font-medium my-1 text-sm sm:text-base line-clamp-2 md:line-clamp-none">{{ ro.items }}</p>
                <div class="flex items-center gap-2 mt-2">
                  <span class="text-[10px] sm:text-xs px-2 py-1 rounded bg-gray-800 text-gray-300 border border-gray-700">
                    {{ ro.deliveryType === 'home-delivery' ? 'Home Delivery' : 'Dine In' }}
                  </span>
                  <span class="text-xs font-bold text-primary">₹{{ ro.amount }}</span>
                </div>
              </div>
              <svg class="w-6 h-6 text-gray-600 group-hover:text-primary transition-colors shrink-0 ml-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path></svg>
            </div>
            
            <div v-if="filteredOrders.length === 0" class="text-center py-6 text-gray-400">
              No orders found matching "{{ searchQuery }}".
            </div>
          </div>
        </div>
        
        <div v-else class="text-center py-10">
          <svg class="w-16 h-16 text-gray-600 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"></path></svg>
          <p class="text-gray-400 mb-6">You haven't placed any orders from this device recently.</p>
          <button @click="router.push('/menu')" class="px-6 py-2 bg-primary text-dark font-bold rounded-lg hover:bg-primary-hover">Browse Menu</button>
        </div>
      </div>

      <!-- Loading State -->
      <div v-else-if="loading" class="text-center py-20">
        <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-primary mx-auto mb-4"></div>
        <p class="text-white text-lg font-medium">Loading tracking details...</p>
      </div>

      <!-- Error State -->
      <div v-else-if="error" class="bg-card p-8 rounded-xl border border-red-500 text-center">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-16 w-16 text-red-500 mx-auto mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
        </svg>
        <h2 class="text-2xl font-bold text-white mb-2">Oops!</h2>
        <p class="text-gray-400 mb-6">{{ error }}</p>
        <button @click="router.push('/track')" class="px-6 py-2 bg-primary text-dark font-bold rounded-lg hover:bg-primary-hover">Try another ID</button>
      </div>

      <div v-else-if="order" class="bg-card rounded-2xl border border-gray-custom overflow-hidden shadow-2xl">
        <div class="bg-gradient-to-r from-gray-800 to-gray-900 p-8 text-center border-b border-gray-700">
          <h1 class="text-3xl font-bold text-white font-serif mb-2">
            {{ order.delivery_type === 'home-delivery' ? 'Delivery Tracking' : 'Dine-In Status' }}
          </h1>
          <p class="text-gray-400">Order ID: <span class="text-primary font-mono">{{ order.order_id }}</span></p>
        </div>

        <div class="p-8">
          <!-- Status Timeline -->
          <div class="relative max-w-lg mx-auto mb-12">
            <div class="absolute top-1/2 left-0 w-full h-1 bg-gray-700 -translate-y-1/2 z-0"></div>
            <div class="absolute top-1/2 left-0 h-1 bg-primary -translate-y-1/2 z-0 transition-all duration-1000"
                 :style="{ width: `${(getStatusIndex(order.delivery_status) / 3) * 100}%` }"></div>
            
            <div class="relative z-10 flex justify-between">
              <div v-for="step in ['pending', 'preparing', 'out_for_delivery', 'delivered']" :key="step" class="flex flex-col items-center">
                <div class="w-12 h-12 rounded-full flex items-center justify-center border-2 transition-colors duration-500 bg-dark"
                     :class="getStatusIndex(order.delivery_status) >= getStatusIndex(step) ? 'border-primary text-primary' : 'border-gray-600 text-gray-500'"
                     v-html="getStatusIcon(step)">
                </div>
                <span class="mt-3 text-xs md:text-sm font-medium text-center"
                      :class="getStatusIndex(order.delivery_status) >= getStatusIndex(step) ? 'text-white' : 'text-gray-500'">
                  {{ getStatusLabel(step) }}
                </span>
              </div>
            </div>
          </div>

          <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
            <div class="bg-dark-lighter p-6 rounded-xl border border-gray-800">
              <h3 class="text-lg font-bold text-white mb-4 border-b border-gray-700 pb-2">Order Details</h3>
              <ul class="space-y-3">
                <li v-for="(item, idx) in order.items" :key="idx" class="flex justify-between text-sm">
                  <span class="text-gray-300"><span class="text-primary">{{ item.quantity }}x</span> {{ item.name }}</span>
                  <span class="text-gray-400">₹{{ item.price * item.quantity }}</span>
                </li>
              </ul>
              <div class="mt-4 pt-4 border-t border-gray-700 flex justify-between font-bold text-lg">
                <span class="text-white">Total</span>
                <span class="text-primary">₹{{ order.amount }}</span>
              </div>
            </div>

            <div class="bg-dark-lighter p-6 rounded-xl border border-gray-800">
              <h3 class="text-lg font-bold text-white mb-4 border-b border-gray-700 pb-2">Delivery Info</h3>
              <div v-if="order.delivery_type === 'home-delivery'">
                <p class="text-gray-400 text-sm mb-1">Delivering to:</p>
                <p class="text-white font-medium">{{ order.address }}</p>
                <div v-if="order.delivery_status !== 'delivered'" class="mt-6 flex items-center gap-3 bg-primary/10 p-3 rounded-lg border border-primary/20">
                  <svg class="w-6 h-6 text-primary shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                  <p class="text-primary text-sm font-medium">Estimated Delivery: 30-45 mins</p>
                </div>
                <div v-else class="mt-6 flex items-center gap-3 bg-green-500/10 p-3 rounded-lg border border-green-500/20">
                  <svg class="w-6 h-6 text-green-500 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                  <p class="text-green-500 text-sm font-medium">Order Delivered Successfully!</p>
                </div>
              </div>
              <div v-else>
                <p class="text-gray-400 text-sm mb-1">Service Type:</p>
                <p class="text-white font-medium text-lg">Dine-In</p>
                <p v-if="order.delivery_status !== 'delivered'" class="text-gray-400 mt-4 text-sm">Please be seated. Your host will serve you shortly.</p>
                <p v-else class="text-green-400 mt-4 text-sm">Marked as completed.</p>
              </div>
            </div>
          </div>

          <!-- Rating & Feedback Section (Only visible when Delivered) -->
          <div v-if="order.delivery_status === 'delivered'" class="mt-8 animate-fade-in">
            <div class="bg-gradient-to-r from-gray-800 to-gray-900 border border-gray-700 p-8 rounded-xl text-center shadow-lg">
              
              <!-- If already rated (by DB or just now) -->
              <div v-if="order.rating || isRatingSubmitted">
                <div class="inline-flex bg-green-500/20 text-green-400 p-4 rounded-full mb-4">
                  <svg class="w-10 h-10" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 10h4.764a2 2 0 011.789 2.894l-3.5 7A2 2 0 0115.263 21h-4.017c-.163 0-.326-.02-.485-.06L7 20m7-10V5a2 2 0 00-2-2h-.095c-.5 0-.905.405-.905.905 0 .714-.211 1.412-.608 2.006L7 11v9m7-10h-2M7 20H5a2 2 0 01-2-2v-6a2 2 0 012-2h2.5"></path></svg>
                </div>
                <h3 class="text-2xl font-bold text-white mb-2">Thank you!</h3>
                <p class="text-gray-400">Your feedback helps us improve our service.</p>
                
                <div class="flex justify-center gap-1 mt-4">
                  <svg v-for="star in 5" :key="star" class="w-6 h-6" 
                       :class="(order.rating || userRating) >= star ? 'text-primary' : 'text-gray-600'" 
                       fill="currentColor" viewBox="0 0 20 20">
                    <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                  </svg>
                </div>
              </div>

              <!-- Not rated yet -->
              <div v-else>
                <h3 class="text-2xl font-bold text-white mb-2 font-serif">Rate Your Experience</h3>
                <p class="text-gray-400 mb-6">How was the food and service?</p>
                
                <!-- Star Rating -->
                <div class="flex justify-center gap-2 mb-6 cursor-pointer">
                  <svg v-for="star in 5" :key="star" 
                       @click="userRating = star"
                       class="w-10 h-10 transition-colors" 
                       :class="userRating >= star ? 'text-primary' : 'text-gray-600 hover:text-primary/50'" 
                       fill="currentColor" viewBox="0 0 20 20">
                    <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                  </svg>
                </div>

                <div v-if="userRating > 0" class="max-w-md mx-auto animate-fade-in-up">
                  <textarea 
                    v-model="userFeedback"
                    placeholder="Tell us what you loved (optional)..."
                    class="w-full bg-dark border border-gray-600 rounded-xl px-4 py-3 text-white focus:outline-none focus:border-primary transition-colors mb-4 resize-none h-24"
                  ></textarea>
                  
                  <button @click="submitRating" 
                          :disabled="isSubmittingRating"
                          class="w-full py-3 bg-primary text-dark font-bold rounded-xl hover:bg-primary-hover transition-colors disabled:opacity-70 flex justify-center items-center">
                    <span v-if="isSubmittingRating"><svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-dark" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg> Submitting...</span>
                    <span v-else>Submit Feedback</span>
                  </button>
                </div>
              </div>
            </div>
          </div>
          
          <div class="mt-8 flex justify-center items-center gap-6">
             <button @click="router.push('/menu')" class="text-gray-400 hover:text-white transition-colors text-sm underline">Return to Menu</button>
             <button @click="trackAnother" class="text-gray-400 hover:text-white transition-colors text-sm underline">Track Another Order</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
@keyframes fade-in {
  from { opacity: 0; }
  to { opacity: 1; }
}
.animate-fade-in {
  animation: fade-in 0.5s ease-out forwards;
}

@keyframes fade-in-up {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
.animate-fade-in-up {
  animation: fade-in-up 0.4s ease-out forwards;
}
</style>
