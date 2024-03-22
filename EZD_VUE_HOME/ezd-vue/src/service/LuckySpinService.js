import axios from 'axios';

const axiosInstance = axios.create({
    headers: {
        'Cache-Control': 'no-cache',
    },
});

const baseURL = 'http://localhost:8081/api/lucky-spin';


class LuckySpinService {

    async getUserLuckyPoint(userId){
        try {

            const GET_TRANSACTION_LUCKY = `${baseURL}/user/${userId}`;
            return await axiosInstance.get(GET_TRANSACTION_LUCKY).then((response) => {
                return response.data;
              
            });       

        } catch (error) {
            console.error(error);
        }
    }
    async createLuckyPoint(userId, point) {
        try {

            const CREATE_LUCKY_POINT_API = `${baseURL}/create?userId=${userId}&point=${point}`;
            return await axiosInstance.post(CREATE_LUCKY_POINT_API).then((response) => {
                return response.data;
              
            });
          

        } catch (error) {
            console.error(error);
        }
    }
}
export default new LuckySpinService();
