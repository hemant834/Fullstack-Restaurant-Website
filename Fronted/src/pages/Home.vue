<script setup>
import { RouterLink } from 'vue-router'
</script>

<template>
  <div>
    <!-- Hero Section -->
    <section class="relative h-screen flex items-center justify-center overflow-hidden">
      <div class="absolute inset-0 z-0">
        <!-- Overlay -->
        <div class="absolute inset-0 bg-gradient-to-b from-dark/70 via-dark/50 to-dark z-10"></div>
        <img src="https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?q=80&w=2070&auto=format&fit=crop"
          alt="Restaurant Interior" class="w-full h-full object-cover" />
      </div>

      <div class="relative z-20 container mx-auto px-6 text-center ">
        <h1 class="text-5xl md:text-7xl font-bold font-serif text-white mb-4 drop-shadow-lg opacity-0 animate-fade-up">
          Welcome to, <span class="text-primary">Secret Garden</span>
        </h1>
        <p
          class="text-xl md:text-2xl text-gray-200 mb-8 max-w-2xl mx-auto drop-shadow-md opacity-0 animate-fade-up animate-delay-100">
          Where luxury dining meets unforgettable flavors.
        </p>

        <div
          class="flex flex-col md:flex-row items-center justify-center space-y-4 md:space-y-0 md:space-x-4 opacity-0 animate-fade-up animate-delay-200">
          <RouterLink to="/menu"
            class="px-8 py-3 bg-primary text-dark font-bold rounded-full hover:bg-primary-hover transition-all transform hover:scale-105 shadow-lg shadow-primary/20">
            View Menu
          </RouterLink>
          <RouterLink to="/booking"
            class="px-8 py-3 border-2 border-white text-white font-bold rounded-full hover:bg-white hover:text-dark transition-all transform hover:scale-105">
            Book a Table
          </RouterLink>
        </div>
        <br> <br>
        <h1 class="text-5xl md:text-5xl font-bold font-serif text-white mb-6 drop-shadow-lg opacity-0 animate-fade-up ">
          Home Delivery <span class="text-primary">Available</span>
        </h1>
        <br />
        <RouterLink to="/menu"
          class="px-8 py-3 bg-primary text-dark font-bold rounded-full hover:bg-primary-hover transition-all transform hover:scale-105 shadow-lg shadow-primary/20">
          Order Now
        </RouterLink>
      </div>
    </section>




    <!-- Features Section -->
    <section class="py-24 bg-dark relative z-10">
      <div class="container mx-auto px-4">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-5xl font-bold text-primary mb-4 font-serif">A Cultivated Experience</h2>
          <p class="text-gray-400 max-w-2xl mx-auto">Explore our three distinct dining concepts designed for every
            palate.</p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
          <RouterLink to="/unlimited-buffet"
            class="bg-card p-10 rounded-xl border border-gray-custom hover:border-primary/50 hover:shadow-2xl hover:shadow-primary/10 transition-all duration-300 group text-center">
            <div
              class="w-20 h-20 bg-dark-lighter rounded-full flex items-center justify-center mx-auto mb-8 group-hover:bg-primary group-hover:text-dark transition-colors duration-300 border border-gray-custom group-hover:border-primary">
              <svg xmlns="http://www.w3.org/2000/svg"
                class="h-10 w-10 text-primary group-hover:text-dark transition-colors" fill="none" viewBox="0 0 24 24"
                stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
              </svg>
            </div>
            <h3 class="text-2xl font-bold text-white mb-3 font-serif">Unlimited Buffet</h3>
            <p class="text-gray-400 leading-relaxed">Top-tier culinary variety at a fixed premium value. Experience
              abundance without compromise.</p>
          </RouterLink>

          <RouterLink to="/fresh-fast"
            class="bg-card p-10 rounded-xl border border-gray-custom hover:border-primary/50 hover:shadow-2xl hover:shadow-primary/10 transition-all duration-300 group text-center">
            <div
              class="w-20 h-20 bg-dark-lighter rounded-full flex items-center justify-center mx-auto mb-8 group-hover:bg-primary group-hover:text-dark transition-colors duration-300 border border-gray-custom group-hover:border-primary">
              <svg xmlns="http://www.w3.org/2000/svg"
                class="h-10 w-10 text-primary group-hover:text-dark transition-colors" fill="none" viewBox="0 0 24 24"
                stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
            </div>
            <h3 class="text-2xl font-bold text-white mb-3 font-serif">Fresh & Fast</h3>
            <p class="text-gray-400 leading-relaxed">Executive express meals curated for busy professionals who demand
              quality and speed.</p>
          </RouterLink>

          <RouterLink to="/quality-assured"
            class="bg-card p-10 rounded-xl border border-gray-custom hover:border-primary/50 hover:shadow-2xl hover:shadow-primary/10 transition-all duration-300 group text-center">
            <div
              class="w-20 h-20 bg-dark-lighter rounded-full flex items-center justify-center mx-auto mb-8 group-hover:bg-primary group-hover:text-dark transition-colors duration-300 border border-gray-custom group-hover:border-primary">
              <svg xmlns="http://www.w3.org/2000/svg"
                class="h-10 w-10 text-primary group-hover:text-dark transition-colors" fill="none" viewBox="0 0 24 24"
                stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
            </div>
            <h3 class="text-2xl font-bold text-white mb-3 font-serif">Quality Assured</h3>
            <p class="text-gray-400 leading-relaxed">Rigorous hygiene standards and premium sourcing for a safe,
              superior dining experience.</p>
          </RouterLink>
        </div>
      </div>
    </section>




    <!-- Home Delivery Section -->
    <section class="py-24 bg-dark relative border-t border-gray-custom">
      <div class="container mx-auto px-4">
        <div class="flex flex-col lg:flex-row items-center gap-16">

          <!-- Content Side -->
          <div class="lg:w-1/2 order-2 lg:order-1">
            <h4 class="text-primary font-bold tracking-widest uppercase mb-4 text-sm">Concierge Service</h4>
            <h2 class="text-4xl lg:text-5xl font-serif font-bold text-white mb-6">
              <span class="text-primary">Home Delivery</span> Available
            </h2>
            <p class="text-gray-400 text-lg leading-relaxed mb-8">
              Experience the same executive quality dining at your desk or dining table.
              Our delivery service is optimized for speed without compromising on presentation
              or temperature. Reliable, professional, and discreet.
            </p>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-y-8 gap-x-6 mb-10">
              <!-- Feature 1 -->
              <div class="flex items-start">
                <div class="mt-1 mr-4 text-primary bg-dark-lighter p-3 rounded-lg border border-gray-800 shadow-sm">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24"
                    stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                </div>
                <div>
                  <h4 class="text-white font-bold mb-1 text-base">Fast Delivery</h4>
                  <p class="text-xs text-gray-500 uppercase tracking-wide">Priority Dispatch</p>
                </div>
              </div>

              <!-- Feature 2 -->
              <div class="flex items-start">
                <div class="mt-1 mr-4 text-primary bg-dark-lighter p-3 rounded-lg border border-gray-800 shadow-sm">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24"
                    stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
                  </svg>
                </div>
                <div>
                  <h4 class="text-white font-bold mb-1 text-base">Hygienic Packaging</h4>
                  <p class="text-xs text-gray-500 uppercase tracking-wide">Sealed & Sanitized</p>
                </div>
              </div>

              <!-- Feature 3 -->
              <div class="flex items-start">
                <div class="mt-1 mr-4 text-primary bg-dark-lighter p-3 rounded-lg border border-gray-800 shadow-sm">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24"
                    stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z" />
                  </svg>
                </div>
                <div>
                  <h4 class="text-white font-bold mb-1 text-base">Freshly Prepared</h4>
                  <p class="text-xs text-gray-500 uppercase tracking-wide">Made to Order</p>
                </div>
              </div>

              <!-- Feature 4 -->
              <div class="flex items-start">
                <div class="mt-1 mr-4 text-primary bg-dark-lighter p-3 rounded-lg border border-gray-800 shadow-sm">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24"
                    stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M12 18h.01M8 21h8a2 2 0 002-2V5a2 2 0 00-2-2H8a2 2 0 00-2 2v14a2 2 0 002 2z" />
                  </svg>
                </div>
                <div>
                  <h4 class="text-white font-bold mb-1 text-base">Easy Online Ordering</h4>
                  <p class="text-xs text-gray-500 uppercase tracking-wide">Seamless Experience</p>
                </div>
              </div>
            </div>

            <div class="flex flex-wrap gap-4">
              <RouterLink to="/menu"
                class="px-8 py-3 bg-primary text-dark font-bold rounded-full hover:bg-primary-hover transition-all transform hover:scale-105 shadow-lg shadow-primary/20">
                Order Now
              </RouterLink>
              <RouterLink to="/menu"
                class="px-8 py-3 border-2 border-white text-white font-bold rounded-full hover:bg-white hover:text-dark transition-all transform hover:scale-105">
                View Menu
              </RouterLink>
            </div>
          </div>

          <!-- Image Side -->
          <div class="lg:w-1/2 relative h-full">
            <!-- Decorative elements -->
            <div class="absolute -top-4 -right-4 w-32 h-32 border-t-2 border-r-2 border-primary/20 rounded-tr-3xl">
            </div>
            <div class="absolute -bottom-4 -left-4 w-32 h-32 border-b-2 border-l-2 border-primary/20 rounded-bl-3xl">
            </div>

            <div class="relative rounded-xl overflow-hidden shadow-2xl">
              <div class="absolute inset-0 bg-primary/10 mix-blend-overlay"></div>
              <img src="../assets/images/Delivery.png" alt="Premium Delivery Packaging"
                class="w-full h-[500px] object-cover hover:scale-105 transition-transform duration-700">
            </div>
          </div>

        </div>
      </div>
    </section>



    <!-- Dining Philosophy Section -->
    <section class="py-24 bg-dark-lighter relative overflow-hidden">
      <div class="container mx-auto px-4">
        <div class="flex flex-col lg:flex-row items-center gap-16">
          <div class="lg:w-1/2 relative">
            <div class="absolute -top-4 -left-4 w-24 h-24 border-t-2 border-l-2 border-primary/50 rounded-tl-3xl"></div>
            <div class="absolute -bottom-4 -right-4 w-24 h-24 border-b-2 border-r-2 border-primary/50 rounded-br-3xl">
            </div>
            <img src="../assets/images/Our Philosophy.png" alt="Chef Plating"
              class="w-full h-[500px] object-cover rounded-lg shadow-2xl filter brightness-90">
          </div>
          <div class="lg:w-1/2">
            <h4 class="text-primary font-bold tracking-widest uppercase mb-4 text-sm">Our Philosophy</h4>
            <h2 class="text-4xl lg:text-5xl font-serif font-bold text-white mb-8">Culinary Excellence <br><span
                class="text-gray-500">Without Compromise</span></h2>
            <p class="text-gray-400 text-lg leading-relaxed mb-6">
              At Secret Garden, we view dining as a serious business of pleasure. Our culinary philosophy is rooted in
              the meticulous balance of tradition and innovation. We do not just serve food; we curate gastronomic
              experiences.
            </p>
            <p class="text-gray-400 text-lg leading-relaxed mb-8">
              Every ingredient is selected with purpose, and every dish is crafted with precision. Whether it is a quick
              executive lunch or a leisurely family dinner, our commitment to excellence remains unwavering.
            </p>
            <div class="flex items-center gap-8">
              <div>
                <span class="block text-4xl font-bold text-white mb-1">15+</span>
                <span class="text-sm text-gray-500 uppercase tracking-wider">Years Experience</span>
              </div>
              <div class="w-px h-12 bg-gray-700"></div>
              <div>
                <span class="block text-4xl font-bold text-white mb-1">50+</span>
                <span class="text-sm text-gray-500 uppercase tracking-wider">Expert Chefs</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Perfect For Section -->
    <section class="py-24 bg-dark relative">
      <div class="container mx-auto px-4">
        <div class="text-center mb-20">
          <h2 class="text-4xl font-serif font-bold text-white mb-4">Perfect For Every Occasion</h2>
          <div class="w-24 h-1 bg-primary mx-auto"></div>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
          <!-- Corporate -->
          <div class="group relative overflow-hidden rounded-xl h-96">
            <img src="https://images.unsplash.com/photo-1556761175-5973dc0f32e7?q=80&w=1932&auto=format&fit=crop"
              alt="Corporate Dining"
              class="absolute inset-0 w-full h-full object-cover transition-transform duration-700 group-hover:scale-110 filter brightness-50 group-hover:brightness-40">
            <div class="absolute inset-0 flex flex-col justify-end p-8">
              <h3
                class="text-2xl font-bold text-white mb-2 translate-y-4 group-hover:translate-y-0 transition-transform duration-500">
                Corporate Lunches</h3>
              <p
                class="text-gray-300 opacity-0 group-hover:opacity-100 transform translate-y-4 group-hover:translate-y-0 transition-all duration-500 delay-100">
                Impress clients and partners in a refined, quiet setting with impeccable service.
              </p>
            </div>
          </div>

          <!-- Family -->
          <div class="group relative overflow-hidden rounded-xl h-96">
            <img src="../assets/images/femilygathering.png" alt="Family Dining"
              class="absolute inset-0 w-full h-full object-cover transition-transform duration-700 group-hover:scale-110 filter brightness-50 group-hover:brightness-40">
            <div class="absolute inset-0 flex flex-col justify-end p-8">
              <h3
                class="text-2xl font-bold text-white mb-2 translate-y-4 group-hover:translate-y-0 transition-transform duration-500">
                Family Gatherings</h3>
              <p
                class="text-gray-300 opacity-0 group-hover:opacity-100 transform translate-y-4 group-hover:translate-y-0 transition-all duration-500 delay-100">
                Spacious seating and a diverse menu ensure comfort and joy for all ages.
              </p>
            </div>
          </div>

          <!-- Casual -->
          <div class="group relative overflow-hidden rounded-xl h-96">
            <img src="https://images.unsplash.com/photo-1552566626-52f8b828add9?q=80&w=2070&auto=format&fit=crop"
              alt="Casual Dining"
              class="absolute inset-0 w-full h-full object-cover transition-transform duration-700 group-hover:scale-110 filter brightness-50 group-hover:brightness-40">
            <div class="absolute inset-0 flex flex-col justify-end p-8">
              <h3
                class="text-2xl font-bold text-white mb-2 translate-y-4 group-hover:translate-y-0 transition-transform duration-500">
                Casual Meetups</h3>
              <p
                class="text-gray-300 opacity-0 group-hover:opacity-100 transform translate-y-4 group-hover:translate-y-0 transition-all duration-500 delay-100">
                Relaxed ambiance perfect for catching up with friends over premium beverages.
              </p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Our Promise (Grid) -->
    <section class="py-24 bg-dark-lighter border-y border-gray-custom">
      <div class="container mx-auto px-4">
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
          <div class="text-center p-6 bg-transparent hover:bg-dark transition-colors rounded-lg">
            <div class="text-primary mb-4 flex justify-center">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-12 w-12" fill="none" viewBox="0 0 24 24"
                stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                  d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
              </svg>
            </div>
            <h4 class="text-xl font-bold text-white mb-2">Hygiene First</h4>
            <p class="text-sm text-gray-400">Regular sterilization and open-kitchen transparency.</p>
          </div>
          <div class="text-center p-6 bg-transparent hover:bg-dark transition-colors rounded-lg">
            <div class="text-primary mb-4 flex justify-center">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-12 w-12" fill="none" viewBox="0 0 24 24"
                stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                  d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z" />
              </svg>
            </div>
            <h4 class="text-xl font-bold text-white mb-2">Premium Sourcing</h4>
            <p class="text-sm text-gray-400">Direct farm-to-table ingredients for freshness.</p>
          </div>
          <div class="text-center p-6 bg-transparent hover:bg-dark transition-colors rounded-lg">
            <div class="text-primary mb-4 flex justify-center">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-12 w-12" fill="none" viewBox="0 0 24 24"
                stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                  d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
            </div>
            <h4 class="text-xl font-bold text-white mb-2">Food Service</h4>
            <p class="text-sm text-gray-400">Respecting your time with efficient hospitality.</p>
          </div>
          <div class="text-center p-6 bg-transparent hover:bg-dark transition-colors rounded-lg">
            <div class="text-primary mb-4 flex justify-center">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-12 w-12" fill="none" viewBox="0 0 24 24"
                stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                  d="M14.828 14.828a4 4 0 01-5.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
            </div>
            <h4 class="text-xl font-bold text-white mb-2">Atmosphere</h4>
            <p class="text-sm text-gray-400">Sofisticated décor perfect for all conversations.</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Final CTA Section -->
    <section class="py-32 relative bg-fixed bg-cover bg-center overflow-hidden"
      style="background-image: url('https://images.unsplash.com/photo-1544148103-0773bf10d330?q=80&w=2070&auto=format&fit=crop');">
      <div class="absolute inset-0 bg-black/80"></div>
      <div class="container mx-auto px-4 relative z-10 text-center">
        <h2 class="text-4xl md:text-6xl font-serif font-bold text-white mb-6">Experience the Difference</h2>
        <p class="text-xl text-gray-300 mb-10 max-w-2xl mx-auto">
          Join us for a meal that transcends the ordinary. Whether it is business or pleasure, we are ready to serve.
        </p>
        <RouterLink to="/booking"
          class="inline-block px-12 py-4 bg-primary text-dark font-bold text-lg rounded-full hover:bg-white hover:text-dark transition-all transform hover:scale-105 shadow-2xl">
          Book a Table Now
        </RouterLink>
      </div>
    </section>
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
