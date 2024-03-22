import axios from 'axios';

const axiosInstance = axios.create({
    headers: {
        'Cache-Control': 'no-cache',
    },
});

const BLOG_API_BASE_URL = 'http://localhost:8081/blogs/';

class BlogService {

     async getAllBlogs() {
        return await axiosInstance.get(BLOG_API_BASE_URL);
    }

    async deleteBlog(id) {
        const url = `${BLOG_API_BASE_URL}delete/${id}`;
        return await axiosInstance.delete(url);
    }

    async createNewBlog(name, title, content, image) {
        if (!name) {
            throw new Error('Name of the blog is required.');
        }

        if (!title) {
            throw new Error('Title is required.');
        }

        if (!content) {
            throw new Error('Content is required.');
        }

        if (!image) {
            throw new Error('Image is required.');
        }

        const formData = new FormData();
        formData.append('name', name);
        formData.append('title', title);
        formData.append('content', content);
        formData.append('image', image);

        try {
            const response = await axiosInstance.post(`${BLOG_API_BASE_URL}add`, formData);
            return response.data;
        } catch (error) {
            console.error('Error creating a new blog:', error);
            throw error;
        }
    }

    async editBlog(id, name, title, content, image) {
        const formData = new FormData();
        formData.append('name', name);
        formData.append('title', title);
        formData.append('content', content);
        formData.append('image', image);

        try {
            const response = await axios.put(`${BLOG_API_BASE_URL}edit/${id}`, formData, {
                headers: {
                    'Content-Type': 'multipart/form-data',
                },
            });

            return response.data;
        } catch (error) {
            console.error('Error editing the blog:', error);
            throw error;
        }
    }

    async getBlogById(id) {
        try {
            const response = await axiosInstance.get(`${BLOG_API_BASE_URL}${id}`);
            return response.data;
        } catch (error) {
            console.error('Error getting blog by ID:', error);
            throw error;
        }
    }
    
}

export default new BlogService();
