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

    async deleteQuiz(id) {
        const url = `${QUIZ_API_BASE_URL}delete?id=${id}`;
        return await axiosInstance.delete(url);
    }

   async createNewQuiz(question, answers, correctAnswerIndex) {
        try {
            if (!question) {
                throw new Error('Question is required.');
            }

            if (!answers || answers.length === 0) {
                throw new Error('Answers are required.');
            }

            const formData = new FormData();
            formData.append('question', question);
            formData.append('answers', JSON.stringify(answers));
            formData.append('correctAnswerIndex', correctAnswerIndex);

            const response = await axiosInstance.post(`${QUIZ_API_BASE_URL}add`, formData);
            return response.data;
        } catch (error) {
            console.error('Error creating a new quiz:', error);
            throw error;
        }
    }
    
    async editQuiz(id, question, answers, correctAnswerIndex) {
        const formData = new FormData();
        formData.append('question', question);
        formData.append('answers', JSON.stringify(answers));
        formData.append('correctAnswerIndex', correctAnswerIndex);
    
        try {
            const response = await axios.put(`${QUIZ_API_BASE_URL}update?id=${id}`, formData, {
                headers: {
                    'Content-Type': 'multipart/form-data',
                },
            });
    
            return response.data;
        } catch (error) {
            console.error('Error editing the quiz:', error);
            throw error;
        }
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
