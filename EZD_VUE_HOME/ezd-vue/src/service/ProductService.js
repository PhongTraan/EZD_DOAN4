import axios from 'axios';

const axiosInstance = axios.create({
  headers: {
    'Cache-Control': 'no-cache',
  },
});

const PRODUCT_API_BASE_URL = 'http://localhost:8081/api/products/';

class ProductService {

  // For Products
  async saveProduct(userProductId, gameProductId, roleProductId, levelProductId, genderProductId, imgProduct, price, hour, description) {
    const formData = new FormData();
    formData.append('userProductId', userProductId);
    formData.append('gameProductId', gameProductId);
    formData.append('roleProductId', roleProductId);
    formData.append('levelProductId', levelProductId);
    formData.append('genderProductId', genderProductId);
    formData.append('imgProduct', imgProduct);
    formData.append('price', price);
    formData.append('hour', hour);
    formData.append('description', description);

    try {
      const response = await axiosInstance.post(`${PRODUCT_API_BASE_URL}add`, formData,{
        headers: {
            'Content-Type': 'multipart/form-data',
        },
    });
      return response.data;
    } catch (error) {
      console.error('Error saving product:', error);
      throw error;
    }
  }

  async getProductsByUser(userProductId) {
    try {

      const FIND_BY_USER_API_URL = `${PRODUCT_API_BASE_URL}byUser/${userProductId}`;
      
     

      return await axiosInstance.get(FIND_BY_USER_API_URL).then((response) => {
        return response.data;
      });
    } catch (error) {
      console.error('Error fetching products by user:', error);
      throw error;
    }
  }

  async getAllProduct(){
    try {

    const FIND_ALL_API_URL = `${PRODUCT_API_BASE_URL}`;
    return await axiosInstance.get(FIND_ALL_API_URL).then((response) => {
      return response.data;
    });
  } catch (error) {
    console.error('Error fetching products by user:', error);
    throw error;
  }
  }
}

export default new ProductService();
