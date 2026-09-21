<template>
  <div class="max-w-full overflow-x-auto custom-scrollbar">
    <div id="chartFinancing" class="-ml-5 min-w-[500px] xl:min-w-full pl-2">
      <div v-if="series.length === 0" class="flex h-[300px] items-center justify-center text-sm text-slate-400 dark:text-gray-500">
        Belum ada data pembiayaan.
      </div>
      <VueApexCharts v-else type="bar" height="300" :options="chartOptions" :series="series" />
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onBeforeUnmount, watch } from 'vue'
import VueApexCharts from 'vue3-apexcharts'
import { fetchDashboardFinancing } from '@/api/dashboard'

const props = defineProps({
  tahun: { type: [Number, String], default: null },
})

const series = ref([])
const isDark = ref(false)

const formatRupiah = (value) =>
  new Intl.NumberFormat('id-ID', {
    style: 'currency',
    currency: 'IDR',
    maximumFractionDigits: 0,
  }).format(value)

const axisColor = () => (isDark.value ? '#9ca3af' : '#6b7280')

const chartOptions = computed(() => ({
  colors: ['#fb6514', '#6366f1'],
  chart: {
    fontFamily: 'Outfit, sans-serif',
    type: 'bar',
    toolbar: {
      show: false,
    },
    foreColor: axisColor(),
  },
  plotOptions: {
    bar: {
      horizontal: false,
      columnWidth: '45%',
      borderRadius: 5,
      borderRadiusApplication: 'end',
    },
  },
  dataLabels: {
    enabled: false,
  },
  stroke: {
    show: true,
    width: 4,
    colors: ['transparent'],
  },
  xaxis: {
    categories: ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'],
    axisBorder: {
      show: false,
    },
    axisTicks: {
      show: false,
    },
    labels: {
      style: { colors: axisColor() },
    },
  },
  legend: {
    show: true,
    position: 'top',
    horizontalAlign: 'left',
    fontFamily: 'Outfit',
    labels: { colors: axisColor() },
    markers: {
      radius: 99,
    },
  },
  yaxis: {
    title: false,
    labels: {
      formatter: (value) => `Rp ${value} jt`,
      style: { colors: axisColor() },
    },
  },
  grid: {
    yaxis: {
      lines: {
        show: true,
      },
    },
  },
  fill: {
    opacity: 1,
  },
  tooltip: {
    x: {
      show: true,
    },
    y: {
      formatter: (value) => formatRupiah(value * 1000000),
    },
  },
}))

const loadData = async () => {
  try {
    const res = await fetchDashboardFinancing(props.tahun ?? new Date().getFullYear())
    series.value = res.series ?? []
  } catch {
    series.value = []
  }
}

watch(() => props.tahun, loadData)

let observer = null

onMounted(() => {
  loadData()
  const check = () => {
    isDark.value = document.documentElement.classList.contains('dark')
  }
  check()
  observer = new MutationObserver(check)
  observer.observe(document.documentElement, { attributes: true, attributeFilter: ['class'] })
})

onBeforeUnmount(() => observer?.disconnect())
</script>