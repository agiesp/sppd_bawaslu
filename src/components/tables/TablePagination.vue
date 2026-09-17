<template>
  <div
    v-if="totalItems > 0"
    class="flex flex-col items-center justify-between gap-4 border-t border-gray-100 px-6 py-4 sm:flex-row sm:items-center dark:border-gray-800"
  >
    <div class="text-sm text-gray-500 dark:text-gray-400">
      Menampilkan
      <span class="font-medium text-gray-800 dark:text-white/90">{{ startIndex }}</span>
      -
      <span class="font-medium text-gray-800 dark:text-white/90">{{ endIndex }}</span>
      dari
      <span class="font-medium text-gray-800 dark:text-white/90">{{ totalItems }}</span>
    </div>

    <div class="flex items-center gap-2">
      <button
        type="button"
        :disabled="currentPage === 1"
        class="inline-flex items-center justify-center rounded-lg border border-gray-200 bg-white p-2.5 text-gray-500 transition hover:bg-gray-50 hover:text-gray-700 disabled:cursor-not-allowed disabled:opacity-50 dark:border-gray-700 dark:bg-white/[0.03] dark:hover:bg-white/5 dark:hover:text-gray-300"
        @click="goTo(currentPage - 1)"
        title="Sebelumnya"
      >
        <svg class="stroke-current" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none">
          <path d="M10 12.6667L5.33333 8L10 3.33334" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" />
        </svg>
      </button>

      <template v-if="totalPages <= 7">
        <button
          v-for="page in visiblePages"
          :key="page"
          type="button"
          :class="
            page === currentPage
              ? 'bg-brand-500 text-white'
              : 'border border-gray-200 bg-white text-gray-500 hover:bg-gray-50 hover:text-gray-700 dark:border-gray-700 dark:bg-white/[0.03] dark:hover:bg-white/5 dark:hover:text-gray-300'
          "
          class="inline-flex h-10 w-10 items-center justify-center rounded-lg text-sm font-medium"
          @click="goTo(page)"
        >
          {{ page }}
        </button>
      </template>

      <template v-else>
        <button
          v-if="currentPage > 3"
          type="button"
          class="inline-flex h-10 w-10 items-center justify-center rounded-lg text-sm text-gray-500 hover:bg-gray-50 dark:hover:bg-white/5"
          @click="goTo(1)"
        >
          1
        </button>
        <span v-if="currentPage > 4" class="px-1 text-gray-400">...</span>

        <template v-for="page in middlePages" :key="page">
          <button
            type="button"
            :class="
              page === currentPage
                ? 'bg-brand-500 text-white'
                : 'border border-gray-200 bg-white text-gray-500 hover:bg-gray-50 hover:text-gray-700 dark:border-gray-700 dark:bg-white/[0.03] dark:hover:bg-white/5 dark:hover:text-gray-300'
            "
            class="inline-flex h-10 w-10 items-center justify-center rounded-lg text-sm font-medium"
            @click="goTo(page)"
          >
            {{ page }}
          </button>
        </template>

        <span v-if="currentPage < totalPages - 3" class="px-1 text-gray-400">...</span>
        <button
          v-if="currentPage < totalPages - 2"
          type="button"
          class="inline-flex h-10 w-10 items-center justify-center rounded-lg text-sm text-gray-500 hover:bg-gray-50 dark:hover:bg-white/5"
          @click="goTo(totalPages)"
        >
          {{ totalPages }}
        </button>
      </template>

      <button
        type="button"
        :disabled="currentPage === totalPages"
        class="inline-flex items-center justify-center rounded-lg border border-gray-200 bg-white p-2.5 text-gray-500 transition hover:bg-gray-50 hover:text-gray-700 disabled:cursor-not-allowed disabled:opacity-50 dark:border-gray-700 dark:bg-white/[0.03] dark:hover:bg-white/5 dark:hover:text-gray-300"
        @click="goTo(currentPage + 1)"
        title="Berikutnya"
      >
        <svg class="stroke-current" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none">
          <path d="M6 12.6667L10.6667 8L6 3.33334" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" />
        </svg>
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'

const props = withDefaults(
  defineProps<{
    currentPage: number
    pageSize: number
    totalItems: number
  }>(),
  {
    pageSize: 10,
  },
)

const emit = defineEmits<{
  (e: 'update:currentPage', page: number): void
}>()

const totalPages = computed(() => Math.max(1, Math.ceil(props.totalItems / props.pageSize)))

const startIndex = computed(() => (props.totalItems === 0 ? 0 : (props.currentPage - 1) * props.pageSize + 1))
const endIndex = computed(() => Math.min(props.currentPage * props.pageSize, props.totalItems))

const visiblePages = computed(() => {
  const pages: number[] = []
  for (let i = 1; i <= totalPages.value; i++) {
    pages.push(i)
  }
  return pages
})

const middlePages = computed(() => {
  const start = Math.max(2, props.currentPage - 1)
  const end = Math.min(totalPages.value - 1, props.currentPage + 1)
  const pages: number[] = []
  for (let i = start; i <= end; i++) {
    pages.push(i)
  }
  return pages
})

const goTo = (page: number) => {
  if (page < 1 || page > totalPages.value) return
  emit('update:currentPage', page)
}
</script>
