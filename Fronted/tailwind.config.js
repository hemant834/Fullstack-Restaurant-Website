/** @type {import('tailwindcss').Config} */
export default {
    content: [
        "./index.html",
        "./src/**/*.{vue,js,ts,jsx,tsx}",
    ],
    theme: {
        extend: {
            colors: {
                dark: '#121212',
                'dark-lighter': '#1E1E1E',
                'gray-custom': '#2D2D2D',
                primary: '#E2B13C', // Gold
                'primary-hover': '#C79A2B',
            },
            fontFamily: {
                sans: ['Inter', 'sans-serif'],
                serif: ['Playfair Display', 'serif'],
            },
        },
    },
    plugins: [],
}
