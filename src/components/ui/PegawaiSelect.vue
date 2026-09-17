<template>
  <div ref="root" class="relative">
    <button
      type="button"
      class="flex w-full items-center gap-3 rounded-lg border border-gray-300 bg-white px-3 py-2.5 text-left text-sm text-gray-900 shadow-sm transition-colors focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500 dark:border-gray-600 dark:bg-white/[0.05] dark:text-gray-100 dark:focus:border-blue-400"
      @click="toggle"
    >
      <span v-if="selected" class="flex min-w-0 flex-1 items-center gap-3">
        <span class="relative inline-flex h-9 w-9 shrink-0 items-center justify-center overflow-hidden rounded-full ring-2 ring-gray-100 dark:ring-gray-700">
          <img
            v-if="selected.avatar_url"
            :src="selected.avatar_url"
            :alt="selected.nama_pegawai"
            class="h-full w-full object-cover"
          />
          <span
            v-else
            class="inline-flex h-full w-full items-center justify-center bg-blue-100 text-sm font-semibold text-blue-600 dark:bg-blue-900/30 dark:text-blue-300"
          >
            {{ selected.nama_pegawai.charAt(0).toUpperCase() }}
          </span>
        </span>
        <span class="flex min-w-0 flex-col">
          <span class="truncate font-medium">{{ selected.nama_pegawai }}</span>
          <span class="truncate text-xs text-gray-500 dark:text-gray-400">{{ selected.nip || 'Tanpa NIP' }}</span>
        </span>
      </span>
      <span v-else class="flex-1 text-gray-400 dark:text-gray-500">-- Pilih Pegawai --</span>
      <ChevronDownIcon
        class="h-4 w-4 shrink-0 text-gray-400 transition-transform"
        :class="{ 'rotate-180': open }"
      />
    </button>

    <transition
      enter-active-class="transition duration-150 ease-out"
      enter-from-class="opacity-0 -translate-y-1"
      enter-to-class="opacity-100 translate-y-0"
      leave-active-class="transition duration-100 ease-in"
      leave-from-class="opacity-100 translate-y-0"
      leave-to-class="opacity-0 -translate-y-1"
    >
      <div
        v-if="open"
        class="absolute left-0 right-0 top-full z-50 mt-2 overflow-hidden rounded-xl border border-gray-200 bg-white shadow-xl shadow-gray-900/10 dark:border-gray-700 dark:bg-gray-900 dark:shadow-black/40"
      >
        <div class="border-b border-gray-100 p-2 dark:border-gray-800">
          <div class="relative">
            <input
              ref="searchInput"
              v-model="query"
              type="text"
              placeholder="Cari pegawai..."
              class="w-full rounded-lg border border-gray-200 bg-gray-50 px-3 py-2 pl-8 text-sm text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:bg-white focus:outline-none focus:ring-1 focus:ring-blue-500 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-100 dark:focus:border-blue-400 dark:focus:bg-gray-800"
            />
            <svg
              class="pointer-events-none absolute left-2.5 top-1/2 h-3.5 w-3.5 -translate-y-1/2 text-gray-400"
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
              stroke-width="2"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
              />
            </svg>
          </div>
        </div>
        <ul class="max-h-64 overflow-y-auto p-1.5">
          <li v-if="filtered.length === 0">
            <span
              class="flex w-full cursor-default items-center gap-3 rounded-lg px-3 py-2.5 text-sm text-gray-400 dark:text-gray-500"
            >
              Tidak ada pegawai ditemukan.
            </span>
          </li>
          <li v-for="p in filtered" :key="p.id">
            <button
              type="button"
              class="flex w-full items-center gap-3 rounded-lg px-3 py-2.5 text-left transition-colors"
              :class="
                isSelected(p.id)
                  ? 'bg-blue-50 dark:bg-blue-900/20'
                  : 'hover:bg-gray-50 dark:hover:bg-gray-800'
              "
              @click="choose(p)"
            >
              <span class="relative inline-flex h-9 w-9 shrink-0 items-center justify-center overflow-hidden rounded-full ring-2 ring-gray-100 dark:ring-gray-700">
                <img
                  v-if="p.avatar_url"
                  :src="p.avatar_url"
                  :alt="p.nama_pegawai"
                  class="h-full w-full object-cover"
                />
                <span
                  v-else
                  class="inline-flex h-full w-full items-center justify-center bg-blue-100 text-sm font-semibold text-blue-600 dark:bg-blue-900/30 dark:text-blue-300"
                >
                  {{ p.nama_pegawai.charAt(0).toUpperCase() }}
                </span>
              </span>
              <span class="flex min-w-0 flex-col">
                <span class="truncate text-sm font-medium text-gray-900 dark:text-gray-100">
                  {{ p.nama_pegawai }}
                </span>
                <span class="truncate text-xs text-gray-500 dark:text-gray-400">
                  {{ p.nip || 'Tanpa NIP' }}
                  <span v-if="p.jabatan" class="text-gray-400 dark:text-gray-500">&middot; {{ p.jabatan }}</span>
                </span>
              </span>
              <CheckIcon
                v-if="isSelected(p.id)"
                class="ml-auto h-4 w-4 shrink-0 text-blue-500"
              />
            </button>
          </li>
        </ul>
      </div>
    </transition>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, nextTick, onMounted, onBeforeUnmount } from 'vue'
import { ChevronDownIcon, CheckIcon } from '@/icons'

export interface PegawaiSelectOption {
  id: number | string
  nama_pegawai: string
  nip: string | null
  jabatan: string | null
  avatar_url: string | null
}

const props = withDefaults(
  defineProps<{
    modelValue: number | '' | null
    pegawais: PegawaiSelectOption[]
  }>(),
  {},
)

const emit = defineEmits<{
  'update:modelValue': [value: number | '' | null]
  change: [value: number | '' | null]
}>()

const root = ref<HTMLDivElement | null>(null)
const open = ref(false)
const query = ref('')
const searchInput = ref<HTMLInputElement | null>(null)

const selected = computed(() => props.pegawais.find((p) => p.id === props.modelValue) ?? null)

const filtered = computed(() => {
  const q = query.value.toLowerCase()
  return props.pegawais.filter(
    (p) =>
      p.nama_pegawai.toLowerCase().includes(q) ||
      (p.nip ?? '').toLowerCase().includes(q) ||
      (p.jabatan ?? '').toLowerCase().includes(q),
  )
})

const toggle = (): void => {
  if (open.value) {
    closeDropdown()
    return
  }
  open.value = true
  query.value = ''
  nextTick(() => searchInput.value?.focus())
}

const closeDropdown = (): void => {
  open.value = false
}

const isSelected = (id: number | string): boolean => id === props.modelValue

const choose = (p: PegawaiSelectOption): void => {
  emit('update:modelValue', p.id as number)
  emit('change', p.id as number)
  closeDropdown()
  query.value = ''
}

const handleOutside = (event: MouseEvent): void => {
  if (root.value && !root.value.contains(event.target as Node)) {
    closeDropdown()
  }
}

onMounted(() => document.addEventListener('click', handleOutside))
onBeforeUnmount(() => document.removeEventListener('click', handleOutside))
</script>