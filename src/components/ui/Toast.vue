<template>
  <div
    class="pointer-events-none fixed right-4 top-4 z-[99999] flex w-full max-w-sm flex-col gap-2"
  >
    <TransitionGroup name="toast">
      <div
        v-for="toast in toasts"
        :key="toast.id"
        :class="[
          'pointer-events-auto flex items-start gap-3 rounded-xl border p-4 shadow-lg dark:shadow-none',
          typeClasses[toast.type].container,
        ]"
      >
        <div :class="['-mt-0.5', typeClasses[toast.type].icon]">
          <component :is="icons[toast.type]" />
        </div>
        <p class="flex-1 pt-0.5 text-sm text-gray-700 dark:text-gray-200">{{ toast.message }}</p>
        <button
          type="button"
          class="text-gray-400 transition-colors hover:text-gray-600 dark:hover:text-gray-300"
          @click="dismiss(toast.id)"
        >
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M18 6L6 18M6 6L18 18" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
          </svg>
        </button>
      </div>
    </TransitionGroup>
  </div>
</template>

<script setup lang="ts">
import { SuccessIcon, ErrorIcon, WarningIcon, InfoCircleIcon } from '@/icons'
import { useToast } from '@/composables/useToast'
import type { Component } from 'vue'

const { toasts } = useToast()

const typeClasses: Record<string, { container: string; icon: string }> = {
  success: {
    container:
      'border-success-500 bg-white dark:border-success-500/40 dark:bg-gray-900',
    icon: 'text-success-500',
  },
  error: {
    container: 'border-error-500 bg-white dark:border-error-500/40 dark:bg-gray-900',
    icon: 'text-error-500',
  },
  warning: {
    container:
      'border-warning-500 bg-white dark:border-warning-500/40 dark:bg-gray-900',
    icon: 'text-warning-500',
  },
  info: {
    container:
      'border-blue-light-500 bg-white dark:border-blue-light-500/40 dark:bg-gray-900',
    icon: 'text-blue-light-500',
  },
}

const icons: Record<string, Component> = {
  success: SuccessIcon,
  error: ErrorIcon,
  warning: WarningIcon,
  info: InfoCircleIcon,
}

const dismiss = (id: number) => {
  toasts.value = toasts.value.filter((t) => t.id !== id)
}
</script>

<style scoped>
.toast-enter-active,
.toast-leave-active {
  transition: all 0.25s ease;
}
.toast-enter-from {
  opacity: 0;
  transform: translateX(100%);
}
.toast-leave-to {
  opacity: 0;
  transform: translateX(100%);
}
</style>
