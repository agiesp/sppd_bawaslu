<template>
  <AdminLayout>
    <PageBreadcrumb pageTitle="Manajemen Menu" />

    <div
      class="rounded-xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-white/[0.03]"
    >
      <div class="mb-6 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <div class="group relative flex-1">
          <input
            v-model="search"
            type="text"
            placeholder="Cari nama menu, URL, icon..."
            class="w-full rounded-lg border border-gray-300 bg-white px-4 py-2.5 pl-10 text-sm text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-gray-600 dark:bg-white/[0.05] dark:text-gray-100 dark:placeholder-gray-500 dark:focus:border-blue-400"
          />
          <svg
            class="pointer-events-none absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500"
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
          Tambah Menu
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
                Nama Menu
              </th>
              <th
                class="px-4 py-3 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400"
              >
                URL
              </th>
              <th
                class="px-4 py-3 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400"
              >
                Icon
              </th>
              <th
                class="px-4 py-3 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400"
              >
                Parent
              </th>
              <th
                class="px-4 py-3 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400"
              >
                Urutan
              </th>
              <th
                class="px-4 py-3 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400"
              >
                Status
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
                <span
                  v-if="parentName(item)"
                  class="mr-1.5 text-xs text-gray-400 dark:text-gray-500"
                >
                  └
                </span>
                {{ item.name }}
              </td>
              <td class="whitespace-nowrap px-4 py-3 text-sm text-gray-700 dark:text-gray-300">
                {{ item.url || '-' }}
              </td>
              <td class="whitespace-nowrap px-4 py-3 text-sm text-gray-700 dark:text-gray-300">
                {{ item.icon || '-' }}
              </td>
              <td class="whitespace-nowrap px-4 py-3 text-sm text-gray-700 dark:text-gray-300">
                <span
                  v-if="parentName(item)"
                  class="inline-flex rounded-full bg-gray-100 px-2.5 py-0.5 text-xs font-medium text-gray-600 dark:bg-white/[0.05] dark:text-gray-300"
                >
                  {{ parentName(item) }}
                </span>
                <span v-else class="text-gray-400 dark:text-gray-500">-</span>
              </td>
              <td class="whitespace-nowrap px-4 py-3 text-sm text-gray-700 dark:text-gray-300">
                {{ item.order }}
              </td>
              <td class="whitespace-nowrap px-4 py-3">
                <span
                  v-if="item.is_active"
                  class="inline-flex rounded-full bg-green-50 px-3 py-1 text-xs font-medium text-green-600 dark:bg-green-900/30 dark:text-green-300"
                >
                  Aktif
                </span>
                <span
                  v-else
                  class="inline-flex rounded-full bg-gray-100 px-3 py-1 text-xs font-medium text-gray-600 dark:bg-white/[0.05] dark:text-gray-300"
                >
                  Nonaktif
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

      <EmptyState v-if="filteredData.length === 0" message="Tidak ada data menu ditemukan." />

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
                {{ isEdit ? 'Edit Menu' : 'Tambah Menu' }}
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
            <form class="space-y-4 px-6 py-5" @submit.prevent="saveMenu">
              <div>
                <label
                  for="name"
                  class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300"
                >
                  Nama Menu <span class="text-red-500">*</span>
                </label>
                <div class="group relative">
                  <span
                    class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
                  >
                    <MenuIcon class="h-4 w-4" />
                  </span>
                  <input
                    id="name"
                    v-model="form.name"
                    type="text"
                    class="w-full rounded-lg border border-gray-300 bg-white py-2.5 pl-10 pr-4 text-sm text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-gray-600 dark:bg-white/[0.05] dark:text-gray-100 dark:focus:border-blue-400"
                    placeholder="Misal: Dashboard"
                    required
                  />
                </div>
              </div>
              <div>
                <label
                  for="icon"
                  class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300"
                >
                  Icon
                </label>
                <div class="group relative">
                  <span
                    class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
                  >
                    <StaredIcon class="h-4 w-4" />
                  </span>
                  <input
                    id="icon"
                    v-model="form.icon"
                    type="text"
                    class="w-full rounded-lg border border-gray-300 bg-white py-2.5 pl-10 pr-4 text-sm text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-gray-600 dark:bg-white/[0.05] dark:text-gray-100 dark:focus:border-blue-400"
                    placeholder="LayoutDashboardIcon"
                  />
                </div>
              </div>
              <div class="grid gap-4 sm:grid-cols-2">
                <div>
                  <label
                    for="url"
                    class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300"
                  >
                    URL
                  </label>
                  <div class="group relative">
                    <span
                      class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
                    >
                      <PaperclipIcon class="h-4 w-4" />
                    </span>
                    <input
                      id="url"
                      v-model="form.url"
                      type="text"
                      class="w-full rounded-lg border border-gray-300 bg-white py-2.5 pl-10 pr-4 text-sm text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-gray-600 dark:bg-white/[0.05] dark:text-gray-100 dark:focus:border-blue-400"
                      placeholder="/dashboard"
                    />
                  </div>
                </div>
                <div>
                  <label
                    for="order"
                    class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300"
                  >
                    Urutan
                  </label>
                  <div class="group relative">
                    <span
                      class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
                    >
                      <ListIcon class="h-4 w-4" />
                    </span>
                    <input
                      id="order"
                      v-model.number="form.order"
                      type="number"
                      class="w-full rounded-lg border border-gray-300 bg-white py-2.5 pl-10 pr-4 text-sm text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-gray-600 dark:bg-white/[0.05] dark:text-gray-100 dark:focus:border-blue-400"
                      min="0"
                    />
                  </div>
                </div>
              </div>
              <div>
                <label
                  for="parent_id"
                  class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300"
                >
                  Parent Menu
                </label>
                <div class="group relative">
                <span
                  class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
                >
                  <FolderIcon class="h-4 w-4" />
                </span>
                <select
                  id="parent_id"
                  v-model="form.parent_id"
                  class="w-full rounded-lg border border-gray-300 bg-white py-2.5 pl-10 pr-4 text-sm text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-gray-600 dark:bg-white/[0.05] dark:text-gray-100 dark:focus:border-blue-400"
                >
                  <option :value="null">Tidak ada (Menu Utama)</option>
                  <option
                    v-for="menu in parentOptions"
                    :key="menu.id"
                    :value="menu.id"
                  >
                    {{ menu.name }}
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
                    Hapus Menu
                  </h3>
                  <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
                    Anda yakin ingin menghapus menu
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
import { MenuIcon, PaperclipIcon, StaredIcon, ListIcon, FolderIcon } from '@/icons'
import { createMenu, updateMenu, deleteMenu } from '@/api/menus'
import { usePermission } from '@/composables/usePermission'
import { useToast } from '@/composables/useToast'

interface MenuChild {
  id: number | string
  name: string
  url: string | null
  icon: string | null
  order: number
}

interface Menu {
  id: number | string
  name: string
  url: string | null
  icon: string | null
  parent_id: number | string | null
  order: number
  is_active: boolean
  children: MenuChild[]
}

const props = defineProps<{
  menus: Menu[]
}>()

const { canCreate, canEdit, canDelete } = usePermission()
const { success, error } = useToast()

const menuUrl = '/menus'

const search = ref('')
const currentPage = ref(1)
const perPage = 10
const loading = ref(false)
const showModal = ref(false)
const showDeleteModal = ref(false)
const isEdit = ref(false)
const selectedItem = ref<Menu | null>(null)
const editingId = ref<number | string | null>(null)

const form = reactive<{
  name: string
  icon: string
  url: string
  parent_id: number | string | null
  order: number
}>({
  name: '',
  icon: '',
  url: '',
  parent_id: null,
  order: 0,
})

const parentOptions = computed<Menu[]>(() => {
  if (isEdit.value && editingId.value !== null) {
    return props.menus.filter((menu) => menu.id !== editingId.value)
  }
  return props.menus
})

const resetForm = (): void => {
  form.name = ''
  form.icon = ''
  form.url = ''
  form.parent_id = null
  form.order = 0
}

const parentName = (item: Menu): string => {
  if (!item.parent_id) return ''
  const parent = props.menus.find((menu) => menu.id === item.parent_id)
  return parent?.name || ''
}

const filteredData = computed(() => {
  let data = props.menus

  if (search.value) {
    const q = search.value.toLowerCase()
    data = data.filter(
      (item) =>
        item.name.toLowerCase().includes(q) ||
        (item.url || '').toLowerCase().includes(q) ||
        (item.icon || '').toLowerCase().includes(q),
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

const openEditModal = (item: Menu): void => {
  isEdit.value = true
  editingId.value = item.id
  form.name = item.name
  form.icon = item.icon || ''
  form.url = item.url || ''
  form.parent_id = item.parent_id
  form.order = item.order
  showModal.value = true
}

const closeModal = (): void => {
  if (loading.value) return
  showModal.value = false
  resetForm()
}

const saveMenu = async (): Promise<void> => {
  if (!form.name.trim() || loading.value) return

  loading.value = true
  try {
    if (isEdit.value && editingId.value !== null) {
      await updateMenu(editingId.value, {
        name: form.name,
        icon: form.icon || null,
        url: form.url || null,
        parent_id: form.parent_id,
        order: form.order,
      })
      success('Data menu berhasil diperbarui.')
    } else {
      await createMenu({
        name: form.name,
        icon: form.icon || null,
        url: form.url || null,
        parent_id: form.parent_id,
        order: form.order,
      })
      success('Data menu berhasil ditambahkan.')
    }
    showModal.value = false
    resetForm()
  } catch (e: unknown) {
    error('Gagal menyimpan data menu.')
  } finally {
    loading.value = false
  }
}

const openDeleteModal = (item: Menu): void => {
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
    await deleteMenu(selectedItem.value.id)
    success('Data menu berhasil dihapus.')
    showDeleteModal.value = false
    selectedItem.value = null
  } catch (e: unknown) {
    error('Gagal menghapus data menu.')
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