import { createRouter, createWebHistory } from 'vue-router'
import Home from '../pages/Home.vue'
import Menu from '../pages/Menu.vue'
import Cart from '../pages/Cart.vue'
import Booking from '../pages/Booking.vue'
import Register from '../pages/Register.vue'
import Profile from '../pages/Profile.vue'
import UnlimitedBuffet from '../pages/UnlimitedBuffet.vue'
import FreshFast from '../pages/FreshFast.vue'
import QualityAssured from '../pages/QualityAssured.vue'
import TrackOrder from '../pages/TrackOrder.vue'

const routes = [
    { path: '/', name: 'Home', component: Home, meta: { requiresAuth: true } },
    { path: '/menu', name: 'Menu', component: Menu, meta: { requiresAuth: true } },
    { path: '/cart', name: 'Cart', component: Cart, meta: { requiresAuth: true } },
    { path: '/booking', name: 'Booking', component: Booking, meta: { requiresAuth: true } },
    { path: '/profile', name: 'Profile', component: Profile },
    { path: '/register', name: 'Register', component: Register },
    { path: '/track/:orderId?', name: 'TrackOrder', component: TrackOrder, meta: { requiresAuth: true } },
    { path: '/unlimited-buffet', name: 'UnlimitedBuffet', component: UnlimitedBuffet, meta: { requiresAuth: true } },
    { path: '/fresh-fast', name: 'FreshFast', component: FreshFast, meta: { requiresAuth: true } },
    { path: '/quality-assured', name: 'QualityAssured', component: QualityAssured, meta: { requiresAuth: true } },
]

const router = createRouter({
    history: createWebHistory(),
    routes,
})

router.beforeEach((to, from, next) => {
    const isAuthenticated = !!localStorage.getItem('currentUser')

    if (to.meta.requiresAuth && !isAuthenticated) {
        next('/profile')
    } else if ((to.path === '/login' || to.path === '/register') && isAuthenticated) {
        next('/')
    } else {
        next()
    }
})

export default router
