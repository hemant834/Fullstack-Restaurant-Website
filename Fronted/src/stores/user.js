import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'

export const useUserStore = defineStore('user', () => {
    const router = useRouter()

    // State
    const user = ref(JSON.parse(localStorage.getItem('currentUser')) || null)

    // Simulate a database of users
    const users = ref(JSON.parse(localStorage.getItem('users')) || [])

    const stats = ref(JSON.parse(localStorage.getItem('userStats')) || {
        bookings: 0,
        totalPlates: 0,
        redeemedCodes: []
    })

    // Getters
    const isAuthenticated = computed(() => !!user.value)

    const earnedFreeDishes = computed(() => {
        // 1 free dish for every 20 plates
        return Math.floor(stats.value.totalPlates / 20)
    })

    const platesTowardNextReward = computed(() => {
        return stats.value.totalPlates % 20
    })

    // Actions
    // Actions
    function register(name, email, password) {
        if (users.value.find(u => u.email === email)) {
            return { success: false, message: 'Email already registered' }
        }

        const newUser = { name, email, password }
        users.value.push(newUser)
        localStorage.setItem('users', JSON.stringify(users.value))

        // Return success without login
        return { success: true, message: 'Registration successful. Please login.' }
    }

    function login(email, password) {
        const foundUser = users.value.find(u => u.email === email && u.password === password)

        if (foundUser) {
            // Create session user (exclude password)
            user.value = { name: foundUser.name, email: foundUser.email }
            localStorage.setItem('currentUser', JSON.stringify(user.value))
            return { success: true, message: 'Login successful' }
        }

        return { success: false, message: 'Invalid credentials' }
    }

    function setUser(userData) {
        // Deprecated but kept for compatibility if needed, prefer register/login
        user.value = userData
        localStorage.setItem('currentUser', JSON.stringify(userData))
    }

    function logout() {
        user.value = null
        // Clear session only
        localStorage.removeItem('currentUser')
        // We DO NOT clear 'users' or 'userStats' completely in a real app, 
        // but for this specific demo where stats are tied to "browser" rather than "user account" structure (simple version),
        // we might leave stats. Ideally, stats should be keyed by user ID. 
        // For simplicity here, we keep the stats as "local device stats".
    }

    function addBooking() {
        stats.value.bookings++
        saveStats()
    }

    function addOrder(platesCount) {
        stats.value.totalPlates += platesCount
        saveStats()
    }

    function redeemCode(code) {
        if (!code) return { success: false, message: 'Please enter a code.' }

        if (stats.value.redeemedCodes.includes(code)) {
            return { success: false, message: 'This code has already been used.' }
        }

        // Simulating valid dish codes (Accept any code > 3 chars that hasn't been used)
        if (code.length >= 3) {
            stats.value.redeemedCodes.push(code)
            stats.value.totalPlates++
            saveStats()

            if (stats.value.totalPlates % 20 === 0) {
                return { success: true, message: '🎉 Congratulations! You completed 20 plates and earned 1 Free Dish!' }
            }

            return { success: true, message: 'Code redeemed! 1 Plate added to your progress.' }
        }

        return { success: false, message: 'Invalid code format.' }
    }

    function saveStats() {
        localStorage.setItem('userStats', JSON.stringify(stats.value))
    }

    return {
        user,
        stats,
        isAuthenticated,
        earnedFreeDishes,
        setUser,
        login,
        register,
        logout,
        addBooking,
        addOrder,
        redeemCode,
        platesTowardNextReward
    }
})
