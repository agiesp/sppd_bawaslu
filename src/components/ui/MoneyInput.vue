<template>
  <div class="relative">
    <span
      class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-sm font-medium text-gray-500 dark:text-gray-400"
    >
      Rp
    </span>
    <input
      :id="id"
      :value="displayValue"
      type="text"
      inputmode="numeric"
      autocomplete="off"
      :placeholder="placeholder"
      class="w-full rounded-lg border border-gray-300 bg-white px-4 py-2.5 pl-10 text-right text-sm text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500 dark:border-gray-600 dark:bg-white/[0.05] dark:text-gray-100 dark:placeholder-gray-500 dark:focus:border-blue-400"
      @input="onInput"
    />
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'

const props = withDefaults(
  defineProps<{
    modelValue: number | null | undefined
    id?: string
    placeholder?: string
  }>(),
  {
    modelValue: 0,
    id: undefined,
    placeholder: '0',
  },
)

const emit = defineEmits<{
  'update:modelValue': [value: number]
}>()

const displayValue = computed<string>(() => {
  const value = Number(props.modelValue) || 0
  return value > 0 ? new Intl.NumberFormat('id-ID').format(value) : ''
})

const onInput = (event: Event): void => {
  const raw = (event.target as HTMLInputElement).value.replace(/\D/g, '')
  emit('update:modelValue', raw ? Number.parseInt(raw, 10) : 0)
}
</script>
