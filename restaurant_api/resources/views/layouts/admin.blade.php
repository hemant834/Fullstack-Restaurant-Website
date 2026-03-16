<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurant Admin</title>
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body class="bg-gray-900 text-gray-100 font-sans antialiased">
    <div class="flex h-screen overflow-hidden">
        <!-- Sidebar -->
        <aside class="w-64 bg-gray-800 border-r border-gray-700 hidden md:block">
            <div class="p-6">
                <h1 class="text-2xl font-bold text-yellow-500 tracking-wider">RESTAURANT<span class="text-white">OS</span></h1>
            </div>
            <nav class="mt-6 px-4 space-y-2">
                <a href="{{ route('admin.menus.index') }}" class="flex items-center px-4 py-3 {{ request()->routeIs('admin.menus.*') ? 'bg-gray-700 text-yellow-500' : 'text-gray-400 hover:bg-gray-700 hover:text-white' }} rounded-lg transition-colors duration-200">
                    <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"></path>
                    </svg>
                    Menu Management
                </a>
                <a href="{{ route('admin.orders.index') }}" class="flex items-center mt-2 px-4 py-3 {{ request()->routeIs('admin.orders.*') ? 'bg-gray-700 text-yellow-500' : 'text-gray-400 hover:bg-gray-700 hover:text-white' }} rounded-lg transition-colors duration-200">
                    <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                    </svg>
                    Orders
                </a>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-900">
            <!-- Header (Mobile) -->
            <header class="bg-gray-800 border-b border-gray-700 p-4 md:hidden">
                <div class="flex items-center justify-between">
                    <h1 class="text-xl font-bold text-yellow-500">RESTAURANT<span class="text-white">OS</span></h1>
                    <button class="text-gray-300 focus:outline-none">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path></svg>
                    </button>
                </div>
            </header>

            <div class="container mx-auto px-6 py-8">
                @if(session('success'))
                    <div class="bg-green-800 text-green-100 border border-green-600 px-4 py-3 rounded relative mb-4" role="alert">
                        <span class="block sm:inline">{{ session('success') }}</span>
                    </div>
                @endif
                
                @yield('content')
            </div>
        </main>
    </div>
</body>
</html>
