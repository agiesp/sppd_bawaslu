<template>
  <button
    type="button"
    class="inline-flex items-center gap-2 rounded-lg border border-gray-200 bg-white px-4 py-2.5 text-sm font-medium text-gray-700 shadow-theme-xs transition hover:bg-gray-50 dark:border-gray-700 dark:bg-white/[0.03] dark:text-gray-300 dark:hover:bg-white/5"
    @click="download"
  >
    <DownloadIcon />
    Download
  </button>
</template>

<script setup lang="ts">
import DownloadIcon from '@/icons/DownloadIcon.vue'

interface Column {
  key: string
  label: string
}

const props = defineProps<{
  columns: Column[]
  items: Record<string, any>[]
  filename?: string
}>()

const download = () => {
  if (props.items.length === 0) return

  const header = props.columns
    .map((c) => `"${String(c.label).replace(/"/g, '""')}"`)
    .join(',')
  const rows = props.items.map((row) =>
    props.columns
      .map((c) => {
        const value = row[c.key]
        const str = value === null || value === undefined ? '' : String(value)
        return `"${str.replace(/"/g, '""')}"`
      })
      .join(','),
  )

  const csv = '\uFEFF' + [header, ...rows].join('\r\n')
  const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' })
  const url = URL.createObjectURL(blob)
  const link = document.createElement('a')
  link.href = url
  link.download = `${props.filename || 'data'}.csv`
  document.body.appendChild(link)
  link.click()
  document.body.removeChild(link)
  URL.revokeObjectURL(url)
}
</script>
