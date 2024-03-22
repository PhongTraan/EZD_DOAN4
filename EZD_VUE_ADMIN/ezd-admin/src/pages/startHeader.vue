<template>
  <!--start header -->
  <header>
    <div class="topbar d-flex align-items-center">
      <nav class="navbar navbar-expand gap-3">
        <div class="top-menu">
         <h4 style="color:rebeccapurple">Xin Chào : </h4>
        </div>
        <div class="top-menu ms-auto">
          <router-link to="/login" @click="Logout"
            ><span>Logout</span>
          </router-link>
        </div>
      </nav>
    </div>
  </header>
  <!--end header -->
</template>

<script>
import Swal from "sweetalert2";
import { userInfo } from "@/store";
export default {
  name: "startHeader",
  data() {
    return {
      BASE_URL: process.env.BASE_URL,
      user: userInfo.value,    };
  },
  
  methods: {
    Logout() {
      // Thực hiện đăng xuất bằng cách đặt lại giá trị của authInfo thành null
      localStorage.removeItem("token");
      // Điều hướng người dùng đến trang đăng nhập sau khi đăng xuất
      this.$router.push("/login");

      // Hiển thị thông báo đăng xuất thành công bằng SweetAlert2 hoặc bất kỳ cách nào bạn mong muốn
      Swal.fire({
        position: "top-end",
        icon: "success",
        title: "Logged out successfully!",
        showConfirmButton: false,
        timer: 2000,
      });
    },
  },


};
</script>
