<template>
  <a :href="href" @click="handleClick"><slot /></a>
</template>

<script setup lang="ts">
import { computed, useAttrs } from 'vue'
import { router } from '@inertiajs/vue3'

const props = defineProps<{
  to?: string | Record<string, unknown>
  href?: string
}>()

const attrs = useAttrs()

const href = computed(() => {
  if (typeof props.href === 'string') return props.href
  if (typeof props.to === 'string') return props.to
  return '#'
})

const handleClick = (event: MouseEvent) => {
  event.preventDefault()
  if (typeof props.to === 'string' && props.to !== '#') {
    router.visit(props.to)
  }
}
</script>
