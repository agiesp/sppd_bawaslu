<template>
  <div
    class="inline-flex w-full items-center overflow-hidden rounded-lg border transition-all duration-200"
    :class="[
      focused
        ? 'border-brand-500 shadow-sm shadow-brand-500/10'
        : 'border-gray-300 dark:border-gray-600',
    ]"
  >
    <span
      class="flex h-full select-none items-center border-r border-gray-200 bg-gray-50 px-3 text-xs font-semibold text-gray-400 dark:border-gray-600 dark:bg-gray-800 dark:text-gray-500"
    >
      Rp
    </span>
    <input
      :value="display"
      type="text"
      inputmode="numeric"
      :placeholder="placeholder"
      class="w-full min-w-0 border-0 bg-white px-3 py-2 text-sm font-medium text-gray-800 placeholder:font-normal placeholder:text-gray-400 focus:outline-none dark:bg-gray-900 dark:text-white dark:placeholder:text-gray-500"
      @focus="focused = true"
      @blur="focused = false"
      @input="onInput"
    />
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'

const props = defineProps<{
  modelValue?: number | null
  placeholder?: string
}>()

const emit = defineEmits<{ (e: 'update:modelValue', value: number): void }>()

const focused = ref(false)

const display = computed(() => {
  const v = props.modelValue ?? 0
  return new Intl.NumberFormat('id-ID').format(v)
})

function onInput(e: Event) {
  const el = e.target as HTMLInputElement
  const digits = el.value.replace(/\D/g, '').slice(0, 15)
  emit('update:modelValue', digits === '' ? 0 : parseInt(digits, 10))
}
</script>