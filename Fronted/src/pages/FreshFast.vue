<script setup>
import { RouterLink } from 'vue-router'
import { useCartStore } from '../stores/cart'

const cartStore = useCartStore()

const quickItems = [
    {
        id: 'ff-1',
        name: 'Classic Cheese Burger',
        price: 149,
        description: 'Juicy patty, melted cheddar, fresh lettuce, and house sauce.',
        image: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=800&auto=format&fit=crop',
        category: 'Burger'
    },
    {
        id: 'ff-2',
        name: 'Spicy Chicken Wrap',
        price: 189,
        description: 'Grilled chicken, spicy mayo, crunchy veggies in a soft tortilla.',
        image: 'https://images.unsplash.com/photo-1626700051175-6818013e1d4f?q=80&w=800&auto=format&fit=crop',
        category: 'Wrap'
    },
    {
        id: 'ff-3',
        name: 'Club Sandwich',
        price: 169,
        description: 'Triple-layered toasted bread with chicken, egg, and fresh salad.',
        image: 'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?q=80&w=800&auto=format&fit=crop',
        category: 'Sandwich'
    },
    {
        id: 'ff-4',
        name: 'Peri Peri Fries',
        price: 99,
        description: 'Crispy golden fries tossed in our signature spicy peri peri mix.',
        image: 'https://images.unsplash.com/photo-1630384060421-cb20d0e0649d?q=80&w=800&auto=format&fit=crop',
        category: 'Sides'
    },
    {
        id: 'ff-5',
        name: 'Veggie Supreme Burger',
        price: 139,
        description: 'Crispy veggie patty with tangy sauce and fresh onions.',
        image: 'https://images.unsplash.com/photo-1550547660-d9450f859349?q=80&w=800&auto=format&fit=crop',
        category: 'Burger'
    },
    {
        id: 'ff-6',
        name: 'Cold Coffee',
        price: 119,
        description: 'Classic brewed cold coffee with a scoop of vanilla ice cream.',
        image: 'https://images.unsplash.com/photo-1517701604599-bb29b5aa5023?q=80&w=800&auto=format&fit=crop',
        category: 'Beverage'
    }
]

const addItemToCart = (item) => {
    cartStore.addToCart(item)
}
</script>

<template>
    <div class="pt-24 pb-16 min-h-screen bg-dark">
        <div class="container mx-auto px-4">
            <div class="text-center mb-16 animate-fade-up">
                <h1 class="text-4xl md:text-6xl font-serif font-bold text-primary mb-4">Fresh & Fast</h1>
                <p class="text-xl text-gray-400">Farm to Table • Express Service</p>
            </div>

            <div
                class="max-w-4xl mx-auto bg-card rounded-2xl p-8 mb-16 border border-gray-custom shadow-2xl animate-fade-up animate-delay-100">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center">
                    <div>
                        <h2 class="text-3xl font-bold text-white mb-4">Our Freshness Promise</h2>
                        <p class="text-gray-400 leading-relaxed mb-6">
                            We believe that great food starts with great ingredients. That's why we source our
                            vegetables daily from local organic farms.
                            All our dishes are prepared fresh upon order, ensuring you get the maximum flavor and
                            nutrition.
                        </p>
                        <div class="flex items-center space-x-4 mb-6">
                            <div class="text-primary">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24"
                                    stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                                </svg>
                            </div>
                            <div>
                                <h4 class="text-white font-bold">20 Minute Service</h4>
                                <p class="text-sm text-gray-500">Average serving time</p>
                            </div>
                        </div>
                    </div>
                    <div class="relative h-64 rounded-xl overflow-hidden">
                        <img src="https://images.unsplash.com/photo-1546069901-ba9599a7e63c?q=80&w=2680&auto=format&fit=crop"
                            class="absolute inset-0 w-full h-full object-cover transform hover:scale-105 transition-transform duration-500"
                            alt="Fresh Food">
                    </div>
                </div>
            </div>

            <!-- Quick Eats Menu Grid -->
            <div class="mb-16">
                <h2
                    class="text-3xl font-serif font-bold text-white text-center mb-12 animate-fade-up animate-delay-200">
                    Express Menu</h2>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                    <div v-for="(item, index) in quickItems" :keyিনাitem.id"
                        class="bg-card rounded-xl overflow-hidden border border-gray-custom hover:border-primary/50 transition-all hover:-translate-y-2 group animate-fade-up"
                        :style="`animation-delay: ${0.2 + (index * 0.1)}s`">
                        <div class="h-48 overflow-hidden relative">
                            <img :src="item.image" :alt="item.name"
                                class="w-full h-full object-cover transform group-hover:scale-110 transition-transform duration-500">
                            <div
                                class="absolute top-2 right-2 bg-black/70 backdrop-blur-sm px-3 py-1 rounded-full text-xs text-primary font-bold border border-primary/20">
                                {{ item.category }}
                            </div>
                        </div>
                        <div class="p-6">
                            <div class="flex justify-between items-start mb-2">
                                <h3 class="text-xl font-bold text-white group-hover:text-primary transition-colors">{{
                                    item.name }}</h3>
                                <span class="text-primary font-bold">₹{{ item.price }}</span>
                            </div>
                            <p class="text-gray-400 text-sm mb-6 line-clamp-2 h-10">{{ item.description }}</p>
                            <button @click="addItemToCart(item)"
                                class="w-full py-2 border border-primary text-primary hover:bg-primary hover:text-dark font-bold rounded-lg transition-all flex items-center justify-center gap-2">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24"
                                    stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
                                </svg>
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</template>

<style scoped>
@keyframes fade-up {
    from {
        opacity: 0;
        transform: translateY(20px);
    }

    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.animate-fade-up {
    animation: fade-up 0.8s ease-out forwards;
}

.animate-delay-100 {
    animation-delay: 0.2s;
}

.animate-delay-200 {
    animation-delay: 0.4s;
}
</style>
