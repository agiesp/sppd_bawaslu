<template>
  <AdminLayout>
    <PageBreadcrumb pageTitle="Manajemen Role" />

    <div class="space-y-5 sm:space-y-6">
      <div
        class="rounded-2xl border border-gray-200 bg-white dark:border-gray-800 dark:bg-gray-900"
      >
        <div class="flex flex-col gap-4 border-b border-gray-100 px-6 py-5 sm:flex-row sm:items-center sm:justify-between dark:border-gray-800">
          <div>
            <h3 class="text-base font-semibold text-gray-800 dark:text-white/90">
              Daftar Role
            </h3>
            <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
              Kelola role pengguna dan hak akses menu.
            </p>
          </div>
          <div class="flex flex-col gap-3 sm:flex-row sm:items-center">
            <Button v-if="canCreate(menuUrl)" className="whitespace-nowrap" @click="openCreateModal">
              <PlusIcon />
              Tambah Role
            </Button>
          </div>
        </div>

        <div class="border-b border-gray-100 px-6 py-4 dark:border-gray-800">
          <p
            v-if="$page.props.flash?.success"
            class="mb-3 rounded-lg bg-success-50 px-4 py-2.5 text-sm text-success-600 dark:bg-success-500/10 dark:text-success-400"
          >
            {{ $page.props.flash.success }}
          </p>
          <div class="flex items-center gap-3">
            <div class="group relative flex-1">
              <input
                v-model="search"
                type="text"
                placeholder="Cari role..."
                class="w-full rounded-lg border border-gray-300 bg-gray-50 py-2.5 pl-10 pr-4 text-sm text-gray-800 placeholder:text-gray-400 focus:border-brand-300 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-700 dark:bg-white/5 dark:text-white/90 dark:placeholder:text-gray-500"
              />
              <svg
                class="pointer-events-none absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500"
                xmlns="http://www.w3.org/2000/svg"
                width="18"
                height="18"
                viewBox="0 0 18 18"
                fill="none"
              >
                <path d="M15.75 15.75l-5.72-5.72m0 0a4.5 4.5 0 1 0-6.36-6.36 4.5 4.5 0 0 0 6.36 6.36Z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
              </svg>
            </div>
            <DataDownloadButton
              :columns="downloadColumns"
              :items="downloadData"
              filename="roles"
            />
            <div class="flex items-center gap-2">
              <div class="group relative">
                <span
                  class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
                >
                  <TableIcon class="h-4 w-4" />
                </span>
                <select
                  v-model="pageSize"
                  class="rounded-lg border border-gray-300 bg-gray-50 py-2.5 pl-10 pr-2.5 text-sm text-gray-800 focus:border-brand-300 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-700 dark:bg-white/5 dark:text-white/90"
                >
                <option :value="10">10</option>
                <option :value="50">50</option>
                <option :value="100">100</option>
              </select>
                </div>
            </div>
          </div>
        </div>

        <div class="px-6 py-4">
          <div class="overflow-x-auto rounded-xl border border-gray-200 dark:border-gray-700">
            <table class="w-full table-auto text-left">
              <thead>
                <tr class="border-b border-gray-200 bg-gradient-to-r from-gray-50 to-gray-100/80 dark:border-gray-700 dark:from-white/[0.05] dark:to-white/[0.02]">
                  <th class="border-r border-gray-200 px-4 py-3.5 text-left text-[11px] font-semibold uppercase tracking-wider text-gray-500 dark:border-gray-700 dark:text-gray-400">No</th>
                  <th class="border-r border-gray-200 px-4 py-3.5 text-left text-[11px] font-semibold uppercase tracking-wider text-gray-500 dark:border-gray-700 dark:text-gray-400">Nama</th>
                  <th class="border-r border-gray-200 px-4 py-3.5 text-left text-[11px] font-semibold uppercase tracking-wider text-gray-500 dark:border-gray-700 dark:text-gray-400">Deskripsi</th>
                  <th class="px-4 py-3.5 text-left text-[11px] font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Aksi</th>
                </tr>
              </thead>
              <tbody>
                <SkeletonTable
                  :loading="loading"
                  :rows="5"
                  :columns="[
                    { width: 'w-4' },
                    { width: 'w-32' },
                    { width: 'w-48' },
                    { width: 'w-14', align: 'center' },
                  ]"
                />
                <template v-if="!loading">
                <tr
                  v-for="(role, index) in pagedRoles"
                  :key="role.id"
                  class="border-b border-gray-200 last:border-0 transition-colors hover:bg-gray-50 hover:dark:bg-white/[0.04] dark:border-gray-700"
                >
                  <td class="border-r border-gray-200 px-4 py-3 text-sm text-gray-700 dark:border-gray-700 dark:text-gray-300">{{ (currentPage - 1) * pageSize + index + 1 }}</td>
                  <td class="border-r border-gray-200 px-4 py-3 text-sm font-medium text-gray-800 dark:border-gray-700 dark:text-white/90">{{ role.name }}</td>
                  <td class="border-r border-gray-200 px-4 py-3 text-sm text-gray-700 dark:border-gray-700 dark:text-gray-300">{{ role.description ?? '-' }}</td>
                  <td class="px-4 py-3">
                    <div class="flex items-center gap-2">
                      <button
                        v-if="canEdit(menuUrl)"
                        @click="openEditModal(role)"
                        class="inline-flex h-9 w-9 items-center justify-center rounded-lg text-brand-500 hover:bg-brand-50 dark:hover:bg-brand-500/10"
                        title="Edit"
                      >
                        <EditIcon />
                      </button>
                      <button
                        v-if="canDelete(menuUrl)"
                        @click="confirmDelete(role)"
                        class="inline-flex h-9 w-9 items-center justify-center rounded-lg text-red-500 hover:bg-red-50 dark:hover:bg-red-500/10"
                        title="Hapus"
                      >
                        <TrashIcon />
                      </button>
                    </div>
                  </td>
                </tr>
                </template>
                <tr v-if="!loading && filteredRoles.length === 0">
                  <td colspan="4" class="px-4 py-8 text-center text-sm text-gray-500 dark:text-gray-400">
                    <EmptyState message="Tidak ada data role." />
                  </td>
                </tr>
              </tbody>
            </table>
          </div>

          <TablePagination
            v-model:currentPage="currentPage"
            :page-size="pageSize"
            :total-items="filteredRoles.length"
          />
        </div>
      </div>
    </div>

    <!-- Modal Tambah/Edit Role -->
    <Transition name="modal">
      <div
        v-if="showModal"
        class="fixed inset-0 z-99999 flex items-center justify-center px-4 py-6 sm:py-10"
      >
        <div
          class="modal-backdrop fixed inset-0 h-full w-full bg-gray-400/50 backdrop-blur-[32px]"
          @click="closeModal"
        ></div>
        <div
          class="modal-panel relative flex  w-full max-w-4xl flex-col overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-2xl shadow-gray-900/10 dark:border-gray-800 dark:bg-gray-900 dark:shadow-black/40"
        >
          <div class="flex items-start justify-between border-b border-gray-100 bg-gradient-to-r from-gray-50/80 to-transparent px-6 py-5 dark:border-gray-800 dark:from-white/[0.03]">
            <div>
              <h3 class="text-lg font-semibold text-gray-800 dark:text-white/90">
                {{ editingId ? 'Edit Role' : 'Tambah Role' }}
              </h3>
              <p class="mt-0.5 text-sm text-gray-500 dark:text-gray-400">
                Atur nama role dan batasi akses menu.
              </p>
            </div>
            <button
              type="button"
              @click="closeModal"
              class="inline-flex h-9 w-9 items-center justify-center rounded-full text-gray-400 transition-colors hover:bg-gray-100 hover:text-gray-700 dark:hover:bg-white/10 dark:hover:text-white"
              aria-label="Tutup"
            >
              <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <line x1="18" y1="6" x2="6" y2="18"></line>
                <line x1="6" y1="6" x2="18" y2="18"></line>
              </svg>
            </button>
          </div>

          <form @submit.prevent="saveRole" class="flex min-h-0 flex-1 flex-col">
            <div class="min-h-0 flex-1 space-y-5 overflow-y-auto px-6 py-5">
              <div>
                <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">Nama Role</label>
                <IconInput :icon="UserGroupIcon">
                  <input
                    v-model="form.name"
                    type="text"
                    required
                    class="w-full rounded-lg border border-gray-300 bg-gray-50 py-2.5 pl-11 pr-4 text-sm text-gray-800 focus:border-brand-300 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-700 dark:bg-white/5 dark:text-white/90"
                    placeholder="Nama role"
                  />
                </IconInput>
              </div>

              <div>
                <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">Deskripsi</label>
                <IconInput :icon="DocsIcon">
                  <input
                    v-model="form.description"
                    type="text"
                    class="w-full rounded-lg border border-gray-300 bg-gray-50 py-2.5 pl-11 pr-4 text-sm text-gray-800 focus:border-brand-300 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-700 dark:bg-white/5 dark:text-white/90"
                    placeholder="Deskripsi role (opsional)"
                  />
                </IconInput>
              </div>

              <div>
            <div class="mb-3 flex items-center justify-between">
              <h4 class="text-sm font-semibold text-gray-800 dark:text-white/90">
                Hak Akses Menu
              </h4>
              <span class="text-xs text-gray-500 dark:text-gray-400">
                Centang izin akses untuk setiap menu
              </span>
            </div>
            <div class="max-h-[42vh] overflow-y-auto overflow-x-auto rounded-xl border border-gray-200 dark:border-gray-700">
              <table class="w-full min-w-[620px] table-auto text-left">
                <thead>
                  <tr class="border-b border-gray-200 bg-gradient-to-r from-gray-50 to-gray-100/80 dark:border-gray-700 dark:from-white/[0.05] dark:to-white/[0.02]">
                    <th class="border-r border-gray-200 px-4 py-3 text-left text-[11px] font-semibold uppercase tracking-wider text-gray-500 dark:border-gray-700 dark:text-gray-400">Nama Menu</th>
                    <th v-for="perm in permissionKeys" :key="perm" class="border-r border-gray-200 px-3 py-3 text-center text-[11px] font-semibold uppercase tracking-wider text-gray-500 last:border-r-0 dark:border-gray-700 dark:text-gray-400">
                      {{ permissionLabels[perm] }}
                    </th>
                  </tr>
                </thead>
                <tbody>
                  <template v-for="menu in menus" :key="menu.id">
                    <tr class="border-b border-gray-200 bg-gray-50/70 dark:border-gray-700 dark:bg-white/[0.03]">
                      <td class="border-r border-gray-200 px-4 py-2.5 text-sm font-semibold text-gray-800 dark:border-gray-700 dark:text-white/90">
                        <div class="flex items-center gap-2">
                          <FolderIcon class="h-4 w-4 text-brand-500" />
                          {{ menu.name }}
                        </div>
                      </td>
                      <td v-for="perm in permissionKeys" :key="perm" class="border-r border-gray-200 px-3 py-2.5 text-center last:border-r-0 dark:border-gray-700">
                        <label class="inline-flex cursor-pointer items-center">
                          <input
                            type="checkbox"
                            class="peer sr-only"
                            :checked="getPermission(menu.id, perm)"
                            @change="togglePermission(menu.id, perm, $event)"
                          />
                          <span
                            :class="[
                              'relative flex h-5 w-5 items-center justify-center rounded-md border transition-all duration-200',
                              getPermission(menu.id, perm)
                                ? 'border-brand-500 bg-brand-500 shadow-sm shadow-brand-500/30'
                                : 'border-gray-300 bg-white hover:border-gray-400 dark:border-gray-600 dark:bg-white/5 dark:hover:border-gray-500',
                            ]"
                          >
                            <svg
                              v-if="getPermission(menu.id, perm)"
                              class="h-3 w-3 text-white"
                              xmlns="http://www.w3.org/2000/svg"
                              viewBox="0 0 24 24"
                              fill="none"
                              stroke="currentColor"
                              stroke-width="3"
                              stroke-linecap="round"
                              stroke-linejoin="round"
                            >
                              <polyline points="20 6 9 17 4 12"></polyline>
                            </svg>
                          </span>
                        </label>
                      </td>
                    </tr>
                    <template v-if="menu.children?.length">
                      <tr
                        v-for="child in menu.children"
                        :key="child.id"
                        class="border-b border-gray-200 last:border-0 dark:border-gray-700"
                      >
                        <td class="border-r border-gray-200 px-4 py-2.5 text-sm text-gray-700 dark:border-gray-700 dark:text-gray-300">
                          <div class="flex items-center gap-2 pl-5">
                            <svg
                              class="h-3.5 w-3.5 shrink-0 text-gray-400 dark:text-gray-500"
                              xmlns="http://www.w3.org/2000/svg"
                              viewBox="0 0 24 24"
                              fill="none"
                              stroke="currentColor"
                              stroke-width="2"
                              stroke-linecap="round"
                              stroke-linejoin="round"
                            >
                              <polyline points="9 18 15 12 9 6"></polyline>
                            </svg>
                            <span class="font-medium text-gray-600 dark:text-gray-400">{{ child.name }}</span>
                          </div>
                        </td>
                        <td v-for="perm in permissionKeys" :key="perm" class="border-r border-gray-200 px-3 py-2.5 text-center last:border-r-0 dark:border-gray-700">
                          <label class="inline-flex cursor-pointer items-center">
                            <input
                              type="checkbox"
                              class="peer sr-only"
                              :checked="getPermission(child.id, perm)"
                              @change="togglePermission(child.id, perm, $event)"
                            />
                            <span
                              :class="[
                                'relative flex h-5 w-5 items-center justify-center rounded-md border transition-all duration-200',
                                getPermission(child.id, perm)
                                  ? 'border-brand-500 bg-brand-500 shadow-sm shadow-brand-500/30'
                                  : 'border-gray-300 bg-white hover:border-gray-400 dark:border-gray-600 dark:bg-white/5 dark:hover:border-gray-500',
                              ]"
                            >
                              <svg
                                v-if="getPermission(child.id, perm)"
                                class="h-3 w-3 text-white"
                                xmlns="http://www.w3.org/2000/svg"
                                viewBox="0 0 24 24"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="3"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                              >
                                <polyline points="20 6 9 17 4 12"></polyline>
                              </svg>
                            </span>
                          </label>
                        </td>
                      </tr>
                    </template>
                  </template>
                  <tr v-if="menus.length === 0">
                    <td colspan="5" class="px-4 py-8 text-center text-sm text-gray-500 dark:text-gray-400">
                      <EmptyState message="Tidak ada menu." />
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>

          <p v-if="error" class="text-sm text-red-600 dark:text-red-400">{{ error }}</p>
          </div>

          <div class="flex shrink-0 items-center justify-end gap-3 border-t border-gray-100 bg-gray-50/70 px-6 py-4 dark:border-gray-800 dark:bg-white/[0.02]">
            <Button variant="outline" @click="closeModal" :disabled="saving">Batal</Button>
            <button
              type="submit"
              :disabled="saving"
              class="inline-flex items-center justify-center gap-2 rounded-lg bg-brand-500 px-5 py-2.5 text-sm font-medium text-white shadow-theme-xs transition-colors hover:bg-brand-600 disabled:cursor-not-allowed disabled:bg-brand-300"
            >
              {{ saving ? 'Menyimpan...' : 'Simpan' }}
            </button>
          </div>
        </form>
      </div>
    </div>
    </Transition>

    <!-- Modal Konfirmasi Hapus -->
    <div
      v-if="showDeleteModal"
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
            <TrashIcon />
          </div>
          <div>
            <h3 class="text-lg font-semibold text-gray-800 dark:text-white/90">
              Hapus Role
            </h3>
            <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
              Apakah Anda yakin ingin menghapus role
              <span class="font-semibold text-gray-700 dark:text-gray-200">
                "{{ deleteTarget?.name }}"
              </span>? Tindakan ini tidak dapat dibatalkan.
            </p>
          </div>
        </div>

        <div class="mt-6 flex items-center justify-end gap-3">
          <Button variant="outline" @click="closeDeleteModal" :disabled="deleting">Batal</Button>
          <button
            type="button"
            :disabled="deleting"
            @click="performDelete"
            class="inline-flex items-center justify-center gap-2 rounded-lg bg-red-600 px-5 py-3.5 text-sm font-medium text-white shadow-theme-xs hover:bg-red-700 disabled:cursor-not-allowed disabled:bg-red-300"
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
import { ref, reactive, computed, watch, onMounted, nextTick } from 'vue'
import AdminLayout from '../../components/layout/AdminLayout.vue'
import PageBreadcrumb from '@/components/common/PageBreadcrumb.vue'
import Button from '@/components/ui/Button.vue'
import IconInput from '@/components/ui/IconInput.vue'
import Toast from '@/components/ui/Toast.vue'
import SkeletonTable from '@/components/ui/SkeletonTable.vue'
import { DocsIcon, UserGroupIcon, TableIcon } from '@/icons'
import TablePagination from '@/components/tables/TablePagination.vue'
import DataDownloadButton from '@/components/tables/DataDownloadButton.vue'
import EditIcon from '@/icons/EditIcon.vue'
import TrashIcon from '@/icons/TrashIcon.vue'
import PlusIcon from '@/icons/PlusIcon.vue'
import FolderIcon from '@/icons/FolderIcon.vue'
import { createRole, updateRole, deleteRole } from '@/api/roles'
import { useToast } from '@/composables/useToast'
import { usePermission } from '@/composables/usePermission'
import type { Role, RolePayload, PermissionPayload } from '@/types/role'
import type { RefMenu } from '@/types/menu'

const { success: toastSuccess, error: toastError } = useToast()

const { canCreate, canEdit, canDelete } = usePermission()
const menuUrl = '/roles'

interface Props {
  roles: Role[]
  menus: RefMenu[]
}

const props = defineProps<Props>()

const loading = ref(true)
const roles = ref<Role[]>(props.roles)
const menus = ref<RefMenu[]>(props.menus)
const saving = ref(false)
const error = ref('')
const showModal = ref(false)
const editingId = ref<number | null>(null)
const showDeleteModal = ref(false)
const deleteTarget = ref<Role | null>(null)
const deleting = ref(false)
const search = ref('')
const currentPage = ref(1)
const pageSize = ref(10)

const filteredRoles = computed(() => {
  const q = search.value.trim().toLowerCase()
  if (!q) return roles.value
  return roles.value.filter(
    (r) =>
      r.name.toLowerCase().includes(q) ||
      (r.description ?? '').toLowerCase().includes(q),
  )
})

const pagedRoles = computed(() => {
  const start = (currentPage.value - 1) * pageSize.value
  return filteredRoles.value.slice(start, start + pageSize.value)
})

watch(search, () => {
  currentPage.value = 1
})

watch(pageSize, () => {
  currentPage.value = 1
})

const downloadColumns = [
  { key: 'name', label: 'Nama' },
  { key: 'description', label: 'Deskripsi' },
]

const downloadData = computed(() =>
  roles.value.map((r) => ({
    name: r.name,
    description: r.description ?? '',
  })),
)

const permissionKeys = ['can_view', 'can_create', 'can_edit', 'can_delete'] as const
const permissionLabels: Record<string, string> = {
  can_view: 'Lihat',
  can_create: 'Tambah',
  can_edit: 'Edit',
  can_delete: 'Hapus',
}

const form = reactive<RolePayload>({
  name: '',
  description: '',
  permissions: [],
})

const getPermission = (menuId: number, key: string) => {
  const perm = form.permissions?.find((p) => p.menu_id === menuId)
  return perm ? !!perm[key as keyof PermissionPayload] : false
}

const togglePermission = (menuId: number, key: string, event: Event) => {
  const checked = (event.target as HTMLInputElement).checked
  const idx = form.permissions?.findIndex((p) => p.menu_id === menuId) ?? -1
  let perm = idx >= 0 ? form.permissions![idx] : null

  if (!perm) {
    if (!checked) return
    form.permissions!.push({
      menu_id: menuId,
      can_view: false,
      can_create: false,
      can_edit: false,
      can_delete: false,
    } as PermissionPayload)
    perm = form.permissions![form.permissions!.length - 1]
  }

  ;(perm as any)[key] = checked

  const hasAny = ['can_view', 'can_create', 'can_edit', 'can_delete'].some(
    (k) => (perm as any)[k],
  )
  if (!hasAny) {
    form.permissions = form.permissions!.filter((p) => p.menu_id !== menuId)
  }
}

const openCreateModal = () => {
  editingId.value = null
  form.name = ''
  form.description = ''
  form.permissions = []
  error.value = ''
  showModal.value = true
}

const openEditModal = (role: Role) => {
  editingId.value = role.id
  form.name = role.name
  form.description = role.description ?? ''
  form.permissions = []
  role.menus?.forEach((menu: any) => {
    const piv = menu.pivot
    const hasAny =
      piv.can_view || piv.can_create || piv.can_edit || piv.can_delete
    if (!hasAny) return
    form.permissions!.push({
      menu_id: menu.id,
      can_view: piv.can_view,
      can_create: piv.can_create,
      can_edit: piv.can_edit,
      can_delete: piv.can_delete,
    } as PermissionPayload)
  })
  error.value = ''
  showModal.value = true
}

const closeModal = () => {
  showModal.value = false
}

const saveRole = async () => {
  saving.value = true
  error.value = ''
  try {
    const payload: RolePayload = {
      name: form.name,
      description: form.description,
      permissions: form.permissions ?? [],
    }
    if (editingId.value) {
      const result = await updateRole(editingId.value, payload)
      const idx = roles.value.findIndex((r) => r.id === editingId.value)
      if (idx !== -1) {
        roles.value[idx] = result.role
      }
      toastSuccess(result.message)
    } else {
      const result = await createRole(payload)
      roles.value.push(result.role)
      toastSuccess(result.message)
    }
    showModal.value = false
  } catch (e: any) {
    const data = e?.response?.data?.errors ?? {}
    const firstError = Object.values(data).flat()[0]
    const msg = typeof firstError === 'string' ? firstError : 'Gagal menyimpan role.'
    error.value = msg
    toastError(msg)
  } finally {
    saving.value = false
  }
}

const confirmDelete = (role: Role) => {
  deleteTarget.value = role
  showDeleteModal.value = true
}

const closeDeleteModal = () => {
  showDeleteModal.value = false
  deleteTarget.value = null
}

const performDelete = async () => {
  if (!deleteTarget.value) return
  deleting.value = true
  error.value = ''
  try {
    const result = await deleteRole(deleteTarget.value.id)
    roles.value = roles.value.filter((r) => r.id !== deleteTarget.value.id)
    showDeleteModal.value = false
    deleteTarget.value = null
    toastSuccess(result.message)
  } catch (e: any) {
    const data = e?.response?.data?.errors ?? {}
    const firstError = Object.values(data).flat()[0]
    const msg = typeof firstError === 'string' ? firstError : 'Gagal menghapus role.'
    error.value = msg
    toastError(msg)
  } finally {
    deleting.value = false
  }
}

onMounted(() => {
  nextTick(() => { loading.value = false })
})
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
