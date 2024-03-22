<template>
  <div class="sidebar-wrapper">
    <ul class="menu">
      <li v-for="menuItem in menuItems" :key="menuItem.id">
        <div
          @click="toggleSubMenu(menuItem)"
          class="menu-title"
          :class="{ 'active': menuItem.open }"
        >
          {{ menuItem.title }}
        </div>
        <ul v-if="menuItem.open" class="submenu">
          <li v-for="subMenuItem in menuItem.children" :key="subMenuItem.id">
            <router-link :to="subMenuItem.path">{{ subMenuItem.title }}</router-link>
          </li>
        </ul>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name:"testAdmin",

  data() {
    return {
      menuItems: [
        {
          id: 1,
          title: "Dashboard",
          open: false, // Trạng thái mặc định là đóng
        },
        {
          id: 2,
          title: "Quản Lý Người Dùng",
          open: false,
          children: [
            {
              id: 3,
              title: "Danh sách User",
              path: "/admin/user/listUser",
            },
            {
              id: 4,
              title: "Danh sách Idol",
              path: "/admin/user/listStaf",
            },
          ],
        },
        // Thêm các mục menu cha và mục con khác ở đây
      ],
    };
  },
  methods: {
    toggleSubMenu(menuItem) {
      menuItem.open = !menuItem.open; // Đảo ngược trạng thái mở/đóng
    },
  },
};
</script>
<style>
.sidebar-wrapper {
}

.menu {
  list-style-type: none;
  padding: 0;
}

li {
  margin: 0;
  padding: 0;
}

.submenu {
  list-style-type: none;
  padding: 0;
  margin-left: 10px; 
}

.active {
  display: block;
}
</style>
