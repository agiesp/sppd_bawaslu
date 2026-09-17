<template>
  <div class="space-y-3">
    <div
      v-if="previewUrl || current"
      class="group relative"
    >
      <div class="relative overflow-hidden rounded-xl border border-gray-200 bg-gray-50 dark:border-gray-700 dark:bg-white/5">
        <img
          :src="(previewUrl || current) || ''"
          alt="preview"
          class="h-40 w-full object-contain p-3"
        />
        <button
          v-if="previewUrl"
          type="button"
          @click.stop="clearFile"
          class="absolute top-2 right-2 flex h-7 w-7 items-center justify-center rounded-full bg-red-500/90 text-white opacity-0 shadow-lg transition-all group-hover:opacity-100 hover:bg-red-600"
        >
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
            <line x1="18" y1="6" x2="6" y2="18"></line>
            <line x1="6" y1="6" x2="18" y2="18"></line>
          </svg>
        </button>
      </div>
      <button
        type="button"
        @click="openFilePicker"
        class="mt-2 w-full rounded-lg border border-dashed border-gray-300 bg-white py-2 text-xs font-medium text-gray-500 transition-colors hover:border-brand-400 hover:text-brand-500 dark:border-gray-600 dark:bg-white/5 dark:text-gray-400 dark:hover:border-brand-400 dark:hover:text-brand-400"
      >
        Ganti File
      </button>
    </div>

    <div
      v-else
      @dragenter.prevent="onDragEnter"
      @dragover.prevent="onDragOver"
      @dragleave.prevent="onDragLeave"
      @drop.prevent="onDrop"
      @click="openFilePicker"
      :class="[
        'relative flex cursor-pointer flex-col items-center justify-center rounded-xl border-2 border-dashed px-4 py-8 text-center transition-all',
        isDragging
          ? 'border-brand-400 bg-brand-50/50 dark:border-brand-400 dark:bg-brand-500/10'
          : 'border-gray-300 bg-gray-50 hover:border-brand-300 hover:bg-brand-50/30 dark:border-gray-600 dark:bg-white/5 dark:hover:border-brand-500 dark:hover:bg-brand-500/5',
      ]"
    >
      <div
        :class="[
          'mb-3 flex h-12 w-12 items-center justify-center rounded-full transition-colors',
          isDragging
            ? 'bg-brand-100 text-brand-500 dark:bg-brand-500/20 dark:text-brand-400'
            : 'bg-gray-100 text-gray-400 dark:bg-white/10 dark:text-gray-500',
        ]"
      >
        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
          <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
          <polyline points="17 8 12 3 7 8"></polyline>
          <line x1="12" y1="3" x2="12" y2="15"></line>
        </svg>
      </div>
      <p class="mb-1 text-sm font-medium text-gray-700 dark:text-gray-300">
        <span class="text-brand-500">Klik untuk upload</span> atau seret ke sini
      </p>
      <p class="text-xs text-gray-400 dark:text-gray-500">
        PNG, JPG, SVG, WebP (Maks. 2MB)
      </p>
    </div>

    <input
      ref="fileInput"
      type="file"
      :accept="accept"
      class="hidden"
      @change="onFileSelect"
    />
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue'

interface FileInputProps {
  current?: string | null
  accept?: string
}

const props = withDefaults(defineProps<FileInputProps>(), {
  current: null,
  accept: 'image/*',
})

const emit = defineEmits<{
  (e: 'change', event: Event): void
}>()

const fileInput = ref<HTMLInputElement | null>(null)
const isDragging = ref(false)
const previewUrl = ref<string | null>(null)
let dragCounter = 0

function openFilePicker() {
  fileInput.value?.click()
}

function onDragEnter() {
  dragCounter++
  isDragging.value = true
}

function onDragOver() {
  isDragging.value = true
}

function onDragLeave() {
  dragCounter--
  if (dragCounter === 0) {
    isDragging.value = false
  }
}

function onDrop(e: DragEvent) {
  dragCounter = 0
  isDragging.value = false
  const file = e.dataTransfer?.files?.[0]
  if (file && file.type.startsWith('image/')) {
    emitSelectedFile(file)
  }
}

function onFileSelect(e: Event) {
  const target = e.target as HTMLInputElement
  const file = target.files?.[0]
  if (file) {
    emitSelectedFile(file)
  }
}

function emitSelectedFile(file: File) {
  if (previewUrl.value) {
    URL.revokeObjectURL(previewUrl.value)
  }
  previewUrl.value = URL.createObjectURL(file)

  const event = new Event('change', { bubbles: true })
  Object.defineProperty(event, 'target', {
    writable: false,
    value: { files: { 0: file, length: 1 } },
  })
  emit('change', event)
}

function clearFile() {
  if (previewUrl.value) {
    URL.revokeObjectURL(previewUrl.value)
    previewUrl.value = null
  }
  if (fileInput.value) {
    fileInput.value.value = ''
  }
}

watch(
  () => props.current,
  () => {
    if (props.current) {
      clearFile()
    }
  },
)
</script>
