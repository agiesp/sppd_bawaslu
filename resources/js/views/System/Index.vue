<template>
  <AdminLayout>
    <PageBreadcrumb pageTitle="System Pengaturan" />
    <Toast />

    <div
      class="rounded-2xl border border-gray-200 bg-white dark:border-gray-800 dark:bg-gray-900"
    >
      <div class="border-b border-gray-200 dark:border-gray-800">
        <nav class="flex gap-0 -mb-px" role="tablist">
          <button
            v-for="(tab, idx) in tabs"
            :key="tab.key"
            @click="activeTab = tab.key"
            :class="[
              'py-4 px-5 text-sm font-medium border-b-2 transition-colors',
              activeTab === tab.key
                ? 'border-brand-500 text-brand-500'
                : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 dark:text-gray-400 dark:hover:text-gray-200',
            ]"
            role="tab"
            :aria-selected="activeTab === tab.key"
          >
            {{ tab.label }}
          </button>
        </nav>
      </div>

      <div class="p-6">
        <div v-show="activeTab === 'informasi'">
          <p class="mb-6 text-sm text-gray-500 dark:text-gray-400">
            Nama aplikasi, deskripsi, logo, dan favicon yang ditampilkan pada aplikasi.
          </p>

          <div class="grid grid-cols-1 gap-6 sm:grid-cols-2">
            <div>
              <label class="mb-2.5 block text-sm font-medium text-gray-800 dark:text-white/90">
                Nama Aplikasi
              </label>
              <div class="group relative">
                <span
                  class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
                >
                  <LayoutDashboardIcon class="h-4 w-4" />
                </span>
                <input
                  v-model="form.app_name"
                  type="text"
                  placeholder="Nama aplikasi"
                  class="w-full rounded-lg border border-gray-300 bg-gray-50 py-2.5 pl-10 pr-4 text-sm text-gray-800 placeholder:text-gray-400 focus:border-brand-300 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-700 dark:bg-white/5 dark:text-white/90 dark:placeholder:text-gray-500"
                />
              </div>
            </div>

            <div>
              <label class="mb-2.5 block text-sm font-medium text-gray-800 dark:text-white/90">
                Alamat
              </label>
              <div class="group relative">
                <span
                  class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
                >
                  <HomeIcon class="h-4 w-4" />
                </span>
                <input
                  v-model="form.app_address"
                  type="text"
                  placeholder="Alamat instansi"
                  class="w-full rounded-lg border border-gray-300 bg-gray-50 py-2.5 pl-10 pr-4 text-sm text-gray-800 placeholder:text-gray-400 focus:border-brand-300 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-700 dark:bg-white/5 dark:text-white/90 dark:placeholder:text-gray-500"
                />
              </div>
            </div>

            <div class="sm:col-span-2">
              <label class="mb-2.5 block text-sm font-medium text-gray-800 dark:text-white/90">
                Deskripsi Aplikasi
              </label>
              <div class="group relative">
                <span
                  class="pointer-events-none absolute left-0 top-3.5 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
                >
                  <DocsIcon class="h-4 w-4" />
                </span>
                <textarea
                  v-model="form.app_description"
                  rows="3"
                  placeholder="Deskripsi aplikasi"
                  class="w-full rounded-lg border border-gray-300 bg-gray-50 py-2.5 pl-10 pr-4 text-sm text-gray-800 placeholder:text-gray-400 focus:border-brand-300 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-700 dark:bg-white/5 dark:text-white/90 dark:placeholder:text-gray-500"
                ></textarea>
              </div>
            </div>

            <div>
              <label class="mb-2.5 block text-sm font-medium text-gray-800 dark:text-white/90">
                Logo
              </label>
              <FileInput
                :current="form.app_logo"
                accept="image/*"
                @change="onFileChange('app_logo', $event)"
              />
            </div>

            <div>
              <label class="mb-2.5 block text-sm font-medium text-gray-800 dark:text-white/90">
                Favicon
              </label>
              <FileInput
                :current="form.app_favicon"
                accept="image/*"
                @change="onFileChange('app_favicon', $event)"
              />
            </div>

            <div class="sm:col-span-2">
              <label class="mb-2.5 block text-sm font-medium text-gray-800 dark:text-white/90">
                Latar Halaman Login
              </label>
              <FileInput
                :current="form.login_background"
                accept="image/*"
                @change="onFileChange('login_background', $event)"
              />
              <p class="mt-2 text-xs text-gray-400 dark:text-gray-500">
                Gambar latar yang ditampilkan pada panel visual halaman login.
              </p>
            </div>
          </div>
        </div>

        <div v-show="activeTab === 'kontak'">
          <p class="mb-6 text-sm text-gray-500 dark:text-gray-400">
            Informasi kontak instansi untuk ditampilkan pada aplikasi.
          </p>

          <div class="grid grid-cols-1 gap-6 sm:grid-cols-2">
            <div>
              <label class="mb-2.5 block text-sm font-medium text-gray-800 dark:text-white/90">
                Email
              </label>
              <div class="group relative">
                <span
                  class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
                >
                  <MailIcon class="h-4 w-4" />
                </span>
                <input
                  v-model="form.app_email"
                  type="email"
                  placeholder="email@domain.com"
                  class="w-full rounded-lg border border-gray-300 bg-gray-50 py-2.5 pl-10 pr-4 text-sm text-gray-800 placeholder:text-gray-400 focus:border-brand-300 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-700 dark:bg-white/5 dark:text-white/90 dark:placeholder:text-gray-500"
                />
              </div>
            </div>

            <div>
              <label class="mb-2.5 block text-sm font-medium text-gray-800 dark:text-white/90">
                No. Telepon
              </label>
              <div class="group relative">
                <span
                  class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
                >
                  <SupportIcon class="h-4 w-4" />
                </span>
                <input
                  v-model="form.app_phone"
                  type="text"
                  placeholder="08xxxxxxxxxx"
                  class="w-full rounded-lg border border-gray-300 bg-gray-50 py-2.5 pl-10 pr-4 text-sm text-gray-800 placeholder:text-gray-400 focus:border-brand-300 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-700 dark:bg-white/5 dark:text-white/90 dark:placeholder:text-gray-500"
                />
              </div>
            </div>

            <div>
              <label class="mb-2.5 block text-sm font-medium text-gray-800 dark:text-white/90">
                No. WhatsApp
              </label>
              <div class="group relative">
                <span
                  class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
                >
                  <ChatIcon class="h-4 w-4" />
                </span>
                <input
                  v-model="form.app_whatsapp"
                  type="text"
                  placeholder="08xxxxxxxxxx"
                  class="w-full rounded-lg border border-gray-300 bg-gray-50 py-2.5 pl-10 pr-4 text-sm text-gray-800 placeholder:text-gray-400 focus:border-brand-300 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-700 dark:bg-white/5 dark:text-white/90 dark:placeholder:text-gray-500"
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="flex justify-end gap-3 mt-6">
      <Button variant="outline" @click="resetForm">Batal</Button>
      <Button v-if="canEdit(menuUrl)" :disabled="saving" @click="save">
        <svg
          v-if="!saving"
          width="18"
          height="18"
          viewBox="0 0 24 24"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <path d="M5 13l4 4L19 7" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
        </svg>
        {{ saving ? 'Menyimpan...' : 'Simpan' }}
      </Button>
    </div>
  </AdminLayout>
</template>

<script setup lang="ts">
import { reactive, ref } from 'vue'
import AdminLayout from '../../components/layout/AdminLayout.vue'
import PageBreadcrumb from '@/components/common/PageBreadcrumb.vue'
import Button from '@/components/ui/Button.vue'
import Toast from '@/components/ui/Toast.vue'
import FileInput from '@/components/ui/FileInput.vue'
import { LayoutDashboardIcon, HomeIcon, DocsIcon, MailIcon, SupportIcon, ChatIcon } from '@/icons'
import { updateSystemSettings, formatSettingsByGroup } from '@/api/systemSettings'
import { useToast } from '@/composables/useToast'
import { usePermission } from '@/composables/usePermission'
import type { SettingsByGroup } from '@/types/setting'

interface Props {
  settings: SettingsByGroup
}

const props = defineProps<Props>()

const { success: toastSuccess, error: toastError } = useToast()

const { canEdit } = usePermission()
const menuUrl = '/admin/system'

const tabs = [
  { key: 'informasi', label: 'Informasi Umum' },
  { key: 'kontak', label: 'Kontak' },
]

const activeTab = ref('informasi')

const initial = formatSettingsByGroup(props.settings)

const form = reactive<Record<string, string>>({})
const files: Record<string, File | null> = {}
const saving = ref(false)

function resetForm() {
  for (const key of Object.keys(initial)) {
    form[key] = initial[key]
  }
}

resetForm()

function onFileChange(key: string, event: Event) {
  const target = event.target as any
  files[key] = target.files?.[0] ?? null
}

async function save() {
  if (saving.value) return
  saving.value = true
  try {
    const payload = new FormData()
    for (const key of Object.keys(form)) {
      if (key in files) continue
      payload.append(key, form[key] ?? '')
    }
    for (const key of Object.keys(files)) {
      if (files[key]) {
        payload.append(key, files[key] as Blob)
      }
    }
    const data = await updateSystemSettings(payload)
    const next = formatSettingsByGroup(data.settings)
    for (const key of Object.keys(next)) {
      form[key] = next[key]
      initial[key] = next[key]
    }
    for (const key of Object.keys(files)) files[key] = null
    toastSuccess(data.message)
  } catch (err: any) {
    toastError(err?.response?.data?.message ?? 'Gagal menyimpan pengaturan.')
  } finally {
    saving.value = false
  }
}
</script>
