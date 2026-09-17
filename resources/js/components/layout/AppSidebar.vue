<template>
  <aside
    :class="[
      'fixed mt-16 flex flex-col lg:mt-0 top-0 px-5 left-0 bg-slate-900 text-slate-300 border-r border-slate-800 h-screen transition-all duration-300 ease-in-out z-99999',
      {
        'lg:w-[290px]': isExpanded || isMobileOpen || isHovered,
        'lg:w-[90px]': !isExpanded && !isHovered,
        'translate-x-0 w-[290px]': isMobileOpen,
        '-translate-x-full': !isMobileOpen,
        'lg:translate-x-0': true,
      },
    ]"
    @mouseenter="!isExpanded && (isHovered = true)"
    @mouseleave="isHovered = false"
  >
    <div
      :class="[
        'pt-4 pb-4 flex flex-col items-center',
        !isExpanded && !isHovered ? 'lg:justify-center' : 'justify-center',
      ]"
    >
      <Link href="/">
        <template v-if="isExpanded || isHovered || isMobileOpen">
          <img
            v-if="appLogo"
            class="h-15 w-auto"
            :src="appLogo"
            alt="Logo"
            width="150"
            height="40"
          />
          <template v-else>
            <img
              class="dark:hidden"
              src="/images/logo/logo.svg"
              alt="Logo"
              width="150"
              height="40"
            />
            <img
              class="hidden dark:block"
              src="/images/logo/logo-dark.svg"
              alt="Logo"
              width="150"
              height="40"
            />
          </template>
        </template>
        <img
          v-else
          src="/images/logo/logo-icon.svg"
          alt="Logo"
          width="32"
          height="32"
        />
      </Link>
      <span
        v-if="isExpanded || isHovered || isMobileOpen"
        class="mt-0.5 block max-w-[260px] text-center text-base leading-snug font-semibold"
      >
        <span class="text-white ">Sistem Informasi Perjalanan Dinas</span>
        <span style="color: #fb6514"> Integralisasi</span>
      </span>
      <div
        v-if="isExpanded || isHovered || isMobileOpen"
        class="mt-3 h-px w-full bg-gradient-to-r from-transparent via-orange-500/70 to-transparent"
      ></div>
    </div>
    <div class="flex flex-col flex-1 min-h-0 overflow-hidden relative">
      <nav
        ref="scrollNav"
        class="flex-1 overflow-y-auto custom-scrollbar"
        @scroll="checkScroll"
      >
        <div class="flex flex-col gap-4 mb-6">
          <div v-for="(menuGroup, groupIndex) in regularMenuGroups" :key="groupIndex">
            <h2
              :class="[
                'mb-4 text-xs uppercase flex leading-[20px] text-slate-500',
                !isExpanded && !isHovered
                  ? 'lg:justify-center'
                  : 'justify-start',
              ]"
            >
              <template v-if="isExpanded || isHovered || isMobileOpen">
                {{ menuGroup.title }}
              </template>
              <HorizontalDots v-else />
            </h2>
            <ul class="flex flex-col gap-4">
              <li v-for="(item, index) in menuGroup.items" :key="item.name">
                <button
                  v-if="item.subItems"
                  @click="toggleSubmenu(groupIndex, index)"
                  :class="[
                    'menu-item group w-full',
                    {
                      'menu-item-active': isSubmenuOpen(groupIndex, index),
                      'menu-item-inactive': !isSubmenuOpen(groupIndex, index),
                    },
                    !isExpanded && !isHovered
                      ? 'lg:justify-center'
                      : 'lg:justify-start',
                  ]"
                >
                  <span
                    :class="[
                      isSubmenuOpen(groupIndex, index)
                        ? 'menu-item-icon-active'
                        : 'menu-item-icon-inactive',
                    ]"
                  >
                    <component :is="item.icon" />
                  </span>
                  <span
                    v-if="isExpanded || isHovered || isMobileOpen"
                    class="menu-item-text"
                    >{{ item.name }}</span
                  >
                  <ChevronDownIcon
                    v-if="isExpanded || isHovered || isMobileOpen"
                    :class="[
                      'ml-auto w-5 h-5 transition-transform duration-200',
                      {
                        'rotate-180 text-brand-500': isSubmenuOpen(
                          groupIndex,
                          index
                        ),
                      },
                    ]"
                  />
                </button>
                <Link
                  v-else-if="item.path"
                  :href="item.path"
                  :class="[
                    'menu-item group',
                    {
                      'menu-item-active': isActive(item.path),
                      'menu-item-inactive': !isActive(item.path),
                    },
                  ]"
                >
                  <span
                    :class="[
                      isActive(item.path)
                        ? 'menu-item-icon-active'
                        : 'menu-item-icon-inactive',
                    ]"
                  >
                    <component :is="item.icon" />
                  </span>
                  <span
                    v-if="isExpanded || isHovered || isMobileOpen"
                    class="menu-item-text"
                    >{{ item.name }}</span
                  >
                </Link>
                <transition
                  @enter="startTransition"
                  @after-enter="endTransition"
                  @before-leave="startTransition"
                  @after-leave="endTransition"
                >
                  <div
                    v-show="
                      isSubmenuOpen(groupIndex, index) &&
                      (isExpanded || isHovered || isMobileOpen)
                    "
                  >
                    <ul class="mt-2 ml-9 space-y-1 border-l-[3px] border-dotted border-slate-700 pl-3">
                      <li v-for="subItem in item.subItems" :key="subItem.name">
                        <Link
                          :href="subItem.path"
                          :class="[
                            'menu-dropdown-item',
                            {
                              'menu-dropdown-item-active': isActive(
                                subItem.path
                              ),
                              'menu-dropdown-item-inactive': !isActive(
                                subItem.path
                              ),
                            },
                          ]"
                        >
                          <svg
                            v-if="!isActive(subItem.path)"
                            class="shrink-0"
                            xmlns="http://www.w3.org/2000/svg"
                            width="8"
                            height="8"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="3"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                          >
                            <line x1="5" y1="12" x2="19" y2="12"></line>
                          </svg>
                          <svg
                            v-else
                            class="shrink-0 text-brand-500"
                            xmlns="http://www.w3.org/2000/svg"
                            width="8"
                            height="8"
                            viewBox="0 0 24 24"
                            fill="#d8d8d8"
                            stroke="#d8d8d8"
                            stroke-width="3"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                          >
                            <circle cx="12" cy="12" r="10"></circle>
                          </svg>
                          {{ subItem.name }}
                          <span class="flex items-center gap-1 ml-auto">
                            <span
                              v-if="subItem.new"
                              :class="[
                                'menu-dropdown-badge',
                                {
                                  'menu-dropdown-badge-active': isActive(
                                    subItem.path
                                  ),
                                  'menu-dropdown-badge-inactive': !isActive(
                                    subItem.path
                                  ),
                                },
                              ]"
                            >
                              new
                            </span>
                            <span
                              v-if="subItem.pro"
                              :class="[
                                'menu-dropdown-badge',
                                {
                                  'menu-dropdown-badge-active': isActive(
                                    subItem.path
                                  ),
                                  'menu-dropdown-badge-inactive': !isActive(
                                    subItem.path
                                  ),
                                },
                              ]"
                            >
                              pro
                            </span>
                          </span>
                        </Link>
                      </li>
                    </ul>
                  </div>
                </transition>
              </li>
            </ul>
          </div>
          </div>
          <div class="">
            <h2
              :class="[
                'mb-4 text-xs uppercase flex leading-[20px] text-slate-500',
                !isExpanded && !isHovered
                  ? 'lg:justify-center'
                  : 'justify-start',
              ]"
            >
              <template v-if="isExpanded || isHovered || isMobileOpen">
                Keluar
              </template>
              <HorizontalDots v-else />
            </h2>
            <button
              type="button"
              @click="signOut"
              :class="[
                'menu-item group w-full cursor-pointer',
                {
                  'menu-item-inactive': true,
                },
                !isExpanded && !isHovered
                  ? 'lg:justify-center'
                  : 'lg:justify-start',
              ]"
            >
              <span class="menu-item-icon-inactive">
                <LogoutIcon class="" />
              </span>
              <span
                v-if="isExpanded || isHovered || isMobileOpen"
                class="menu-item-text "
                >Logout</span
              >
            </button>
          </div>

      </nav>

      <!-- Scroll-down indicator -->
      <div
        v-show="hasMoreScroll"
        class="scroll-indicator absolute bottom-0 left-0 right-0 flex items-center justify-center h-10 pointer-events-none z-10"
      >
        <svg class="w-4 h-4 text-slate-500 animate-bounce" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
          <path stroke-linecap="round" stroke-linejoin="round" d="M19 14l-7 7m0 0l-7-7m7 7V3" />
        </svg>
      </div>

      <footer v-if="systemMenuGroup" class="mt-auto pb-6 pt-2">
          <div>
            <h2
              :class="[
                'mb-4 text-xs uppercase flex leading-[20px] text-slate-500',
                !isExpanded && !isHovered
                  ? 'lg:justify-center'
                  : 'justify-start',
              ]"
            >
              <template v-if="isExpanded || isHovered || isMobileOpen">
                {{ systemMenuGroup.title }}
              </template>
              <HorizontalDots v-else />
            </h2>
            <ul class="flex flex-col gap-4">
              <li v-for="(item, index) in systemMenuGroup.items" :key="item.name">
                <button
                  v-if="item.subItems"
                  @click="toggleSystemSubmenu(index)"
                  :class="[
                    'menu-item group w-full',
                    {
                      'menu-item-active': isSystemSubmenuOpen(index),
                      'menu-item-inactive': !isSystemSubmenuOpen(index),
                    },
                    !isExpanded && !isHovered
                      ? 'lg:justify-center'
                      : 'lg:justify-start',
                  ]"
                >
                  <span
                    :class="[
                      isSystemSubmenuOpen(index)
                        ? 'menu-item-icon-active'
                        : 'menu-item-icon-inactive',
                    ]"
                  >
                    <component :is="item.icon" />
                  </span>
                  <span
                    v-if="isExpanded || isHovered || isMobileOpen"
                    class="menu-item-text"
                    >{{ item.name }}</span
                  >
                  <ChevronDownIcon
                    v-if="isExpanded || isHovered || isMobileOpen"
                    :class="[
                      'ml-auto w-5 h-5 transition-transform duration-200',
                      {
                        'rotate-180 text-brand-500': isSystemSubmenuOpen(index),
                      },
                    ]"
                  />
                </button>
                <Link
                  v-else-if="item.path"
                  :href="item.path"
                  :class="[
                    'menu-item group',
                    {
                      'menu-item-active': isActive(item.path),
                      'menu-item-inactive': !isActive(item.path),
                    },
                  ]"
                >
                  <span
                    :class="[
                      isActive(item.path)
                        ? 'menu-item-icon-active'
                        : 'menu-item-icon-inactive',
                    ]"
                  >
                    <component :is="item.icon" />
                  </span>
                  <span
                    v-if="isExpanded || isHovered || isMobileOpen"
                    class="menu-item-text"
                    >{{ item.name }}</span
                  >
                </Link>
                <transition
                  @enter="startTransition"
                  @after-enter="endTransition"
                  @before-leave="startTransition"
                  @after-leave="endTransition"
                >
                  <div
                    v-show="
                      isSystemSubmenuOpen(index) &&
                      (isExpanded || isHovered || isMobileOpen)
                    "
                  >
                    <ul class="mt-2 ml-9 space-y-1 border-l-[3px] border-dotted border-slate-700 pl-3">
                      <li v-for="subItem in item.subItems" :key="subItem.name">
                        <Link
                          :href="subItem.path"
                          :class="[
                            'menu-dropdown-item',
                            {
                              'menu-dropdown-item-active': isActive(
                                subItem.path
                              ),
                              'menu-dropdown-item-inactive': !isActive(
                                subItem.path
                              ),
                            },
                          ]"
                        >
                          <svg
                            v-if="!isActive(subItem.path)"
                            class="shrink-0"
                            xmlns="http://www.w3.org/2000/svg"
                            width="8"
                            height="8"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="3"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                          >
                            <line x1="5" y1="12" x2="19" y2="12"></line>
                          </svg>
                          <svg
                            v-else
                            class="shrink-0 text-brand-500"
                            xmlns="http://www.w3.org/2000/svg"
                            width="8"
                            height="8"
                            viewBox="0 0 24 24"
                            fill="#d8d8d8"
                            stroke="#d8d8d8"
                            stroke-width="3"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                          >
                            <circle cx="12" cy="12" r="10"></circle>
                          </svg>
                          {{ subItem.name }}
                          <span class="flex items-center gap-1 ml-auto">
                            <span
                              v-if="subItem.new"
                              :class="[
                                'menu-dropdown-badge',
                                {
                                  'menu-dropdown-badge-active': isActive(
                                    subItem.path
                                  ),
                                  'menu-dropdown-badge-inactive': !isActive(
                                    subItem.path
                                  ),
                                },
                              ]"
                            >
                              new
                            </span>
                            <span
                              v-if="subItem.pro"
                              :class="[
                                'menu-dropdown-badge',
                                {
                                  'menu-dropdown-badge-active': isActive(
                                    subItem.path
                                  ),
                                  'menu-dropdown-badge-inactive': !isActive(
                                    subItem.path
                                  ),
                                },
                              ]"
                            >
                              pro
                            </span>
                          </span>
                        </Link>
                      </li>
                    </ul>
                  </div>
                </transition>
              </li>
            </ul>
          </div>
          
        </footer>
    </div>
  </aside>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted, nextTick, watch } from "vue";
import { usePage, Link, useForm } from "@inertiajs/vue3";

import {
  GridIcon,
  CalenderIcon,
  UserCircleIcon,
  ChatIcon,
  MailIcon,
  DocsIcon,
  PieChartIcon,
  ChevronDownIcon,
  HorizontalDots,
  PageIcon,
  TableIcon,
  ListIcon,
  PlugInIcon,
  SettingsIcon,
  HomeIcon,
  LayoutDashboardIcon,
  UserGroupIcon,
  BoxIcon,
  FolderIcon,
  ArchiveIcon,
  TaskIcon,
  BarChartIcon,
  BellIcon,
  FlagIcon,
  StaredIcon,
  RefreshIcon,
  SupportIcon,
  MailBox,
  Message2Line,
  SendIcon,
  DraftIcon,
  PaperclipIcon,
  LogoutIcon,
} from "@/icons";
import SidebarWidget from "./SidebarWidget.vue";
import BoxCubeIcon from "@/icons/BoxCubeIcon.vue";
import { useSidebar } from "../../composables/useSidebar";

const route = usePage();

const appLogo = computed(() => route.props.appSettings?.app_logo || null);

const { isExpanded, isMobileOpen, isHovered, openSubmenu } = useSidebar();

const scrollNav = ref<HTMLElement | null>(null);
const hasMoreScroll = ref(false);

const checkScroll = () => {
  const el = scrollNav.value;
  if (!el) return;
  hasMoreScroll.value = el.scrollTop + el.clientHeight < el.scrollHeight - 10;
};

const recheckScroll = () => {
  nextTick(() => {
    checkScroll();
  });
};

watch(
  () => isExpanded.value,
  () => recheckScroll()
);

watch(
  () => isMobileOpen.value,
  () => recheckScroll()
);

onMounted(() => {
  checkScroll();
  window.addEventListener("resize", checkScroll);
});

onUnmounted(() => {
  window.removeEventListener("resize", checkScroll);
});

// Peta nama ikon (dari ref_menu.icon) ke komponen ikon yang tersedia
const iconMap = {
  GridIcon,
  BoxCubeIcon,
  CalenderIcon,
  UserCircleIcon,
  ChatIcon,
  MailIcon,
  DocsIcon,
  PieChartIcon,
  PlugInIcon,
  PageIcon,
  TableIcon,
  ListIcon,
  SettingsIcon,
  HomeIcon,
  LayoutDashboardIcon,
  UserGroupIcon,
  BoxIcon,
  FolderIcon,
  ArchiveIcon,
  TaskIcon,
  BarChartIcon,
  BellIcon,
  FlagIcon,
  StaredIcon,
  RefreshIcon,
  SupportIcon,
  MailBox,
  Message2Line,
  SendIcon,
  DraftIcon,
  PaperclipIcon,
};

const resolveIcon = (name) => {
  if (name && iconMap[name]) {
    return iconMap[name];
  }
  return GridIcon;
};

// Menu dari backend (ref_menu + role_permissions), dibagikan via Inertia
const menus = computed(() => {
  const data = route.props.menus;
  return Array.isArray(data) ? data : [];
});

const menuGroups = computed(() => {
  const systemMenu = menus.value.find((m) => m.url === "/admin/system");
  const otherMenus = menus.value.filter((m) => m.url !== "/admin/system");

  const mapMenu = (menu) => {
    const children = menu.children && menu.children.length > 0
      ? menu.children
          .filter((c) => c.url)
          .map((c) => ({ name: c.name, path: c.url, pro: false }))
      : [];

    if (children.length > 0) {
      return {
        icon: resolveIcon(menu.icon),
        name: menu.name,
        subItems: children,
      };
    }

    return {
      icon: resolveIcon(menu.icon),
      name: menu.name,
      path: menu.url || "/dashboard",
    };
  };

  const groups = [
    {
      title: "Menu",
      items: otherMenus.map(mapMenu),
    },
  ];

  if (systemMenu) {
    groups.push({
      title: "App System",
      items: [mapMenu(systemMenu)],
    });
  }

  return groups;
});

const regularMenuGroups = computed(() => {
  return menuGroups.value.filter((g) => g.title !== "App System");
});

const systemMenuGroup = computed(() => {
  return menuGroups.value.find((g) => g.title === "App System") || null;
});

const systemGroupIndex = computed(() => {
  return menuGroups.value.findIndex((g) => g.title === "App System");
});

const isActive = (path) => route.url === path;

const toggleSubmenu = (groupIndex, itemIndex) => {
  const key = `${groupIndex}-${itemIndex}`;
  openSubmenu.value = openSubmenu.value === key ? null : key;
};

const isAnySubmenuRouteActive = computed(() => {
  return menuGroups.value.some((group) =>
    group.items.some(
      (item) =>
        item.subItems && item.subItems.some((subItem) => isActive(subItem.path))
    )
  );
});

const isSubmenuOpen = (groupIndex, itemIndex) => {
  const key = `${groupIndex}-${itemIndex}`;
  return (
    openSubmenu.value === key ||
    (isAnySubmenuRouteActive.value &&
      menuGroups.value[groupIndex].items[itemIndex].subItems?.some((subItem) =>
        isActive(subItem.path)
      ))
  );
};

const toggleSystemSubmenu = (itemIndex) => {
  const key = `${systemGroupIndex.value}-${itemIndex}`;
  openSubmenu.value = openSubmenu.value === key ? null : key;
};

const isSystemSubmenuOpen = (itemIndex) => {
  const key = `${systemGroupIndex.value}-${itemIndex}`;
  const gi = systemGroupIndex.value;
  return (
    openSubmenu.value === key ||
    (isAnySubmenuRouteActive.value &&
      menuGroups.value[gi]?.items[itemIndex].subItems?.some((subItem) =>
        isActive(subItem.path)
      ))
  );
};

const startTransition = (el) => {
  el.style.height = "auto";
  const height = el.scrollHeight;
  el.style.height = "0px";
  el.offsetHeight; // force reflow
  el.style.height = height + "px";
};

const endTransition = (el) => {
  el.style.height = "";
};

const signOut = () => {
  useForm({}).post("/logout");
};
</script>
