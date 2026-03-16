<script setup>
import { RouterLink, useRouter } from 'vue-router'
import { useCartStore } from '../stores/cart'
import { useUserStore } from '../stores/user'
import { ref, computed, onMounted, onUnmounted } from 'vue'

const cartStore = useCartStore()
const userStore = useUserStore()
const router = useRouter()

const isMobileMenuOpen = ref(false)
const currentTheme = ref('default') // default, royal, emerald, crimson, amethyst

const themes = ['default', 'royal', 'emerald', 'crimson', 'amethyst']

function toggleTheme() {
  const currentIndex = themes.indexOf(currentTheme.value)
  const nextIndex = (currentIndex + 1) % themes.length
  const nextTheme = themes[nextIndex]

  // Remove all theme classes first
  themes.forEach(theme => {
    if (theme !== 'default') {
      document.body.classList.remove(`theme-${theme}`)
    }
  })

  // Add new theme class if not default
  if (nextTheme !== 'default') {
    document.body.classList.add(`theme-${nextTheme}`)
  }

  currentTheme.value = nextTheme
  localStorage.setItem('theme', nextTheme)
}

const isVisible = ref(true)
const lastScrollPosition = ref(0)

function handleScroll() {
  const currentScrollPosition = window.pageYOffset || document.documentElement.scrollTop
  if (currentScrollPosition < 0) return

  // Show navbar if at the very top
  if (currentScrollPosition < 50) {
    isVisible.value = true
    lastScrollPosition.value = currentScrollPosition
    return
  }

  // Throttle small movements
  if (Math.abs(currentScrollPosition - lastScrollPosition.value) < 10) return

  // Show if scrolling UP, Hide if scrolling DOWN
  isVisible.value = currentScrollPosition < lastScrollPosition.value
  lastScrollPosition.value = currentScrollPosition
}

onMounted(() => {
  const savedTheme = localStorage.getItem('theme')
  if (themes.includes(savedTheme)) {
    currentTheme.value = savedTheme
    if (savedTheme !== 'default') {
      document.body.classList.add(`theme-${savedTheme}`)
    }
  }
  window.addEventListener('scroll', handleScroll)
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
})

// Robust check for user display name
const userInitials = computed(() => {
  if (userStore.user && userStore.user.name) {
    return userStore.user.name.charAt(0).toUpperCase()
  }
  return 'U' // Fallback for User
})

function toggleMobileMenu() {
  isMobileMenuOpen.value = !isMobileMenuOpen.value
}

// function handleLogout() {
//   userStore.logout()
//   isMobileMenuOpen.value = false
//   router.push('/register')
// }
// Logout is now handled in Profile page

</script>

<template>
  <nav :class="[
    'fixed top-0 w-full z-50 bg-dark-lighter/90 backdrop-blur-md border-b border-gray-custom shadow-lg transition-transform duration-300',
    isVisible ? 'translate-y-0' : '-translate-y-full'
  ]">
    <div class="container mx-auto px-4 py-4 flex justify-between items-center">
      <!-- Logo -->
      <RouterLink to="/" class="text-2xl font-bold font-serif text-primary tracking-wider z-50 flex-shrink-0">
        <img src="../assets/images/logo.png" alt="Logo" width="50" height="50"
          class="inline-block mr-2 rounded-full">Secret <span class="text-white">Garden</span>
      </RouterLink>

      <!-- Desktop Navigation & Profile (Hidden on Mobile) -->
      <div class="hidden md:flex items-center space-x-8">
        <RouterLink to="/" class="text-white hover:text-primary transition-colors font-medium">Home</RouterLink>
        <RouterLink to="/menu" class="text-white hover:text-primary transition-colors font-medium">Menu</RouterLink>
        <RouterLink to="/booking" class="text-white hover:text-primary transition-colors font-medium">Book Table</RouterLink>
        <RouterLink to="/track" class="text-white hover:text-primary transition-colors font-medium">Track Order</RouterLink>

        <!-- Cart -->
        <RouterLink to="/cart" class="relative group">
          <div class="flex items-center space-x-2 text-white group-hover:text-primary transition-colors">
            <span class="font-medium">Cart</span>
            <div class="relative">
              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                class="lucide lucide-shopping-cart">
                <circle cx="8" cy="21" r="1" />
                <circle cx="19" cy="21" r="1" />
                <path d="M2.05 2.05h2l2.66 12.42a2 2 0 0 0 2 1.58h9.78a2 2 0 0 0 1.95-1.57l1.65-7.43H5.12" />
              </svg>
              <span v-if="cartStore.totalItems > 0"
                class="absolute -top-2 -right-2 bg-primary text-dark text-xs font-bold w-5 h-5 rounded-full flex items-center justify-center">
                {{ cartStore.totalItems }}
              </span>
            </div>
          </div>
        </RouterLink>

        <!-- Theme Toggle -->

        <button @click="toggleTheme"
          class="p-2 rounded-full hover:bg-white/10 transition-colors focus:outline-none flex items-center justify-center w-10 h-10"
          :title="'Current Theme: ' + currentTheme.charAt(0).toUpperCase() + currentTheme.slice(1)">
          <span v-if="currentTheme === 'default'" class="text-xl">⚫</span>
          <span v-else-if="currentTheme === 'royal'" class="text-xl">🌌</span>
          <span v-else-if="currentTheme === 'emerald'" class="text-xl">🌿</span>
          <span v-else-if="currentTheme === 'crimson'" class="text-xl">🌹</span>
          <span v-else-if="currentTheme === 'amethyst'" class="text-xl">🔮</span>
        </button>

        <!-- Profile Link (No Dropdown) -->
        <RouterLink to="/profile" class="relative group">
          <div
            :class="['w-10 h-10 rounded-full flex items-center justify-center border-2 shadow-[0_0_10px_rgba(226,177,60,0.3)] transition-all hover:shadow-[0_0_15px_rgba(226,177,60,0.5)]', userStore.isAuthenticated ? 'bg-primary/20 border-primary' : 'bg-gray-800 border-gray-600']">
            <span :class="['font-bold', userStore.isAuthenticated ? 'text-primary' : 'text-gray-400']">{{ userInitials
            }}</span>
          </div>
        </RouterLink>
      </div>

      <!-- Mobile Header Right Section (Visible ONLY on Mobile) -->
      <div class="flex items-center gap-4 md:hidden">
        <!-- Mobile Theme Toggle -->
        <button @click="toggleTheme"
          class="p-2 rounded-full hover:bg-white/10 transition-colors focus:outline-none flex items-center justify-center w-10 h-10"
          :title="'Current Theme: ' + currentTheme.charAt(0).toUpperCase() + currentTheme.slice(1)">
          <span v-if="currentTheme === 'default'" class="text-xl">🌑</span>
          <span v-else-if="currentTheme === 'royal'" class="text-xl">🌌</span>
          <span v-else-if="currentTheme === 'emerald'" class="text-xl">🌿</span>
          <span v-else-if="currentTheme === 'crimson'" class="text-xl">🌹</span>
          <span v-else-if="currentTheme === 'amethyst'" class="text-xl">🔮</span>
        </button>

        <!-- Mobile Profile Icon -->
        <RouterLink to="/profile"
          :class="['w-10 h-10 rounded-full flex items-center justify-center border-2 font-bold shadow-[0_0_10px_rgba(226,177,60,0.3)]', userStore.isAuthenticated ? 'bg-primary/20 border-primary text-primary' : 'bg-gray-800 border-gray-600 text-gray-400']">
          {{ userInitials }}
        </RouterLink>

        <!-- Mobile Menu Toggler -->
        <button @click="toggleMobileMenu" class="text-white p-1 focus:outline-none">
          <svg v-if="!isMobileMenuOpen" xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-primary" fill="none"
            viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16m-7 6h7" />
          </svg>
          <svg v-else xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-primary" fill="none" viewBox="0 0 24 24"
            stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
          </svg>
        </button>
      </div>
    </div>

    <!-- Mobile Menu Drawer -->
    <div v-show="isMobileMenuOpen"
      class="md:hidden bg-dark-lighter border-t border-gray-custom animate-fade-in shadow-2xl">
      <div class="container mx-auto px-4 py-6 flex flex-col space-y-4">
        <RouterLink to="/"
          class="text-white hover:text-primary transition-colors font-medium py-2 text-lg border-b border-gray-800"
          @click="isMobileMenuOpen = false">Home</RouterLink>
        <RouterLink to="/menu"
          class="text-white hover:text-primary transition-colors font-medium py-2 text-lg border-b border-gray-800"
          @click="isMobileMenuOpen = false">Menu</RouterLink>
        <RouterLink to="/booking"
          class="text-white hover:text-primary transition-colors font-medium py-2 text-lg border-b border-gray-800"
          @click="isMobileMenuOpen = false">Book Table</RouterLink>
        <RouterLink to="/track"
          class="text-white hover:text-primary transition-colors font-medium py-2 text-lg border-b border-gray-800"
          @click="isMobileMenuOpen = false">Track Order</RouterLink>
        <RouterLink to="/cart"
          class="text-white hover:text-primary transition-colors font-medium py-2 flex items-center justify-between border-b border-gray-800"
          @click="isMobileMenuOpen = false">
          <span>Cart</span>
          <span v-if="cartStore.totalItems > 0" class="bg-primary text-dark text-xs font-bold px-2 py-1 rounded-full">{{
            cartStore.totalItems }}</span>
        </RouterLink>

        <div class="pt-4 pb-4">
          <RouterLink to="/profile"
            class="block w-full py-3 text-center bg-primary text-dark font-bold rounded-lg hover:bg-primary-hover transition-colors"
            @click="isMobileMenuOpen = false">
            {{ userStore.isAuthenticated ? 'My Profile' : 'Login / Register' }}
          </RouterLink>
        </div>
      </div>
    </div>
  </nav>
</template>

<style scoped>
.router-link-active {
  @apply text-primary;
}

@keyframes fadeInDown {
  from {
    opacity: 0;
    transform: translateY(-10px);
  }

  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.animate-fade-in-down {
  animation: fadeInDown 0.2s ease-out forwards;
}

@keyframes fadeIn {
  from {
    opacity: 0;
  }

  to {
    opacity: 1;
  }
}

.animate-fade-in {
  animation: fadeIn 0.2s ease-out forwards;
}
</style>
