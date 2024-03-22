import axios from "axios";

const baseURL = "http://localhost:8081/api/become-forms/";

const axiosInstance = axios.create({
  baseURL,
  headers: {
    "Cache-Control": "no-cache",
  },
});

const BecomeIdolService = {
    async getBecomeListByStatus(status){
        try {
            const FIND_BY_STATUS_API_URL = `${baseURL}byStatus?status=${status}`;
            return await axiosInstance.get(FIND_BY_STATUS_API_URL).then((response) => {
              return response.data;
            });
        } catch (error) {
            console.error(error);
        }
       
    },
    async adminCheckTransaction(id, newStatus) {
        try {
          const ADMIN_CHECK_API_URL = `${baseURL}admin-check?id=${id}&newStatus=${newStatus}`;
          await axiosInstance.put(ADMIN_CHECK_API_URL).then((response) => {
            return response.data;
          });
          console.log(`BecomeForm with ID ${id} updated to ${newStatus}`);
        } catch (error) {
          console.error("Lỗi khi cập nhật giao dịch: ", error);
        }
      },
}


export default BecomeIdolService;
