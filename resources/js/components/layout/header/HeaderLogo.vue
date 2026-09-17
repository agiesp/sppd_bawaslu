<template>
  <Link href="/" class="flex items-center justify-center py-0 w-full">
    <img v-if="logo" class="h-20 w-full object-contain" :src="logo" alt="Logo" />
    <template v-else>
      <img class="h-20 w-full object-contain dark:hidden" src="/images/logo/logo.svg" alt="Logo" />
      <img class="h-20 w-full object-contain hidden dark:block" src="/images/logo/logo-dark.svg" alt="Logo" />
    </template>
  </Link>
</template>

<script setup>
import { Link, usePage } from '@inertiajs/vue3'
import { computed } from 'vue'

const page = usePage()
const logo = computed(() => page.props.appSettings?.app_logo || null)
</script>
