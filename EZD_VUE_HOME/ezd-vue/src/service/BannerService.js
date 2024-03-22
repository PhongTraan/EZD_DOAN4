import axios from 'axios' ; 

const axiosInstance = axios.create({
    headers:{
        'Cache-Control' :'no-cache',
    },
});

const BANNER_API_BASE_URL = "http://localhost:8081/api/banners/";
 
class BannerService {
    async getAllBanners (){
        return await axiosInstance.get(BANNER_API_BASE_URL);
    }
}

export default new BannerService()