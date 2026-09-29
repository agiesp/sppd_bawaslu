<template>
  <Modal v-if="open && item" full-screen-backdrop @close="$emit('close')">
    <template #body>
      <div class="no-scrollbar relative w-full max-w-lg overflow-y-auto rounded-3xl bg-white p-5 dark:bg-gray-900 lg:p-7">
        <button
          type="button"
          class="absolute right-4 top-4 z-10 flex h-9 w-9 items-center justify-center rounded-full bg-gray-100 text-gray-400 transition-colors hover:bg-gray-200 hover:text-gray-600 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-white/[0.07] dark:hover:text-gray-300"
          @click="$emit('close')"
        >
          <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round">
            <path d="M6 6l12 12M18 6L6 18" />
          </svg>
          <span class="sr-only">Tutup</span>
        </button>

        <div>
          <h3 class="text-base font-semibold text-gray-800 dark:text-white/90">Detail Bukti</h3>
          <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">{{ item.uraian }}</p>
        </div>

        <div v-if="isPesawat" class="mt-5 grid grid-cols-1 gap-4 sm:grid-cols-2">
          <div class="sm:col-span-2">
            <label for="bk-maskapai" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              Nama Maskapai
            </label>
            <input
              id="bk-maskapai"
              v-model="form.maskapai"
              type="text"
              :class="inputClass"
              placeholder="Contoh: Garuda Indonesia"
            />
          </div>
          <div>
            <label for="bk-nobooking" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              No. Booking
            </label>
            <input
              id="bk-nobooking"
              v-model="form.no_booking"
              type="text"
              :class="inputClass"
              placeholder="Kode booking"
            />
          </div>
          <div>
            <label for="bk-notiket" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              No. Tiket
            </label>
            <input
              id="bk-notiket"
              v-model="form.no_tiket"
              type="text"
              :class="inputClass"
              placeholder="Nomor tiket"
            />
          </div>
          <div class="sm:col-span-2">
            <label for="bk-nopenerbangan" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              Nomor Penerbangan
            </label>
            <input
              id="bk-nopenerbangan"
              v-model="form.no_penerbangan"
              type="text"
              :class="inputClass"
              placeholder="Contoh: GA-112"
            />
          </div>
        </div>

        <div v-else-if="isPenginapan" class="mt-5 grid grid-cols-1 gap-4 sm:grid-cols-2">
          <div>
            <label for="bk-hotel" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              Nama Hotel
            </label>
            <input
              id="bk-hotel"
              v-model="form.nama_hotel"
              type="text"
              :class="inputClass"
              placeholder="Nama hotel"
            />
          </div>
          <div>
            <label for="bk-nokamar" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              No. Kamar
            </label>
            <input
              id="bk-nokamar"
              v-model="form.no_kamar"
              type="text"
              :class="inputClass"
              placeholder="Nomor kamar"
            />
          </div>
        </div>

        <div class="mt-6">
          <FileDropzone
            label="File Bukti"
            :url="buktiUrl"
            editable
            :busy="uploading"
            :hint="uploadHint"
            @select="onFileSelected"
            @remove="onFileRemove"
          />
        </div>

        <p v-if="uploadError" class="mt-3 rounded-lg bg-red-50 px-3 py-2 text-sm text-red-600 dark:bg-red-500/10 dark:text-red-400">
          {{ uploadError }}
        </p>

        <div class="mt-6 flex flex-col-reverse justify-end gap-3 sm:flex-row">
          <button
            type="button"
            class="inline-flex items-center justify-center rounded-lg bg-white px-5 py-2.5 text-sm font-medium text-gray-700 ring-1 ring-inset ring-gray-300 transition-colors hover:bg-gray-50 dark:bg-gray-800 dark:text-gray-400 dark:ring-gray-700 dark:hover:bg-white/[0.03]"
            @click="$emit('close')"
          >
            Batal
          </button>
          <button
            type="button"
            :disabled="uploading || saving"
            class="inline-flex items-center justify-center gap-2 rounded-lg bg-brand-500 px-5 py-2.5 text-sm font-medium text-white shadow-theme-xs transition-colors hover:bg-brand-600 disabled:cursor-not-allowed disabled:bg-brand-300"
            @click="handleSave"
          >
            {{ saving ? 'Menyimpan...' : 'Simpan' }}
          </button>
        </div>
      </div>
    </template>
  </Modal>
</template>

<script setup lang="ts">
import { reactive, computed, ref, watch } from 'vue'
import Modal from './Modal.vue'
import FileDropzone from './FileDropzone.vue'
import { uploadBukti } from '@/api/sppd'
import type { CalculateRincian } from '@/types/sppd'

const props = defineProps<{
  open: boolean
  item: CalculateRincian | null
}>()

const emit = defineEmits<{
  close: []
  saved: [item: CalculateRincian]
}>()

const inputClass =
  'w-full rounded-lg border border-gray-300 bg-white px-4 py-2.5 text-sm text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500 dark:border-gray-600 dark:bg-white/[0.05] dark:text-gray-100 dark:placeholder-gray-500 dark:focus:border-blue-400'

const form = reactive<{
  maskapai: string
  no_booking: string
  no_tiket: string
  no_penerbangan: string
  nama_hotel: string
  no_kamar: string
}>({
  maskapai: '',
  no_booking: '',
  no_tiket: '',
  no_penerbangan: '',
  nama_hotel: '',
  no_kamar: '',
})

const buktiPath = ref<string | null>(null)
const buktiUrl = ref<string | null>(null)
const uploading = ref(false)
const saving = ref(false)
const uploadError = ref('')

const isPesawat = computed(() => (props.item?.jenis_biaya ?? '').startsWith('transport_udara'))
const isPenginapan = computed(() => props.item?.jenis_biaya === 'penginapan')
const uploadHint = computed(() => (buktiPath.value ? 'PDF, JPG, PNG, WEBP maks 5 MB' : 'PDF, JPG, PNG, WEBP maks 5 MB'))

watch(
  () => props.item,
  (item) => {
    if (!item) return
    form.maskapai = item.maskapai ?? ''
    form.no_booking = item.no_booking ?? ''
    form.no_tiket = item.no_tiket ?? ''
    form.no_penerbangan = item.no_penerbangan ?? ''
    form.nama_hotel = item.nama_hotel ?? ''
    form.no_kamar = item.no_kamar ?? ''
    buktiPath.value = item.bukti ?? null
    buktiUrl.value = item.bukti_url ?? null
    uploadError.value = ''
  },
  { immediate: true },
)

const onFileSelected = async (file: File): Promise<void> => {
  uploading.value = true
  uploadError.value = ''
  try {
    const res = await uploadBukti(file)
    buktiPath.value = res.path
    buktiUrl.value = res.url
  } catch {
    uploadError.value = 'Gagal mengunggah bukti. Gunakan format PDF/JPG/PNG/WEBP maksimal 5 MB.'
  } finally {
    uploading.value = false
  }
}

const onFileRemove = (): void => {
  buktiPath.value = null
  buktiUrl.value = null
  uploadError.value = ''
}

const handleSave = (): void => {
  if (!props.item) return
  saving.value = true
  const updated: CalculateRincian = {
    ...props.item,
    bukti: buktiPath.value,
    bukti_url: buktiUrl.value,
    maskapai: form.maskapai.trim() || null,
    no_booking: form.no_booking.trim() || null,
    no_tiket: form.no_tiket.trim() || null,
    no_penerbangan: form.no_penerbangan.trim() || null,
    nama_hotel: form.nama_hotel.trim() || null,
    no_kamar: form.no_kamar.trim() || null,
  }
  saving.value = false
  emit('saved', updated)
}
</script>