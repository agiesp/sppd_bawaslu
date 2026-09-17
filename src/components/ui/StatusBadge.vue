<template>
  <span
    :class="[
      'inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-semibold ring-1 ring-inset',
      styles[status] || styles.DRAFT,
    ]"
  >
    {{ labels[status] || status }}
  </span>
</template>

<script setup lang="ts">
import type { PemantauanStatus } from '@/types/pemantauan'

defineProps<{ status: PemantauanStatus }>()

const styles: Record<string, string> = {
  DRAFT: 'bg-gray-100 text-gray-600 ring-gray-200 dark:bg-white/10 dark:text-gray-300 dark:ring-white/20',
  SUBMITTED: 'bg-amber-50 text-amber-600 ring-amber-200 dark:bg-amber-500/10 dark:text-amber-400 dark:ring-amber-500/30',
  APPROVED: 'bg-emerald-50 text-emerald-600 ring-emerald-200 dark:bg-emerald-500/10 dark:text-emerald-400 dark:ring-emerald-500/30',
}

const labels: Record<string, string> = {
  DRAFT: 'Draft',
  SUBMITTED: 'Submitted',
  APPROVED: 'Approved',
}
</script>
