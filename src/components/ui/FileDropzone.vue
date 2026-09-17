<template>
  <div>
    <p class="mb-1.5 block text-xs font-medium uppercase tracking-wide text-gray-500 dark:text-gray-400">
      {{ label }}
    </p>

    <div
      v-if="url"
      class="flex items-center justify-between gap-3 rounded-lg border border-gray-200 bg-gray-50 px-3 py-2.5 dark:border-gray-700 dark:bg-white/[0.03]"
    >
      <a
        :href="url"
        target="_blank"
        rel="noopener"
        class="inline-flex min-w-0 items-center gap-2 text-sm font-medium text-brand-600 hover:underline dark:text-brand-400"
      >
        <PaperclipIcon class="h-4 w-4 shrink-0" />
        <span class="truncate">Lihat {{ label }}</span>
      </a>
      <div v-if="editable" class="flex shrink-0 items-center gap-2">
        <button
          type="button"
          class="text-xs font-medium text-gray-500 transition-colors hover:text-brand-500 dark:text-gray-400 dark:hover:text-brand-400"
          @click="openPicker"
        >
          Ganti
        </button>
        <button
          type="button"
          class="text-gray-400 transition-colors hover:text-error-500 dark:hover:text-error-500"
          title="Hapus dokumen"
          @click="$emit('remove')"
        >
          <TrashIcon class="h-4 w-4" />
        </button>
      </div>
    </div>

    <div
      v-else-if="editable"
      role="button"
      tabindex="0"
      class="relative flex cursor-pointer flex-col items-center justify-center gap-1.5 rounded-lg border-2 border-dashed px-4 py-5 text-center transition-colors focus:outline-none focus-visible:ring-2 focus-visible:ring-brand-500/40"
      :class="
        dragActive
          ? 'border-brand-500 bg-brand-50/60 dark:border-brand-500 dark:bg-brand-500/10'
          : 'border-gray-300 bg-white hover:border-brand-400 hover:bg-gray-50 dark:border-gray-600 dark:bg-white/[0.02] dark:hover:bg-white/[0.04]'
      "
      @click="openPicker"
      @keydown.enter.prevent="openPicker"
      @keydown.space.prevent="openPicker"
      @dragover.prevent="dragActive = true"
      @dragenter.prevent="dragActive = true"
      @dragleave.prevent="dragActive = false"
      @drop.prevent="onDrop"
    >
      <svg
        class="h-6 w-6 transition-colors"
        :class="dragActive ? 'text-brand-500' : 'text-gray-400'"
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        stroke-width="1.8"
        stroke-linecap="round"
        stroke-linejoin="round"
      >
        <path d="M12 16V8m0 0-3 3m3-3 3 3" />
        <path d="M20 16.5a4 4 0 0 0-2.4-7.2 5.5 5.5 0 0 0-10.6 1.6A3.5 3.5 0 0 0 7 17.5h12" />
      </svg>
      <p class="text-sm text-gray-600 dark:text-gray-300">
        <span class="font-semibold text-brand-600 dark:text-brand-400">Klik</span> atau tarik &amp; letakkan file
      </p>
      <p class="text-xs text-gray-400 dark:text-gray-500">{{ hint }}</p>

      <div
        v-if="busy"
        class="absolute inset-0 flex items-center justify-center gap-2 rounded-lg bg-white/80 text-sm font-medium text-gray-600 dark:bg-gray-900/80 dark:text-gray-200"
      >
        <span class="h-4 w-4 animate-spin rounded-full border-2 border-brand-500 border-t-transparent"></span>
        Mengunggah...
      </div>
    </div>

    <div
      v-else
      class="rounded-lg border border-dashed border-gray-300 bg-gray-50 px-3 py-3 text-center text-xs text-gray-400 dark:border-gray-600 dark:bg-white/[0.02] dark:text-gray-500"
    >
      Belum ada file
    </div>

    <input ref="inputEl" type="file" :accept="accept" class="hidden" @change="onChange" />
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { PaperclipIcon, TrashIcon } from '@/icons'

withDefaults(
  defineProps<{
    label: string
    url?: string | null
    editable?: boolean
    busy?: boolean
    accept?: string
    hint?: string
  }>(),
  {
    url: null,
    editable: false,
    busy: false,
    accept: '.pdf,.jpg,.jpeg,.png,.webp',
    hint: 'PDF, JPG, PNG, WEBP maks 10 MB',
  },
)

const emit = defineEmits<{
  select: [file: File]
  remove: []
}>()

const inputEl = ref<HTMLInputElement | null>(null)
const dragActive = ref(false)

const openPicker = (): void => {
  if (inputEl.value) inputEl.value.click()
}

const onChange = (event: Event): void => {
  const input = event.target as HTMLInputElement
  const file = input.files?.[0]
  input.value = ''
  if (file) emit('select', file)
}

const onDrop = (event: DragEvent): void => {
  dragActive.value = false
  const file = event.dataTransfer?.files?.[0]
  if (file) emit('select', file)
}
</script>
