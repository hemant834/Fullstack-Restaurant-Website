import { defineStore } from 'pinia'
import { computed, ref, watch } from 'vue'

export const useCartStore = defineStore('cart', () => {
    // 🔹 Load from localStorage on init
    const items = ref(JSON.parse(localStorage.getItem('cart_items') || '[]'))
    const isUnlimitedPlan = ref(JSON.parse(localStorage.getItem('unlimited_plan') || 'false'))
    const unlimitedPrice = 299

    const totalItems = computed(() => {
        return items.value.reduce((total, item) => total + item.quantity, 0)
    })

    const totalPrice = computed(() => {
        if (isUnlimitedPlan.value) {
            return unlimitedPrice
        }
        return items.value.reduce((total, item) => total + (item.price * item.quantity), 0)
    })

    function saveToStorage() {
        localStorage.setItem('cart_items', JSON.stringify(items.value))
        localStorage.setItem('unlimited_plan', JSON.stringify(isUnlimitedPlan.value))
    }

    function addToCart(product) {
        const existingItem = items.value.find(item => item.id === product.id)
        if (existingItem) {
            if (existingItem.quantity < 20) {
                existingItem.quantity++
            } else {
                alert('Maximum 20 quantity allowed for this item')
            }
        } else {
            items.value.push({ ...product, quantity: 1 })
        }
        saveToStorage()

    }

    function decrementQuantity(productId) {
        const item = items.value.find(item => item.id === productId)
        if (item && item.quantity > 1) {
            item.quantity--
            saveToStorage()
        }
        // quantity === 1 par kuch nahi hoga
    }


    function incrementQuantity(productId) {
        const item = items.value.find(item => item.id === productId)
        if (item) {
            if (item.quantity < 20) {
                item.quantity++
                saveToStorage()
            } else {
                alert('Maximum 20 quantity allowed for this item')
            }
        }
    }

   

    function toggleUnlimitedPlan() {
        isUnlimitedPlan.value = !isUnlimitedPlan.value
        saveToStorage()
    }

    function clearCart() {
        items.value = []
        isUnlimitedPlan.value = false
        saveToStorage()
    }

    // ❌ Remove from cart (sirf remove button se)
    function removeFromCart(productId) {
        items.value = items.value.filter(item => item.id !== productId)
        saveToStorage()
    }

    return {
        items,
        isUnlimitedPlan,
        totalItems,
        totalPrice,
        addToCart,
        removeFromCart,
        incrementQuantity,
        decrementQuantity,
        toggleUnlimitedPlan,
        clearCart
    }
})