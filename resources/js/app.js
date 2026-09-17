import '../css/app.css'

import { createApp, h } from 'vue'
import { createInertiaApp } from '@inertiajs/vue3'
import { resolvePageComponent } from 'laravel-vite-plugin/inertia-helpers'
import VueApexCharts from 'vue3-apexcharts'
import RouterLinkCompat from '../../src/components/common/RouterLinkCompat.vue'
import EmptyState from '../../src/components/ui/EmptyState.vue'
import AppLayout from './App.vue'

createInertiaApp({
  title: (title) => (title ? `${title} | SPPD Bawaslu` : 'SPPD Bawaslu'),
  resolve: (name) =>
    resolvePageComponent(
      `./views/${name}.vue`,
      import.meta.glob('./views/**/*.vue'),
    ),
  layout: () => AppLayout,
  setup({ el, App, props, plugin }) {
    const app = createApp({ render: () => h(App, props) })

    app.use(plugin)
    app.use(VueApexCharts)
    app.component('RouterLink', RouterLinkCompat)
    app.component('EmptyState', EmptyState)

    app.mount(el)
  },
  progress: {
    color: '#4f46e5',
  },
})