<template>
  <div ref="searchBarRef" class="hidden lg:block">
    <div class="relative">
      <button
        class="absolute -translate-y-1/2 left-4 top-1/2"
        tabindex="-1"
        aria-hidden="true"
      >
        <svg
          class="fill-gray-500 dark:fill-gray-400"
          width="20"
          height="20"
          viewBox="0 0 20 20"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <path
            fill-rule="evenodd"
            clip-rule="evenodd"
            d="M3.04175 9.37363C3.04175 5.87693 5.87711 3.04199 9.37508 3.04199C12.8731 3.04199 15.7084 5.87693 15.7084 9.37363C15.7084 12.8703 12.8731 15.7053 9.37508 15.7053C5.87711 15.7053 3.04175 12.8703 3.04175 9.37363ZM9.37508 1.54199C5.04902 1.54199 1.54175 5.04817 1.54175 9.37363C1.54175 13.6991 5.04902 17.2053 9.37508 17.2053C11.2674 17.2053 13.003 16.5344 14.357 15.4176L17.177 18.238C17.4699 18.5309 17.9448 18.5309 18.2377 18.238C18.5306 17.9451 18.5306 17.4703 18.2377 17.1774L15.418 14.3573C16.5365 13.0033 17.2084 11.2669 17.2084 9.37363C17.2084 5.04817 13.7011 1.54199 9.37508 1.54199Z"
            fill=""
          />
        </svg>
      </button>

      <input
        ref="searchInputRef"
        v-model="query"
        type="text"
        placeholder="Cari menu..."
        class="dark:bg-dark-900 h-11 w-full rounded-lg border border-gray-200 bg-transparent py-2.5 pl-12 pr-14 text-sm text-gray-800 shadow-theme-xs placeholder:text-gray-400 focus:border-brand-300 focus:outline-hidden focus:ring-3 focus:ring-brand-500/10 dark:border-gray-800 dark:bg-gray-900 dark:bg-white/[0.03] dark:text-white/90 dark:placeholder:text-white/30 dark:focus:border-brand-800 xl:w-[430px]"
        @focus="open = true"
        @click="open = true"
        @input="resetActiveIndex"
        @keydown.down.prevent="moveSelection(1)"
        @keydown.up.prevent="moveSelection(-1)"
        @keydown.enter.prevent="goToSelected"
        @keydown.esc="closeResults"
      />

      <button
        class="absolute right-2.5 top-1/2 inline-flex -translate-y-1/2 items-center gap-0.5 rounded-lg border border-gray-200 bg-gray-50 px-[7px] py-[4.5px] text-xs -tracking-[0.2px] text-gray-500 dark:border-gray-800 dark:bg-white/[0.03] dark:text-gray-400"
        @click="focusSearch"
      >
        <span> ⌘ </span>
        <span> K </span>
      </button>

      <div
        v-if="open"
        class="absolute left-0 z-50 mt-2 w-full overflow-hidden rounded-xl border border-gray-200 bg-white shadow-theme-xl dark:border-gray-800 dark:bg-gray-900"
      >
        <p
          v-if="filteredItems.length === 0"
          class="px-4 py-8 text-center text-sm text-gray-500 dark:text-gray-400"
        >
          Tidak ada menu yang cocok.
        </p>
        <ul v-else class="max-h-80 overflow-y-auto py-2">
          <li v-for="(item, index) in filteredItems" :key="item.id">
            <button
              class="flex w-full items-center gap-3 px-4 py-2.5 text-left text-sm text-gray-700 dark:text-gray-300"
              :class="
                index === activeIndex
                  ? 'bg-brand-50 text-brand-600 dark:bg-white/[0.06] dark:text-white'
                  : 'hover:bg-gray-50 dark:hover:bg-white/[0.04]'
              "
              @mouseenter="activeIndex = index"
              @click="goToItem(item)"
            >
              <svg
                class="shrink-0 fill-current"
                :class="
                  index === activeIndex
                    ? 'text-brand-500'
                    : 'text-gray-400 dark:text-gray-500'
                "
                width="18"
                height="18"
                viewBox="0 0 24 24"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  fill-rule="evenodd"
                  clip-rule="evenodd"
                  d="M4 4.5C4 3.11929 5.11929 2 6.5 2H12V7.5C12 8.88071 13.1193 10 14.5 10H20V19.5C20 20.8807 18.8807 22 17.5 22H6.5C5.11929 22 4 20.8807 4 19.5V4.5Z"
                  fill=""
                />
                <path
                  fill-rule="evenodd"
                  clip-rule="evenodd"
                  d="M13.75 2.43934L18.5607 7.25L13.75 7.25V2.43934Z"
                  fill=""
                />
              </svg>
              <span class="truncate">{{ item.name }}</span>
              <span
                v-if="item.group"
                class="ml-auto shrink-0 text-xs text-gray-400 dark:text-gray-500"
              >
                {{ item.group }}
              </span>
            </button>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, onMounted, onUnmounted, ref } from 'vue'
import { router, usePage } from '@inertiajs/vue3'

interface MenuItem {
  id: number
  name: string
  icon: string | null
  url: string | null
  children?: MenuItem[]
}

interface FlatMenuItem {
  id: number
  name: string
  url: string
  group: string | null
}

const page = usePage()
const searchBarRef = ref<HTMLElement | null>(null)
const searchInputRef = ref<HTMLInputElement | null>(null)
const query = ref('')
const open = ref(false)
const activeIndex = ref(0)

const menus = computed<MenuItem[]>(() => {
  const data = page.props.menus
  return Array.isArray(data) ? (data as MenuItem[]) : []
})

const flatItems = computed<FlatMenuItem[]>(() => {
  const items: FlatMenuItem[] = []
  for (const menu of menus.value) {
    const children = (menu.children ?? []).filter((c) => c.url)
    if (children.length > 0) {
      for (const child of children) {
        items.push({
          id: child.id,
          name: child.name,
          url: child.url!,
          group: menu.name,
        })
      }
    } else if (menu.url) {
      items.push({
        id: menu.id,
        name: menu.name,
        url: menu.url,
        group: null,
      })
    }
  }
  return items
})

const filteredItems = computed<FlatMenuItem[]>(() => {
  const q = query.value.trim().toLowerCase()
  if (!q) return flatItems.value
  return flatItems.value.filter(
    (item) =>
      item.name.toLowerCase().includes(q) ||
      (item.group ?? '').toLowerCase().includes(q),
  )
})

const resetActiveIndex = () => {
  activeIndex.value = 0
}

const moveSelection = (step: number) => {
  const total = filteredItems.value.length
  if (total === 0) return
  activeIndex.value = (activeIndex.value + step + total) % total
}

const goToSelected = () => {
  const item = filteredItems.value[activeIndex.value]
  if (item) goToItem(item)
}

const goToItem = (item: FlatMenuItem) => {
  open.value = false
  query.value = ''
  router.visit(item.url)
}

const closeResults = () => {
  open.value = false
  const input = searchInputRef.value
  if (input) input.blur()
}

const focusSearch = () => {
  const input = searchInputRef.value
  if (input) {
    input.focus()
    open.value = true
  }
}

const handleGlobalKeydown = (event: KeyboardEvent) => {
  if ((event.metaKey || event.ctrlKey) && event.key.toLowerCase() === 'k') {
    event.preventDefault()
    focusSearch()
  }
}

const handleClickOutside = (event: MouseEvent) => {
  if (searchBarRef.value && !searchBarRef.value.contains(event.target as Node)) {
    open.value = false
  }
}

onMounted(() => {
  document.addEventListener('keydown', handleGlobalKeydown)
  document.addEventListener('click', handleClickOutside)
})

onUnmounted(() => {
  document.removeEventListener('keydown', handleGlobalKeydown)
  document.removeEventListener('click', handleClickOutside)
})
</script>