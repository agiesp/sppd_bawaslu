<template>
  <AdminLayout>
    <PageBreadcrumb pageTitle="Master Pegawai" />

    <div
      class="rounded-xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-white/[0.03]"
    >
      <div class="mb-5 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <div class="flex gap-1 rounded-lg bg-gray-100 p-1 dark:bg-gray-800">
            <button
              v-for="tab in tabs"
              :key="tab.key"
              type="button"
              class="inline-flex items-center gap-1.5 rounded-md px-4 py-2 text-sm font-medium transition-all duration-200"
              :class="
                activeTab === tab.key
                  ? 'bg-white text-blue-600 shadow-sm dark:bg-gray-700 dark:text-blue-400'
                  : 'text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200'
              "
              @click="activeTab = tab.key"
            >
              {{ tab.label }}
              <span
                class="rounded-full px-1.5 py-0.5 text-[10px] font-semibold"
                :class="
                  activeTab === tab.key
                    ? 'bg-blue-100 text-blue-600 dark:bg-blue-900/40 dark:text-blue-300'
                    : 'bg-gray-200 text-gray-500 dark:bg-gray-700 dark:text-gray-400'
                "
              >
                {{ tab.count }}
              </span>
            </button>
          </div>
        </div>
        <button
          v-if="canCreate(menuUrl)"
          type="button"
          class="inline-flex items-center gap-2 rounded-lg bg-blue-600 px-4 py-2.5 text-sm font-medium text-white shadow-sm transition-colors hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 dark:focus:ring-offset-gray-900"
          @click="openCreateModal"
        >
          <PlusIcon class="h-4 w-4" />
          Tambah Pegawai
        </button>
      </div>

      <div class="mb-5 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <div class="group relative flex-1">
          <input
            v-model="search"
            type="text"
            placeholder="Cari nama, NIP, jabatan..."
            class="w-full rounded-lg border border-gray-300 bg-white px-4 py-2.5 pl-10 text-sm text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500 dark:border-gray-600 dark:bg-white/[0.05] dark:text-gray-100 dark:placeholder-gray-500 dark:focus:border-blue-400"
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
                No
              </th>
              <th
                class="px-4 py-3 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400"
              >
                Nama
              </th>
              <th
                class="px-4 py-3 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400"
              >
                NIP
              </th>
              <th
                class="px-4 py-3 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400"
              >
                Pangkat/Golongan
              </th>
              <th
                class="px-4 py-3 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400"
              >
                Jabatan
              </th>
              <th
                class="px-4 py-3 text-center text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400"
              >
                Tipe
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
              v-for="(item, index) in paginatedData"
              :key="item.id"
              class="border-b border-gray-100 transition-colors hover:bg-gray-50/50 dark:border-gray-800 dark:hover:bg-white/[0.02]"
            >
              <td class="whitespace-nowrap px-4 py-3 text-sm text-gray-500 dark:text-gray-400">
                {{ (currentPage - 1) * perPage + index + 1 }}
              </td>
              <td class="whitespace-nowrap px-4 py-3 text-sm font-medium text-gray-900 dark:text-gray-100">
                <div class="flex items-center gap-3">
                  <img
                    v-if="item.avatar_url"
                    :src="item.avatar_url"
                    alt="Foto"
                    class="h-8 w-8 shrink-0 rounded-full object-cover"
                  />
                  <span
                    v-else
                    class="inline-flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-blue-100 text-xs font-semibold text-blue-600 dark:bg-blue-900/30 dark:text-blue-300"
                  >
                    {{ item.nama_pegawai.charAt(0).toUpperCase() }}
                  </span>
                  {{ item.nama_pegawai }}
                </div>
              </td>
              <td class="whitespace-nowrap px-4 py-3 text-sm text-gray-700 dark:text-gray-300">
                {{ item.nip || '-' }}
              </td>
              <td class="whitespace-nowrap px-4 py-3 text-sm text-gray-700 dark:text-gray-300">
                {{ item.pangkat_golongan || '-' }}
              </td>
              <td class="whitespace-nowrap px-4 py-3 text-sm text-gray-700 dark:text-gray-300">
                {{ item.jabatan || '-' }}
              </td>
              <td class="whitespace-nowrap px-4 py-3 text-center">
                <span
                  class="inline-flex items-center gap-1 rounded-full px-2.5 py-1 text-xs font-medium"
                  :class="
                    item.tipe === 'komisioner'
                      ? 'bg-purple-50 text-purple-600 dark:bg-purple-900/30 dark:text-purple-300'
                      : 'bg-blue-50 text-blue-600 dark:bg-blue-900/30 dark:text-blue-300'
                  "
                >
                  <UserCircleIcon class="h-3 w-3" />
                  {{ item.tipe === 'komisioner' ? 'Komisioner' : 'Pegawai' }}
                </span>
              </td>
              <td class="whitespace-nowrap px-4 py-3 text-center">
                <div class="flex items-center justify-center gap-2">
                  <button
                    v-if="canEdit(menuUrl)"
                    type="button"
                    class="inline-flex h-8 w-8 items-center justify-center rounded-lg text-gray-400 transition-colors hover:bg-amber-50 hover:text-amber-600 dark:hover:bg-amber-900/30 dark:hover:text-amber-400"
                    title="Edit"
                    @click="openEditModal(item)"
                  >
                    <EditIcon class="h-4 w-4" />
                  </button>
                  <button
                    v-if="canDelete(menuUrl)"
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

      <EmptyState v-if="filteredData.length === 0" message="Tidak ada data pegawai ditemukan." />

      <TablePagination
        v-if="filteredData.length > 0"
        v-model:currentPage="currentPage"
        :total-items="filteredData.length"
        :per-page="perPage"
      />
    </div>

    <Teleport to="body">
      <Transition name="modal">
        <div
          v-if="showModal"
          class="fixed inset-0 z-99999 flex items-center justify-center p-4"
        >
          <div
            class="modal-backdrop fixed inset-0 h-full w-full bg-gray-400/50 backdrop-blur-[32px]"
            @click="closeModal"
          ></div>
          <div
            class="modal-panel relative z-10 w-full max-w-lg overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-2xl shadow-gray-900/10 dark:border-gray-700 dark:bg-gray-900 dark:shadow-black/40"
          >
            <div
              class="flex items-center justify-between border-b border-gray-200 px-6 py-4 dark:border-gray-700"
            >
              <h3 class="text-base font-semibold text-gray-900 dark:text-gray-100">
                {{ isEdit ? 'Edit Pegawai' : 'Tambah Pegawai' }}
              </h3>
              <button
                type="button"
                class="inline-flex h-8 w-8 items-center justify-center rounded-lg text-gray-400 transition-colors hover:bg-gray-100 hover:text-gray-600 dark:hover:bg-gray-800 dark:hover:text-gray-300"
                @click="closeModal"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  class="h-4 w-4"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                  stroke-width="2"
                >
                  <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                </svg>
              </button>
            </div>
            <form class="space-y-4 px-6 py-5" @submit.prevent="savePegawai">
              <div class="flex flex-col items-center gap-4 sm:flex-row">
                <div class="relative shrink-0">
                  <img
                    v-if="form.avatarPreview"
                    :src="form.avatarPreview"
                    alt="Preview Foto"
                    class="h-20 w-20 rounded-full object-cover ring-2 ring-gray-200 dark:ring-gray-700"
                  />
                  <span
                    v-else
                    class="inline-flex h-20 w-20 items-center justify-center rounded-full bg-blue-100 text-2xl font-semibold text-blue-600 ring-2 ring-gray-200 dark:bg-blue-900/30 dark:text-blue-300 dark:ring-gray-700"
                  >
                    {{ form.nama_pegawai.charAt(0).toUpperCase() || '?' }}
                  </span>
                  <button
                    type="button"
                    class="absolute bottom-0 right-0 flex h-7 w-7 items-center justify-center rounded-full bg-blue-600 text-white shadow-md transition-colors hover:bg-blue-700"
                    @click="avatarInput?.click()"
                  >
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-3.5 w-3.5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M23 19a2 2 0 01-2 2H3a2 2 0 01-2-2V8a2 2 0 012-2h4l2-3h6l2 3h4a2 2 0 012 2z" />
                      <circle cx="12" cy="13" r="4" />
                    </svg>
                  </button>
                  <input
                    ref="avatarInput"
                    type="file"
                    accept="image/jpeg,image/png,image/jpg,image/gif,image/webp"
                    class="sr-only"
                    @change="onAvatarChange"
                  />
                </div>
                <div class="flex-1">
                  <label
                    for="avatar"
                    class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300"
                  >
                    Foto
                  </label>
                  <p class="text-xs text-gray-400 dark:text-gray-500">
                    Klik ikon kamera pada foto untuk mengganti.
                  </p>
                  <p class="mt-1 text-xs text-gray-400 dark:text-gray-500">
                    JPG, PNG, GIF atau WebP. Maksimal 2MB.
                  </p>
                  <button
                    v-if="form.avatarPreview"
                    type="button"
                    class="mt-2 text-xs font-medium text-red-500 hover:text-red-600 dark:text-red-400"
                    @click="removeAvatar"
                  >
                    Hapus Foto
                  </button>
                </div>
              </div>
              <div>
                <label
                  for="nama_pegawai"
                  class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300"
                >
                  Nama Pegawai <span class="text-red-500">*</span>
                </label>
                <div class="group relative">
                  <span
                    class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
                  >
                    <UserCircleIcon class="h-4 w-4" />
                  </span>
                  <input
                    id="nama_pegawai"
                    v-model="form.nama_pegawai"
                    type="text"
                    class="w-full rounded-lg border border-gray-300 bg-white px-4 py-2.5 pl-10 text-sm text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500 dark:border-gray-600 dark:bg-white/[0.05] dark:text-gray-100 dark:focus:border-blue-400"
                    placeholder="Nama lengkap pegawai"
                    required
                  />
                </div>
              </div>
              <div>
                <label
                  for="nip"
                  class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300"
                >
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
                    class="w-full rounded-lg border border-gray-300 bg-white px-4 py-2.5 pl-10 text-sm text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500 dark:border-gray-600 dark:bg-white/[0.05] dark:text-gray-100 dark:focus:border-blue-400"
                    placeholder="Nomor induk pegawai"
                  />
                </div>
              </div>
              <div>
                <label
                  for="pangkat_golongan"
                  class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300"
                >
                  Pangkat/Golongan
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
                    class="w-full rounded-lg border border-gray-300 bg-white px-4 py-2.5 pl-10 text-sm text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500 dark:border-gray-600 dark:bg-white/[0.05] dark:text-gray-100 dark:focus:border-blue-400"
                    placeholder="Misal: Pembina, IV/a"
                  />
                </div>
              </div>
              <div>
                <label
                  for="jabatan"
                  class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300"
                >
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
                    class="w-full rounded-lg border border-gray-300 bg-white px-4 py-2.5 pl-10 text-sm text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500 dark:border-gray-600 dark:bg-white/[0.05] dark:text-gray-100 dark:focus:border-blue-400"
                    placeholder="Jabatan saat ini"
                  />
                </div>
              </div>
              <div>
                <span class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">Tipe</span>
                <div class="grid grid-cols-2 gap-3">
                  <label
                    class="flex cursor-pointer items-center gap-3 rounded-lg border p-3 transition-colors"
                    :class="
                      form.tipe === 'pegawai'
                        ? 'border-blue-500 bg-blue-50 dark:bg-blue-900/20'
                        : 'border-gray-300 dark:border-gray-600'
                    "
                  >
                    <input
                      v-model="form.tipe"
                      type="radio"
                      value="pegawai"
                      class="h-4 w-4 text-blue-600 focus:ring-blue-500"
                    />
                    <span class="text-sm text-gray-900 dark:text-gray-100">Pegawai</span>
                  </label>
                  <label
                    class="flex cursor-pointer items-center gap-3 rounded-lg border p-3 transition-colors"
                    :class="
                      form.tipe === 'komisioner'
                        ? 'border-purple-500 bg-purple-50 dark:bg-purple-900/20'
                        : 'border-gray-300 dark:border-gray-600'
                    "
                  >
                    <input
                      v-model="form.tipe"
                      type="radio"
                      value="komisioner"
                      class="h-4 w-4 text-purple-600 focus:ring-purple-500"
                    />
                    <span class="text-sm text-gray-900 dark:text-gray-100">Komisioner</span>
                  </label>
                </div>
              </div>
              <div class="flex items-center justify-end gap-3 pt-2">
                <button
                  type="button"
                  class="rounded-lg border border-gray-300 px-4 py-2.5 text-sm font-medium text-gray-700 transition-colors hover:bg-gray-50 dark:border-gray-600 dark:text-gray-300 dark:hover:bg-gray-800"
                  @click="closeModal"
                >
                  Batal
                </button>
                <button
                  type="submit"
                  :disabled="loading"
                  class="inline-flex items-center gap-2 rounded-lg bg-blue-600 px-4 py-2.5 text-sm font-medium text-white shadow-sm transition-colors hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 disabled:opacity-60 dark:focus:ring-offset-gray-900"
                >
                  <svg
                    v-if="loading"
                    class="h-4 w-4 animate-spin"
                    xmlns="http://www.w3.org/2000/svg"
                    fill="none"
                    viewBox="0 0 24 24"
                  >
                    <circle
                      class="opacity-25"
                      cx="12"
                      cy="12"
                      r="10"
                      stroke="currentColor"
                      stroke-width="4"
                    ></circle>
                    <path
                      class="opacity-75"
                      fill="currentColor"
                      d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"
                    ></path>
                  </svg>
                  {{ isEdit ? 'Simpan Perubahan' : 'Simpan' }}
                </button>
              </div>
            </form>
          </div>
        </div>
      </Transition>
    </Teleport>

    <Teleport to="body">
      <Transition name="modal">
        <div
          v-if="showDeleteModal"
          class="fixed inset-0 z-99999 flex items-center justify-center p-4"
        >
          <div
            class="modal-backdrop fixed inset-0 h-full w-full bg-gray-400/50 backdrop-blur-[32px]"
            @click="closeDeleteModal"
          ></div>
          <div
            class="modal-panel relative z-10 w-full max-w-md overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-2xl shadow-gray-900/10 dark:border-gray-700 dark:bg-gray-900 dark:shadow-black/40"
          >
            <div class="px-6 py-5">
              <div class="flex items-start gap-4">
                <div
                  class="inline-flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-red-50 dark:bg-red-900/30"
                >
                  <TrashIcon class="h-5 w-5 text-red-600 dark:text-red-400" />
                </div>
                <div>
                  <h3 class="text-base font-semibold text-gray-900 dark:text-gray-100">
                    Hapus Pegawai
                  </h3>
                  <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
                    Anda yakin ingin menghapus pegawai
                    <span class="font-medium text-gray-900 dark:text-gray-100">
                      {{ selectedItem?.nama_pegawai }}
                    </span>? Tindakan ini tidak dapat dibatalkan.
                  </p>
                </div>
              </div>
            </div>
            <div
              class="flex items-center justify-end gap-3 border-t border-gray-200 px-6 py-4 dark:border-gray-700"
            >
              <button
                type="button"
                class="rounded-lg border border-gray-300 px-4 py-2.5 text-sm font-medium text-gray-700 transition-colors hover:bg-gray-50 dark:border-gray-600 dark:text-gray-300 dark:hover:bg-gray-800"
                @click="closeDeleteModal"
              >
                Batal
              </button>
              <button
                type="button"
                :disabled="loading"
                class="inline-flex items-center gap-2 rounded-lg bg-red-600 px-4 py-2.5 text-sm font-medium text-white shadow-sm transition-colors hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-offset-2 disabled:opacity-60 dark:focus:ring-offset-gray-900"
                @click="confirmDelete"
              >
                <svg
                  v-if="loading"
                  class="h-4 w-4 animate-spin"
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 24 24"
                >
                  <circle
                    class="opacity-25"
                    cx="12"
                    cy="12"
                    r="10"
                    stroke="currentColor"
                    stroke-width="4"
                  ></circle>
                  <path
                    class="opacity-75"
                    fill="currentColor"
                    d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"
                  ></path>
                </svg>
                Hapus
              </button>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>
  </AdminLayout>
  <Toast />
</template>

<script setup lang="ts">
import { ref, reactive, computed, watch } from 'vue'
import AdminLayout from '../../components/layout/AdminLayout.vue'
import PageBreadcrumb from '@/components/common/PageBreadcrumb.vue'
import TablePagination from '@/components/tables/TablePagination.vue'
import EmptyState from '@/components/ui/EmptyState.vue'
import Toast from '@/components/ui/Toast.vue'
import EditIcon from '@/icons/EditIcon.vue'
import TrashIcon from '@/icons/TrashIcon.vue'
import PlusIcon from '@/icons/PlusIcon.vue'
import { UserCircleIcon, GridIcon, BarChartIcon, UserGroupIcon } from '@/icons'
import { createPegawai, updatePegawai, deletePegawai } from '@/api/pegawai'
import { usePermission } from '@/composables/usePermission'
import { useToast } from '@/composables/useToast'
import type { PegawaiTipe } from '@/types/pegawai'

interface Pegawai {
  id: number | string
  nama_pegawai: string
  nip: string | null
  pangkat_golongan: string | null
  jabatan: string | null
  tipe: PegawaiTipe
  avatar: string | null
  avatar_url: string | null
}

const props = defineProps<{
  pegawais: Pegawai[]
}>()

const { canCreate, canEdit, canDelete } = usePermission()
const { success, error } = useToast()

const menuUrl = '/admin/master/pegawai'

const tabs = [
  { key: 'semua', label: 'Semua', get: () => props.pegawais },
  { key: 'pegawai', label: 'Pegawai', get: () => props.pegawais.filter((p) => p.tipe === 'pegawai') },
  { key: 'komisioner', label: 'Komisioner', get: () => props.pegawais.filter((p) => p.tipe === 'komisioner') },
] as const

type TabKey = (typeof tabs)[number]['key']

const activeTab = ref<TabKey>('semua')
const search = ref('')
const currentPage = ref(1)
const perPage = 10
const avatarInput = ref<HTMLInputElement | null>(null)
const loading = ref(false)
const showModal = ref(false)
const showDeleteModal = ref(false)
const isEdit = ref(false)
const selectedItem = ref<Pegawai | null>(null)
const editingId = ref<number | string | null>(null)

const form = reactive<{
  nama_pegawai: string
  nip: string
  pangkat_golongan: string
  jabatan: string
  tipe: PegawaiTipe
  avatar: File | null
  avatarPreview: string | null
}>({
  nama_pegawai: '',
  nip: '',
  pangkat_golongan: '',
  jabatan: '',
  tipe: 'pegawai',
  avatar: null,
  avatarPreview: null,
})

const resetForm = (): void => {
  form.nama_pegawai = ''
  form.nip = ''
  form.pangkat_golongan = ''
  form.jabatan = ''
  form.tipe = 'pegawai'
  form.avatar = null
  form.avatarPreview = null
  if (avatarInput.value) avatarInput.value.value = ''
}

const filteredData = computed(() => {
  let data = props.pegawais

  if (activeTab.value !== 'semua') {
    data = data.filter((item) => item.tipe === activeTab.value)
  }

  if (search.value) {
    const q = search.value.toLowerCase()
    data = data.filter(
      (item) =>
        item.nama_pegawai.toLowerCase().includes(q) ||
        (item.nip || '').toLowerCase().includes(q) ||
        (item.jabatan || '').toLowerCase().includes(q),
    )
  }

  return data
})

const paginatedData = computed(() => {
  const start = (currentPage.value - 1) * perPage
  const end = start + perPage
  return filteredData.value.slice(start, end)
})

watch([activeTab, search], () => {
  currentPage.value = 1
})

const openCreateModal = (): void => {
  resetForm()
  isEdit.value = false
  editingId.value = null
  showModal.value = true
}

const openEditModal = (item: Pegawai): void => {
  isEdit.value = true
  editingId.value = item.id
  form.nama_pegawai = item.nama_pegawai
  form.nip = item.nip || ''
  form.pangkat_golongan = item.pangkat_golongan || ''
  form.jabatan = item.jabatan || ''
  form.tipe = item.tipe
  form.avatar = null
  form.avatarPreview = item.avatar_url
  showModal.value = true
}

const closeModal = (): void => {
  if (loading.value) return
  showModal.value = false
  resetForm()
}

const onAvatarChange = (event: Event): void => {
  const input = event.target as HTMLInputElement
  const file = input.files?.[0]
  if (!file) {
    form.avatar = null
    return
  }
  if (!file.type.startsWith('image/')) {
    error('File harus berupa gambar.')
    input.value = ''
    return
  }
  if (file.size > 2 * 1024 * 1024) {
    error('Ukuran file maksimal 2MB.')
    input.value = ''
    return
  }
  form.avatar = file
  form.avatarPreview = URL.createObjectURL(file)
}

const removeAvatar = (): void => {
  form.avatar = null
  form.avatarPreview = null
}

const savePegawai = async (): Promise<void> => {
  if (!form.nama_pegawai.trim()) return
  if (loading.value) return

  loading.value = true
  try {
    if (isEdit.value && editingId.value !== null) {
      await updatePegawai(editingId.value, {
        nama_pegawai: form.nama_pegawai,
        nip: form.nip || null,
        pangkat_golongan: form.pangkat_golongan || null,
        jabatan: form.jabatan || null,
        tipe: form.tipe,
        avatar: form.avatar,
      })
      success('Data pegawai berhasil diperbarui.')
    } else {
      await createPegawai({
        nama_pegawai: form.nama_pegawai,
        nip: form.nip || null,
        pangkat_golongan: form.pangkat_golongan || null,
        jabatan: form.jabatan || null,
        tipe: form.tipe,
        avatar: form.avatar,
      })
      success('Data pegawai berhasil ditambahkan.')
    }
    showModal.value = false
    resetForm()
  } catch (e: unknown) {
    error('Gagal menyimpan data pegawai.')
  } finally {
    loading.value = false
  }
}

const openDeleteModal = (item: Pegawai): void => {
  selectedItem.value = item
  showDeleteModal.value = true
}

const closeDeleteModal = (): void => {
  if (loading.value) return
  showDeleteModal.value = false
  selectedItem.value = null
}

const confirmDelete = async (): Promise<void> => {
  if (!selectedItem.value || loading.value) return

  loading.value = true
  try {
    await deletePegawai(selectedItem.value.id)
    success('Data pegawai berhasil dihapus.')
    showDeleteModal.value = false
    selectedItem.value = null
  } catch (e: unknown) {
    error('Gagal menghapus data pegawai.')
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.modal-backdrop {
  opacity: 1;
  transition: opacity 0.2s ease;
}
.modal-panel {
  transform: translateY(0) scale(1);
  opacity: 1;
  transition:
    opacity 0.25s ease,
    transform 0.25s cubic-bezier(0.16, 1, 0.3, 1);
}

.modal-enter-from .modal-backdrop,
.modal-leave-to .modal-backdrop {
  opacity: 0;
}
.modal-enter-from .modal-panel,
.modal-leave-to .modal-panel {
  opacity: 0;
  transform: translateY(16px) scale(0.97);
}

.modal-enter-active,
.modal-leave-active {
  transition: opacity 0.25s ease;
}
.modal-leave-active .modal-panel {
  transition:
    opacity 0.18s ease,
    transform 0.18s cubic-bezier(0.16, 1, 0.3, 1);
}
</style>