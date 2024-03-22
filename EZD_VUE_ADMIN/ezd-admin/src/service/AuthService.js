import axios from "axios";

const baseURL = "http://localhost:8081/api/v1"; // Thay thế bằng địa chỉ URL thực tế của máy chủ API

const axiosInstance = axios.create({
  baseURL,
  headers: {
    "Cache-Control": "no-cache",
  },
});

const AuthService = {

  async login(credentials) {
    const LOGIN_API_URL = `${baseURL}/auth/signinAdmin`; // Địa chỉ đăng nhập
    return await axiosInstance.post(LOGIN_API_URL, credentials).then((response) => {
      const token = response.data.token;
      // Lưu JWT vào localStorage hoặc Vuex state
      localStorage.setItem("token", token);
      return response;
    });
  },
  async findByEmail(email) {
    const FIND_BY_EMAIL_API_URL = `${baseURL}/auth/findByEmail?email=${email}`;
    return await axiosInstance.get(FIND_BY_EMAIL_API_URL).then((response) => {
      return response.data;
    });
  },

  async getAllUser(role) {
    try {
      const GET_ALL_USERS = `${baseURL}/auth/role?role=${role}`;
      return await axiosInstance.get(GET_ALL_USERS).then((response) => {
        return response.data;
      });
    } catch (error) {
      console.error(error);
    }
  },

  async getAllAccount() {
    try {
      const GET_ALL_USERS = `${baseURL}/auth/`;
      return await axiosInstance.get(GET_ALL_USERS).then((response) => {
        return response.data;
      });
    } catch (error) {
      console.error(error);
    }
  },


  async resetPassword(email) {
    const RESET_API_URL = `${baseURL}/auth/reset-password?email=${email}`;
    return await axiosInstance.post(RESET_API_URL).then((response) => {
      return response.data;
    });
  },
  async updatePassword(email,currentPassword,newPasword) {
    const UPDATE_PASSWORD_API_URL = `${baseURL}/auth/updatePassword?email=${email}&currentPassword=${currentPassword}&newPasword=${newPasword}`;
   
    return await axiosInstance.post(UPDATE_PASSWORD_API_URL).then((response) => {
      return response.data;
    });
  },
};

export default AuthService;