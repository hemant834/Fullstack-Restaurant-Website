<script setup>
import { onMounted, ref } from 'vue'
import { useCartStore } from '../stores/cart'

const cartStore = useCartStore()

const menuItems = ref([
  // {
  //   id: 1,
  //   name: 'Grilled Salmon',
  //   description: 'Fresh salmon fillet grilled to perfection with herbs.',
  //   price: 450,
  //   category: 'Main Course',
  //   image: 'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?q=80&w=2070&auto=format&fit=crop'
  // },
  // {
  //   id: 2,
  //   name: 'Chicken Biryani',
  //   description: 'Aromatic basmati rice cooked with tender chicken and spices.',
  //   price: 350,
  //   category: 'Main Course',
  //   image: 'https://images.unsplash.com/photo-1589302168068-964664d93dc0?q=80&w=1974&auto=format&fit=crop'
  // },
  // {
  //   id: 3,
  //   name: 'Paneer Tikka',
  //   description: 'Cottage cheese cubes marinated in spices and grilled.',
  //   price: 280,
  //   category: 'Starters',
  //   image: 'https://images.unsplash.com/photo-1567188040759-fb8a883dc6d8?q=80&w=2034&auto=format&fit=crop'
  // },
  // {
  //   id: 4,
  //   name: 'Chocolate Brownie',
  //   description: 'Rich chocolate brownie topped with vanilla ice cream.',
  //   price: 180,
  //   category: 'Desserts',
  //   image: 'https://images.unsplash.com/photo-1564355808539-22fda35bed7e?q=80&w=2057&auto=format&fit=crop'
  // },
  // {
  //   id: 5,
  //   name: 'Caesar Salad',
  //   description: 'Fresh romaine lettuce with croutons and parmesan.',
  //   price: 220,
  //   category: 'Starters',
  //   image: 'https://images.unsplash.com/photo-1550304943-4f24f54ddde9?q=80&w=2070&auto=format&fit=crop'
  // },
  // {
  //   id: 6,
  //   name: 'Mushroom Risotto',
  //   description: 'Creamy Italian rice dish cooked with wild mushrooms.',
  //   price: 380,
  //   category: 'Main Course',
  //   image: 'https://images.unsplash.com/photo-1476124369491-e7addf5db371?q=80&w=2070&auto=format&fit=crop'
  // }
])
const categories = ['All', 'Starters', 'Main Course', 'Desserts']
const activeCategory = ref('All')

const filteredItems = computed(() => {
  if (activeCategory.value === 'All') return menuItems.value
  return menuItems.value.filter(item => item.category === activeCategory.value)
})

import { computed } from 'vue'

const showNotification = ref(false)
const notificationMessage = ref('')

function addToCart(item) {
  cartStore.addToCart(item)
  notificationMessage.value = `${item.name} added to cart!`
  showNotification.value = true
  setTimeout(() => {
    showNotification.value = false
  }, 2000)
}

import axiosInstance from '../services/axiosInstance'

const fetchMenu = async () => {
  try {
    const response = await axiosInstance.get('/menus');
    console.log("response", response);

    menuItems.value = response.data.data
  } catch (error) {
    console.error('Error fetching menu:', error)
  }
}

onMounted(() => {
  fetchMenu()
})
</script>

<template>
  <div class="min-h-screen pt-24 pb-12 bg-dark">
    <div class="container mx-auto px-4">
      <div class="text-center mb-12">
        <h1 class="text-4xl font-bold text-primary font-serif mb-4">Our Exclusive Menu</h1>
        <p class="text-gray-400">Discover our carefully curated dishes.</p>
      </div>

      <!-- Category Filter -->
      <div class="flex flex-wrap justify-center gap-4 mb-12">
        <button v-for="category in categories" :key="category" @click="activeCategory = category" :class="[
          'px-6 py-2 rounded-full transition-all duration-300 border border-gray-custom',
          activeCategory === category
            ? 'bg-primary text-dark font-bold'
            : 'bg-transparent text-gray-300 hover:border-primary hover:text-primary'
        ]">
          {{ category }}
        </button>
      </div>

      <!-- Menu Grid -->
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        <div v-for="item in filteredItems" :key="item.id"
          class="bg-card rounded-xl overflow-hidden shadow-lg border border-gray-custom hover:shadow-primary/20 hover:border-primary/50 transition-all duration-300 group flex flex-col">
          <div class="relative h-48 overflow-hidden">
            <img :src="item.image" :alt="item.name"
              class="w-full h-full object-cover transform group-hover:scale-110 transition-transform duration-500" />
            <div
              class="absolute top-4 right-4 bg-dark/80 backdrop-blur px-3 py-1 rounded-full border border-primary/50">
              <span class="text-primary font-bold">₹{{ item.price }}</span>
            </div>
          </div>

          <div class="p-6 flex flex-col flex-grow">
            <div class="mb-4">
              <span class="text-xs text-primary bg-primary/10 px-2 py-1 rounded uppercase tracking-wider">{{
                item.category }}</span>
            </div>
            <h3 class="text-xl font-bold text-white mb-2">{{ item.name }}</h3>
            <p class="text-gray-400 text-sm mb-6 flex-grow">{{ item.description }}</p>

            <button @click="addToCart(item)"
              class="w-full py-3 bg-gray-custom text-white hover:bg-primary hover:text-dark font-medium rounded-lg transition-colors flex items-center justify-center gap-2">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24"
                stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
              </svg>
              Add to Cart
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Notification Toast -->
    <div v-if="showNotification"
      class="fixed bottom-8 left-1/2 transform -translate-x-1/2 bg-primary text-dark px-6 py-3 rounded-full shadow-lg z-50 animate-bounce">
      <span class="font-bold">{{ notificationMessage }}</span>
    </div>
  </div>
</template>
