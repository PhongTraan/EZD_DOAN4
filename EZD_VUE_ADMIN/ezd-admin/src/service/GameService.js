import axios from 'axios';

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


  async deleteGame(id) {
    const url = `${GAME_API_BASE_URL}delete/${id}`;
    return await axiosInstance.delete(url);
  }
  async createNewGame(nameGame, imageName, levelIds, roleIds, genderIds) {
    if (!nameGame) {
      throw new Error('Name of the game is required.');
    }

    if (!imageName) {
      throw new Error('Image is required.');
    }

    if (!levelIds.length || !roleIds.length || !genderIds.length) {
      throw new Error('At least one level, role, and gender is required.');
    }


    const formData = new FormData();
    formData.append('nameGame', nameGame);
    formData.append('imageName', imageName);

    for (const levelId of levelIds) {
      formData.append('levelIds', levelId);
    }

    for (const roleId of roleIds) {
      formData.append('roleIds', roleId);
    }

    for (const genderId of genderIds) {
      formData.append('genderIds', genderId);
    }

    try {
      const response = await axiosInstance.post(`${GAME_API_BASE_URL}add`, formData);
      return response.data;
    } catch (error) {
      console.error('Error creating a new game:', error);
      throw error;
    }
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
  // Chỉnh sửa tên của trò chơi
  async updateGameName(id, nameGame) {
    if (!nameGame) {
      throw new Error('Name of the game is required.');
    }

    const formData = new FormData();
    formData.append('nameGame', nameGame);

    try {
      const response = await axios.put(`${GAME_API_BASE_URL}edit/${id}/name`, formData, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      });
      return response.data;
    } catch (error) {
      console.error('Error editing the game name:', error);
      throw error;
    }
  }

  // Chỉnh sửa hình ảnh của trò chơi
  async updateGameImage(id, imageName) {
    if (!imageName) {
      throw new Error('Image is required.');
    }

    const formData = new FormData();
    formData.append('imageName', imageName);

    try {
      const response = await axios.put(`${GAME_API_BASE_URL}edit/${id}/image`, formData, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      });
      return response.data;
    } catch (error) {
      console.error('Error editing the game image:', error);
      throw error;
    }
  }

  async updateGameRoles(id, roleIds) {
    const formData = new FormData();
    const roleIdArray = Object.values(roleIds);
    for (const roleId of roleIdArray) {
      formData.append('roleIds', roleId);
    }

    try {
      const response = await axios.put(`${GAME_API_BASE_URL}edit/${id}/roles`, formData, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      });
      return response.data;
    } catch (error) {
      console.error('Error editing the game roles:', error);
      throw error;
    }
  }

  async updateGameGenders(id, genderIds) {
    const formData = new FormData();
    for (const genderId of genderIds) {
      formData.append('genderIds', genderId);
    }

    try {
      const response = await axios.put(`${GAME_API_BASE_URL}edit/${id}/genders`, formData, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      });
      return response.data;
    } catch (error) {
      console.error('Error editing the game genders:', error);
      throw error;
    }
  }

  async updateGameLevels(id, levelIds) {
    const formData = new FormData();
    // Biến đổi đối tượng thành mảng
    const levelIdArray = Object.values(levelIds);
  
    for (const levelId of levelIdArray) {
      formData.append('levelIds', levelId);
    }
  
    try {
      const response = await axios.put(`${GAME_API_BASE_URL}edit/${id}/levels`, formData, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      });
      return response.data;
    } catch (error) {
      console.error('Error editing the game levels:', error);
      throw error;
    }
  }
  



}

export default new GameService();
