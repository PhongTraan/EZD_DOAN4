import axios from 'axios';

const axiosInstance = axios.create({
    headers: {
        'Cache-Control': 'no-cache',
    },
});

const TRANSACTION_API_BASE_URL = 'http://localhost:8081/api/transactions/';


class TransactionService {
    async saveTransaction(userId, amount) {
        const formData = new FormData();
        formData.append('userId', userId);
        formData.append('amount', amount);
        try {

            const response = await axiosInstance.post(`${TRANSACTION_API_BASE_URL}save`, formData, {
                headers: {
                    'Content-Type': 'multipart/form-data',
                },
            });
            return response.data;
        } catch (error) {
            console.error('Error Save:', error);
            throw error;
        }
    }
}
export default new TransactionService();
