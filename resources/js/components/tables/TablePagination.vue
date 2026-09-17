<template>
  <div class="mt-4 flex flex-col items-center justify-between gap-4 border-t border-gray-100 px-4 py-4 sm:flex-row dark:border-gray-800">
    <span class="text-sm text-gray-500 dark:text-gray-400">
      Menampilkan {{ startItem }}–{{ endItem }} dari {{ total }} data
    </span>
    <div class="flex items-center gap-2">
      <select
        :value="perPage"
        class="rounded-lg border border-gray-300 bg-white px-2 py-1.5 text-sm text-gray-700 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500 dark:border-gray-600 dark:bg-gray-800 dark:text-gray-300"
        @change="onPerPageChange(($event.target as HTMLSelectElement).value)"
      >
        <option :value="10">10</option>
        <option :value="25">25</option>
        <option :value="50">50</option>
      </select>
      <div class="flex items-center gap-1">
        <button
          type="button"
          :disabled="currentPage <= 1"
          class="inline-flex h-8 w-8 items-center justify-center rounded-lg border border-gray-300 bg-white text-sm text-gray-500 transition-colors hover:bg-gray-50 disabled:cursor-not-allowed disabled:opacity-40 dark:border-gray-600 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-gray-700"
          @click="goTo(currentPage - 1)"
        >
          <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" /></svg>
        </button>
        <button
          v-for="page in visiblePages"
          :key="page"
          type="button"
          class="inline-flex h-8 w-8 items-center justify-center rounded-lg border text-sm font-medium transition-colors"
          :class="page === currentPage
            ? 'border-blue-500 bg-blue-50 text-blue-600 dark:border-blue-500 dark:bg-blue-900/30 dark:text-blue-400'
            : 'border-gray-300 bg-white text-gray-500 hover:bg-gray-50 dark:border-gray-600 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-gray-700'"
          @click="goTo(page)"
        >
          {{ page }}
        </button>
        <button
          type="button"
          :disabled="currentPage >= totalPages"
          class="inline-flex h-8 w-8 items-center justify-center rounded-lg border border-gray-300 bg-white text-sm text-gray-500 transition-colors hover:bg-gray-50 disabled:cursor-not-allowed disabled:opacity-40 dark:border-gray-600 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-gray-700"
          @click="goTo(currentPage + 1)"
        >
          <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7" /></svg>
        </button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'

const props = withDefaults(
  defineProps<{
    total: number
    perPage?: number
    currentPage?: number
    totalItems?: number
  }>(),
  {
    perPage: 10,
    currentPage: 1,
    totalItems: undefined,
  },
)

const emit = defineEmits<{
  'page-change': [page: number]
  'per-page-change': [size: number]
  'update:currentPage': [page: number]
}>()

const total = computed(() => props.totalItems ?? props.total)

const totalPages = computed(() => Math.max(1, Math.ceil(total.value / props.perPage)))

const clampedPage = computed(() => Math.min(Math.max(1, props.currentPage), totalPages.value))

const startItem = computed(() => (total.value === 0 ? 0 : (clampedPage.value - 1) * props.perPage + 1))
const endItem = computed(() => Math.min(clampedPage.value * props.perPage, total.value))

const visiblePages = computed(() => {
  const pages: number[] = []
  const maxVisible = 5
  let start = Math.max(1, clampedPage.value - Math.floor(maxVisible / 2))
  const end = Math.min(totalPages.value, start + maxVisible - 1)
  start = Math.max(1, end - maxVisible + 1)
  for (let i = start; i <= end; i++) pages.push(i)
  return pages
})

function goTo(page: number) {
  const p = Math.min(Math.max(1, page), totalPages.value)
  emit('page-change', p)
  emit('update:currentPage', p)
}

function onPerPageChange(val: string) {
  const size = parseInt(val, 10)
  emit('per-page-change', size)
  emit('page-change', 1)
  emit('update:currentPage', 1)
}
</script>
