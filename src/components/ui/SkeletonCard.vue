<template>
  <template v-if="loading">
    <div
      v-for="n in count"
      :key="'sk-card-' + n"
      class="rounded-2xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-800 dark:bg-white/[0.03] md:p-6"
    >
      <div class="h-11 w-11 animate-pulse rounded-xl bg-gray-200 dark:bg-white/10"></div>
      <div class="mt-4 flex items-end justify-between">
        <div class="space-y-2">
          <div class="h-3 w-20 animate-pulse rounded bg-gray-200 dark:bg-white/10"></div>
          <div class="h-5 w-16 animate-pulse rounded bg-gray-200 dark:bg-white/10"></div>
        </div>
      </div>
    </div>
  </template>
</template>

<script setup lang="ts">
defineProps<{
  loading: boolean
  count?: number
}>()
</script>
