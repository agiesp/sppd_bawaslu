<template>
  <div class="flex flex-col items-center justify-center px-4 py-12">
    <lord-icon
      :src="icon"
      trigger="loop"
      delay="2000"
      :colors="'primary:#6366f1,secondary:#a5b4fc,tertiary:#e0e7ff'"
      class="h-28 w-28"
    />
    <p class="mt-4 text-sm font-medium text-gray-500 dark:text-gray-400">
      {{ message }}
    </p>
  </div>
</template>

<script setup lang="ts">
import emptyFileIcon from '@/assets/icons/empty-file.json?url'

interface EmptyStateProps {
  icon?: string
  message?: string
}

withDefaults(defineProps<EmptyStateProps>(), {
  icon: emptyFileIcon,
  message: 'Tidak ada data.',
})
</script>
