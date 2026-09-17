<template>
  <div class="relative" @focusin="focused = true" @focusout="focused = false">
    <FlatPickr
      :model-value="modelValue"
      :config="config"
      :placeholder="placeholder"
      :class="[
        'w-full rounded-lg border py-2.5 pl-9 pr-4 text-sm text-gray-800 placeholder:text-gray-400 focus:outline-none focus:ring-2 dark:text-white/90 dark:placeholder:text-gray-500',
        error
          ? 'border-error-500 bg-white/50 focus:border-error-500 focus:ring-error-500/10 dark:bg-white/5'
          : 'border-gray-300 bg-gray-50 focus:border-brand-300 focus:ring-brand-500/20 dark:border-gray-700 dark:bg-white/5',
      ]"
      @update:model-value="onChange"
    />
    <span
      class="pointer-events-none absolute left-3 top-1/2 -translate-y-1/2 transition-colors"
      :class="focused ? 'text-brand-500' : 'text-gray-400 dark:text-gray-500'"
    >
      <CalenderIcon class="h-4 w-4" />
    </span>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import FlatPickr from 'vue-flatpickr-component'
import 'flatpickr/dist/flatpickr.css'
import { CalenderIcon } from '@/icons'
import type { Options } from 'flatpickr/dist/types/options'

withDefaults(
  defineProps<{
    modelValue: string
    placeholder?: string
    config?: Options
    error?: boolean
  }>(),
  {
    placeholder: 'Pilih tanggal...',
    error: false,
    config: () => ({
      dateFormat: 'Y-m-d',
      allowInput: true,
      animate: true,
    }),
  },
)

const emit = defineEmits<{
  'update:modelValue': [value: string]
}>()

const focused = ref(false)

const onChange = (value: string) => emit('update:modelValue', value)
</script>