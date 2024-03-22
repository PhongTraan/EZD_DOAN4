<template>
  <div>
    <start-header></start-header>
    <div class="cs-height_90 cs-height_lg_80"></div>
    <!-- Start Page Head -->
    <section class="cs-page_head cs-bg" data-src="assets/img/page_head_bg.svg">
      <div class="container">
        <div class="text-center">
          <h1 class="cs-page_title">Reset Password</h1>
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><router-link to="/">Home</router-link></li>
            <li class="breadcrumb-item active">Reset Password</li>
          </ol>
        </div>
      </div>
    </section>
    <!-- End Page Head -->
    <div class="cs-height_100 cs-height_lg_70"></div>
    <div class="container">
      <div class="row">
        <div class="col-xl-6 col-md-8 offset-xl-3 offset-md-2">
          <form class="cs-form_card cs-style1 cs-type1 cs-box_shadow cs-white_bg"  @submit.prevent="resetPasswordUser">
            <h2 class="cs-form_title">Enter your username to continue</h2>
            <div class="cs-form_field_wrap">
              <input type="email" class="cs-form_field" placeholder="Enter Your Email" v-model="email">
            </div>
            <div class="cs-height_20 cs-height_lg_20"></div>
            <button class="cs-btn cs-style1 cs-btn_lg w-100" type="submit">
              <span>Forgot Password</span>
            </button>
            <div class="cs-height_30 cs-height_lg_30"></div>
            <div class="cs-form_footer text-center">
              
             
              <hr>
              <router-link to="/login">Login </router-link>
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
import { userInfo } from "@/store";
import footerHome from "@/pages/footer.vue";
import startHeader from "@/pages/startHeader.vue";
import RegisterService from "@/service/RegisterService";
import Swal from "sweetalert2";
export default {
    data() {
    return {
      BASE_URL: process.env.BASE_URL,
      userInfoData: userInfo.value, // Gán userInfo vào biến userInfoData
      email:""
    };
  },
  components: {
    startHeader,
    footerHome,
  },
  methods: {
    async resetPasswordUser(){
       await RegisterService.resetPassword(this.email);
      console.log("email:"+this.email);
    
        Swal.fire("Login Success!", "Reset Password Success , Check Email!", "success");
        this.email="";
      
        this.$router.push("/login");
    }
  },
}
</script>

<style>

</style>