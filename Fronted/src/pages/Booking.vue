<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '../stores/user'

const router = useRouter()
const userStore = useUserStore()

const booking = ref({
    name: '',
    email: '',
    phone: '',
    date: '',
    time: '',
    guests: 2,
    specialRequest: ''
})

const isSubmitting = ref(false)
const showSuccess = ref(false)

// ✅ ONLY THIS FUNCTION CHANGED (REAL BACKEND CALL)
async function handleSubmit() {
    isSubmitting.value = true

    try {
        const res = await fetch('/api/book-table', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                name: booking.value.name,
                email: booking.value.email,
                phone: booking.value.phone,
                guests: booking.value.guests,
                date: booking.value.date,
                time: booking.value.time,
                request: booking.value.specialRequest
            })
        })

        const data = await res.json()
        console.log('Backend response:', data)

        if (data.success) {
            userStore.addBooking()
            showSuccess.value = true

            setTimeout(() => {
                showSuccess.value = false
                router.push('/')
            }, 2000)
        } else {
            alert(data.message || 'Booking failed')
        }

    } catch (err) {
        console.error('Booking error:', err)
        alert('Server error. Please try again.')
    } finally {
        isSubmitting.value = false
    }
}

// Min date
const today = new Date().toISOString().split('T')[0]
</script>

<template>
    <div class="min-h-screen pt-24 pb-12 bg-dark">
        <div class="container mx-auto px-4">
            <div class="max-w-3xl mx-auto">

                <div class="text-center mb-10">
                    <h1 class="text-4xl font-bold text-primary font-serif mb-4">
                        Book a Table
                    </h1>
                    <p class="text-gray-400">
                        Reserve your spot for an unforgettable dining experience.
                    </p>
                </div>

                <div
                    class="bg-card p-8 md:p-10 rounded-xl shadow-xl border border-gray-custom relative overflow-hidden">

                    <!-- SUCCESS OVERLAY (UNCHANGED) -->
                    <div v-if="showSuccess"
                        class="absolute inset-0 bg-dark-lighter/95 backdrop-blur-sm flex flex-col items-center justify-center z-20 animate-fade-in">
                        <div class="w-20 h-20 bg-primary rounded-full flex items-center justify-center mb-6">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10 text-dark" fill="none"
                                viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="3"
                                    d="M5 13l4 4L19 7" />
                            </svg>
                        </div>
                        <h3 class="text-2xl font-bold text-white mb-2">
                            Booking Confirmed!
                        </h3>
                        <p class="text-gray-400">
                            Confirmation email sent 🎉
                        </p>
                    </div>

                    <!-- FORM (UNCHANGED LAYOUT) -->
                    <form @submit.prevent="handleSubmit" class="space-y-6">

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="space-y-2">
                                <label class="text-sm text-gray-300">Full Name</label>
                                <input v-model="booking.name" required
                                    class="w-full bg-dark border border-gray-custom rounded-lg px-4 py-3 text-white" />
                            </div>

                            <div class="space-y-2">
                                <label class="text-sm text-gray-300">Email Address</label>
                                <input v-model="booking.email" type="email" required
                                    class="w-full bg-dark border border-gray-custom rounded-lg px-4 py-3 text-white" />
                            </div>

                            <div class="space-y-2">
                                <label class="text-sm text-gray-300">Phone Number</label>
                                <input v-model="booking.phone" required
                                    class="w-full bg-dark border border-gray-custom rounded-lg px-4 py-3 text-white" />
                            </div>

                            <div class="space-y-2">
                                <label class="text-sm text-gray-300">Number of Guests</label>
                                <select v-model="booking.guests"
                                    class="w-full bg-dark border border-gray-custom rounded-lg px-4 py-3 text-white">
                                    <option v-for="n in 10" :key="n" :value="n">
                                        {{ n }} Guests
                                    </option>
                                </select>
                            </div>

                            <div class="space-y-2">
                                <label class="text-sm text-gray-300">Date</label>
                                <input v-model="booking.date" type="date" :min="today" required
                                    class="w-full bg-dark border border-gray-custom rounded-lg px-4 py-3 text-white" />
                            </div>

                            <div class="space-y-2">
                                <label class="text-sm text-gray-300">Time</label>
                                <input v-model="booking.time" type="time" required
                                    class="w-full bg-dark border border-gray-custom rounded-lg px-4 py-3 text-white" />
                            </div>
                        </div>

                        <div class="space-y-2">
                            <label class="text-sm text-gray-300">Special Request (Optional)</label>
                            <textarea v-model="booking.specialRequest" rows="3"
                                class="w-full bg-dark border border-gray-custom rounded-lg px-4 py-3 text-white"></textarea>
                        </div>

                        <button type="submit" :disabled="isSubmitting"
                            class="w-full bg-primary text-dark font-bold text-lg py-4 rounded-lg">
                            {{ isSubmitting ? 'Confirming Reservation...' : 'Confirm Reservation' }}
                        </button>

                    </form>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.animate-fade-in {
    animation: fadeIn 0.3s ease-out;
}

@keyframes fadeIn {
    from {
        opacity: 0
    }

    to {
        opacity: 1
    }
}
</style>
