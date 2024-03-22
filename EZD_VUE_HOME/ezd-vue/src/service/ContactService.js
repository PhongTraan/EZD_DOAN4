import axios from 'axios';

const axiosInstance = axios.create({
    headers: {
        'Cache-Control': 'no-cache',
        'Content-Type': 'multipart/form-data',
    },
});

const CONTACT_API_BASE_URL = 'http://localhost:8081/api/contacts/';

class ContactService {
   
    async getAllQuizzes() {
        return await axiosInstance.get(CONTACT_API_BASE_URL);
    }

   

    async getContactById(id) {
        try {
            const response = await axiosInstance.get(`${CONTACT_API_BASE_URL}${id}`);
            return response.data;
        } catch (error) {
            console.error('Error getting quiz by ID:', error);
            throw error;
        }
    }
    async createNewContact(fullName, email, title, content) {
        
    
        const formData = new FormData();
        formData.append('fullName', fullName);
        formData.append('email', email);
        formData.append('title', title);
        formData.append('content', content);
    
        try {
          const response = await axios.post(`${CONTACT_API_BASE_URL}add`, formData);
          return response;
        } catch (error) {
          console.error('Error creating a new contact:', error);
          throw error;
        }
      }
}

export default new ContactService();
