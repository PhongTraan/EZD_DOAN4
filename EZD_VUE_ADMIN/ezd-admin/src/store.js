import { ref } from 'vue';

import { jwtDecode } from "jwt-decode";
import AuthService from "@/service/AuthService";

// Khai báo userInfo là một biến tham chiếu với giá trị ban đầu là null

export let userInfo = ref(null);

  let token = localStorage.getItem("token");

  // Kiểm tra nếu token tồn tại
  if (token) {
    const decoded = jwtDecode(token);
    const userGmail = decoded.sub;

    // Lấy dữ liệu người dùng từ API dựa trên email
    AuthService.findByEmail(userGmail)
      .then((response) => {
        // Gán dữ liệu cho userInfo
        userInfo.value = response;
      
        // Gán các trường dữ liệu khác tại đây nếu cần
      })
      .catch((error) => {
        console.error("Lỗi khi lấy thông tin người dùng: " + error);
      });
  }
  // Mutation để cập nhật userInfo
