<script setup>
import { RouterView, useRoute } from 'vue-router'
import Navbar from './components/Navbar.vue'
import Footer from './components/Footer.vue'
import { computed } from 'vue'


const route = useRoute()
const showNavAndFooter = computed(() => route.path !== '/register')
</script>

<template>
  <div class="flex flex-col min-h-screen bg-dark text-white font-sans">
    <Navbar v-if="showNavAndFooter" />
    <main class="flex-grow">
      <RouterView v-slot="{ Component }">
        <transition name="fade" mode="out-in">
          <component :is="Component" />
        </transition>
      </RouterView>
    </main>
    <Footer v-if="showNavAndFooter" />
  </div>
</template>

<style>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>
