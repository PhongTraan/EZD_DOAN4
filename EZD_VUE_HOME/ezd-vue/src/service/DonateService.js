import axios from 'axios';

const axiosInstance = axios.create({
    headers: {
        'Cache-Control': 'no-cache',
    },
});

const BASE_URL = 'http://localhost:8081/api/donates/';


class DonateService {
    async saveTransaction(fromUserId,toUserId, amount) {
        const formData = new FormData();
        formData.append('fromUserId', fromUserId);
        formData.append('toUserId', toUserId);
        formData.append('amount', amount);
        try {

            const response = await axiosInstance.post(`${BASE_URL}donate`, formData, {
                headers: {
                    'Content-Type': 'multipart/form-data',
                },
            });
            console.log("create donate oke");
            return response.data;
          
        } catch (error) {
            console.error('Error Save:', error);
            throw error;
        }
    }
}
export default new DonateService();
