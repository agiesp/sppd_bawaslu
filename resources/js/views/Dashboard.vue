<template>
  <AdminLayout>
    <div class="space-y-6">
      <!-- Dashboard Header & Top Status Bar -->
      <div class="flex items-center justify-between">
        <h1 class="text-xl font-bold text-slate-900 tracking-tight dark:text-gray-100">Dashboard</h1>

        <div class="flex items-center gap-3">
          <div class="flex items-center gap-2 bg-white px-3 py-1.5 rounded-xl border border-slate-200 text-xs font-medium text-slate-600 shadow-sm dark:border-gray-800 dark:bg-gray-900 dark:text-gray-300">
            <span class="w-2 h-2 rounded-full bg-emerald-500"></span>
            <span>Pegawai: <strong class="text-slate-900 dark:text-gray-100">4</strong></span>
          </div>
          <div class="flex items-center gap-2 bg-white px-3 py-1.5 rounded-xl border border-slate-200 text-xs font-medium text-slate-600 shadow-sm dark:border-gray-800 dark:bg-gray-900 dark:text-gray-300">
            <span class="w-2 h-2 rounded-full bg-indigo-500"></span>
            <span>Tujuan Daerah: <strong class="text-slate-900 dark:text-gray-100">8</strong></span>
          </div>
          <!-- Team Member Avatars Stack -->
          <div class="flex -space-x-2 overflow-hidden bg-white p-1 rounded-xl border border-slate-200 shadow-sm dark:border-gray-800 dark:bg-gray-900">
            <img class="inline-block h-6 w-6 rounded-full ring-2 ring-white dark:ring-gray-900" src="https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?w=100" />
            <img class="inline-block h-6 w-6 rounded-full ring-2 ring-white dark:ring-gray-900" src="https://images.unsplash.com/photo-1517841905240-472988babdf9?w=100" />
            <img class="inline-block h-6 w-6 rounded-full ring-2 ring-white dark:ring-gray-900" src="https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=100" />
          </div>
          <button class="flex items-center gap-2 bg-orange-500 hover:bg-orange-600 text-white px-4 py-2 rounded-xl text-xs font-semibold shadow-lg shadow-orange-500/25 transition">
            <span>+ Buat SPPD</span>
          </button>
        </div>
      </div>

      <!-- Project Progress Cards Row -->
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <div
          v-for="project in projectCards"
          :key="project.title"
          class="bg-white p-5 rounded-2xl border border-slate-200/80 shadow-sm hover:shadow-md transition group dark:border-gray-800 dark:bg-gray-900"
        >
          <div class="flex items-start justify-between mb-3">
            <h3 class="font-semibold text-slate-800 text-sm group-hover:text-indigo-600 transition dark:text-gray-100">{{ project.title }}</h3>
            <span :class="['text-[10px] font-bold px-2 py-0.5 rounded-full', project.tagColor]">{{ project.tag }}</span>
          </div>
          <div class="space-y-2 mb-4">
            <div class="flex justify-between text-xs">
              <span class="text-slate-400 dark:text-gray-500">Progress Perjalanan</span>
              <span class="font-semibold text-slate-700 dark:text-gray-200">{{ project.progress }}%</span>
            </div>
            <div class="w-full bg-slate-100 h-2 rounded-full overflow-hidden dark:bg-gray-800">
              <div :class="['h-full rounded-full', project.barColor]" :style="{ width: project.progress + '%' }"></div>
            </div>
          </div>
          <div class="flex items-center justify-between pt-3 border-t border-slate-100 dark:border-gray-800">
            <div class="flex -space-x-1.5">
              <template v-for="(member, idx) in project.team" :key="idx">
                <img
                  v-if="member.url"
                  :src="member.url"
                  :alt="member.name"
                  :title="member.name"
                  class="w-5 h-5 rounded-full border border-white object-cover dark:border-gray-900"
                />
                <span
                  v-else
                  :title="member.name"
                  class="inline-flex w-5 h-5 items-center justify-center rounded-full bg-indigo-500 text-[9px] font-bold text-white border border-white dark:border-gray-900"
                >
                  {{ (member.name || '?').charAt(0).toUpperCase() }}
                </span>
              </template>
            </div>
            <span class="text-[11px] text-slate-400 font-medium dark:text-gray-500">{{ project.time }}</span>
          </div>
        </div>
      </div>

      <!-- Bottom Grid: Timeline & Tools/Widget -->
      <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">

        <!-- Develop Web App Timeline Section (2 Columns) -->
        <div class="lg:col-span-2 bg-white rounded-2xl border border-slate-200/80 p-6 shadow-sm flex flex-col justify-between dark:border-gray-800 dark:bg-gray-900">
          <div>
            <div class="flex items-center justify-between mb-4">
              <div>
                <h3 class="font-bold text-slate-900 text-base dark:text-gray-100">Jadwal Perjalanan Dinas</h3>
                <p class="text-xs text-slate-400 dark:text-gray-500">Timeline & Rencana SPPD</p>
              </div>
              <div class="flex items-center gap-2">
                <button @click="prevMonth" class="p-1.5 border border-slate-200 rounded-lg text-slate-500 hover:bg-slate-50 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-800"><svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/></svg></button>
                <span class="text-xs font-bold text-slate-700 px-2 dark:text-gray-200">{{ monthNames[currentMonth] }} {{ currentYear }}</span>
                <button @click="nextMonth" class="p-1.5 border border-slate-200 rounded-lg text-slate-500 hover:bg-slate-50 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-800"><svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/></svg></button>
              </div>
            </div>

            <!-- Day Names Header -->
            <div class="grid grid-cols-7 gap-1 mb-2 text-center">
              <div v-for="dayName in dayNames" :key="dayName" class="text-[10px] uppercase font-semibold text-slate-400 py-1 dark:text-gray-500">
                {{ dayName }}
              </div>
            </div>

            <!-- Calendar Grid -->
            <div class="grid grid-cols-7 gap-1 mb-6">
              <div v-for="(blank, index) in firstDayOfMonth" :key="'blank-'+index"></div>
              <div
                v-for="day in daysInMonth"
                :key="day"
                :class="[
                  'relative py-1.5 rounded-lg text-center transition text-xs',
                  isToday(day) ? 'bg-orange-500 text-white shadow-md shadow-orange-500/20 font-bold' :
                  hasSchedule(day) ? 'bg-indigo-100 text-indigo-700 font-medium dark:bg-indigo-900/40 dark:text-indigo-300' :
                  'bg-slate-50 text-slate-600 hover:bg-slate-100 dark:bg-gray-800 dark:text-gray-300 dark:hover:bg-gray-700'
                ]"
                :title="scheduleTooltip(day)"
              >
                {{ day }}
                <span v-if="hasSchedule(day)" class="absolute bottom-1 left-1/2 -translate-x-1/2 w-1 h-1 rounded-full bg-current opacity-70"></span>
              </div>
            </div>

            <!-- Gantt / Schedule Bars (data real dari tb_sppd) -->
            <div class="space-y-3 relative py-4">
              

              <template v-if="loadingSchedule">
                <div v-for="i in 3" :key="'skel-'+i" class="flex items-center gap-4 relative z-10">
                  <div class="w-32 h-4 rounded bg-slate-100 animate-pulse dark:bg-gray-800"></div>
                  <div class="flex-1 h-9 rounded-xl bg-slate-100 animate-pulse dark:bg-gray-800"></div>
                </div>
              </template>

              <div
                v-for="(s, idx) in monthSchedules"
                :key="s.id"
                class="flex items-center gap-4 relative z-10"
              >
                <div class="w-32 text-xs font-semibold truncate" :class="schedulePalette[idx % schedulePalette.length].text" :title="s.tujuan_daerah">{{ s.tujuan_daerah }}</div>
                <div :class="['flex-1 px-4 py-2 rounded-xl text-xs font-medium flex items-center justify-between gap-2 shadow-xs transition', schedulePalette[idx % schedulePalette.length].bar]">
                  <div class="min-w-0">
                    <span class="block truncate">{{ s.keperluan || s.nomor_sppd }}</span>
                    <span class="block text-[10px] opacity-70">{{ formatTanggal(s.tanggal_mulai) }} - {{ formatTanggal(s.tanggal_selesai) }} ({{ s.lama_hari }} hari)</span>
                  </div>
                  <div class="flex shrink-0 items-center gap-2">
                    <img
                      v-if="s.avatar_url"
                      :src="s.avatar_url"
                      :alt="s.atas_nama"
                      title="Foto pegawai"
                      class="h-7 w-7 rounded-full object-cover ring-2 ring-white dark:ring-gray-900"
                    />
                    <span
                      v-else
                      class="inline-flex h-7 w-7 items-center justify-center rounded-full text-[10px] font-bold text-white"
                      :class="schedulePalette[idx % schedulePalette.length].ring"
                      title="Foto pegawai"
                    >
                      {{ (s.atas_nama || '?').charAt(0).toUpperCase() }}
                    </span>
                    <span :class="['text-[10px] px-2 py-0.5 rounded-full font-bold', schedulePalette[idx % schedulePalette.length].pill]">{{ statusLabel(s.status) }}</span>
                  </div>
                </div>
              </div>

              <div v-if="!loadingSchedule && monthSchedules.length === 0" class="text-center text-xs text-slate-400 py-8 dark:text-gray-500">
                Tidak ada jadwal perjalanan dinas pada bulan ini.
              </div>
            </div>
          </div>
        </div>

        <!-- Right Column: Time Tracker & Upgrade Plan Widget -->
        <div class="space-y-6">

          <!-- Statistik Pembiayaan SPPD Widget -->
          <div class="bg-white rounded-2xl border border-slate-200/80 p-5 shadow-sm dark:border-gray-800 dark:bg-gray-900">
            <div class="flex items-center justify-between mb-4">
              <div>
                <span class="text-xs font-bold text-slate-400 uppercase tracking-wider dark:text-gray-500">Statistik</span>
                <h4 class="mt-1 text-sm font-bold text-slate-800 dark:text-gray-100">Pembiayaan SPPD 1 Tahun</h4>
              </div>
              <button class="text-slate-400 hover:text-slate-600 dark:text-gray-500 dark:hover:text-gray-300">...</button>
            </div>
            <BarChartFinancing :tahun="selectedTahun" />
          </div>

          <!-- Upgrade Plan Banner Card -->
          <div class="relative bg-gradient-to-br from-slate-900 via-slate-800 to-indigo-950 rounded-2xl p-5 text-white shadow-xl overflow-hidden">
            <!-- Decorative background elements -->
            <div class="absolute -right-4 -bottom-4 w-32 h-32 bg-orange-500/20 rounded-full blur-2xl"></div>

            <div class="relative z-10">
              <div class="flex items-center justify-between mb-3">
                <span class="text-xs font-semibold uppercase tracking-wider text-orange-400">Info Anggaran</span>
                <span class="text-2xl">📊</span>
              </div>
              <h4 class="font-bold text-sm mb-1">Rekap Anggaran Perjalanan</h4>
              <p class="text-xs text-slate-300 mb-4 leading-relaxed">Pantau total biaya dan rincian SPPD setiap periode.</p>

              <button class="w-full py-2.5 bg-gradient-to-r from-orange-500 to-amber-500 text-white rounded-xl text-xs font-bold shadow-lg shadow-orange-500/25 hover:opacity-95 transition">
                Lihat Rincian
              </button>
            </div>
          </div>

        </div>

      </div>
    </div>
  </AdminLayout>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, watch } from 'vue'
import AdminLayout from '../components/layout/AdminLayout.vue'
import BarChartFinancing from '@/components/charts/BarChart/BarChartFinancing.vue'
import { fetchDashboardMetrics, fetchDashboardSchedule, type DashboardMetrics, type SppdScheduleItem } from '@/api/dashboard'
import { useTahun } from '@/composables/useTahun'

// Selected year from header (shared state)
const { selectedTahun } = useTahun()

// Dashboard metrics (ASN progress & avatars)
const metrics = ref<DashboardMetrics | null>(null)

const loadMetrics = async () => {
  try {
    metrics.value = await fetchDashboardMetrics()
  } catch {
    metrics.value = null
  }
}

// Project Top Progress Cards (cards 1 & 2 are live, the rest are static)
const projectCards = computed(() => {
  const total = metrics.value?.total_sppd ?? 0
  const asn = metrics.value?.sppd_asn ?? 0
  const asnProgress = total > 0 ? Math.round((asn / total) * 100) : 0
  const komisioner = metrics.value?.sppd_komisioner ?? 0
  const komisionerProgress = total > 0 ? Math.round((komisioner / total) * 100) : 0
  const dalam = metrics.value?.sppd_dalam ?? 0
  const dalamProgress = total > 0 ? Math.round((dalam / total) * 100) : 0
  const luar = metrics.value?.sppd_luar ?? 0
  const luarProgress = total > 0 ? Math.round((luar / total) * 100) : 0

  const avatarList = (metrics.value?.asn_avatars ?? [])
  const dalamTeam = avatarList.map((a) => ({ name: a.name, url: a.avatar_url })).slice(0, 1)
  const luarTeam = avatarList.map((a) => ({ name: a.name, url: a.avatar_url })).slice(0, 2)

  return [
    {
      title: 'SPPD ASN Bawaslu',
      tag: `${asn} SPPD`,
      tagColor: 'bg-indigo-50 text-indigo-600 dark:bg-indigo-900/40 dark:text-indigo-300',
      progress: asnProgress,
      barColor: 'bg-indigo-600',
      team: (metrics.value?.asn_avatars ?? []).map((a) => ({ name: a.name, url: a.avatar_url })),
      time: `${asnProgress}% dari ${total} total`,
    },
    {
      title: 'SPPD Komisioner Bawaslu',
      tag: `${komisioner} SPPD`,
      tagColor: 'bg-orange-50 text-orange-600 dark:bg-orange-900/40 dark:text-orange-300',
      progress: komisionerProgress,
      barColor: 'bg-orange-500',
      team: (metrics.value?.komisioner_avatars ?? []).map((a) => ({ name: a.name, url: a.avatar_url })),
      time: `${komisionerProgress}% dari ${total} total`,
    },
    {
      title: 'SPPD Dalam Daerah',
      tag: `${dalam} SPPD`,
      tagColor: 'bg-purple-50 text-purple-600 dark:bg-purple-900/40 dark:text-purple-300',
      progress: dalamProgress,
      barColor: 'bg-purple-500',
      team: dalamTeam.length ? dalamTeam : [{ name: 'Staf', url: null }],
      time: `${dalamProgress}% dari ${total} total`,
    },
    {
      title: 'SPPD Luar Daerah',
      tag: `${luar} SPPD`,
      tagColor: 'bg-emerald-50 text-emerald-600 dark:bg-emerald-900/40 dark:text-emerald-300',
      progress: luarProgress,
      barColor: 'bg-emerald-500',
      team: luarTeam.length ? luarTeam : [{ name: 'ASN', url: null }],
      time: `${luarProgress}% dari ${total} total`,
    },
  ]
})

// Calendar State
const currentDate = new Date()
const currentMonth = ref(currentDate.getMonth())
const currentYear = ref(currentDate.getFullYear())

const monthNames = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember']
const dayNames = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab']

const firstDayOfMonth = computed(() => new Date(currentYear.value, currentMonth.value, 1).getDay())
const daysInMonth = computed(() => new Date(currentYear.value, currentMonth.value + 1, 0).getDate())

// Jadwal Perjalanan Dinas (data real dari tb_sppd)
const schedules = ref<SppdScheduleItem[]>([])
const loadingSchedule = ref(true)

const pad = (n: number) => String(n).padStart(2, '0')

const toIso = (year: number, month: number, day: number) =>
  `${year}-${pad(month + 1)}-${pad(day)}`

const loadSchedule = async () => {
  loadingSchedule.value = true
  try {
    const res = await fetchDashboardSchedule(currentYear.value)
    schedules.value = res.schedules ?? []
  } finally {
    loadingSchedule.value = false
  }
}

onMounted(() => {
  loadSchedule()
  loadMetrics()
})
watch(currentYear, loadSchedule)

const monthSchedules = computed(() => {
  const start = toIso(currentYear.value, currentMonth.value, 1)
  const end = toIso(currentYear.value, currentMonth.value, daysInMonth.value)
  return schedules.value.filter(
    (s) => s.tanggal_selesai >= start && s.tanggal_mulai <= end,
  )
})

const scheduleByDay = computed(() => {
  const map = new Map<number, SppdScheduleItem[]>()
  for (let day = 1; day <= daysInMonth.value; day++) {
    const iso = toIso(currentYear.value, currentMonth.value, day)
    const active = schedules.value.filter(
      (s) => iso >= s.tanggal_mulai && iso <= s.tanggal_selesai,
    )
    if (active.length) map.set(day, active)
  }
  return map
})

const hasSchedule = (day: number) => scheduleByDay.value.has(day)

const scheduleTooltip = (day: number) =>
  scheduleByDay.value
    .get(day)
    ?.map((s) => `${s.keperluan || s.nomor_sppd} (${s.tujuan_daerah})`)
    .join(' · ') ?? ''

const formatTanggal = (iso: string) => {
  const [y, m, d] = iso.split('-').map(Number)
  return `${d} ${monthNames[m - 1]} ${y}`
}

const schedulePalette = [
  { text: 'text-indigo-700 dark:text-indigo-300', bar: 'bg-indigo-50 border border-indigo-100 text-indigo-700 dark:bg-indigo-950/40 dark:border-indigo-900/50 dark:text-indigo-300', pill: 'bg-indigo-100 text-indigo-700 dark:bg-indigo-900/50 dark:text-indigo-300', ring: 'bg-indigo-500' },
  { text: 'text-orange-700 dark:text-orange-300', bar: 'bg-orange-50 border border-orange-100 text-orange-700 dark:bg-orange-950/40 dark:border-orange-900/50 dark:text-orange-300', pill: 'bg-orange-100 text-orange-700 dark:bg-orange-900/50 dark:text-orange-300', ring: 'bg-orange-500' },
  { text: 'text-emerald-700 dark:text-emerald-300', bar: 'bg-emerald-50 border border-emerald-100 text-emerald-700 dark:bg-emerald-950/40 dark:border-emerald-900/50 dark:text-emerald-300', pill: 'bg-emerald-100 text-emerald-700 dark:bg-emerald-900/50 dark:text-emerald-300', ring: 'bg-emerald-500' },
  { text: 'text-purple-700 dark:text-purple-300', bar: 'bg-purple-50 border border-purple-100 text-purple-700 dark:bg-purple-950/40 dark:border-purple-900/50 dark:text-purple-300', pill: 'bg-purple-100 text-purple-700 dark:bg-purple-900/50 dark:text-purple-300', ring: 'bg-purple-500' },
  { text: 'text-sky-700 dark:text-sky-300', bar: 'bg-sky-50 border border-sky-100 text-sky-700 dark:bg-sky-950/40 dark:border-sky-900/50 dark:text-sky-300', pill: 'bg-sky-100 text-sky-700 dark:bg-sky-900/50 dark:text-sky-300', ring: 'bg-sky-500' },
  { text: 'text-rose-700 dark:text-rose-300', bar: 'bg-rose-50 border border-rose-100 text-rose-700 dark:bg-rose-950/40 dark:border-rose-900/50 dark:text-rose-300', pill: 'bg-rose-100 text-rose-700 dark:bg-rose-900/50 dark:text-rose-300', ring: 'bg-rose-500' },
]

const statusLabel = (status: string) =>
  ({ draft: 'Draft', proses: 'Proses', selesai: 'Selesai', batal: 'Batal' })[status] ?? status

const isToday = (day: number) => {
  const today = new Date()
  return day === today.getDate() && currentMonth.value === today.getMonth() && currentYear.value === today.getFullYear()
}

const prevMonth = () => {
  if (currentMonth.value === 0) {
    currentMonth.value = 11
    currentYear.value--
  } else {
    currentMonth.value--
  }
}

const nextMonth = () => {
  if (currentMonth.value === 11) {
    currentMonth.value = 0
    currentYear.value++
  } else {
    currentMonth.value++
  }
}
</script>