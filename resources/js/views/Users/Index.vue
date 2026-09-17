<template>
  <AdminLayout>
    <PageBreadcrumb pageTitle="Manajemen Pengguna" />

    <div
      class="rounded-xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-white/[0.03]"
    >
      <div class="mb-6 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <div class="group relative flex-1">
          <input
            v-model="search"
            type="text"
            placeholder="Cari nama, email, role..."
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
        <button
          v-if="canCreate(menuUrl)"
          type="button"
          class="inline-flex items-center gap-2 rounded-lg bg-brand-500 px-4 py-2.5 text-sm font-medium text-white shadow-sm transition-colors hover:bg-brand-600 focus:outline-none focus:ring-2 focus:ring-brand-500 focus:ring-offset-2 dark:focus:ring-offset-gray-900"
          @click="openCreateModal"
        >
          <PlusIcon class="h-4 w-4" />
          Tambah Pengguna
        </button>
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
                Email
              </th>
              <th
                class="px-4 py-3 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400"
              >
                Role
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
                    alt="Avatar"
                    class="h-8 w-8 shrink-0 rounded-full object-cover"
                  />
                  <span
                    v-else
                    class="inline-flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-blue-100 text-xs font-semibold text-blue-600 dark:bg-blue-900/30 dark:text-blue-300"
                  >
                    {{ item.name.charAt(0).toUpperCase() }}
                  </span>
                  {{ item.name }}
                </div>
              </td>
              <td class="whitespace-nowrap px-4 py-3 text-sm text-gray-700 dark:text-gray-300">
                {{ item.email }}
              </td>
              <td class="whitespace-nowrap px-4 py-3">
                <span
                  class="inline-flex rounded-full bg-blue-50 px-3 py-1 text-xs font-medium text-blue-600 dark:bg-blue-900/30 dark:text-blue-300"
                >
                  {{ item.role?.name || '-' }}
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

      <EmptyState v-if="filteredData.length === 0" message="Tidak ada data pengguna ditemukan." />

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
                {{ isEdit ? 'Edit Pengguna' : 'Tambah Pengguna' }}
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
            <form class="space-y-4 px-6 py-5" @submit.prevent="saveUser">
              <div class="flex flex-col items-center gap-4 sm:flex-row">
                <div class="relative shrink-0">
                  <img
                    v-if="form.avatarPreview"
                    :src="form.avatarPreview"
                    alt="Preview Avatar"
                    class="h-20 w-20 rounded-full object-cover ring-2 ring-gray-200 dark:ring-gray-700"
                  />
                  <span
                    v-else
                    class="inline-flex h-20 w-20 items-center justify-center rounded-full bg-blue-100 text-2xl font-semibold text-blue-600 ring-2 ring-gray-200 dark:bg-blue-900/30 dark:text-blue-300 dark:ring-gray-700"
                  >
                    {{ form.name.charAt(0).toUpperCase() || '?' }}
                  </span>
                  <button
                    type="button"
                    class="absolute bottom-0 right-0 flex h-7 w-7 items-center justify-center rounded-full bg-brand-500 text-white shadow-md transition-colors hover:bg-brand-600"
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
                    Foto Profil
                  </label>
                  <p class="text-xs text-gray-400 dark:text-gray-500">
                    Klik ikon kamera pada foto untuk mengganti avatar.
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
                  for="name"
                  class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300"
                >
                  Nama <span class="text-red-500">*</span>
                </label>
                <div class="group relative">
                  <span
                    class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
                  >
                    <UserCircleIcon class="h-4 w-4" />
                  </span>
                  <input
                    id="name"
                    v-model="form.name"
                    type="text"
                    class="w-full rounded-lg border border-gray-300 bg-white px-4 py-2.5 pl-10 text-sm text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-gray-600 dark:bg-white/[0.05] dark:text-gray-100 dark:focus:border-blue-400"
                    placeholder="Nama lengkap pengguna"
                    required
                  />
                </div>
              </div>
              <div>
                <label
                  for="email"
                  class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300"
                >
                  Email <span class="text-red-500">*</span>
                </label>
                <div class="group relative">
                  <span
                    class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
                  >
                    <MailIcon class="h-4 w-4" />
                  </span>
                  <input
                    id="email"
                    v-model="form.email"
                    type="email"
                    class="w-full rounded-lg border border-gray-300 bg-white px-4 py-2.5 pl-10 text-sm text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-gray-600 dark:bg-white/[0.05] dark:text-gray-100 dark:focus:border-blue-400"
                    placeholder="nama@email.com"
                    required
                  />
                </div>
              </div>
              <div class="grid gap-4 sm:grid-cols-2">
                <div>
                  <label
                    for="password"
                    class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300"
                  >
                    Password <span v-if="!isEdit" class="text-red-500">*</span>
                  </label>
                  <div class="group relative">
                    <span
                      class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
                    >
                      <LockIcon class="h-4 w-4" />
                    </span>
                    <input
                      id="password"
                      v-model="form.password"
                      type="password"
                      class="w-full rounded-lg border border-gray-300 bg-white px-4 py-2.5 pl-10 text-sm text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-gray-600 dark:bg-white/[0.05] dark:text-gray-100 dark:focus:border-blue-400"
                      placeholder="Minimal 8 karakter"
                      :required="!isEdit"
                    />
                  </div>
                </div>
                <div>
                  <label
                    for="password_confirmation"
                    class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300"
                  >
                    Konfirmasi Password <span v-if="!isEdit" class="text-red-500">*</span>
                  </label>
                  <div class="group relative">
                    <span
                      class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
                    >
                      <LockIcon class="h-4 w-4" />
                    </span>
                    <input
                      id="password_confirmation"
                      v-model="form.password_confirmation"
                      type="password"
                      class="w-full rounded-lg border border-gray-300 bg-white px-4 py-2.5 pl-10 text-sm text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-gray-600 dark:bg-white/[0.05] dark:text-gray-100 dark:focus:border-blue-400"
                      placeholder="Ulangi password"
                      :required="!isEdit"
                    />
                  </div>
                </div>
              </div>
              <div>
                <label
                  for="role_id"
                  class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300"
                >
                  Role <span class="text-red-500">*</span>
                </label>
                <div class="group relative">
                  <span
                    class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
                  >
                    <UserGroupIcon class="h-4 w-4" />
                  </span>
                  <select
                    id="role_id"
                    v-model="form.role_id"
                    class="w-full rounded-lg border border-gray-300 bg-white px-4 py-2.5 pl-10 text-sm text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-gray-600 dark:bg-white/[0.05] dark:text-gray-100 dark:focus:border-blue-400"
                    required
                  >
                    <option value="" disabled>Pilih role</option>
                    <option
                      v-for="role in roles"
                      :key="role.id"
                      :value="role.id"
                    >
                      {{ role.name }}
                    </option>
                  </select>
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
                  class="inline-flex items-center gap-2 rounded-lg bg-brand-500 px-4 py-2.5 text-sm font-medium text-white shadow-sm transition-colors hover:bg-brand-600 focus:outline-none focus:ring-2 focus:ring-brand-500 focus:ring-offset-2 disabled:opacity-60 dark:focus:ring-offset-gray-900"
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
                    Hapus Pengguna
                  </h3>
                  <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
                    Anda yakin ingin menghapus pengguna
                    <span class="font-medium text-gray-900 dark:text-gray-100">
                      {{ selectedItem?.name }}
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
import { ref, reactive, computed } from 'vue'
import AdminLayout from '../../components/layout/AdminLayout.vue'
import PageBreadcrumb from '@/components/common/PageBreadcrumb.vue'
import TablePagination from '@/components/tables/TablePagination.vue'
import EmptyState from '@/components/ui/EmptyState.vue'
import Toast from '@/components/ui/Toast.vue'
import EditIcon from '@/icons/EditIcon.vue'
import TrashIcon from '@/icons/TrashIcon.vue'
import PlusIcon from '@/icons/PlusIcon.vue'
import { UserCircleIcon, MailIcon, LockIcon, UserGroupIcon } from '@/icons'
import { createUser, updateUser, deleteUser } from '@/api/users'
import { usePermission } from '@/composables/usePermission'
import { useToast } from '@/composables/useToast'

interface Role {
  id: number | string
  name: string
}

interface User {
  id: number | string
  name: string
  email: string
  role_id: number | string | null
  role: Role | null
  avatar: string | null
  avatar_url: string | null
  created_at: string
}

const props = defineProps<{
  users: User[]
  roles: Role[]
}>()

const { canCreate, canEdit, canDelete } = usePermission()
const { success, error } = useToast()

const menuUrl = '/users'

const search = ref('')
const currentPage = ref(1)
const perPage = 10
const avatarInput = ref<HTMLInputElement | null>(null)
const loading = ref(false)
const showModal = ref(false)
const showDeleteModal = ref(false)
const isEdit = ref(false)
const selectedItem = ref<User | null>(null)
const editingId = ref<number | string | null>(null)

const form = reactive<{
  name: string
  email: string
  password: string
  password_confirmation: string
  role_id: number | string | null
  avatar: File | null
  avatarPreview: string | null
}>({
  name: '',
  email: '',
  password: '',
  password_confirmation: '',
  role_id: null,
  avatar: null,
  avatarPreview: null,
})

const resetForm = (): void => {
  form.name = ''
  form.email = ''
  form.password = ''
  form.password_confirmation = ''
  form.role_id = null
  form.avatar = null
  form.avatarPreview = null
  if (avatarInput.value) avatarInput.value.value = ''
}

const filteredData = computed(() => {
  let data = props.users

  if (search.value) {
    const q = search.value.toLowerCase()
    data = data.filter(
      (item) =>
        item.name.toLowerCase().includes(q) ||
        item.email.toLowerCase().includes(q) ||
        (item.role?.name || '').toLowerCase().includes(q),
    )
  }

  return data
})

const paginatedData = computed(() => {
  const start = (currentPage.value - 1) * perPage
  const end = start + perPage
  return filteredData.value.slice(start, end)
})

const openCreateModal = (): void => {
  resetForm()
  isEdit.value = false
  editingId.value = null
  showModal.value = true
}

const openEditModal = (item: User): void => {
  isEdit.value = true
  editingId.value = item.id
  form.name = item.name
  form.email = item.email
  form.password = ''
  form.password_confirmation = ''
  form.role_id = item.role_id
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

const saveUser = async (): Promise<void> => {
  if (!form.name.trim() || !form.email.trim() || form.role_id === null) return
  if (form.password !== form.password_confirmation) {
    error('Konfirmasi password tidak cocok.')
    return
  }
  if (loading.value) return

  loading.value = true
  try {
    if (isEdit.value && editingId.value !== null) {
      await updateUser(editingId.value, {
        name: form.name,
        email: form.email,
        password: form.password || undefined,
        password_confirmation: form.password_confirmation || undefined,
        role_id: form.role_id,
        avatar: form.avatar,
      })
      success('Data pengguna berhasil diperbarui.')
    } else {
      await createUser({
        name: form.name,
        email: form.email,
        password: form.password,
        password_confirmation: form.password_confirmation,
        role_id: form.role_id,
        avatar: form.avatar,
      })
      success('Data pengguna berhasil ditambahkan.')
    }
    showModal.value = false
    resetForm()
  } catch (e: unknown) {
    error('Gagal menyimpan data pengguna.')
  } finally {
    loading.value = false
  }
}

const openDeleteModal = (item: User): void => {
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
    await deleteUser(selectedItem.value.id)
    success('Data pengguna berhasil dihapus.')
    closeDeleteModal()
  } catch (e: unknown) {
    error('Gagal menghapus data pengguna.')
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