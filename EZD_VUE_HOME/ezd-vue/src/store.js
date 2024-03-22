// store.js

import { ref } from "vue";
import { jwtDecode } from "jwt-decode";
import RegisterService from "@/service/RegisterService";

export const userInfo = ref(null);

let token = localStorage.getItem("token");

if (token) {
  const decoded = jwtDecode(token);
  const userGmail = decoded.sub;

  RegisterService.findByEmail(userGmail)
    .then((response) => {
      userInfo.value = response;
    })
    .catch((error) => {
      console.error("Lỗi khi lấy thông tin người dùng: " + error);
    });
}

// Mutation để cập nhật userInfo
export const mutations = {
  setUserInfo(state, user) {
    state.userInfo = user;
  },
};

// Tạo amountPayPal là một ref
export const amountPayPal = ref(0);
