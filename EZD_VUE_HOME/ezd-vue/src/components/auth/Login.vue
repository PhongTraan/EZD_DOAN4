<template>
  <div>
    <startHeader></startHeader>
    <div class="cs-height_90 cs-height_lg_80"></div>
    <!-- Start Page Head -->
    <section class="cs-page_head cs-bg" data-src="assets/img/page_head_bg.svg">
      <div class="container">
        <div class="text-center">
          <h1 class="cs-page_title">Login</h1>
          <ol class="breadcrumb">
            <li class="breadcrumb-item">
              <router-link to="/">Home</router-link>
            </li>
            <li class="breadcrumb-item active">Login</li>
          </ol>
        </div>
      </div>
    </section>
    <div class="cs-height_20 cs-height_lg_20"></div>
    <!-- End Page Head -->
    <div class="container">
      <div class="row">
        <div class="col-xl-6 col-md-8 offset-xl-3 offset-md-2">
          <form
            class="cs-form_card cs-style1 cs-box_shadow cs-white_bg"
            @submit.prevent="login"
          >
            <div class="cs-form_card_in">
              <h2 class="cs-form_title text-center">Sign In</h2>
              <!-- <div class="cs-form_btns">
                <a href="#" class="cs-btn cs-style2 cs-btn_lg">
                  <span><i class="fab fa-google"></i>Google</span>
                </a>
                <a href="#" class="cs-btn cs-style2 cs-btn_lg">
                  <span><i class="fab fa-facebook-f"></i>Facebook</span>
                </a>
                <a href="#" class="cs-btn cs-style2 cs-btn_lg">
                  <span><i class="fab fa-linkedin-in"></i>Linkedin</span>
                </a>
              </div> -->
              <div class="cs-height_30 cs-height_lg_30"></div>
              <div class="cs-form_field_wrap">
                <input
                  type="text"
                  v-model="userData.email"
                  class="cs-form_field"
                  placeholder="Your Email"
                />
                <!-- Thêm phần hiển thị thông báo lỗi -->
              </div>
              <div v-if="emailError" class="error-message" style="color: red">
                {{ emailError }}
              </div>
              <div class="cs-height_20 cs-height_lg_20"></div>
              <div class="cs-form_field_wrap">
                <input
                  type="password"
                  v-model="userData.password"
                  class="cs-form_field"
                  placeholder="Your password"
                />
                <!-- Thêm phần hiển thị thông báo lỗi -->
              </div>
              <div v-if="passError" class="error-message" style="color: red">
                {{ passError }}
              </div>
              <div class="cs-height_20 cs-height_lg_20"></div>
             
              <div class="cs-height_15 cs-height_lg_15"></div>
              <button class="cs-btn cs-style1 cs-btn_lg w-100" type="submit">
                <span>Sign In</span>
              </button>
              <div class="cs-height_30 cs-height_lg_30"></div>
              <div class="cs-form_footer text-center">
                No Account?
                <router-link to="/register">Register Now</router-link>
                <hr>
                <router-link to="/reset-password">Foget Password</router-link>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>

    <div class="cs-height_100 cs-height_lg_70"></div>
    <footerHome></footerHome>
  </div>
</template>

<script>
import { jwtDecode } from "jwt-decode";
import footerHome from "@/pages/footer.vue";
import startHeader from "@/pages/startHeader.vue";
import RegisterService from "@/service/RegisterService";
import Swal from "sweetalert2";
import { userInfo } from "@/store";

export default {
  name: "LoginPage",
  data() {
    return {
      userData: {
        email: "",
        password: "",
      },
      emailError: null, // Thêm biến để theo dõi lỗi email
      passError: null, // Thêm biến để theo dõi lỗi email
    };
  },

  methods: {
    validateForm() {
    this.resetErrors(); // Đặt lại tất cả các biến lỗi trước khi kiểm tra

    if (!this.userData.email) {
      this.emailError = "Email is required";
    } else {
      const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      if (!emailPattern.test(this.userData.email)) {
        this.emailError = "Invalid email format";
      }
    }

    if (!this.userData.password) {
      this.passError = "Password is required";
    } else {
      // Kiểm tra password từ 8-16 ký tự, chứa cả số và chữ cái, không có khoảng trắng
      const passwordPattern = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,16}$/;
      if (!passwordPattern.test(this.userData.password)) {
        this.passError = "Password must be 8-16 characters, contain both letters and numbers, and no spaces";
      }
    } 

    // Trả về true nếu không có lỗi, ngược lại trả về false
    return !this.emailError && !this.passError;
  },

  resetErrors() {
    this.emailError = null;
    this.passError = null;
    // Thêm các biến lỗi khác nếu cần
  },
    async login() {
      try {
        if (!this.validateForm()) {
        return; // Dừng quá trình đăng nhập nếu có lỗi
      }

        const response = await RegisterService.login(this.userData);
        const token = response.data.token;
        const decoded = jwtDecode(token);
        console.log(decoded);
        // Gán giá trị sub vào biến user

        const userGmail = decoded.sub;
        console.log("email :" + userGmail);
        // Fetch the complete Auth information
        const authInfoResponse = await RegisterService.findByEmail(userGmail);
        userInfo.value = authInfoResponse;
        console.log("userInfo:" + userInfo.value.name);
        this.$router.push("/");

        Swal.fire("Login Success!", "Login Success!", "success");
      } catch {
        Swal.fire("Login Fail!", "Login Fail!", "error");
      }
    },
  },
  components: {
    startHeader,
    footerHome,
  },
};
</script>
<style>
.formkit-inner {
  width: 100%;
}
[data-invalid] .formkit-inner {
  border-color: red;
  box-shadow: 0 0 0 1px red;
}

[data-complete] .formkit-inner {
  border-color: red;
}
</style>
