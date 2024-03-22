<template>
  <!--wrapper-->
  <div class="wrapper">
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
                  src="assets/images/login-images/Foget.gif"
                  class="img-fluid"
                  width="500"
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
                <div class="p-3">
                  <div class="text-center">
                    <img
                      src="assets/images/login-images/LoginPage.gif"
                      class="img-fluid"
                      width="450"
                      alt=""
                    />
                  </div>
                  <h4 class="mt-5 font-weight-bold">Forgot Password?</h4>
                  <p class="text-muted">
                    Enter your registered email ID to reset the password
                  </p>
                  <div class="form-body">
                    <form
                      @submit.prevent="resetPasswordUser"
                      class="row g-3 was-validated"
                      novalidate
                    >
                      <div class="col-12">
                        <label class="form-label">Email :</label>
                        <input
                          type="text"
                          class="form-control"
                          placeholder="example@user.com"
                          v-model="email"
                          required
                        />
                        <div v-if="emailError" class="invalid-feedback">
                          {{ emailError }}
                        </div>
                        <div v-else class="valid-feedback">Looks good!</div>
                      </div>

                      <button type="submit" class="btn btn-primary">
                        Send
                      </button>
                    </form>
                  </div>
                  <hr>
                  <div>
                    <router-link to="/login"
                      ><i class="bx bx-arrow-back me-1"></i>Back to
                      Login</router-link
                    >
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
  name: "forgotPassword",
  data() {
    return {
      BASE_URL: process.env.BASE_URL,
      email: "",

      emailError: null,
    };
  },
  methods: {
    async resetPasswordUser() {
      // Reset previous error message
      if (!this.email) {
          this.emailError = "Email is required";
        } else if (!/\S+@\S+\.\S+/.test(this.email)) {
          this.emailError = "Invalid email format";
        } else {
          this.emailError = null;
        }
      try {
        // Call resetPassword only if email is valid
        await AuthService.resetPassword(this.email);
        console.log("email:" + this.email);

        Swal.fire(
          "Login Success!",
          "Reset Password Success, Check Email!",
          "success"
        );
        this.email = "";

        this.$router.push("/login");
      } catch (error) {
        console.error("Error resetting password:", error);
        Swal.fire("Reset Password Failed", "Please try again later", "error");
      }
    },
  },
};
</script>
