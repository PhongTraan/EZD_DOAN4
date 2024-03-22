<template lang="">
  <div>
    <startHeader> </startHeader>
    <div class="cs-height_90 cs-height_lg_80"></div>
    <!-- Start Page Head -->
    <section class="cs-page_head cs-bg" data-src="assets/img/page_head_bg.svg">
      <div class="container">
        <div class="text-center">
          <h1 class="cs-page_title">Register</h1>
          <ol class="breadcrumb">
            <li class="breadcrumb-item">
              <router-link to="/">Home</router-link>
            </li>

            <li class="breadcrumb-item active">Register</li>
          </ol>
        </div>
      </div>
    </section>
    <div class="cs-height_20 cs-height_lg_20"></div>
    <!-- End Page Head -->
    <div class="container">
      <div class="row">
        <div class="col-xl-6 col-md-8 offset-xl-3 offset-md-2" >
          <form class="cs-form_card cs-style1 cs-box_shadow cs-white_bg"   @submit.prevent="registerUser" >
            <div class="cs-form_card_in">
              <h2 class="cs-form_title text-center">Create Account</h2>
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
                  class="cs-form_field"
                  v-model="userData.name"
                  placeholder="Username"
                  style="background-color:#617bb8 ; "
                />
              </div>
              <div v-if="nameError" class="error-message" style="color: red">
                {{ nameError }}
              </div>
              <div class="cs-height_20 cs-height_lg_20"></div>
              <div class="cs-form_field_wrap">
                <input
                  type="email"
                  class="cs-form_field"
                  v-model="userData.email"
                  placeholder="Your Email"
                  style="background-color:#617bb8 ;"
                />
              </div>
              <div v-if="emailError" class="error-message" style="color: red">
                {{ emailError }}
              </div>
              <div class="cs-height_20 cs-height_lg_20"></div>
              <div class="cs-form_field_wrap">
                <input
                  type="date"
                  class="cs-form_field"
                  v-model="userData.birthday"
                
                  style="background-color:#617bb8 ;"
                  
                />
              </div>
              <div
                v-if="birthdayError"
                class="error-message"
                style="color: red"
              >
                {{ birthdayError }}
              </div>
              <div class="cs-height_20 cs-height_lg_20"></div>
              <div class="cs-form_field_wrap">
                <input
                  type="password"
                  class="cs-form_field"
                  v-model="userData.password"
                  placeholder="Set your password"
                  style="background-color:#617bb8 ;"
                />
              </div>
              <div class="cs-height_20 cs-height_lg_20"></div>
              <div v-if="passError" class="error-message" style="color: red">
                {{ passError }}
              </div>
              <div class="cs-form_field_wrap">
                <input
                  type="password"
                  class="cs-form_field"
                  v-model="confirmPassword"
                  placeholder="Confirm password"
                  style="background-color:#617bb8 ;"
                />
              </div>
              <div class="cs-height_20 cs-height_lg_20"></div>
              <div
                v-if="confirmPassError"
                class="error-message"
                style="color: red"
              >
                {{ confirmPassError }}
              </div>

              <div class="cs-height_20 cs-height_lg_20"></div>
              <button class="cs-btn cs-style1 cs-btn_lg w-100" type="submit">
                <span>Register Now</span>
              </button>
              <div class="cs-height_30 cs-height_lg_30"></div>
              <div class="cs-form_footer text-center">
                Have an account? <router-link to="/login">Log In</router-link>
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
import footerHome from "@/pages/footer.vue";
import startHeader from "@/pages/startHeader.vue";
import AuthService from "@/service/RegisterService";
// import { useRouter } from "vue-router"; // Sử dụng useRouter thay vì useRoute
import Swal from "sweetalert2";

export default {
  name: "RegisterPage",

  components: {
    startHeader,
    footerHome,
  },
  data() {
    return {
      userData: {
        name: "",
        email: "",
        password: "",
        birthday: "",
      },
      nameError: "",
      emailError: "",
      birthdayError: "",
      passError: "",
      confirmPassError: "",
    };
  },
  methods: {
    validateForm() {
      this.resetErrors(); // Đặt lại tất cả các biến lỗi trước khi kiểm tra

      if (!this.userData.name) {
        this.nameError = "Username is required";
      }

      if (!this.userData.email) {
        this.emailError = "Email is required";
      } else {
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailPattern.test(this.userData.email)) {
          this.emailError = "Invalid email format";
        }
      }

      if (!this.userData.birthday) {
        this.birthdayError = "Birthday is required";
      } else {
        const birthdayDate = new Date(this.userData.birthday);
        const currentDate = new Date();
        const age = currentDate.getFullYear() - birthdayDate.getFullYear();

        if (age < 16) {
          this.birthdayError = "You must be at least 16 years old";
        }
      }

      if (!this.userData.password) {
        this.passError = "Password is required";
      } else {
        // Kiểm tra password từ 8-16 ký tự, chứa cả số và chữ cái, không có khoảng trắng
        const passwordPattern = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,16}$/;
        if (!passwordPattern.test(this.userData.password)) {
          this.passError =
            "Password must be 8-16 characters, contain both letters and numbers, and no spaces";
        }
      }

      if (this.userData.password !== this.confirmPassword) {
        this.confirmPassError = "Passwords do not match";
      }

      // Trả về true nếu không có lỗi, ngược lại trả về false
      return (
        !this.nameError &&
        !this.emailError &&
        !this.birthdayError &&
        !this.passError &&
        !this.confirmPassError
      );
    },

    resetErrors() {
      this.nameError = null;
      this.emailError = null;
      this.birthdayError = null;
      this.passError = null;
      this.confirmPassError = null;
      // Thêm các biến lỗi khác nếu cần
    },
    async registerUser() {
      try {
        if (!this.validateForm()) {
          return; // Dừng quá trình đăng ký nếu có lỗi
        }
        const response = await AuthService.register(this.userData);
        if (response.id) {
          this.$router.push("/login");
          Swal.fire("Sign Up Success!", "Sign Up Success!!", "success");
        }
      } catch (error) {
        if (
          error.response &&
          error.response.status === 400 &&
          error.response.data.message === "Email đã tồn tại"
        ) {
          // Xử lý trường hợp Email đã tồn tại
          Swal.fire("Sign Up Error!", "Email Đã Tồn Tại !", "error");
        } else {
          // Xử lý các lỗi khác
          Swal.fire("Sign Up Error!", "Sign Up Error !", "error");
        }
      }
    },
  },
};
</script>
