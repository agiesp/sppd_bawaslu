<template>
  <AdminLayout>
    <PageBreadcrumb pageTitle="Edit SPPD" />

    <div
      v-if="page.props.flash?.success"
      class="mb-4 rounded-lg border border-green-200 bg-green-50 p-4 text-sm text-green-700 dark:border-green-800 dark:bg-green-900/30 dark:text-green-300"
    >
      {{ page.props.flash.success }}
    </div>

    <form novalidate @submit.prevent="handleSimpan">
      <div
        class="rounded-2xl border border-gray-200 bg-white p-6 dark:border-gray-800 dark:bg-white/[0.03]"
      >
        <div class="mb-6">
          <h3 class="text-base font-semibold text-gray-800 dark:text-white/90">Data SPPD</h3>
          <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
            Ubah data pelaksana perjalanan dinas ({{ sppd.nomor_sppd }}).
          </p>
        </div>

        <div class="grid grid-cols-1 gap-5 lg:grid-cols-2">
          <div class="lg:col-span-2">
            <label for="pegawai" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              Pilih Pegawai <span class="text-xs font-normal text-gray-400 dark:text-gray-500">(opsional, isi otomatis)</span>
            </label>
            <PegawaiSelect v-model="selectedPegawaiId" :pegawais="pegawais" @change="onPegawaiChange" />
          </div>

          <div>
            <label for="atas_nama" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              Atas Nama<span class="text-error-500">*</span>
            </label>
            <div class="group relative">
              <span
                class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
              >
                <UserCircleIcon class="h-4 w-4" />
              </span>
              <input
                id="atas_nama"
                v-model="form.atas_nama"
                type="text"
                placeholder="Nama pelaksana dinas"
                :class="[inputClass, { 'border-error-500 focus:border-error-500 focus:ring-error-500/10': form.errors.atas_nama }]"
              />
            </div>
            <p v-if="form.errors.atas_nama" class="mt-1.5 text-sm text-red-600 dark:text-red-400">
              {{ form.errors.atas_nama }}
            </p>
          </div>

          <div>
            <label for="nip" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              NIP
            </label>
            <div class="group relative">
              <span
                class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
              >
                <GridIcon class="h-4 w-4" />
              </span>
              <input
                id="nip"
                v-model="form.nip"
                type="text"
                placeholder="Nomor Induk Pegawai"
                :class="inputClass"
              />
            </div>
            <p v-if="form.errors.nip" class="mt-1.5 text-sm text-red-600 dark:text-red-400">
              {{ form.errors.nip }}
            </p>
          </div>

          <div>
            <label for="pangkat_golongan" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              Pangkat / Golongan
            </label>
            <div class="group relative">
              <span
                class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
              >
                <BarChartIcon class="h-4 w-4" />
              </span>
              <input
                id="pangkat_golongan"
                v-model="form.pangkat_golongan"
                type="text"
                placeholder="Pangkat dan golongan"
                :class="inputClass"
              />
            </div>
            <p v-if="form.errors.pangkat_golongan" class="mt-1.5 text-sm text-red-600 dark:text-red-400">
              {{ form.errors.pangkat_golongan }}
            </p>
          </div>

          <div>
            <label for="jabatan" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              Jabatan
            </label>
            <div class="group relative">
              <span
                class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
              >
                <UserGroupIcon class="h-4 w-4" />
              </span>
              <input
                id="jabatan"
                v-model="form.jabatan"
                type="text"
                placeholder="Jabatan pelaksana dinas"
                :class="inputClass"
              />
            </div>
            <p v-if="form.errors.jabatan" class="mt-1.5 text-sm text-red-600 dark:text-red-400">
              {{ form.errors.jabatan }}
            </p>
          </div>

          <div>
            <label for="tanggal_mulai" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              Tanggal Mulai<span class="text-error-500">*</span>
            </label>
            <DatePicker
              id="tanggal_mulai"
              v-model="form.tanggal_mulai"
              placeholder="Pilih tanggal mulai"
              :error="!!form.errors.tanggal_mulai"
            />
            <p v-if="form.errors.tanggal_mulai" class="mt-1.5 text-sm text-red-600 dark:text-red-400">
              {{ form.errors.tanggal_mulai }}
            </p>
          </div>

          <div>
            <label for="tanggal_selesai" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              Tanggal Selesai<span class="text-error-500">*</span>
            </label>
            <DatePicker
              id="tanggal_selesai"
              v-model="form.tanggal_selesai"
              placeholder="Pilih tanggal selesai"
              :error="!!form.errors.tanggal_selesai"
            />
            <p v-if="form.errors.tanggal_selesai" class="mt-1.5 text-sm text-red-600 dark:text-red-400">
              {{ form.errors.tanggal_selesai }}
            </p>
          </div>

          <div>
            <label for="provinsi_tujuan" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              Provinsi Tujuan<span class="text-error-500">*</span>
            </label>
            <div class="group relative">
              <span
                class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
              >
                <FlagIcon class="h-4 w-4" />
              </span>
              <select
                id="provinsi_tujuan"
                v-model="form.provinsi_tujuan"
                @change="onProvinsiChange"
                :class="[inputClass, { 'border-error-500 focus:border-error-500 focus:ring-error-500/10': form.errors.provinsi_tujuan }]"
              >
                <option value="">-- Pilih Provinsi --</option>
                <option v-for="p in provinsi" :key="p.id_provinsi" :value="p.id_provinsi">
                  {{ p.id_provinsi }} - {{ p.nama_provinsi }}
                </option>
              </select>
            </div>
            <p v-if="form.errors.provinsi_tujuan" class="mt-1.5 text-sm text-red-600 dark:text-red-400">
              {{ form.errors.provinsi_tujuan }}
            </p>
          </div>

          <div>
            <label for="tujuan_daerah" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              Tujuan Daerah<span class="text-error-500">*</span>
            </label>
            <div class="group relative">
              <span
                class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
              >
                <GridIcon class="h-4 w-4" />
              </span>
              <input
                id="tujuan_daerah"
                v-model="form.tujuan_daerah"
                type="text"
                placeholder="Ibu kota provinsi tujuan"
                :class="[inputClass, { 'border-error-500 focus:border-error-500 focus:ring-error-500/10': form.errors.tujuan_daerah }]"
              />
            </div>
            <p v-if="form.errors.tujuan_daerah" class="mt-1.5 text-sm text-red-600 dark:text-red-400">
              {{ form.errors.tujuan_daerah }}
            </p>
          </div>

          <div class="lg:col-span-2">
            <label for="keperluan" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              Keperluan
            </label>
            <div class="group relative">
              <span
                class="absolute left-0 top-3.5 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
              >
                <DocsIcon class="h-4 w-4" />
              </span>
              <textarea
                id="keperluan"
                v-model="form.keperluan"
                rows="3"
                placeholder="Keperluan perjalanan dinas"
                :class="inputClass"
              ></textarea>
            </div>
            <p v-if="form.errors.keperluan" class="mt-1.5 text-sm text-red-600 dark:text-red-400">
              {{ form.errors.keperluan }}
            </p>
          </div>
        </div>
      </div>

      <div
        class="mt-6 rounded-2xl border border-gray-200 bg-white p-6 dark:border-gray-800 dark:bg-white/[0.03]"
      >
        <div class="mb-6 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
          <div>
            <h3 class="text-base font-semibold text-gray-800 dark:text-white/90">Perhitungan Biaya</h3>
            <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
              Atur parameter perjalanan dinas lalu hitung estimasi biaya.
            </p>
          </div>
          <button
            type="button"
            :disabled="calculating"
            class="inline-flex items-center justify-center gap-2 rounded-lg bg-brand-500 px-5 py-2.5 text-sm font-medium text-white shadow-theme-xs transition-colors hover:bg-brand-600 disabled:cursor-not-allowed disabled:bg-brand-300"
            @click="handleCalculate"
          >
            {{ calculating ? 'Menghitung...' : 'Hitung Biaya' }}
          </button>
        </div>

        <div class="grid grid-cols-1 gap-5 lg:grid-cols-2">
          <div>
            <label for="golongan" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              Golongan
            </label>
            <div class="group relative">
              <span
                class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
              >
                <BarChartIcon class="h-4 w-4" />
              </span>
              <select id="golongan" v-model="golongan" :class="inputClass">
                <option v-for="opt in golonganOptions" :key="opt.value" :value="opt.value">
                  {{ opt.label }}
                </option>
              </select>
            </div>
          </div>

          <div class="flex flex-col justify-end gap-3">
            <label class="flex cursor-pointer items-center gap-2.5 text-sm text-gray-700 dark:text-gray-300">
              <input v-model="transportUdara" type="checkbox" class="h-4 w-4 rounded border-gray-300 text-brand-500 focus:ring-brand-500/30 dark:border-gray-600 dark:bg-white/[0.05]" />
              Transportasi Udara (Pesawat)
            </label>
            <label class="flex cursor-pointer items-center gap-2.5 text-sm text-gray-700 dark:text-gray-300">
              <input v-model="transportDarat" type="checkbox" class="h-4 w-4 rounded border-gray-300 text-brand-500 focus:ring-brand-500/30 dark:border-gray-600 dark:bg-white/[0.05]" />
              Transportasi Darat (PP)
            </label>
            <label class="flex cursor-pointer items-center gap-2.5 text-sm text-gray-700 dark:text-gray-300">
              <input v-model="taksiBandara" type="checkbox" class="h-4 w-4 rounded border-gray-300 text-brand-500 focus:ring-brand-500/30 dark:border-gray-600 dark:bg-white/[0.05]" />
              Taksi Bandara (PP)
            </label>
          </div>

          <template v-if="transportUdara">
            <div>
              <label for="kota_asal_pesawat" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
                Kota Asal Pesawat
              </label>
              <div class="group relative">
                <span
                  class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
                >
                  <SendIcon class="h-4 w-4" />
                </span>
                <input
                  id="kota_asal_pesawat"
                  v-model="kotaAsal"
                  type="text"
                  placeholder="Contoh: Banda Aceh"
                  :class="inputClass"
                />
              </div>
            </div>
            <div>
              <label for="kota_tujuan_pesawat" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
                Kota Tujuan Pesawat
              </label>
              <div class="group relative">
                <span
                  class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
                >
                  <BoxCubeIcon class="h-4 w-4" />
                </span>
                <input
                  id="kota_tujuan_pesawat"
                  v-model="kotaTujuan"
                  type="text"
                  placeholder="Contoh: Jakarta"
                  :class="inputClass"
                />
              </div>
            </div>
          </template>
        </div>

        <p v-if="calcError" class="mt-4 rounded-lg bg-red-50 px-4 py-2.5 text-sm text-red-600 dark:bg-red-500/10 dark:text-red-400">
          {{ calcError }}
        </p>

        <div class="mt-6 overflow-hidden rounded-xl border border-gray-200 dark:border-gray-800">
          <template v-if="result">
            <div class="overflow-x-auto">
              <table class="w-full table-auto text-left">
                <thead>
                  <tr class="border-b border-gray-200 bg-gray-50 dark:border-gray-800 dark:bg-white/[0.03]">
                    <th class="px-4 py-3 text-left text-[11px] font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Uraian</th>
                    <th class="px-4 py-3 text-center text-[11px] font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Hari</th>
                    <th class="px-4 py-3 text-right text-[11px] font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Satuan</th>
                    <th class="px-4 py-3 text-right text-[11px] font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Jumlah</th>
                    <th class="px-4 py-3 text-left text-[11px] font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Keterangan</th>
                  </tr>
                </thead>
                <tbody>
                  <tr
                    v-for="(item, index) in result.rincian"
                    :key="index"
                    class="border-b border-gray-100 last:border-0 dark:border-gray-800"
                  >
                    <td class="px-4 py-3 text-sm text-gray-800 dark:text-white/90">{{ item.uraian }}</td>
                    <td class="px-4 py-3 text-center text-sm text-gray-700 dark:text-gray-300">{{ item.hari }}</td>
                    <td class="px-4 py-3 text-right text-sm text-gray-700 dark:text-gray-300">{{ formatRupiah(item.satuan) }}</td>
                    <td class="px-4 py-3 text-right text-sm font-medium text-gray-800 dark:text-white/90">{{ formatRupiah(item.jumlah) }}</td>
                    <td class="px-4 py-3 text-sm text-gray-500 dark:text-gray-400">{{ item.keterangan }}</td>
                  </tr>
                </tbody>
              </table>
            </div>
            <div class="flex flex-col gap-2 border-t border-gray-200 bg-gray-50 px-4 py-4 dark:border-gray-800 dark:bg-white/[0.03] sm:flex-row sm:items-center sm:justify-between">
              <div class="text-sm text-gray-600 dark:text-gray-300">
                Lama Perjalanan: <span class="font-semibold text-gray-800 dark:text-white/90">{{ result.lama_hari }} hari</span>
              </div>
              <div class="text-sm text-gray-600 dark:text-gray-300">
                Total Biaya: <span class="text-lg font-bold text-gray-900 dark:text-white">{{ formatRupiah(result.total_biaya) }}</span>
              </div>
            </div>
            <div class="border-t border-gray-200 bg-gray-50 px-4 py-4 dark:border-gray-800 dark:bg-white/[0.03]">
              <p class="text-sm text-gray-600 dark:text-gray-300">
                <span class="font-semibold text-gray-800 dark:text-white/90">Terbilang: </span>
                {{ result.terbilang }} Rupiah
              </p>
            </div>
          </template>
          <EmptyState v-else message="Klik 'Hitung Biaya' untuk menampilkan rincian biaya perjalanan dinas." />
        </div>
      </div>

      <div class="mt-6 flex flex-col-reverse justify-end gap-3 sm:flex-row">
        <Link
          href="/sppd"
          class="inline-flex items-center justify-center rounded-lg bg-white px-5 py-2.5 text-sm font-medium text-gray-700 ring-1 ring-inset ring-gray-300 transition-colors hover:bg-gray-50 dark:bg-gray-800 dark:text-gray-400 dark:ring-gray-700 dark:hover:bg-white/[0.03]"
        >
          Batal
        </Link>
        <button
          type="submit"
          :disabled="saving"
          class="inline-flex items-center justify-center rounded-lg bg-brand-500 px-5 py-2.5 text-sm font-medium text-white shadow-theme-xs transition-colors hover:bg-brand-600 disabled:cursor-not-allowed disabled:bg-brand-300"
        >
          {{ saving ? 'Menyimpan...' : 'Simpan Perubahan' }}
        </button>
      </div>
    </form>
  </AdminLayout>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { Link, router, useForm, usePage } from '@inertiajs/vue3'
import { isAxiosError } from 'axios'
import AdminLayout from '../../components/layout/AdminLayout.vue'
import PageBreadcrumb from '@/components/common/PageBreadcrumb.vue'
import EmptyState from '@/components/ui/EmptyState.vue'
import DatePicker from '@/components/ui/DatePicker.vue'
import PegawaiSelect from '@/components/ui/PegawaiSelect.vue'
import { calculateSppd, updateSppd } from '@/api/sppd'
import type { CalculatePayload, CalculateResult, CalculateRincian, Golongan } from '@/types/sppd'
import type { Provinsi } from '@/types/pegawai'
import { UserCircleIcon, GridIcon, BarChartIcon, UserGroupIcon, FlagIcon, DocsIcon, SendIcon, BoxCubeIcon } from '@/icons'

interface SppdForm {
  atas_nama: string
  nip: string
  pangkat_golongan: string
  jabatan: string
  tanggal_mulai: string
  tanggal_selesai: string
  tujuan_daerah: string
  provinsi_tujuan: number | ''
  keperluan: string
}

interface SppdProp {
  id: number
  nomor_sppd: string
  atas_nama: string
  nip: string | null
  pangkat_golongan: string | null
  jabatan: string | null
  tanggal_mulai: string
  tanggal_selesai: string
  tujuan_daerah: string
  provinsi_tujuan: number
  keperluan: string | null
  status: string
}

const props = defineProps<{
  sppd: SppdProp
  provinsi: Provinsi[]
  pegawais: {
    id: number
    nama_pegawai: string
    nip: string | null
    pangkat_golongan: string | null
    jabatan: string | null
    avatar_url: string | null
  }[]
}>()

interface PagePropsShape {
  flash?: {
    success?: string
  }
  [key: string]: unknown
}

const page = usePage<PagePropsShape>()

const inputClass =
  'w-full rounded-lg border border-gray-300 bg-white px-4 pl-10 py-2.5 text-sm text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500 dark:border-gray-600 dark:bg-white/[0.05] dark:text-gray-100 dark:placeholder-gray-500 dark:focus:border-blue-400'

const form = useForm<SppdForm>({
  atas_nama: props.sppd.atas_nama,
  nip: props.sppd.nip ?? '',
  pangkat_golongan: props.sppd.pangkat_golongan ?? '',
  jabatan: props.sppd.jabatan ?? '',
  tanggal_mulai: props.sppd.tanggal_mulai,
  tanggal_selesai: props.sppd.tanggal_selesai,
  tujuan_daerah: props.sppd.tujuan_daerah,
  provinsi_tujuan: props.sppd.provinsi_tujuan,
  keperluan: props.sppd.keperluan ?? '',
})

const selectedPegawaiId = ref<number | ''>(
  props.sppd.nip
    ? (props.pegawais.find((p) => p.nip === props.sppd.nip)?.id ?? '')
    : '',
)
const golongan = ref<Golongan>('eselon_4')
const transportUdara = ref(false)
const transportDarat = ref(false)
const taksiBandara = ref(false)
const kotaAsal = ref('')
const kotaTujuan = ref('')

const result = ref<CalculateResult | null>(null)
const rincian = ref<CalculateRincian[]>([])
const calculating = ref(false)
const saving = ref(false)
const calcError = ref('')

const golonganOptions: { value: Golongan; label: string }[] = [
  { value: 'eselon_1', label: 'Eselon I' },
  { value: 'eselon_2', label: 'Eselon II' },
  { value: 'eselon_3', label: 'Eselon III' },
  { value: 'eselon_4', label: 'Gol IV' },
]

const formatRupiah = (value: number): string =>
  new Intl.NumberFormat('id-ID', {
    style: 'currency',
    currency: 'IDR',
    maximumFractionDigits: 0,
  }).format(value || 0)

const onPegawaiChange = (): void => {
  const pegawai = props.pegawais.find((p) => p.id === selectedPegawaiId.value)
  if (!pegawai) {
    form.atas_nama = ''
    form.nip = ''
    form.pangkat_golongan = ''
    form.jabatan = ''
    return
  }
  form.atas_nama = pegawai.nama_pegawai
  form.nip = pegawai.nip ?? ''
  form.pangkat_golongan = pegawai.pangkat_golongan ?? ''
  form.jabatan = pegawai.jabatan ?? ''
}

const onProvinsiChange = (): void => {
  const prov = props.provinsi.find((p) => p.id_provinsi === form.provinsi_tujuan)
  if (prov) {
    form.tujuan_daerah = prov.ibukota
  }
}

const buildCalculatePayload = (): CalculatePayload => ({
  provinsi_tujuan: Number(form.provinsi_tujuan),
  tanggal_mulai: form.tanggal_mulai,
  tanggal_selesai: form.tanggal_selesai,
  golongan: golongan.value,
  transport_udara: transportUdara.value,
  transport_darat_pp: transportDarat.value,
  taksi_bandara: taksiBandara.value,
  kota_asal_pesawat: transportUdara.value ? kotaAsal.value || null : null,
  kota_tujuan_pesawat: transportUdara.value ? kotaTujuan.value || null : null,
})

const handleCalculate = async (): Promise<void> => {
  if (form.provinsi_tujuan === '') {
    calcError.value = 'Pilih provinsi tujuan terlebih dahulu.'
    return
  }
  if (!form.tanggal_mulai || !form.tanggal_selesai) {
    calcError.value = 'Lengkapi tanggal mulai dan tanggal selesai.'
    return
  }
  if (form.tanggal_selesai < form.tanggal_mulai) {
    calcError.value = 'Tanggal selesai tidak boleh sebelum tanggal mulai.'
    return
  }
  calcError.value = ''
  calculating.value = true
  try {
    const res = await calculateSppd(buildCalculatePayload())
    result.value = res
    rincian.value = res.rincian
  } catch {
    calcError.value = 'Gagal menghitung biaya. Silakan coba kembali.'
  } finally {
    calculating.value = false
  }
}

const handleSimpan = async (): Promise<void> => {
  saving.value = true
  try {
    await updateSppd(props.sppd.id, {
      atas_nama: form.atas_nama,
      nip: form.nip || null,
      pangkat_golongan: form.pangkat_golongan || null,
      jabatan: form.jabatan || null,
      tanggal_mulai: form.tanggal_mulai,
      tanggal_selesai: form.tanggal_selesai,
      tujuan_daerah: form.tujuan_daerah,
      provinsi_tujuan: Number(form.provinsi_tujuan),
      keperluan: form.keperluan || null,
      status: props.sppd.status === 'batal' ? 'draft' : undefined,
    })
    form.clearErrors()
    router.visit('/sppd')
  } catch (error) {
    if (isAxiosError(error) && error.response?.status === 422) {
      const errors = error.response.data?.errors ?? {}
      form.clearErrors().setError(errors)
    } else {
      calcError.value = 'Gagal menyimpan perubahan. Silakan coba kembali.'
    }
  } finally {
    saving.value = false
  }
}
</script>