import axios from 'axios'
const axiosInstance = axios.create({
    headers: {
        'Cache-Control': 'no-cache',
    },
});

const GAME_API_BASE_URL = 'http://localhost:8081/api/games/';
class GameService {


    // For Games
    async getAllGames() {
        return await axiosInstance.get(GAME_API_BASE_URL);
    }
    async getGameById(id) {
        try {
            const response = await axiosInstance.get(`${GAME_API_BASE_URL}${id}`);
            return response.data;
        } catch (error) {
            console.error('Error getting game by ID:', error);
            throw error;
        }
    }
}
export default new GameService()