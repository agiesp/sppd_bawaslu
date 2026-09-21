<template>
  <AdminLayout>
    <!-- Top Toolbar (not printed) -->
    <header class="no-print mb-6 flex flex-wrap items-center justify-end gap-3">
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
        <svg
          xmlns="http://www.w3.org/2000/svg"
          class="h-4 w-4"
          fill="none"
          viewBox="0 0 24 24"
          stroke="currentColor"
          stroke-width="2"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a2 2 0 00-2-2H9a2 2 0 00-2 2v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z"
          />
        </svg>
        Cetak PDF / Print
      </button>
    </header>

    <!-- Printable Sheet: Replica RINCIAN SPPD (Excel Format) -->
    <main class="max-w-4xl mx-auto mt-6 px-2 sm:px-4">
      <div
        id="print-sheet"
        class="print-container excel-doc bg-white rounded-md shadow-xl border border-slate-300 p-8 sm:p-12 text-black leading-snug"
      >
        <!-- Document Title -->
        <div class="text-center mb-6">
          <h1 class="text-base sm:text-lg font-bold uppercase tracking-wide">PERINCIAN BIAYA PERJALANAN DINAS</h1>
        </div>

        <!-- Header Metadata Block -->
        <div class="mb-4 text-xs sm:text-sm space-y-1 max-w-lg">
          <div class="grid grid-cols-12 items-center">
            <span class="col-span-3 font-normal">Atas Nama</span>
            <span class="col-span-1 text-center">:</span>
            <div class="col-span-8">
              <input
                type="text"
                v-model="metaNama"
                class="input-cell w-full font-bold border-b border-dotted border-gray-400 focus:border-solid"
              />
            </div>
          </div>
          <div class="grid grid-cols-12 items-center">
            <span class="col-span-3 font-normal">SPPD Nomor</span>
            <span class="col-span-1 text-center">:</span>
            <div class="col-span-8">
              <input
                type="text"
                v-model="metaNomor"
                class="input-cell w-full border-b border-dotted border-gray-400 focus:border-solid"
              />
            </div>
          </div>
          <div class="grid grid-cols-12 items-center">
            <span class="col-span-3 font-normal">Tanggal</span>
            <span class="col-span-1 text-center">:</span>
            <div class="col-span-8">
              <input
                type="text"
                v-model="metaTanggal"
                class="input-cell w-full border-b border-dotted border-gray-400 focus:border-solid"
              />
            </div>
          </div>
        </div>

        <!-- Main Table -->
        <table class="excel-table mb-2">
          <thead>
            <tr class="text-center font-bold">
              <th class="w-10">No</th>
              <th>Perincian Biaya</th>
              <th class="w-40">Jumlah</th>
              <th class="w-40">Keterangan</th>
            </tr>
            <tr class="text-center text-xs italic bg-gray-50/50">
              <th class="py-0.5">1</th>
              <th class="py-0.5">2</th>
              <th class="py-0.5">3</th>
              <th class="py-0.5">4</th>
            </tr>
          </thead>
          <tbody>
            <template v-if="rows.length > 0">
              <template v-for="(row, index) in rows" :key="'row-' + index">
                <!-- Group Header Row -->
                <tr v-if="row.type === 'header'" class="font-bold bg-gray-50/30">
                  <td class="text-center align-top w-10">{{ row.no }}</td>
                  <td class="align-top">{{ row.label }}</td>
                  <td class="text-right align-top"></td>
                  <td class="align-top">{{ row.ket }}</td>
                </tr>
                <!-- Detail Row -->
                <tr v-else class="align-top">
                  <td class="text-center align-top w-10"></td>
<td class="align-top pl-4 sm:pl-6">
                      <input
                        type="text"
                        v-model="row.title"
                        class="input-cell w-full"
                      />
                    </td>
                  <td class="text-right align-top">
                    <div class="detail-jumlah flex items-center justify-end gap-1 text-xs sm:text-sm min-w-0">
                      <span class="text-gray-500 font-normal" style="white-space: nowrap">
                        <strong>{{ row.qty }}</strong> {{ row.unit }} x Rp.{{ formatRupiah(row.rate) }} =
                      </span>
                      <span class="font-medium" style="white-space: nowrap">
                        Rp.{{ formatRupiah((row.qty || 0) * (row.rate || 0)) }}
                      </span>
                    </div>
                  </td>
                  <td class="align-top">
                    <input type="text" v-model="row.ket" class="input-cell w-full" />
                  </td>
                </tr>
              </template>
            </template>
            <template v-else>
              <tr>
                <td colspan="4" class="p-4 text-center text-gray-500 italic">
                  Belum ada rincian biaya untuk SPPD ini.
                </td>
              </tr>
            </template>
          </tbody>
          <tfoot>
            <!-- Grand Total Row -->
            <tr class="font-bold">
              <td colspan="2" class="text-center tracking-widest uppercase">
                J u m l a h
              </td>
              <td class="text-right whitespace-nowrap px-2">
                Rp. <span>{{ formatRupiah(grandTotal) }}</span>
              </td>
              <td></td>
            </tr>
          </tfoot>
        </table>

        <!-- Terbilang Box (Matches Excel Row) -->
        <table class="excel-table mb-6">
          <tbody>
            <tr>
              <td class="w-24 font-bold align-top">Terbilang :</td>
              <td class="italic font-bold capitalize leading-tight">
                {{ terbilangText }}
              </td>
            </tr>
          </tbody>
        </table>

        <!-- Signatures Middle Block -->
        <div class="grid grid-cols-2 gap-4 text-xs sm:text-sm mb-6 pt-2">
          <!-- Left Side: Paid by Bendahara -->
          <div>
            <p class="mb-0.5">Telah dibayar sebesar</p>
            <p class="font-bold">Rp. <span>{{ formatRupiah(grandTotal) }}</span></p>
            <p class="mt-4 font-normal">Bendahara Pengeluaran Pembantu,</p>
            <div class="mt-16">
              <input
                type="text"
                v-model="bendaharaNama"
                class="input-cell w-full font-bold underline uppercase"
              />
              <div class="flex items-center gap-1">
                <span>NIP.</span>
                <input type="text" v-model="bendaharaNip" class="input-cell w-full" />
              </div>
            </div>
          </div>

          <!-- Right Side: Traveler Receipt -->
          <div>
            <div class="flex items-center gap-1">
              <input type="text" v-model="lokasiTgl" class="input-cell w-full text-right" />
            </div>
            <p class="mt-0.5">Telah menerima uang sebesar</p>
            <p class="font-bold">Rp. <span>{{ formatRupiah(grandTotal) }}</span></p>
            <p class="mt-4 font-normal">Yang Menerima,</p>
            <div class="mt-16">
              <input
                type="text"
                v-model="penerimaNama"
                class="input-cell w-full font-bold underline uppercase"
              />
              <div class="flex items-center gap-1">
                <span>NIP.</span>
                <input
                  type="text"
                  v-model="penerimaNip"
                  class="input-cell w-full"
                  placeholder="-"
                />
              </div>
            </div>
          </div>
        </div>

        <!-- Bottom Section: PERHITUNGAN SPPD RAMPUNG -->
        <div class="border-t border-black pt-3">
          <h2 class="font-bold text-xs sm:text-sm uppercase mb-2 text-center sm:text-left">
            PERHITUNGAN SPPD RAMPUNG
          </h2>

          <div class="grid grid-cols-1 sm:grid-cols-12 gap-2 text-xs sm:text-sm">
            <!-- Breakdown Table Left -->
            <div class="sm:col-span-7">
              <table class="w-full text-xs sm:text-sm">
                <tr>
                  <td class="py-1">Ditetapkan sejumlah</td>
                  <td class="w-8">Rp.</td>
                  <td class="text-right font-medium pr-4">{{ formatRupiah(grandTotal) }}</td>
                </tr>
                <tr>
                  <td class="py-1">Yang telah dibayar semula</td>
                  <td>Rp.</td>
                  <td class="text-right font-medium pr-4">
                    <input type="text" value="-" class="input-cell w-full text-right" />
                  </td>
                </tr>
                <tr class="border-t border-black font-semibold">
                  <td class="py-1">Sisa kekurangan / lebih</td>
                  <td>Rp.</td>
                  <td class="text-right pr-4">
                    <input type="text" value="-" class="input-cell w-full text-right" />
                  </td>
                </tr>
              </table>
            </div>

            <!-- PPK Signature Right -->
            <div class="sm:col-span-5 text-center mt-2 sm:mt-0">
              <p class="font-normal">Pejabat Pembuat Komitmen</p>
              <div class="mt-12">
                <input
                  type="text"
                  v-model="ppkNama"
                  class="input-cell w-full text-center font-bold underline uppercase"
                />
                <div class="flex justify-center items-center gap-1">
                  <span>NIP.</span>
                  <input type="text" v-model="ppkNip" class="input-cell w-full text-center" />
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
  </AdminLayout>
</template>

<script setup lang="ts">
import { computed, ref } from 'vue'
import { Link, usePage } from '@inertiajs/vue3'
import AdminLayout from '../../components/layout/AdminLayout.vue'

interface RincianItem {
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
  asal_daerah: string
  tujuan_daerah: string
  tanggal_mulai: string
  tanggal_selesai: string
  lama_hari: number
  keperluan: string | null
  status: string
  total_biaya: number
  rincian?: RincianItem[]
  approver?: { name: string; nip?: string } | null
  payer?: { name: string; nip?: string } | null
}

interface DetailRow {
  type: 'item'
  no: string
  title: string
  qty: number
  unit: string
  rate: number
  ket: string
}

interface GroupRow {
  type: 'header'
  no: string
  label: string
  ket: string
}

type SheetRow = DetailRow | GroupRow

const props = defineProps<{
  sppd: CetakSppd
  terbilang?: string | null
}>()

const BULAN_PANJANG = [
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember',
]

const formatTanggal = (dateStr: string): string => {
  if (!dateStr) return '-'
  const d = new Date(dateStr)
  return `${d.getDate()} ${BULAN_PANJANG[d.getMonth()]} ${d.getFullYear()}`
}

const formatRange = (): string => {
  const mulai = new Date(props.sppd.tanggal_mulai)
  const selesai = new Date(props.sppd.tanggal_selesai)
  if (
    mulai.getMonth() === selesai.getMonth() &&
    mulai.getFullYear() === selesai.getFullYear()
  ) {
    return `${mulai.getDate()} s/d ${selesai.getDate()} ${BULAN_PANJANG[selesai.getMonth()]} ${selesai.getFullYear()}`
  }
  return `${formatTanggal(props.sppd.tanggal_mulai)} - ${formatTanggal(props.sppd.tanggal_selesai)}`
}

const formatRupiah = (value: number): string =>
  new Intl.NumberFormat('id-ID').format(Number(value) || 0)

// ---- Sheet data (editable, prefilled from SPPD) ----
const metaNama = ref(props.sppd.atas_nama)
const metaNomor = ref(props.sppd.nomor_sppd)
const metaTanggal = ref(formatRange())
const lokasiTgl = ref(
  `${(props.sppd.asal_daerah || 'Sigli').trim() || 'Sigli'}, ${formatTanggal(props.sppd.tanggal_selesai)}`,
)
const page = usePage<{ appSettings?: Record<string, string | null> }>()
const appSettings = page.props.appSettings ?? {}
const bendaharaNama = ref(
  appSettings.print_bendahara_nama || props.sppd.payer?.name || '........................................',
)
const bendaharaNip = ref(
  appSettings.print_bendahara_nip || props.sppd.payer?.nip || '........................................',
)
const penerimaNama = ref(props.sppd.atas_nama)
const penerimaNip = ref(props.sppd.nip ?? '')
const ppkNama = ref(
  appSettings.print_ppk_nama || props.sppd.approver?.name || '........................................',
)
const ppkNip = ref(
  appSettings.print_ppk_nip || props.sppd.approver?.nip || '........................................',
)

// ---- Build Excel-style grouped rows from real rincian ----
const unitFor = (jenis: string): string => {
  if (jenis === 'penginapan') return 'Malam'
  if (jenis === 'uang_harian' || jenis === 'uang_saku') return 'Hari'
  if (jenis === 'transport_udara_pergi' || jenis === 'transport_udara_pulang') return 'Ptg'
  return 'Kali'
}

interface GroupDef {
  label: string
  test: (jenis: string) => boolean
}

const GROUPS: GroupDef[] = [
  {
    label: 'Uang Harian / Saku',
    test: (j) => ['uang_harian', 'uang_saku'].includes(j),
  },
  {
    label: 'Penginapan',
    test: (j) => j === 'penginapan',
  },
  {
    label: 'Transportasi',
    test: (j) => j.startsWith('transport') || j === 'taksi_bandara',
  },
  {
    label: 'Biaya Lain-Lain',
    test: () => true,
  },
]

const buildRows = (): SheetRow[] => {
  const source = props.sppd.rincian ?? []
  const result: SheetRow[] = []
  const used = new Set<number>()

  let groupNo = 0
  for (const group of GROUPS) {
    const memberIdx: number[] = []
    source.forEach((item, idx) => {
      if (!used.has(idx) && group.test(item.jenis_biaya)) memberIdx.push(idx)
    })
    if (memberIdx.length === 0) continue

    groupNo += 1
    result.push({ type: 'header', no: String(groupNo), label: group.label, ket: '' })

    memberIdx.forEach((idx) => {
      const item = source[idx]
      result.push({
        type: 'item',
        no: '',
        title: item.uraian,
        qty: Number(item.hari) || 0,
        unit: unitFor(item.jenis_biaya),
        rate: Number(item.satuan) || 0,
        ket: '',
      })
      used.add(idx)
    })
  }

  return result
}

const rows = ref<SheetRow[]>(buildRows())

const detailRows = computed<DetailRow[]>(() =>
  rows.value.filter((row): row is DetailRow => row.type === 'item'),
)

const grandTotal = computed(() =>
  detailRows.value.reduce((sum, row) => sum + (Number(row.qty) || 0) * (Number(row.rate) || 0), 0),
)

const capex = (s: string): string => (s ? s.charAt(0).toUpperCase() + s.slice(1) : s)

const terbilangWords = (angka: number): string => {
  const bil = [
    '',
    'satu',
    'dua',
    'tiga',
    'empat',
    'lima',
    'enam',
    'tujuh',
    'delapan',
    'sembilan',
    'sepuluh',
    'sebelas',
  ]
  angka = Math.floor(angka)
  if (angka < 12) return bil[angka]
  if (angka < 20) return terbilangWords(angka - 10) + ' belas'
  if (angka < 100) return terbilangWords(Math.floor(angka / 10)) + ' puluh ' + terbilangWords(angka % 10)
  if (angka < 200) return 'seratus ' + terbilangWords(angka - 100)
  if (angka < 1000) return terbilangWords(Math.floor(angka / 100)) + ' ratus ' + terbilangWords(angka % 100)
  if (angka < 2000) return 'seribu ' + terbilangWords(angka - 1000)
  if (angka < 1000000) return terbilangWords(Math.floor(angka / 1000)) + ' ribu ' + terbilangWords(angka % 1000)
  if (angka < 1000000000) return terbilangWords(Math.floor(angka / 1000000)) + ' juta ' + terbilangWords(angka % 1000000)
  return terbilangWords(Math.floor(angka / 1000000000000)) + ' trilyun ' + terbilangWords(angka % 1000000000000)
}

const terbilangText = computed(() => {
  const total = grandTotal.value
  if (!total) return 'Nol rupiah'
  const words = terbilangWords(total).replace(/\s+/g, ' ').trim()
  return `${capex(words)} rupiah`
})

const handlePrint = (): void => {
  window.print()
}
</script>

<style>
.excel-doc {
  font-family: 'Times New Roman', 'Liberation Serif', Times, serif;
  color: #000000;
}

/* Precision Excel Borders */
.excel-table {
  border-collapse: collapse;
  width: 100%;
}

.excel-table th,
.excel-table td {
  border: 1px solid #000000;
  padding: 3px 5px;
  font-size: 11.5pt;
  line-height: 1.25;
}

/* Interactive Input Fields inside Table Cell */
.input-cell {
  background-color: transparent;
  outline: none;
  transition: background-color 0.15s ease;
}

.input-cell:focus {
  background-color: #fef08a;
}

@media print {
  @page {
    size: A4 portrait;
    margin: 10mm 12mm 10mm 12mm;
  }

  body {
    background-color: #ffffff !important;
    color: #000000 !important;
    margin: 0 !important;
    padding: 0 !important;
    -webkit-print-color-adjust: exact !important;
    print-color-adjust: exact !important;
  }

  aside,
  header,
  footer,
  nav,
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

  .print-container {
    width: 100% !important;
    max-width: 100% !important;
    margin: 0 !important;
    padding: 0 !important;
    box-shadow: none !important;
    border: none !important;
    background: #ffffff !important;
  }

  .excel-table th,
  .excel-table td {
    border-color: #000000 !important;
  }

  .input-cell {
    border: none !important;
    background: transparent !important;
    padding: 0 !important;
    box-shadow: none !important;
    outline: none !important;
  }

  .detail-jumlah {
    justify-content: flex-end !important;
    min-width: 0 !important;
  }
}
</style>