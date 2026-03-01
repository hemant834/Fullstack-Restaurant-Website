<script setup>
import { RouterLink } from 'vue-router'
import { useCartStore } from '../stores/cart'

const cartStore = useCartStore()

const premiumItems = [
    {
        id: 'qa-1',
        name: 'Truffle Risotto',
        price: 499,
        description: 'Arborio rice slow-cooked with black truffle oil and parmesan crisp.',
        image: 'https://images.unsplash.com/photo-1476124369491-e7addf5db371?q=80&w=800&auto=format&fit=crop',
        category: 'Signature'
    },
    {
        id: 'qa-2',
        name: 'Grilled Salmon',
        price: 549,
        description: 'Fresh Atlantic salmon perfectly grilled with asparagus and lemon butter sauce.',
        image: 'https://images.unsplash.com/photo-1519708227418-c8fd9a3a2720?q=80&w=800&auto=format&fit=crop',
        category: 'Seafood'
    },
    {
        id: 'qa-3',
        name: 'Wagyu Beef Steak',
        price: 899,
        description: 'Premium A5 Wagyu cut, seared to perfection, served with mashed potatoes.',
        image: 'https://images.unsplash.com/photo-1546964124-0cce460f38ef?q=80&w=800&auto=format&fit=crop',
        category: 'Steak'
    },
    {
        id: 'qa-4',
        name: 'Lobster Thermidor',
        price: 999,
        description: 'Whole lobster tail cooked in a rich creamy sauce with cognac and cheese.',
        image: 'https://images.unsplash.com/photo-1533777857889-4be7c70b33f7?q=80&w=800&auto=format&fit=crop',
        category: 'Seafood'
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
                <h1 class="text-4xl md:text-6xl font-serif font-bold text-primary mb-4">Quality Assured</h1>
                <p class="text-xl text-gray-400">Premium Ingredients • Top Hygiene</p>
            </div>

            <div
                class="max-w-4xl mx-auto bg-card rounded-2xl p-8 mb-16 border border-gray-custom shadow-2xl animate-fade-up animate-delay-100">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center">
                    <div class="order-2 md:order-1 relative h-64 rounded-xl overflow-hidden">
                        <img src="https://images.unsplash.com/photo-1414235077428-338989a2e8c0?q=80&w=2670&auto=format&fit=crop"
                            class="absolute inset-0 w-full h-full object-cover transform hover:scale-105 transition-transform duration-500"
                            alt="Quality Food">
                    </div>
                    <div class="order-1 md:order-2">
                        <h2 class="text-3xl font-bold text-white mb-4">5-Star Standards</h2>
                        <p class="text-gray-400 leading-relaxed mb-6">
                            We adhere to the strictest hygiene standards in the industry. Our kitchen is open for
                            inspection, and our chefs are trained in international food safety protocols.
                        </p>
                        <ul class="space-y-3">
                            <li class="flex items-center text-gray-300">
                                <svg class="w-5 h-5 text-primary mr-3" fill="none" stroke="currentColor"
                                    viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                </svg>
                                Strict Hygiene Checks
                            </li>
                            <li class="flex items-center text-gray-300">
                                <svg class="w-5 h-5 text-primary mr-3" fill="none" stroke="currentColor"
                                    viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                </svg>
                                Premium Imported Ingredients
                            </li>
                            <li class="flex items-center text-gray-300">
                                <svg class="w-5 h-5 text-primary mr-3" fill="none" stroke="currentColor"
                                    viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                </svg>
                                Regular Food Safety Audits
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Signature Collection Grid -->
            <div class="mb-16">
                <h2
                    class="text-3xl font-serif font-bold text-white text-center mb-12 animate-fade-up animate-delay-200">
                    Chef's Signature Collection</h2>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                    <div v-for="(item, index) in premiumItems" :keyিনাitem.id"
                        class="bg-card rounded-xl overflow-hidden border border-gray-custom hover:border-primary/50 transition-all hover:-translate-y-2 group animate-fade-up"
                        :style="`animation-delay: ${0.2 + (index * 0.1)}s`">
                        <div class="flex flex-col md:flex-row h-full">
                            <div class="md:w-2/5 h-48 md:h-auto overflow-hidden relative">
                                <img :src="item.image" :alt="item.name"
                                    class="w-full h-full object-cover transform group-hover:scale-110 transition-transform duration-500">
                            </div>
                            <div class="md:w-3/5 p-6 flex flex-col justify-between">
                                <div>
                                    <div class="flex justify-between items-start mb-2">
                                        <h3
                                            class="text-xl font-bold text-white group-hover:text-primary transition-colors">
                                            {{ item.name }}</h3>
                                        <span class="text-primary font-bold text-lg">₹{{ item.price }}</span>
                                    </div>
                                    <p class="text-gray-400 text-sm mb-4">{{ item.description }}</p>
                                    <div
                                        class="inline-block px-3 py-1 bg-dark-lighter rounded-full text-xs text-primary border border-primary/20 mb-4">
                                        {{ item.category }}
                                    </div>
                                </div>
                                <button @click="addItemToCart(item)"
                                    class="w-full py-2 bg-primary text-dark hover:bg-white font-bold rounded-lg transition-all flex items-center justify-center gap-2 transform active:scale-95">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none"
                                        viewBox="0 0 24 24" stroke="currentColor">
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
