<template>
  <AdminLayout>
    <div class="space-y-6">
      <!-- Dashboard Header & Top Status Bar -->
      <div class="flex items-center justify-between">
        <h1 class="text-xl font-bold text-slate-900 tracking-tight">Dashboard</h1>

        <div class="flex items-center gap-3">
          <div class="flex items-center gap-2 bg-white px-3 py-1.5 rounded-xl border border-slate-200 text-xs font-medium text-slate-600 shadow-sm">
            <span class="w-2 h-2 rounded-full bg-emerald-500"></span>
            <span>Pegawai: <strong class="text-slate-900">4</strong></span>
          </div>
          <div class="flex items-center gap-2 bg-white px-3 py-1.5 rounded-xl border border-slate-200 text-xs font-medium text-slate-600 shadow-sm">
            <span class="w-2 h-2 rounded-full bg-indigo-500"></span>
            <span>Tujuan Daerah: <strong class="text-slate-900">8</strong></span>
          </div>
          <!-- Team Member Avatars Stack -->
          <div class="flex -space-x-2 overflow-hidden bg-white p-1 rounded-xl border border-slate-200 shadow-sm">
            <img class="inline-block h-6 w-6 rounded-full ring-2 ring-white" src="https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?w=100" />
            <img class="inline-block h-6 w-6 rounded-full ring-2 ring-white" src="https://images.unsplash.com/photo-1517841905240-472988babdf9?w=100" />
            <img class="inline-block h-6 w-6 rounded-full ring-2 ring-white" src="https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=100" />
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
          class="bg-white p-5 rounded-2xl border border-slate-200/80 shadow-sm hover:shadow-md transition group"
        >
          <div class="flex items-start justify-between mb-3">
            <h3 class="font-semibold text-slate-800 text-sm group-hover:text-indigo-600 transition">{{ project.title }}</h3>
            <span :class="['text-[10px] font-bold px-2 py-0.5 rounded-full', project.tagColor]">{{ project.tag }}</span>
          </div>
          <div class="space-y-2 mb-4">
            <div class="flex justify-between text-xs">
              <span class="text-slate-400">Progress Perjalanan</span>
              <span class="font-semibold text-slate-700">{{ project.progress }}%</span>
            </div>
            <div class="w-full bg-slate-100 h-2 rounded-full overflow-hidden">
              <div :class="['h-full rounded-full', project.barColor]" :style="{ width: project.progress + '%' }"></div>
            </div>
          </div>
          <div class="flex items-center justify-between pt-3 border-t border-slate-100">
            <div class="flex -space-x-1.5">
              <img v-for="(img, idx) in project.team" :key="idx" :src="img" class="w-5 h-5 rounded-full border border-white object-cover" />
            </div>
            <span class="text-[11px] text-slate-400 font-medium">{{ project.time }}</span>
          </div>
        </div>
      </div>

      <!-- Bottom Grid: Timeline & Tools/Widget -->
      <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">

        <!-- Develop Web App Timeline Section (2 Columns) -->
        <div class="lg:col-span-2 bg-white rounded-2xl border border-slate-200/80 p-6 shadow-sm flex flex-col justify-between">
          <div>
            <div class="flex items-center justify-between mb-4">
              <div>
                <h3 class="font-bold text-slate-900 text-base">Jadwal Perjalanan Dinas</h3>
                <p class="text-xs text-slate-400">Timeline & Rencana SPPD</p>
              </div>
              <div class="flex items-center gap-2">
                <button @click="prevMonth" class="p-1.5 border border-slate-200 rounded-lg text-slate-500 hover:bg-slate-50"><svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/></svg></button>
                <span class="text-xs font-bold text-slate-700 px-2">{{ monthNames[currentMonth] }} {{ currentYear }}</span>
                <button @click="nextMonth" class="p-1.5 border border-slate-200 rounded-lg text-slate-500 hover:bg-slate-50"><svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/></svg></button>
              </div>
            </div>

            <!-- Day Names Header -->
            <div class="grid grid-cols-7 gap-1 mb-2 text-center">
              <div v-for="dayName in dayNames" :key="dayName" class="text-[10px] uppercase font-semibold text-slate-400 py-1">
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
                  'py-1.5 rounded-lg text-center transition text-xs',
                  isToday(day) ? 'bg-orange-500 text-white shadow-md shadow-orange-500/20 font-bold' :
                  hasSchedule(day) ? 'bg-indigo-100 text-indigo-700 font-medium' :
                  'bg-slate-50 text-slate-600 hover:bg-slate-100'
                ]"
              >
                {{ day }}
              </div>
            </div>

            <!-- Gantt / Schedule Bars Simulation -->
            <div class="space-y-3 relative py-4">
              <div class="absolute left-1/3 top-0 bottom-0 w-0.5 bg-orange-400 z-0"></div>

              <!-- Row 1 -->
              <div class="flex items-center gap-4 relative z-10">
                <div class="w-32 text-xs font-semibold text-slate-600 truncate">Pengawasan</div>
                <div class="flex-1 bg-indigo-50 border border-indigo-100 text-indigo-700 px-4 py-2 rounded-xl text-xs font-medium flex items-center justify-between shadow-xs">
                  <span>Verifikasi Berkas Perjalanan</span>
                  <div class="flex -space-x-1">
                    <img src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=50" class="w-4 h-4 rounded-full" />
                    <img src="https://images.unsplash.com/photo-1517841905240-472988babdf9?w=50" class="w-4 h-4 rounded-full" />
                  </div>
                </div>
              </div>

              <!-- Row 2 -->
              <div class="flex items-center gap-4 relative z-10">
                <div class="w-32 text-xs font-semibold text-slate-600 truncate">Koordinasi</div>
                <div class="flex-1 bg-purple-50 border border-purple-100 text-purple-700 px-4 py-2 rounded-xl text-xs font-medium flex items-center justify-between shadow-xs ml-12">
                  <span>Koordinasi Lapangan</span>
                  <span class="text-[10px] bg-purple-200/60 px-2 py-0.5 rounded">Berlangsung</span>
                </div>
              </div>

              <!-- Row 3 -->
              <div class="flex items-center gap-4 relative z-10">
                <div class="w-32 text-xs font-semibold text-slate-600 truncate">Sosialisasi</div>
                <div class="flex-1 bg-emerald-50 border border-emerald-100 text-emerald-700 px-4 py-2 rounded-xl text-xs font-medium flex items-center justify-between shadow-xs ml-24">
                  <span>Sosialisasi & Bimtek</span>
                  <div class="flex -space-x-1">
                    <img src="https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=50" class="w-4 h-4 rounded-full" />
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Right Column: Time Tracker & Upgrade Plan Widget -->
        <div class="space-y-6">

          <!-- Statistik Pembiayaan SPPD Widget -->
          <div class="bg-white rounded-2xl border border-slate-200/80 p-5 shadow-sm">
            <div class="flex items-center justify-between mb-4">
              <div>
                <span class="text-xs font-bold text-slate-400 uppercase tracking-wider">Statistik</span>
                <h4 class="mt-1 text-sm font-bold text-slate-800">Pembiayaan SPPD 1 Tahun</h4>
              </div>
              <button class="text-slate-400 hover:text-slate-600">...</button>
            </div>
            <BarChartFinancing />
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
import { ref, computed } from 'vue'
import AdminLayout from '../components/layout/AdminLayout.vue'
import BarChartFinancing from '@/components/charts/BarChart/BarChartFinancing.vue'

// Project Top Progress Cards
const projectCards = ref([
  {
    title: 'SPPD ASN Bawaslu',
    tag: 'Proses',
    tagColor: 'bg-indigo-50 text-indigo-600',
    progress: 75,
    barColor: 'bg-indigo-600',
    team: [
      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=50',
      'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=50'
    ],
    time: '2 jam lalu'
  },
  {
    title: 'SPPD Komisioner Bawaslu',
    tag: 'Draft',
    tagColor: 'bg-orange-50 text-orange-600',
    progress: 45,
    barColor: 'bg-orange-500',
    team: [
      'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=50',
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100'
    ],
    time: '4 jam lalu'
  },
  {
    title: 'SPPD Dalam Daerah',
    tag: 'Selesai',
    tagColor: 'bg-purple-50 text-purple-600',
    progress: 20,
    barColor: 'bg-purple-500',
    team: [
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100'
    ],
    time: '1 hari lalu'
  },
  {
    title: 'SPPD Luar Daerah',
    tag: 'Selesai',
    tagColor: 'bg-emerald-50 text-emerald-600',
    progress: 90,
    barColor: 'bg-emerald-500',
    team: [
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100'
    ],
    time: '3 jam lalu'
  },
])

// Calendar State
const currentDate = new Date()
const currentMonth = ref(currentDate.getMonth())
const currentYear = ref(currentDate.getFullYear())

const monthNames = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember']
const dayNames = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab']

const firstDayOfMonth = computed(() => new Date(currentYear.value, currentMonth.value, 1).getDay())
const daysInMonth = computed(() => new Date(currentYear.value, currentMonth.value + 1, 0).getDate())

// Mock schedule data: day of month => schedule description
const schedules = ref<Record<number, string>>({
  3: 'Verifikasi Berkas',
  7: 'Koordinasi Lapangan',
  10: 'Sosialisasi & Bimtek',
  14: 'Pengawasan',
  21: 'Rakernas',
})

const hasSchedule = (day: number) => Object.prototype.hasOwnProperty.call(schedules.value, day)

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