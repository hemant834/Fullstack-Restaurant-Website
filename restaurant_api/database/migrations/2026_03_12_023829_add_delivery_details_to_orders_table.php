<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('orders', function (Blueprint $table) {
            $table->string('delivery_type')->default('dine-in'); // dine-in, home-delivery
            $table->text('address')->nullable();
            $table->string('delivery_status')->default('pending'); // pending, preparing, out_for_delivery, delivered
            $table->json('items')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('orders', function (Blueprint $table) {
            $table->dropColumn(['delivery_type', 'address', 'delivery_status', 'items']);
        });
    }
};
