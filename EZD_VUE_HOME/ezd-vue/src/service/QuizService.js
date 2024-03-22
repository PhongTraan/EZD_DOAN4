import axios from 'axios';

const axiosInstance = axios.create({
    headers: {
        'Cache-Control': 'no-cache',
    },
});

const QUIZ_API_BASE_URL = 'http://localhost:8081/api/quizitems/';

class QuizService {
   
    async getAllQuizzes() {
        return await axiosInstance.get(QUIZ_API_BASE_URL);
    }

   

    async getQuizById(id) {
        try {
            const response = await axiosInstance.get(`${QUIZ_API_BASE_URL}${id}`);
            return response.data;
        } catch (error) {
            console.error('Error getting quiz by ID:', error);
            throw error;
        }
    }
}

export default new QuizService();
