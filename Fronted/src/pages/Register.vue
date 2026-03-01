<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '../stores/user'

const router = useRouter()
const userStore = useUserStore()

const form = ref({
    name: '',
    email: '',
    password: '',
    confirmPassword: ''
})

const errors = ref({})
const isSubmitting = ref(false)

function validate() {
    errors.value = {}

    if (!form.value.name.trim()) {
        errors.value.name = 'Full Name is required'
    }

    if (!form.value.email.trim()) {
        errors.value.email = 'Email is required'
    } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(form.value.email)) {
        errors.value.email = 'Invalid email format'
    }

    if (!form.value.password) {
        errors.value.password = 'Password is required'
    } else if (form.value.password.length < 6) {
        errors.value.password = 'Password must be at least 6 characters'
    }

    if (form.value.password !== form.value.confirmPassword) {
        errors.value.confirmPassword = 'Passwords do not match'
    }

    return Object.keys(errors.value).length === 0
}

function handleRegister() {
    if (!validate()) return

    isSubmitting.value = true

    setTimeout(() => {
        // Use Store Action
        const result = userStore.register(
            form.value.name,
            form.value.email,
            form.value.password
        )

        isSubmitting.value = false

        if (result.success) {
            router.push('/profile')
        } else {
            if (result.message.toLowerCase().includes('email')) {
                errors.value.email = result.message
            } else {
                // Fallback for generic error if any
                alert(result.message)
            }
        }
    }, 1000)
}
</script>

<template>
    <div
        class="min-h-screen flex items-center justify-center bg-dark px-4 bg-[url('https://images.unsplash.com/photo-1555396273-367ea4eb4db5?q=80&w=1974&auto=format&fit=crop')] bg-cover bg-center bg-no-repeat relative">

        <!-- Dark Overlay -->
        <div class="absolute inset-0 bg-dark/80 backdrop-blur-sm z-0"></div>

        <div
            class="max-w-md w-full bg-card/90 backdrop-blur-md p-8 rounded-xl shadow-2xl border border-gray-custom relative z-10 animate-fade-up">
            <div class="text-center mb-8">
                <h1 class="text-3xl font-bold font-serif text-primary mb-2">Create Account</h1>
                <p class="text-gray-300">Join Restodine to experience fine dining.</p>
            </div>

            <form @submit.prevent="handleRegister" class="space-y-5">
                <!-- Name -->
                <div>
                    <label class="block text-sm font-medium text-gray-300 mb-1">Full Name</label>
                    <input type="text" v-model="form.name"
                        class="w-full bg-dark-lighter border border-gray-custom rounded-lg px-4 py-3 text-white focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary transition-colors"
                        :class="{ 'border-red-500': errors.name }" placeholder="John Doe" />
                    <p v-if="errors.name" class="text-red-500 text-xs mt-1">{{ errors.name }}</p>
                </div>

                <!-- Email -->
                <div>
                    <label class="block text-sm font-medium text-gray-300 mb-1">Email Address</label>
                    <input type="email" v-model="form.email"
                        class="w-full bg-dark-lighter border border-gray-custom rounded-lg px-4 py-3 text-white focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary transition-colors"
                        :class="{ 'border-red-500': errors.email }" placeholder="john@example.com" />
                    <p v-if="errors.email" class="text-red-500 text-xs mt-1">{{ errors.email }}</p>
                </div>

                <!-- Password -->
                <div>
                    <label class="block text-sm font-medium text-gray-300 mb-1">Password</label>
                    <input type="password" v-model="form.password"
                        class="w-full bg-dark-lighter border border-gray-custom rounded-lg px-4 py-3 text-white focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary transition-colors"
                        :class="{ 'border-red-500': errors.password }" placeholder="••••••••" />
                    <p v-if="errors.password" class="text-red-500 text-xs mt-1">{{ errors.password }}</p>
                </div>

                <!-- Confirm Password -->
                <div>
                    <label class="block text-sm font-medium text-gray-300 mb-1">Confirm Password</label>
                    <input type="password" v-model="form.confirmPassword"
                        class="w-full bg-dark-lighter border border-gray-custom rounded-lg px-4 py-3 text-white focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary transition-colors"
                        :class="{ 'border-red-500': errors.confirmPassword }" placeholder="••••••••" />
                    <p v-if="errors.confirmPassword" class="text-red-500 text-xs mt-1">{{ errors.confirmPassword }}</p>
                </div>

                <button type="submit" :disabled="isSubmitting"
                    class="w-full bg-primary text-dark font-bold text-lg py-3 rounded-lg hover:bg-primary-hover transition-colors shadow-lg shadow-primary/20 flex items-center justify-center gap-2 mt-6 disabled:opacity-70 disabled:cursor-not-allowed">
                    <svg v-if="isSubmitting" class="animate-spin h-5 w-5 text-dark" xmlns="http://www.w3.org/2000/svg"
                        fill="none" viewBox="0 0 24 24">
                        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4">
                        </circle>
                        <path class="opacity-75" fill="currentColor"
                            d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z">
                        </path>
                    </svg>
                    <span>{{ isSubmitting ? 'Creating Account...' : 'Register Now' }}</span>
                </button>
            </form>
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
    animation: fade-up 0.6s ease-out forwards;
}
</style>
