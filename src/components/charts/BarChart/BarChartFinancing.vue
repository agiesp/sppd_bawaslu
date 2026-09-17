<template>
  <div class="max-w-full overflow-x-auto custom-scrollbar">
    <div id="chartFinancing" class="-ml-5 min-w-[500px] xl:min-w-full pl-2">
      <VueApexCharts type="bar" height="300" :options="chartOptions" :series="series" />
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import VueApexCharts from 'vue3-apexcharts'

const series = ref([
  {
    name: 'PNS',
    data: [42, 38, 51, 47, 55, 49, 60, 58, 62, 66, 70, 65],
  },
  {
    name: 'Komisioner',
    data: [25, 22, 30, 28, 33, 31, 38, 36, 40, 44, 46, 42],
  },
])

const formatRupiah = (value) =>
  new Intl.NumberFormat('id-ID', {
    style: 'currency',
    currency: 'IDR',
    maximumFractionDigits: 0,
  }).format(value)

const chartOptions = ref({
  colors: ['#fb6514', '#465fff'],
  chart: {
    fontFamily: 'Outfit, sans-serif',
    type: 'bar',
    toolbar: {
      show: false,
    },
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
  },
  legend: {
    show: true,
    position: 'top',
    horizontalAlign: 'left',
    fontFamily: 'Outfit',
    markers: {
      radius: 99,
    },
  },
  yaxis: {
    title: false,
    labels: {
      formatter: (value) => `Rp ${value} jt`,
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
})
</script>