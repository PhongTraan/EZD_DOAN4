import axios from 'axios';

const axiosInstance = axios.create({
    headers: {
        'Cache-Control': 'no-cache',
    },
});
const LEVEL_GAME_API_BASE_URL = 'http://localhost:8081/api/levels/';

const GENDER_GAME_API_BASE_URL = 'http://localhost:8081/api/genders/';

const ROLE_GAME_API_BASE_URL = 'http://localhost:8081/api/gameroles/';

class ForGameService {
     // for Level of Game
     async getAllLevelGames() {
        return await axiosInstance.get(LEVEL_GAME_API_BASE_URL);
    }
    async createLevelGame(name) {
        const formData = new FormData();
        formData.append('name', name);
    
        try {
          const response = await axiosInstance.post(LEVEL_GAME_API_BASE_URL + 'add', formData);
          return response.data;
        } catch (error) {
          console.error('Error creating a new level game:', error);
          throw error;
        }
      }
 
      async deleteLevelGame(id) {
        const url = LEVEL_GAME_API_BASE_URL + `delete/${id}`;
        return await axiosInstance.delete(url);
      }

   // Gender Game
    async getAllGenderGames() {
        return await axiosInstance.get(GENDER_GAME_API_BASE_URL);
    }
    async createGenderGame(name) {
        const formData = new FormData();
        formData.append('name', name);
    
        try {
          const response = await axiosInstance.post(GENDER_GAME_API_BASE_URL + 'add', formData);
          return response.data;
        } catch (error) {
          console.error('Error creating a new gender game:', error);
          throw error;
        }
      }
      async deleteGenderGame(id) {
        const url = GENDER_GAME_API_BASE_URL + `delete/${id}`;
        return await axiosInstance.delete(url);
      }

      // Role Games 

    async getAllRoleGames() {
        return await axiosInstance.get(ROLE_GAME_API_BASE_URL);
    }

    async createRoleGame(name) {
        const formData = new FormData();
        formData.append('name', name);
    
        try {
          const response = await axiosInstance.post(ROLE_GAME_API_BASE_URL + 'add', formData);
          return response.data;
        } catch (error) {
          console.error('Error creating a new role game:', error);
          throw error;
        }
      }
    
      async editRoleGame(id, name) {
        const formData = new FormData();
        formData.append('name', name);
    
        try {
          const response = await axiosInstance.put(ROLE_GAME_API_BASE_URL + `edit/${id}`, formData);
          return response.data;
        } catch (error) {
          console.error('Error editing role game:', error);
          throw error;
        }
      }
    
      async deleteRoleGame(id) {
        const url = ROLE_GAME_API_BASE_URL + `delete/${id}`;
        return await axiosInstance.delete(url);
      }
}

export default new ForGameService();