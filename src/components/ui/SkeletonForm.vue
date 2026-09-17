<template>
  <template v-if="loading">
    <div class="space-y-6">
      <div v-for="n in fields" :key="'sk-field-' + n" class="space-y-2">
        <div class="h-4 w-32 animate-pulse rounded bg-gray-200 dark:bg-white/10"></div>
        <div class="h-10 w-full animate-pulse rounded-lg bg-gray-200 dark:bg-white/10"></div>
      </div>
    </div>
  </template>
</template>

<script setup lang="ts">
defineProps<{
  loading: boolean
  fields?: number
}>()
</script>
