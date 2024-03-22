import axios from "axios";

const axiosInstance = axios.create({
    
    headers: {
        'Cache-Control': 'no-cache',
    },
});
const RANK_GAME_API_BASE_URL = 'http://localhost:8081/api/ranks/';

class RankService {

    async getRank(){
        return await axiosInstance.get(RANK_GAME_API_BASE_URL);
    }
    async getRankById(id) {
        return await axiosInstance.get(`${RANK_GAME_API_BASE_URL}${id}`);
    }

    async deleteRank(id) {
      const url = `${RANK_GAME_API_BASE_URL}delete/${id}`;
      return await axiosInstance.delete(url);
    }

    async createRank(rankData) {
        try {  
            const response = await axiosInstance.post(`${RANK_GAME_API_BASE_URL}add`,rankData);
            return response.data;
        } catch (error) {
                  console.error('Error creating a new rank:', error);
         throw error;
        }
      }

    async updateRank(id, updatedRank) {
          try {
            const response = await axiosInstance.put(`${RANK_GAME_API_BASE_URL}edit/${id}`, updatedRank);
            return response.data;
          } catch (error) {
            console.error('Error updating rank:', error);
            throw error;
          }
    }
    async getGameById(id) {
      try {
        const response = await axiosInstance.get(`${RANK_GAME_API_BASE_URL}${id}`);
        return response.data;
      } catch (error) {
        console.error('Error getting game by ID:', error);
        throw error;
      }
    }
    
}

export default new RankService();