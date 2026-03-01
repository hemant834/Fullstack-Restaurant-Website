<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '../stores/user'

const userStore = useUserStore()
const router = useRouter()

const discountCode = ref('')
const message = ref('')
const messageType = ref('')

// Auth State
const isRegistering = ref(false)
const form = ref({
    name: '',
    email: '',
    password: ''
})

const authMessage = ref('')
const authSuccess = ref(false)

/* ================= AUTH (REGISTER + LOGIN) ================= */
async function handleAuth() {
    console.log('handleAuth called', isRegistering.value)

    authMessage.value = ''
    authSuccess.value = false

    if (!form.value.email || !form.value.password) {
        authMessage.value = 'Please fill in all details.'
        return
    }

    if (isRegistering.value && !form.value.name) {
        authMessage.value = 'Please enter your name.'
        return
    }

    try {
        const url = isRegistering.value
            ? '/api/register'
            : '/api/login'

        const payload = isRegistering.value
            ? {
                name: form.value.name,
                email: form.value.email,
                password: form.value.password
            }
            : {
                email: form.value.email,
                password: form.value.password
            }

        const res = await fetch(url, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload)
        })

        const data = await res.json()

        authMessage.value = data.message
        authSuccess.value = data.success

        if (data.success) {
            if (isRegistering.value) {
                // Register ke baad Login tab auto open
                isRegistering.value = false
            } else {
                // Login success → store me user set
                userStore.setUser(data.user)
            }
            form.value.password = ''
        }
    } catch (err) {
        authMessage.value = 'Server error. Please try again.'
    }
}

/* ================= LOGOUT ================= */
function handleLogout() {
    userStore.logout()
    router.push('/profile')
}

/* ================= LOYALTY ================= */
function handleRedeem() {
    if (!discountCode.value.trim()) return

    const result = userStore.redeemCode(discountCode.value.toUpperCase())
    message.value = result.message
    messageType.value = result.success ? 'success' : 'error'

    if (result.success) {
        discountCode.value = ''
    }

    setTimeout(() => {
        message.value = ''
    }, 3000)
}
</script>

<template>
    <div class="min-h-screen pt-24 pb-12 bg-dark flex flex-col">

        <!-- AUTHENTICATED VIEW -->
        <div v-if="userStore.isAuthenticated" class="container mx-auto px-4">
            <div class="max-w-4xl mx-auto">
                <div class="flex justify-between items-center mb-8">
                    <h1 class="text-4xl font-bold text-primary font-serif">
                        My Loyalty Profile
                    </h1>
                    <button @click="handleLogout"
                        class="px-6 py-2 border border-red-500/50 text-red-500 rounded-lg hover:bg-red-500/10 font-bold">
                        Logout
                    </button>
                </div>

                <div class="bg-card p-6 rounded-xl border border-gray-custom text-center mb-6">
                    <div
                        class="w-24 h-24 bg-primary/20 rounded-full flex items-center justify-center border-2 border-primary mx-auto mb-4">
                        <span class="text-3xl font-bold text-primary">
                            {{ userStore.user?.name
                                ? userStore.user.name.charAt(0).toUpperCase()
                                : 'U'
                            }}
                        </span>
                    </div>
                    <h2 class="text-2xl font-bold text-white">
                        {{ userStore.user?.name || 'Guest' }}
                    </h2>
                    <p class="text-gray-400">
                        {{ userStore.user?.email || 'No email' }}
                    </p>
                </div>

                <div class="bg-card p-6 rounded-xl border border-gray-custom">
                    <h3 class="text-xl font-bold text-white mb-2">
                        Free Plate Reward
                    </h3>
                    <p class="text-gray-400 mb-4">
                        Earn 1 free dish for every 20 plates purchased. Rewards never expire!
                    </p>

                    <p class="text-2xl font-bold text-primary mb-2">
                        {{ userStore.platesTowardNextReward }} / 20
                    </p>

                    <div class="w-full bg-dark-lighter h-3 rounded-full">
                        <div class="bg-primary h-3 rounded-full"
                            :style="{ width: `${(userStore.platesTowardNextReward / 20) * 100}%` }"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- LOGIN / REGISTER VIEW -->
        <div v-else class="container mx-auto px-4 flex-grow flex items-center justify-center">
            <div class="max-w-md w-full bg-card p-8 rounded-xl border border-gray-custom">

                <div class="flex bg-dark-lighter p-1 rounded-lg mb-6">
                    <button @click="isRegistering = false" :class="[
                        'flex-1 py-2 font-bold rounded-md',
                        !isRegistering ? 'bg-primary text-dark' : 'text-gray-400'
                    ]">
                        Login
                    </button>
                    <button @click="isRegistering = true" :class="[
                        'flex-1 py-2 font-bold rounded-md',
                        isRegistering ? 'bg-primary text-dark' : 'text-gray-400'
                    ]">
                        Register
                    </button>
                </div>

                <div class="text-center mb-6">
                    <h1 class="text-3xl font-bold text-primary mb-2">
                        {{ isRegistering ? 'Create Account' : 'Welcome Back' }}
                    </h1>
                    <p class="text-gray-300 text-sm">
                        {{ isRegistering
                            ? 'Join to start earning tasty rewards.'
                            : 'Login to view your rewards and stats.'
                        }}
                    </p>
                </div>

                <form @submit.prevent="handleAuth" class="space-y-4">
                    <div v-if="isRegistering">
                        <input type="text" v-model="form.name" placeholder="Full Name"
                            class="w-full px-4 py-3 rounded bg-dark-lighter text-white" />
                    </div>

                    <input type="email" v-model="form.email" placeholder="Email"
                        class="w-full px-4 py-3 rounded bg-dark-lighter text-white" />

                    <input type="password" v-model="form.password" placeholder="Password"
                        class="w-full px-4 py-3 rounded bg-dark-lighter text-white" />

                    <button type="submit" class="w-full bg-primary text-dark py-3 rounded font-bold">
                        {{ isRegistering ? 'Register' : 'Login' }}
                    </button>
                </form>

                <p v-if="authMessage" :class="[
                    'mt-4 text-center font-bold',
                    authSuccess ? 'text-green-500' : 'text-red-500'
                ]">
                    {{ authMessage }}
                </p>
            </div>
        </div>
    </div>
</template>
