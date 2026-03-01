<template>
  <footer class="bg-dark-lighter border-t border-gray-custom mt-auto">
    <div class="container mx-auto px-4 py-8">
      <div class="grid grid-cols-1 md:grid-cols-3 gap-8 text-center md:text-left">
        <div>
          <h3 class="text-xl font-bold text-primary mb-4 font-serif">Secret Garden</h3>
          <p class="text-gray-400">Experience the best culinary delights in town. Fresh ingredients, unlimited love.</p>
        </div>
        <div>
          <h3 class="text-lg font-bold text-white mb-4">Quick Links</h3>
          <div class="flex flex-col space-y-2">
            <router-link to="/" class="text-gray-400 hover:text-primary transition-colors">Home</router-link>
            <router-link to="/menu" class="text-gray-400 hover:text-primary transition-colors">Menu</router-link>
            <router-link to="/cart" class="text-gray-400 hover:text-primary transition-colors">Cart</router-link>
          </div>
        </div>
        <div>
          <h3 class="text-lg font-bold text-white mb-4">Contact</h3>
          <p class="text-gray-400">CIT ke samne,Abu Road, Rajasthan, 307026</p>
          <p class="text-gray-400">hemantkumar809499@gmail.com</p>
          <p class="text-gray-400">+91 8094991751</p>
        </div>
      </div>
      <div class="border-t border-gray-custom mt-8 pt-4 text-center text-gray-500 text-sm">
        &copy; 2026 Secret Garden. All rights reserved.
      </div>
    </div>
  </footer>
</template>
