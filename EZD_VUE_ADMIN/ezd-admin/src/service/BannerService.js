import axios from 'axios';

const axiosInstance = axios.create({
    headers: {
        'Cache-Control': 'no-cache',
    },
});

const BANNER_API_BASE_URL = 'http://localhost:8081/api/banners/';

class BannerService {
   
    async getAllBanners() {
        return await axiosInstance.get(BANNER_API_BASE_URL);
    }

    async deleteBanner(id) {
        const url = `${BANNER_API_BASE_URL}delete/${id}`;
        return await axiosInstance.delete(url);
    }

    async createNewBanner(name, title, image) {
        if (!name) {
            throw new Error('Name of the banner is required.');
        }
    
        if (!title) {
            throw new Error('Title is required.');
        }
    
        if (!image) {
            throw new Error('Image is required.');
        }
    
        const formData = new FormData();
        formData.append('name', name);
        formData.append('title', title);
        formData.append('image', image);
    
        try {
            const response = await axiosInstance.post(`${BANNER_API_BASE_URL}add`, formData);
            return response.data;
        } catch (error) {
            console.error('Error creating a new banner:', error);
            throw error;
        }
    }
    
    async editBanner(id, name, title, image) {
        const formData = new FormData();
        formData.append('name', name);
        formData.append('title', title);
        formData.append('image', image);
    
        try {
            const response = await axios.put(`${BANNER_API_BASE_URL}edit/${id}`, formData, {
                headers: {
                    'Content-Type': 'multipart/form-data',
                },
            });
    
            return response.data;
        } catch (error) {
            console.error('Error editing the banner:', error);
            throw error;
        }
    }

    async getBannerById(id) {
        try {
            const response = await axiosInstance.get(`${BANNER_API_BASE_URL}${id}`);
            return response.data;
        } catch (error) {
            console.error('Error getting banner by ID:', error);
            throw error;
        }
    }
    async changeStatus(bannerId, status) {
        const formData = new FormData();
        formData.append('status', status);
    
        try {
          const response = await axios.put(`${BANNER_API_BASE_URL}changeStatus/${bannerId}`, formData, {
            headers: {
              'Content-Type': 'multipart/form-data',
            },
          });
    
          return response.data; // Trả về phản hồi từ máy chủ
        } catch (error) {
          console.error('Error changing the status:', error);
          throw error;
        }
      }
}

export default new BannerService();
