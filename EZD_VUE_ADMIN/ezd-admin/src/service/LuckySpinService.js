import axios from 'axios';

const axiosInstance = axios.create({
    headers: {
        'Cache-Control': 'no-cache',
    },
});

const baseURL = 'http://localhost:8081/api/lucky-spin';


class LuckySpinService {

    async getAllLuckSpins(){
        try {

            const GET_ALL_TRANSACTION_LUCKY = `${baseURL}/`;
            return await axiosInstance.get(GET_ALL_TRANSACTION_LUCKY).then((response) => {
                return response.data;
              
            });       

        } catch (error) {
            console.error(error);
        }
    }
   
}
export default new LuckySpinService();