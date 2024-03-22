<template>
  <div>
    <div class="section-authentication-cover">
      <div class="">
        <div class="row g-0">
          <div
            class="col-12 col-xl-7 col-xxl-8 auth-cover-left align-items-center justify-content-center d-none d-xl-flex"
          >
            <div
              class="card shadow-none bg-transparent shadow-none rounded-0 mb-0"
            >
              <div class="card-body">
                <img
                  src="assets/images/login-images/EZ.gif"
                  class="img-fluid"
                  width="650"
                  alt=""
                />
              </div>
            </div>
          </div>

          <div
            class="col-12 col-xl-5 col-xxl-4 auth-cover-right align-items-center justify-content-center"
          >
            <div class="card rounded-0 m-3 shadow-none bg-transparent mb-0">
              <div class="card-body p-sm-5">
                <div class="">
                  <div class="text-center">
                    <img
                      src="assets/images/login-images/LoginPage.gif"
                      class="img-fluid"
                  width="450"
                      alt=""
                    />
                  </div>
                  <div class="text-center mb-4">
                    <h4 class=""><strong>Welcome to EZG Admin</strong></h4>
                  </div>
                  <div class="form-body">
                    <form
                      class="row g-3 was-validated"
                      @submit.prevent="login"
                      novalidate
                    >
                      <div class="col-12">
                        <label for="inputEmailAddress" class="form-label"
                          >Email</label
                        >
                        <input
                          type="email"
                          class="form-control"
                          id="inputEmailAddress"
                          placeholder="Please Input Email"
                          v-model="userData.email"
                          required
                        />
                        <div v-if="emailError" class="invalid-feedback">
                          {{ emailError }}
                        </div>
                        <div v-else class="valid-feedback">Looks good!</div>
                      </div>

                      <div class="col-12">
                        <label for="inputChoosePassword" class="form-label"
                          >Password</label
                        >
                        <div class="input-group">
                          <input
                            type="password"
                            class="form-control"
                            id="inputChoosePassword"
                            v-model="userData.password"
                            placeholder="Enter Password"
                            required
                          />
                          <div v-if="passwordError" class="invalid-feedback">
                            {{ passwordError }}
                          </div>
                          <div v-else class="valid-feedback">Looks good!</div>
                        </div>
                      </div>

                     
                      <div class="col-12">
                        <div class="d-grid">
                          <button type="submit" class="btn btn-primary">
                            Sign in
                          </button>
                        </div>
                      </div>
                    </form>
                    <hr />
                    <div class="col-md-12 text-center">
                      <router-link to="/reset-pass"
                        >Forgot Password ?</router-link
                      >
                    </div>
                  </div>
              
                </div>
              </div>
            </div>
          </div>
        </div>
        <!--end row-->
      </div>
    </div>
  </div>
  <!--end wrapper-->
</template>

<script>
import Swal from "sweetalert2";
import AuthService from "@/service/AuthService";
export default {
  name: "loginAdmin",
  data() {
    return {
      BASE_URL: process.env.BASE_URL,

      userData: {
        email: null,
        password: "",
      },
      emailError: null,
      passwordError: null,

    };
  },
  methods: {
    async login() {
      try {
        // Kiểm tra trường email
        if (!this.userData.email) {
          this.emailError = "Email is required";
        } else if (!/\S+@\S+\.\S+/.test(this.userData.email)) {
          this.emailError = "Invalid email format";
        } else {
          this.emailError = null;
        }

        // Kiểm tra trường password
        if (!this.userData.password) {
          this.passwordError = "Password is required";
        } else {
          this.passwordError = null;
        }

        // Nếu có lỗi, không thực hiện đăng nhập
        if (this.emailError || this.passwordError) {
          return;
        }
        console.log(this.userData.email + this.userData.password);

        const response = await AuthService.login(this.userData);
        const token = response.data.token;

        // Lưu JWT vào localStorage hoặc Vuex state
        localStorage.setItem("token", token);
        console.log(token);

        Swal.fire({
          position: "top-end",
          icon: "success",
          title: "Log In successfully!",
          showConfirmButton: false,
          timer: 2000,
        }).then(() => {
          // Chuyển hướng sau khi người dùng xác nhận thông báo
          window.location.href = "/";
        });
      } catch {
        Swal.fire("Login Fail!", "Email or password not wrong!", "error");
      }
    },
  },
};
</script>
