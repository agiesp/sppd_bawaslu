<template>
  <template v-if="loading">
    <tr v-for="n in rows" :key="'sk-row-' + n" class="border-b border-gray-200 dark:border-gray-700">
      <td
        v-for="(col, ci) in columns"
        :key="'sk-cell-' + n + '-' + ci"
        class="border-r border-gray-200 px-4 py-3 dark:border-gray-700"
        :class="col.align === 'right' ? 'text-right' : col.align === 'center' ? 'text-center' : ''"
      >
        <div
          class="h-3 animate-pulse rounded bg-gray-200 dark:bg-white/10"
          :class="[
            col.width || 'w-20',
            col.align === 'right' ? 'ml-auto' : '',
            col.align === 'center' ? 'mx-auto' : '',
          ]"
        ></div>
      </td>
    </tr>
  </template>
</template>

<script setup lang="ts">
interface Column {
  width?: string
  align?: 'left' | 'right' | 'center'
}

defineProps<{
  loading: boolean
  rows?: number
  columns: Column[]
}>()
</script>
