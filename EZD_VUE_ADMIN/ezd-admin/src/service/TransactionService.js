import axios from "axios";

const baseURL = "http://localhost:8081/api/transactions/";

const axiosInstance = axios.create({
  baseURL,
  headers: {
    "Cache-Control": "no-cache",
  },
});

const TransactionService = {
    async getTransactionsByStatus(status){
        try {
            const FIND_BY_STATUS_API_URL = `${baseURL}byStatus?status=${status}`;
            return await axiosInstance.get(FIND_BY_STATUS_API_URL).then((response) => {
              return response.data;
            });
        } catch (error) {
            console.error(error);
        }
       
    },
    async adminCheckTransaction(transactionId, newStatus) {
        try {
          const ADMIN_CHECK_API_URL = `${baseURL}admin-check?transactionId=${transactionId}&newStatus=${newStatus}`;
          await axiosInstance.put(ADMIN_CHECK_API_URL).then((response) => {
            return response.data;
          });
          console.log(`Transaction with ID ${transactionId} updated to ${newStatus}`);
        } catch (error) {
          console.error("Lỗi khi cập nhật giao dịch: ", error);
        }
      },
}


export default TransactionService;
