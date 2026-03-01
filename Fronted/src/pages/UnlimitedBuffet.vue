<script setup>
import { RouterLink } from 'vue-router'
import { useCartStore } from '../stores/cart'

const cartStore = useCartStore()

const buffetItem = {
    id: 'unlimited-buffet',
    name: 'Unlimited Buffet Access',
    price: 299,
    description: 'All-you-can-eat experience',
    category: 'Buffet'
}

const addBuffetToCart = () => {
    cartStore.addToCart(buffetItem)
    // Optional: Toggle unlimited plan mode if strictly required by store logic,
    // but requirement says "Add as a product".
    // If we want the specialized pricing logic validation:
    // cartStore.toggleUnlimitedPlan() 
    // But we stick to adding product as requested.
}
</script>

<template>
    <div class="pt-24 pb-16 min-h-screen bg-dark">
        <div class="container mx-auto px-4">
            <!-- Header -->
            <div class="text-center mb-16 animate-fade-up">
                <h1 class="text-4xl md:text-6xl font-serif font-bold text-primary mb-4">Unlimited Buffet</h1>
                <p class="text-xl text-gray-400">All You Can Eat • Premium Experience</p>
            </div>

            <!-- Pricing Card -->
            <div
                class="max-w-4xl mx-auto bg-card rounded-2xl p-8 mb-16 border border-gray-custom shadow-2xl relative overflow-hidden animate-fade-up animate-delay-100">
                <div class="absolute top-0 right-0 bg-primary text-dark font-bold px-6 py-1 rounded-bl-2xl">
                    Best Value
                </div>
                <div class="flex flex-col md:flex-row items-center justify-between">
                    <div class="mb-6 md:mb-0">
                        <h2 class="text-3xl font-bold text-white mb-2">Grand Feast</h2>
                        <p class="text-gray-400">Unlimited access to all sections</p>
                    </div>
                    <div class="text-center md:text-right flex flex-col items-center md:items-end gap-3">
                        <div>
                            <span class="text-5xl font-bold text-primary">₹299</span>
                            <span class="text-gray-400 text-lg">/per person</span>
                        </div>
                        <button @click="addBuffetToCart"
                            class="px-8 py-2 mt-6 bg-primary text-dark font-bold rounded-lg hover:bg-white transition-all transform hover:scale-105 shadow-lg active:scale-95">
                            Add to Cart
                        </button>
                    </div>
                </div>
            </div>

            <!-- Menu Sections -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-16">
                <!-- Starters -->
                <div
                    class="bg-card p-8 rounded-xl border border-gray-custom hover:border-primary/50 transition-colors animate-fade-up animate-delay-200">
                    <h3 class="text-2xl font-serif font-bold text-white mb-6 border-b border-gray-custom pb-4">Starters
                    </h3>
                    <ul class="space-y-3 text-gray-300">
                        <li class="flex items-center space-x-2">
                            <span class="w-1.5 h-1.5 rounded-full bg-primary"></span>
                            <span>Crispy Corn</span>
                        </li>
                        <li class="flex items-center space-x-2">
                            <span class="w-1.5 h-1.5 rounded-full bg-primary"></span>
                            <span>Paneer Tikka</span>
                        </li>
                        <li class="flex items-center space-x-2">
                            <span class="w-1.5 h-1.5 rounded-full bg-primary"></span>
                            <span>Honey Chilli Potato</span>
                        </li>
                        <li class="flex items-center space-x-2">
                            <span class="w-1.5 h-1.5 rounded-full bg-primary"></span>
                            <span>Veg Seekh Kebab</span>
                        </li>
                    </ul>
                </div>

                <!-- Main Course -->
                <div
                    class="bg-card p-8 rounded-xl border border-gray-custom hover:border-primary/50 transition-colors animate-fade-up animate-delay-300">
                    <h3 class="text-2xl font-serif font-bold text-white mb-6 border-b border-gray-custom pb-4">Main
                        Course</h3>
                    <ul class="space-y-3 text-gray-300">
                        <li class="flex items-center space-x-2">
                            <span class="w-1.5 h-1.5 rounded-full bg-primary"></span>
                            <span>Paneer Butter Masala</span>
                        </li>
                        <li class="flex items-center space-x-2">
                            <span class="w-1.5 h-1.5 rounded-full bg-primary"></span>
                            <span>Dal Makhani</span>
                        </li>
                        <li class="flex items-center space-x-2">
                            <span class="w-1.5 h-1.5 rounded-full bg-primary"></span>
                            <span>Veg Biryani</span>
                        </li>
                        <li class="flex items-center space-x-2">
                            <span class="w-1.5 h-1.5 rounded-full bg-primary"></span>
                            <span>Assorted Breads</span>
                        </li>
                        <li class="flex items-center space-x-2">
                            <span class="w-1.5 h-1.5 rounded-full bg-primary"></span>
                            <span>Hakka Noodles</span>
                        </li>
                    </ul>
                </div>

                <!-- Desserts -->
                <div
                    class="bg-card p-8 rounded-xl border border-gray-custom hover:border-primary/50 transition-colors animate-fade-up animate-delay-400">
                    <h3 class="text-2xl font-serif font-bold text-white mb-6 border-b border-gray-custom pb-4">Desserts
                    </h3>
                    <ul class="space-y-3 text-gray-300">
                        <li class="flex items-center space-x-2">
                            <span class="w-1.5 h-1.5 rounded-full bg-primary"></span>
                            <span>Gulab Jamun</span>
                        </li>
                        <li class="flex items-center space-x-2">
                            <span class="w-1.5 h-1.5 rounded-full bg-primary"></span>
                            <span>Vanilla Ice Cream</span>
                        </li>
                        <li class="flex items-center space-x-2">
                            <span class="w-1.5 h-1.5 rounded-full bg-primary"></span>
                            <span>Chocolate Brownie</span>
                        </li>
                        <li class="flex items-center space-x-2">
                            <span class="w-1.5 h-1.5 rounded-full bg-primary"></span>
                            <span>Fresh Fruits</span>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Terms & Conditions -->
            <div
                class="bg-dark-lighter p-6 rounded-lg border border-red-500/20 max-w-2xl mx-auto animate-fade-up animate-delay-500">
                <h4 class="text-white font-bold mb-4 flex items-center">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-red-500 mr-2" viewBox="0 0 20 20"
                        fill="currentColor">
                        <path fill-rule="evenodd"
                            d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z"
                            clip-rule="evenodd" />
                    </svg>
                    Important Information
                </h4>
                <ul class="text-sm text-gray-400 space-y-2 list-disc list-inside">
                    <li>Offer valid for dine-in only.</li>
                    <li>Sharing of buffet is not allowed.</li>
                    <li>Wastage will be chargeable at ₹100/100g.</li>
                    <li>Kids up to 5 years eat for free.</li>
                    <li>Half charges applicable for kids between 5-10 years.</li>
                </ul>
            </div>

            <div class="mt-12 text-center animate-fade-up animate-delay-500">
                <RouterLink to="/booking"
                    class="inline-block px-10 py-4 bg-primary text-dark font-bold rounded-full hover:bg-primary-hover transition-all transform hover:scale-105 shadow-xl shadow-primary/20 text-lg">
                    Book Table Now
                </RouterLink>
            </div>

        </div>
    </div>
</template>

<style scoped>
/* Reuse the fade animations from Home if needed, or define locally as they might be global or scoped */
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
    animation-delay: 0.1s;
}

.animate-delay-200 {
    animation-delay: 0.2s;
}

.animate-delay-300 {
    animation-delay: 0.3s;
}

.animate-delay-400 {
    animation-delay: 0.4s;
}

.animate-delay-500 {
    animation-delay: 0.5s;
}
</style>
