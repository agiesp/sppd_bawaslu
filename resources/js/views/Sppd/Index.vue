<template>
  <AdminLayout>
    <PageBreadcrumb pageTitle="Daftar SPPD" />

    <div
      v-if="$page.props.flash?.success"
      class="mb-4 rounded-lg border border-green-200 bg-green-50 p-4 text-sm text-green-700 dark:border-green-800 dark:bg-green-900/30 dark:text-green-300"
    >
      {{ $page.props.flash.success }}
    </div>

    <div
      class="rounded-xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-white/[0.03]"
    >
      <div class="mb-6 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <div class="flex flex-1 flex-col gap-3 sm:flex-row sm:items-center">
          <div class="group relative flex-1">
            <input
              v-model="search"
              type="text"
              placeholder="Cari nomor SPPD, atas nama, keperluan..."
              class="w-full rounded-lg border border-gray-300 bg-white px-4 py-2.5 pl-10 text-sm text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-gray-600 dark:bg-white/[0.05] dark:text-gray-100 dark:placeholder-gray-500 dark:focus:border-blue-400"
            />
            <svg
              class="pointer-events-none absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
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
          <div class="group relative">
            <span
              class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
            >
              <TaskIcon class="h-4 w-4" />
            </span>
            <select
              v-model="statusFilter"
              class="rounded-lg border border-gray-300 bg-white px-4 py-2.5 pl-10 text-sm text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-gray-600 dark:bg-white/[0.05] dark:text-gray-100 dark:focus:border-blue-400"
            >
              <option value="">Semua Status</option>
              <option value="draft">Draft</option>
              <option value="proses">Proses</option>
              <option value="selesai">Selesai</option>
              <option value="batal">Batal</option>
            </select>
          </div>
        </div>
        <Link
          v-if="canCreate(menuUrl)"
          href="/sppd/buat"
          class="inline-flex items-center gap-2 rounded-lg bg-brand-500 px-4 py-2.5 text-sm font-medium text-white shadow-sm transition-colors hover:bg-brand-600 focus:outline-none focus:ring-2 focus:ring-brand-500 focus:ring-offset-2 dark:focus:ring-offset-gray-900"
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            class="h-4 w-4"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
            stroke-width="2"
          >
            <path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4" />
          </svg>
          Buat SPPD
        </Link>
      </div>

      <div class="overflow-x-auto">
        <table class="w-full table-auto text-left">
          <thead>
            <tr
              class="border-b border-gray-200 bg-gradient-to-r from-gray-50 to-gray-100/80 dark:border-gray-700 dark:from-white/[0.05] dark:to-white/[0.02]"
            >
              <th
                class="px-4 py-3 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400"
              >
                Nomor SPPD
              </th>
              <th
                class="px-4 py-3 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400"
              >
                Atas Nama
              </th>
              <th
                class="px-4 py-3 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400"
              >
                Keperluan
              </th>
              <th
                class="px-4 py-3 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400"
              >
                Tanggal
              </th>
              <th
                class="px-4 py-3 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400"
              >
                Lama Hari
              </th>
              <th
                class="px-4 py-3 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400"
              >
                Status
              </th>
              <th
                class="px-4 py-3 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400"
              >
                Total Biaya
              </th>
              <th
                class="px-4 py-3 text-center text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400"
              >
                Aksi
              </th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="item in paginatedData"
              :key="item.id"
              class="border-b border-gray-100 transition-colors hover:bg-gray-50/50 dark:border-gray-800 dark:hover:bg-white/[0.02]"
            >
              <td class="whitespace-nowrap px-4 py-3 text-sm font-medium text-gray-900 dark:text-gray-100">
                {{ item.nomor_sppd }}
              </td>
              <td class="whitespace-nowrap px-4 py-3">
                <div class="flex items-center gap-3">
                  <img
                    v-if="item.pegawai?.avatar_url"
                    :src="item.pegawai.avatar_url"
                    :alt="item.atas_nama"
                    class="h-8 w-8 shrink-0 rounded-full object-cover"
                  />
                  <span
                    v-else
                    class="inline-flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-blue-100 text-xs font-semibold text-blue-600 dark:bg-blue-900/30 dark:text-blue-300"
                  >
                    {{ item.atas_nama.charAt(0).toUpperCase() }}
                  </span>
                  <div>
                    <p class="text-sm font-medium text-gray-900 dark:text-gray-100">{{ item.atas_nama }}</p>
                    <p v-if="item.nip" class="text-xs text-gray-500 dark:text-gray-400">NIP. {{ item.nip }}</p>
                  </div>
                </div>
              </td>
              <td class="px-4 py-3 text-sm text-gray-700 dark:text-gray-300">
                {{ item.keperluan || '-' }}
              </td>
              <td class="whitespace-nowrap px-4 py-3 text-sm text-gray-700 dark:text-gray-300">
                {{ formatTanggal(item.tanggal_mulai) }} - {{ formatTanggal(item.tanggal_selesai) }}
              </td>
              <td class="whitespace-nowrap px-4 py-3 text-sm text-gray-700 dark:text-gray-300">
                {{ item.lama_hari }} hari
              </td>
              <td class="whitespace-nowrap px-4 py-3">
                <StatusBadge :status="item.status" />
              </td>
              <td class="whitespace-nowrap px-4 py-3 text-right text-sm font-medium text-gray-900 dark:text-gray-100">
                {{ formatRupiah(item.total_biaya) }}
              </td>
              <td class="whitespace-nowrap px-4 py-3 text-center">
                <div class="flex items-center justify-center gap-2">
                  <Link
                    v-if="canView(menuUrl)"
                    :href="`/sppd/${item.id}`"
                    class="inline-flex h-8 w-8 items-center justify-center rounded-lg text-gray-400 transition-colors hover:bg-blue-50 hover:text-blue-600 dark:hover:bg-blue-900/30 dark:hover:text-blue-400"
                    title="Lihat Detail"
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
                        d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"
                      />
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"
                      />
                    </svg>
                  </Link>
                  <Link
                    v-if="['draft', 'batal'].includes(item.status) && canEdit(menuUrl)"
                    :href="`/sppd/${item.id}/edit`"
                    class="inline-flex h-8 w-8 items-center justify-center rounded-lg text-gray-400 transition-colors hover:bg-amber-50 hover:text-amber-600 dark:hover:bg-amber-900/30 dark:hover:text-amber-400"
                    title="Edit"
                  >
                    <EditIcon class="h-4 w-4" />
                  </Link>
                  <button
                    v-if="item.status === 'draft' && canDelete(menuUrl)"
                    type="button"
                    class="inline-flex h-8 w-8 items-center justify-center rounded-lg text-gray-400 transition-colors hover:bg-red-50 hover:text-red-600 dark:hover:bg-red-900/30 dark:hover:text-red-400"
                    title="Hapus"
                    @click="openDeleteModal(item)"
                  >
                    <TrashIcon class="h-4 w-4" />
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <EmptyState
        v-if="filteredData.length === 0"
        message="Tidak ada data SPPD ditemukan."
      />

      <TablePagination
        v-if="filteredData.length > 0"
        v-model:currentPage="currentPage"
        :total-items="filteredData.length"
        :per-page="perPage"
      />
    </div>

    <!-- Modal Konfirmasi Hapus -->
    <div
      v-if="deleteTarget"
      class="fixed inset-0 flex items-center justify-center overflow-y-auto z-99999 px-4"
    >
      <div
        class="fixed inset-0 h-full w-full bg-gray-400/50 backdrop-blur-[32px]"
        @click="closeDeleteModal"
      ></div>
      <div
        class="relative w-full max-w-md rounded-2xl border border-gray-200 bg-white p-6 shadow-2xl dark:border-gray-800 dark:bg-gray-900"
      >
        <div class="flex items-start gap-4">
          <div
            class="flex h-11 w-11 flex-shrink-0 items-center justify-center rounded-full bg-red-100 text-red-600 dark:bg-red-500/10 dark:text-red-400"
          >
            <TrashIcon class="h-5 w-5" />
          </div>
          <div>
            <h3 class="text-lg font-semibold text-gray-800 dark:text-white/90">
              Hapus SPPD
            </h3>
            <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
              Apakah Anda yakin ingin menghapus SPPD
              <span class="font-semibold text-gray-700 dark:text-gray-200">
                "{{ deleteTarget?.nomor_sppd }}"
              </span>? Tindakan ini tidak dapat dibatalkan.
            </p>
          </div>
        </div>

        <div class="mt-6 flex items-center justify-end gap-3">
          <button
            type="button"
            :disabled="deleting"
            class="inline-flex items-center justify-center rounded-lg bg-white px-5 py-2.5 text-sm font-medium text-gray-700 ring-1 ring-inset ring-gray-300 transition-colors hover:bg-gray-50 dark:bg-gray-800 dark:text-gray-400 dark:ring-gray-700 dark:hover:bg-white/[0.03]"
            @click="closeDeleteModal"
          >
            Batal
          </button>
          <button
            type="button"
            :disabled="deleting"
            class="inline-flex items-center justify-center gap-2 rounded-lg bg-red-600 px-5 py-2.5 text-sm font-medium text-white shadow-theme-xs transition-colors hover:bg-red-700 disabled:cursor-not-allowed disabled:bg-red-300"
            @click="confirmDelete"
          >
            {{ deleting ? 'Menghapus...' : 'Hapus' }}
          </button>
        </div>
      </div>
    </div>
  </AdminLayout>
  <Toast />
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { Link, usePage, router } from '@inertiajs/vue3'
import AdminLayout from '../../components/layout/AdminLayout.vue'
import PageBreadcrumb from '@/components/common/PageBreadcrumb.vue'
import TablePagination from '@/components/tables/TablePagination.vue'
import StatusBadge from '@/components/ui/StatusBadge.vue'
import EmptyState from '@/components/ui/EmptyState.vue'
import Toast from '@/components/ui/Toast.vue'
import EditIcon from '@/icons/EditIcon.vue'
import TrashIcon from '@/icons/TrashIcon.vue'
import { usePermission } from '@/composables/usePermission'
import { useToast } from '@/composables/useToast'
import { deleteSppd } from '@/api/sppd'
import TaskIcon from '@/icons/TaskIcon.vue'

interface SppdItem {
  id: number | string
  nomor_sppd: string
  atas_nama: string
  nip: string | null
  keperluan: string | null
  tujuan_daerah: string
  provinsi: string
  pegawai?: { avatar_url: string | null } | null
  tanggal_mulai: string
  tanggal_selesai: string
  lama_hari: number
  status: string
  total_biaya: number
}

const props = defineProps<{
  sppdList: SppdItem[]
}>()

const { canView, canCreate, canEdit, canDelete } = usePermission()
const { success, error } = useToast()
const menuUrl = '/sppd'

const search = ref('')
const statusFilter = ref('')
const currentPage = ref(1)
const perPage = 10

const deleteTarget = ref<SppdItem | null>(null)
const deleting = ref(false)

const openDeleteModal = (item: SppdItem): void => {
  deleteTarget.value = item
}

const closeDeleteModal = (): void => {
  deleteTarget.value = null
}

const confirmDelete = async (): Promise<void> => {
  if (!deleteTarget.value || deleting.value) return
  deleting.value = true
  try {
    await deleteSppd(Number(deleteTarget.value.id))
    success('SPPD berhasil dihapus.')
    closeDeleteModal()
    router.reload()
  } catch {
    error('Gagal menghapus SPPD. Silakan coba kembali.')
  } finally {
    deleting.value = false
  }
}

const formatRupiah = (value: number): string => {
  return new Intl.NumberFormat('id-ID', {
    style: 'currency',
    currency: 'IDR',
    maximumFractionDigits: 0,
  }).format(value)
}

const formatTanggal = (dateStr: string): string => {
  if (!dateStr) return '-'
  const d = new Date(dateStr)
  const day = d.getDate()
  const months = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des']
  return `${day} ${months[d.getMonth()]} ${d.getFullYear()}`
}

const filteredData = computed(() => {
  let data = props.sppdList

  if (statusFilter.value) {
    data = data.filter((item) => item.status === statusFilter.value)
  }

  if (search.value) {
    const q = search.value.toLowerCase()
    data = data.filter(
      (item) =>
        item.nomor_sppd.toLowerCase().includes(q) ||
        item.atas_nama.toLowerCase().includes(q) ||
        (item.keperluan ?? '').toLowerCase().includes(q),
    )
  }

  return data
})

const paginatedData = computed(() => {
  const start = (currentPage.value - 1) * perPage
  const end = start + perPage
  return filteredData.value.slice(start, end)
})
</script>
