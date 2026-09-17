<template>
  <AdminLayout>
    <div class="no-print mb-6 flex flex-wrap items-center justify-end gap-3">
      <Link
        href="/sppd"
        class="inline-flex items-center gap-2 rounded-lg border border-gray-300 bg-white px-4 py-2.5 text-sm font-medium text-gray-700 shadow-sm transition-colors hover:bg-gray-50 dark:border-gray-600 dark:bg-white/[0.03] dark:text-gray-200 dark:hover:bg-white/[0.06]"
      >
        Kembali
      </Link>
      <button
        type="button"
        class="inline-flex items-center gap-2 rounded-lg bg-brand-500 px-4 py-2.5 text-sm font-medium text-white shadow-sm transition-colors hover:bg-brand-600"
        @click="handlePrint"
      >
        Cetak / Simpan PDF
      </button>
    </div>

    <div class="print-area rounded-xl border border-gray-200 bg-white p-8 shadow-sm dark:border-gray-700 dark:bg-gray-900">
      <div class="text-center">
        <h1 class="text-xl font-bold uppercase leading-snug text-gray-900 dark:text-white">
          Pemerintah Kabupaten Pidie
        </h1>
        <h2 class="mt-1 text-lg font-bold uppercase leading-snug text-gray-900 dark:text-white">
          Badan Awas Rakyat Kabupaten Pidie
        </h2>
        <p class="mt-1 text-sm text-gray-600 dark:text-gray-300">
          Jl. Tgk. Di Lamjabat, Kec. Sakti, Kab. Pidie, Prov. Aceh
        </p>
        <div class="mx-auto mt-3 border-b-4 border-t border-gray-900 dark:border-gray-100"></div>
      </div>

      <h3 class="mt-8 text-center text-lg font-bold uppercase underline text-gray-900 dark:text-white">
        Surat Perintah Perjalanan Dinas
      </h3>

      <div class="mt-4 flex flex-wrap items-baseline justify-between gap-2">
        <p class="text-sm text-gray-800 dark:text-gray-200">
          <span class="font-semibold">Nomor:</span> {{ sppd.nomor_sppd }}
        </p>
        <p class="text-sm text-gray-800 dark:text-gray-200">
          <span class="font-semibold">Tanggal:</span> {{ formatTanggal(sppd.tanggal_mulai) }}
        </p>
      </div>

      <div class="mt-6 space-y-2 text-sm text-gray-800 dark:text-gray-200">
        <p>
          Yang bertanda tangan di bawah ini, Pejabat Pembuat Komitmen Badan Awas Rakyat Kabupaten Pidie,
          memerintahkan kepada:
        </p>
        <div class="ml-8 space-y-1">
          <p><span class="inline-block w-44 font-semibold">Nama</span>: {{ sppd.atas_nama }}</p>
          <p><span class="inline-block w-44 font-semibold">NIP</span>: {{ sppd.nip || '-' }}</p>
          <p><span class="inline-block w-44 font-semibold">Pangkat / Golongan</span>: {{ sppd.pangkat_golongan || '-' }}</p>
          <p><span class="inline-block w-44 font-semibold">Jabatan</span>: {{ sppd.jabatan || '-' }}</p>
        </div>
        <p class="mt-3">
          Untuk melakukan perjalanan dinas ke <span class="font-semibold">{{ sppd.tujuan_daerah }}</span>,
          <span class="font-semibold">{{ provinsiNama }}</span> selama
          <span class="font-semibold">{{ sppd.lama_hari }} hari</span>, terhitung mulai tanggal
          <span class="font-semibold">{{ formatTanggal(sppd.tanggal_mulai) }}</span> sampai dengan tanggal
          <span class="font-semibold">{{ formatTanggal(sppd.tanggal_selesai) }}</span>, dengan keperluan
          <span class="font-semibold">{{ sppd.keperluan || '-' }}</span>.
        </p>
      </div>

      <h4 class="mt-8 text-sm font-bold uppercase text-gray-900 dark:text-white">Rincian Biaya</h4>
      <template v-if="sppd.rincian && sppd.rincian.length > 0">
        <table class="print-table mt-2 w-full table-auto text-left text-sm text-gray-800 dark:text-gray-200">
          <thead>
            <tr class="border-b-2 border-gray-900 dark:border-gray-100">
              <th class="px-2 py-2 text-center font-semibold">No</th>
              <th class="px-2 py-2 font-semibold">Uraian</th>
              <th class="px-2 py-2 text-center font-semibold">Hari</th>
              <th class="px-2 py-2 text-right font-semibold">Satuan</th>
              <th class="px-2 py-2 text-right font-semibold">Jumlah</th>
              <th class="px-2 py-2 font-semibold">Keterangan</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(item, index) in sppd.rincian" :key="item.id" class="border-b border-gray-300 dark:border-gray-700">
              <td class="px-2 py-2 text-center">{{ index + 1 }}</td>
              <td class="px-2 py-2">{{ item.uraian }}</td>
              <td class="px-2 py-2 text-center">{{ item.hari }}</td>
              <td class="px-2 py-2 text-right">{{ formatRupiah(item.satuan) }}</td>
              <td class="px-2 py-2 text-right">{{ formatRupiah(item.jumlah) }}</td>
              <td class="px-2 py-2">{{ item.keterangan || '-' }}</td>
            </tr>
          </tbody>
          <tfoot>
            <tr class="border-t-2 border-gray-900 font-semibold dark:border-gray-100">
              <td colspan="4" class="px-2 py-2 text-right">Jumlah Biaya</td>
              <td class="px-2 py-2 text-right">{{ formatRupiah(sppd.total_biaya) }}</td>
              <td class="px-2 py-2"></td>
            </tr>
            <tr v-if="sppd.terbilang">
              <td colspan="6" class="px-2 py-2 italic">
                Terbilang: {{ sppd.terbilang }}
              </td>
            </tr>
          </tfoot>
        </table>
      </template>
      <div v-else class="mt-2">
        <EmptyState message="Belum ada rincian biaya untuk SPPD ini." />
      </div>

      <div class="mt-10 grid grid-cols-2 gap-8 text-center text-sm text-gray-800 dark:text-gray-200">
        <div>
          <p>Mengetahui / Pejabat Pembuat Komitmen,</p>
          <div class="mt-16">
            <p class="font-semibold underline">{{ approverName }}</p>
            <p class="text-xs">{{ approverNip }}</p>
          </div>
        </div>
        <div>
          <p>Bendahara Pengeluaran,</p>
          <div class="mt-16">
            <p class="font-semibold underline">{{ payerName }}</p>
            <p class="text-xs">{{ payerNip }}</p>
          </div>
        </div>
      </div>
    </div>
  </AdminLayout>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import AdminLayout from '../../components/layout/AdminLayout.vue'
import EmptyState from '@/components/ui/EmptyState.vue'
import { Link, usePage } from '@inertiajs/vue3'

interface CetakRincian {
  id: number
  jenis_biaya: string
  uraian: string
  hari: number
  satuan: number
  jumlah: number
  keterangan: string | null
}

interface CetakSppd {
  id: number
  nomor_sppd: string
  atas_nama: string
  nip: string | null
  pangkat_golongan: string | null
  jabatan: string | null
  tanggal_mulai: string
  tanggal_selesai: string
  lama_hari: number
  asal_daerah: string
  tujuan_daerah: string
  provinsi_tujuan: number
  keperluan: string | null
  status: string
  total_biaya: number
  rincian?: CetakRincian[]
  provinsi?: { id_provinsi: number; nama_provinsi: string } | null
  creator?: { id: number; name: string; nip?: string } | null
  approver?: { id: number; name: string; nip?: string } | null
  payer?: { id: number; name: string; nip?: string } | null
  terbilang?: string | null
}

const props = defineProps<{
  sppd: CetakSppd
}>()

const page = usePage<{
  sppd?: CetakSppd
  provinsi?: { id_provinsi: number; nama_provinsi: string }[]
}>()

const sppd = computed<CetakSppd>(() => page.props.sppd ?? props.sppd)

const provinsiNama = computed<string>(() => sppd.value.provinsi?.nama_provinsi ?? upstreamProvinsiName.value)

const upstreamProvinsiName = computed<string>(() => {
  const id = sppd.value.provinsi_tujuan
  const found = page.props.provinsi?.find((item) => item.id_provinsi === id)
  return found ? found.nama_provinsi : '-'
})

const approverName = computed<string>(() => sppd.value.approver?.name ?? '....................................')
const approverNip = computed<string>(() => (sppd.value.approver?.nip ? `NIP. ${sppd.value.approver.nip}` : 'NIP. ........................................'))

const payerName = computed<string>(() => sppd.value.payer?.name ?? '....................................')
const payerNip = computed<string>(() => (sppd.value.payer?.nip ? `NIP. ${sppd.value.payer.nip}` : 'NIP. ........................................'))

const formatRupiah = (value: number): string => {
  return new Intl.NumberFormat('id-ID', {
    style: 'currency',
    currency: 'IDR',
    maximumFractionDigits: 0,
  }).format(value)
}

const formatTanggal = (dateStr: string): string => {
  if (!dateStr) return '-'
  const date = new Date(dateStr)
  return date.toLocaleDateString('id-ID', {
    day: '2-digit',
    month: 'long',
    year: 'numeric',
  })
}

const handlePrint = (): void => {
  window.print()
}
</script>

<style>
@media print {
  @page {
    size: A4;
    margin: 14mm;
  }

  body {
    background: #ffffff !important;
  }

  aside,
  header,
  .no-print {
    display: none !important;
  }

  .min-h-screen {
    min-height: 0 !important;
    padding: 0 !important;
    margin: 0 !important;
    background: #ffffff !important;
  }

  .xl\:flex {
    display: block !important;
  }

  .print-area {
    border: none !important;
    box-shadow: none !important;
    border-radius: 0 !important;
    padding: 0 !important;
    background: #ffffff !important;
  }

  .print-table tr {
    page-break-inside: avoid;
  }
}
</style>