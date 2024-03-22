import axios from "axios";

const axiosInstance = axios.create({
    
    headers: {
        'Cache-Control': 'no-cache',
    },
});
const ITEM_API_BASE_URL = 'http://localhost:8081/api/items/';

class ItemService{
    async getItem(){
        return await axiosInstance.get(ITEM_API_BASE_URL);
    }
    async getItemById(id){
        return await axiosInstance.get(`${ITEM_API_BASE_URL}${id}`);
    }
    async deleteItem(id) {
        const url = `${ITEM_API_BASE_URL}delete/${id}`;
        return await axiosInstance.delete(url);
      }
    async addItem(formData){
        try {
            const response = await axiosInstance.post(`${ITEM_API_BASE_URL}add`,formData);
            return response.data;
        } catch (error) {
            console.error('Error creating a new item:', error);
            throw error;
        }
    }
    async updateItem(id, updateItem){
        try {
            const response = await axiosInstance.put(`${ITEM_API_BASE_URL}edit/${id}`,updateItem);
            return response.data;
        } catch (error) {
            console.error('Error update a new item:', error);
            throw error;
        }
    }

    async addMultiple(fomrsData){
        try {
            const response = await axiosInstance.post(`${ITEM_API_BASE_URL}add-multiple`,fomrsData);
            return response.data;
        } catch (error) {
            console.error('Error creating a new item: ',error);
            throw error;
        }
    }
}
export default new ItemService();
