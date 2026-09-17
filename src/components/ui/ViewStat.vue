<template>
  <div class="rounded-xl border border-gray-200 bg-gray-50/70 px-4 py-3 dark:border-gray-700 dark:bg-white/[0.02]">
    <div class="text-[11px] font-semibold uppercase tracking-wider text-gray-400">{{ label }}</div>
    <div class="mt-1 text-sm font-semibold text-gray-800 dark:text-white/90">{{ value }}</div>
  </div>
</template>

<script setup lang="ts">
defineProps<{ label: string; value: string }>()
</script>
