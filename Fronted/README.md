# Restodine - Premium Restaurant Website

A Final Year Project level responsive restaurant website built with Vue.js 3, Pinia, and Tailwind CSS.

## 🚀 Features

- **Modern & Premium Design**: Dark theme with gold accents, glassmorphism effects, and smooth animations.
- **Dynamic Menu**: Categorized menu with food items.
- **Shopping Cart**: Add items, adjust quantity, remove items.
- **Unlimited Food Offer**: Special feature allowing users to toggle a fixed price unlimited plan (₹299).
- **State Management**: Powered by Pinia for seamless cart updates across components.
- **Routing**: SPA navigation using Vue Router.
- **Responsive**: Fully optimized for Desktop and Mobile.

## 🛠 Tech Stack

- **Vue.js 3** (Composition API)
- **Vite** (Build tool)
- **Pinia** (State Management)
- **Vue Router** (Navigation)
- **Tailwind CSS** (Styling)

## 📂 Project Structure

```
src/
├── components/      # Reusable UI components
│   ├── Navbar.vue   # Top navigation with cart badge
│   └── Footer.vue   # Footer with links
├── pages/           # Page views
│   ├── Home.vue     # Landing page with hero & features
│   ├── Menu.vue     # Food menu with filtering
│   └── Cart.vue     # Cart management & unlimited offer toggle
├── router/          # Route definitions
├── stores/          # Pinia stores
│   └── cart.js      # Cart logic & unlimited plan state
├── App.vue          # Root component
└── main.js          # App entry point
```

## 📦 Setup & Run

1. **Install dependencies**:
   ```bash
   npm install
   ```

2. **Run development server**:
   ```bash
   npm run dev
   ```

3. **Build for production**:
   ```bash
   npm run build
   ```

## 💡 How It Works

- **Cart Logic**: The `cart.js` store maintains an array of items. Actions are provided to `increment`, `decrement`, and `remove` items.
- **Unlimited Offer**: A boolean state `isUnlimitedPlan` in the store controls the pricing strategy.
  - If `false` (default): Total = Sum of (Price * Quantity).
  - If `true`: Total is fixed at ₹299.
- **UI/UX**: Tailwind classes are used for styling. `App.vue` handles page transitions using Vue's `<transition>` component.

## 🎨 Theme Customization

colors are defined in `tailwind.config.js`:
- Primary: `#E2B13C` (Gold)
- Background: `#121212` (Dark)
