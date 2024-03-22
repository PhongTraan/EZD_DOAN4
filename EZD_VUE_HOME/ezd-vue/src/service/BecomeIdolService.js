import axios from 'axios';

const axiosInstance = axios.create({
    headers: {
        'Cache-Control': 'no-cache',
    },
});

const BECOME_API_BASE_URL = 'http://localhost:8081/api/become-forms/';


class BecomeService {
    async saveTransaction(fullName, birthDay,street,imgBefore,imgAfter,imgAvarta,imgRank,decription,
        url_faceBook,
        url_youtube,userId
        ) {
        const formData = new FormData();
        formData.append('fullName', fullName);
        formData.append('birthDay', birthDay);
        formData.append('street', street);
        formData.append('imgBefore', imgBefore);
        formData.append('imgAfter', imgAfter);
        formData.append('imgAvarta', imgAvarta);
        formData.append('imgRank', imgRank);
        formData.append('decription', decription);
        formData.append('url_faceBook', url_faceBook);
        formData.append('url_youtube', url_youtube);
        formData.append('userId', userId);

        
        try {

            const response = await axiosInstance.post(`${BECOME_API_BASE_URL}add`, formData, {
                headers: {
                    'Content-Type': 'multipart/form-data',
                },
            });
            console.log("Add Oke");
            return response.data;
          
        } catch (error) {
            console.error('Error Save:', error);
            throw error;
        }
    }
}
export default new BecomeService();
