<template>
  <div class="relative" @focusin="focused = true" @focusout="focused = false">
    <span
      class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 transition-colors"
      :class="focused ? 'text-brand-500' : 'text-gray-400 dark:text-gray-500'"
    >
      <component :is="icon" class="h-5 w-5" />
    </span>
    <slot />
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import type { Component } from 'vue'

defineProps<{
  icon: Component
}>()

const focused = ref(false)
</script>
