<template>
  <AdminLayout>
    <PageBreadcrumb pageTitle="Laporan SPPD" />

    <div class="space-y-5">
      <div class="rounded-xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-white/[0.03]">
        <div class="grid grid-cols-1 gap-6 lg:grid-cols-3">
          <div>
            <h3 class="mb-3 text-sm font-semibold text-gray-800 dark:text-gray-100">Jenis Laporan</h3>
            <div class="space-y-2.5">
              <label
                v-for="(label, key) in jenisLaporan"
                :key="key"
                class="flex cursor-pointer items-start gap-3 rounded-lg border border-gray-200 p-3 transition-colors hover:bg-gray-50 dark:border-gray-700 dark:hover:bg-white/[0.03]"
                :class="{ 'border-brand-500 bg-brand-50 dark:border-brand-500 dark:bg-brand-500/10': jenis === key }"
              >
                <input
                  v-model="jenis"
                  type="radio"
                  name="jenis_laporan"
                  :value="key"
                  class="mt-0.5 h-4 w-4 shrink-0 border-gray-300 text-brand-500 focus:ring-brand-500"
                />
                <span class="text-sm text-gray-700 dark:text-gray-300">{{ label }}</span>
              </label>
            </div>
          </div>

          <div class="lg:col-span-2">
            <h3 class="mb-3 text-sm font-semibold text-gray-800 dark:text-gray-100">Pilihan Cetak</h3>
            <div class="grid grid-cols-1 gap-4 sm:grid-cols-2">
              <div>
                <label class="mb-1.5 block text-xs font-medium text-gray-500 dark:text-gray-400">Periode Awal</label>
                <DatePicker v-model="tglAwal" placeholder="Tanggal awal..." />
              </div>
              <div>
                <label class="mb-1.5 block text-xs font-medium text-gray-500 dark:text-gray-400">Periode Akhir</label>
                <DatePicker v-model="tglAkhir" placeholder="Tanggal akhir..." />
              </div>

              <div v-if="jenis === 'rincian'" class="sm:col-span-2">
                <label class="mb-1.5 block text-xs font-medium text-gray-500 dark:text-gray-400">Nomor SPPD</label>
                <select
                  v-model="nomorSppd"
                  class="w-full rounded-lg border border-gray-300 bg-white px-4 py-2.5 text-sm text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-gray-600 dark:bg-white/[0.05] dark:text-gray-100 dark:focus:border-blue-400"
                >
                  <option value="">-- Pilih Nomor SPPD --</option>
                  <option v-for="s in sppdList" :key="s.id" :value="s.nomor_sppd">
                    {{ s.nomor_sppd }} - {{ s.atas_nama }}
                  </option>
                </select>
              </div>
            </div>

            <div class="mt-5 flex flex-wrap items-center gap-3">
              <button
                type="button"
                class="inline-flex items-center gap-2 rounded-lg bg-brand-500 px-4 py-2.5 text-sm font-medium text-white shadow-sm transition-colors hover:bg-brand-600"
                @click="handleTampilkan"
              >
                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                  <path stroke-linecap="round" stroke-linejoin="round" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                </svg>
                Tampilkan
              </button>
              <button
                type="button"
                class="inline-flex items-center gap-2 rounded-lg border border-gray-300 bg-white px-4 py-2.5 text-sm font-medium text-gray-700 shadow-sm transition-colors hover:bg-gray-50 dark:border-gray-600 dark:bg-white/[0.03] dark:text-gray-200 dark:hover:bg-white/[0.06]"
                @click="handlePrint"
              >
                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a2 2 0 00-2-2H9a2 2 0 00-2 2v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z" />
                </svg>
                Cetak
              </button>
              <template v-if="previewUrl">
                <a
                  :href="exportPdfUrl"
                  class="inline-flex items-center gap-2 rounded-lg border border-red-200 bg-red-50 px-4 py-2.5 text-sm font-medium text-red-600 shadow-sm transition-colors hover:bg-red-100 dark:border-red-900/50 dark:bg-red-950/30 dark:text-red-400 dark:hover:bg-red-950/50"
                >
                  <DownloadIcon class="h-4 w-4" />
                  Export PDF
                </a>
                <a
                  :href="exportExcelUrl"
                  class="inline-flex items-center gap-2 rounded-lg border border-green-200 bg-green-50 px-4 py-2.5 text-sm font-medium text-green-700 shadow-sm transition-colors hover:bg-green-100 dark:border-green-900/50 dark:bg-green-950/30 dark:text-green-400 dark:hover:bg-green-950/50"
                >
                  <DownloadIcon class="h-4 w-4" />
                  Export Excel
                </a>
              </template>
            </div>
          </div>
        </div>
      </div>

      <div class="overflow-hidden rounded-xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-white/[0.03]">
        <div class="flex items-center justify-between gap-3 border-b border-gray-200 px-5 py-3 dark:border-gray-700">
          <p class="text-sm font-medium text-gray-700 dark:text-gray-300">Pratinjau Laporan</p>
          <p v-if="previewUrl" class="truncate font-mono text-xs text-gray-400">{{ previewUrl }}</p>
        </div>
        <div class="bg-gray-100 p-4 sm:p-6 dark:bg-gray-800">
          <iframe
            ref="iframeRef"
            :src="previewUrl"
            title="Pratinjau Laporan"
            class="h-[72vh] w-full rounded-lg border border-gray-200 bg-white shadow-sm dark:border-gray-700"
          ></iframe>
        </div>
      </div>
    </div>
  </AdminLayout>
  <Toast />
</template>

<script setup lang="ts">
import { computed, ref, onMounted } from 'vue'
import AdminLayout from '../../components/layout/AdminLayout.vue'
import PageBreadcrumb from '@/components/common/PageBreadcrumb.vue'
import DatePicker from '@/components/ui/DatePicker.vue'
import Toast from '@/components/ui/Toast.vue'
import DownloadIcon from '@/icons/DownloadIcon.vue'
import { useToast } from '@/composables/useToast'

interface SppdOption {
  id: number
  nomor_sppd: string
  atas_nama: string
}

const props = defineProps<{
  sppdList: SppdOption[]
  jenisLaporan: Record<string, string>
}>()

const { error } = useToast()

const jenis = ref<string>('rekap')
const tglAwal = ref<string>('')
const tglAkhir = ref<string>('')
const nomorSppd = ref<string>('')
const previewUrl = ref<string>('')
const iframeRef = ref<HTMLIFrameElement | null>(null)

const formatDate = (d: Date): string => {
  const m = String(d.getMonth() + 1).padStart(2, '0')
  const day = String(d.getDate()).padStart(2, '0')
  return `${d.getFullYear()}-${m}-${day}`
}

const buildParams = (): string => {
  const params = new URLSearchParams()
  params.set('jenis', jenis.value)
  if (tglAwal.value) params.set('tgl_awal', tglAwal.value)
  if (tglAkhir.value) params.set('tgl_akhir', tglAkhir.value)
  if (jenis.value === 'rincian' && nomorSppd.value) params.set('nomor_sppd', nomorSppd.value)
  return params.toString()
}

const exportPdfUrl = computed<string>(() => `/sppd/laporan/export/pdf?${buildParams()}`)
const exportExcelUrl = computed<string>(() => `/sppd/laporan/export/excel?${buildParams()}`)

const handleTampilkan = (): void => {
  if (jenis.value === 'rincian' && !nomorSppd.value) {
    error('Silakan pilih Nomor SPPD terlebih dahulu.')
    return
  }
  previewUrl.value = `/sppd/laporan/preview?${buildParams()}`
}

const handlePrint = (): void => {
  const frame = iframeRef.value
  if (!frame?.contentWindow) return
  frame.contentWindow.focus()
  frame.contentWindow.print()
}

onMounted(() => {
  const now = new Date()
  tglAwal.value = formatDate(new Date(now.getFullYear(), now.getMonth(), 1))
  tglAkhir.value = formatDate(new Date(now.getFullYear(), now.getMonth() + 1, 0))
  previewUrl.value = `/sppd/laporan/preview?${buildParams()}`
})
</script>