import axios from 'axios' ; 

const axiosInstance = axios.create({
    headers:{
        'Cache-Control' :'no-cache',
    },
});

const BLOG_API_BASE_URL = "http://localhost:8081/blogs/";
 
class BlogService {
    async getAllBlogs (){
        return await axiosInstance.get(BLOG_API_BASE_URL);
    }
    async getBlogById(id) {
        try {
            const response = await axiosInstance.get(`${BLOG_API_BASE_URL}${id}`);
            
            return response;
        } catch (error) {
            console.error('Error getting blog by ID:', error);
            throw error;
        }
    }
}

export default new BlogService()