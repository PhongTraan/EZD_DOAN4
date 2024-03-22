import axios from "axios";

const axiosInstance = axios.create({
  headers: {
    "Cache-Control": "no-cache",
    "Content-Type": "multipart/form-data",
  },
});

const FEEDBACK_API_BASE_URL = "http://localhost:8081/api/feedbacks/";

class FeedbackService {
  async getAllFeedbacks() {
    return await axiosInstance.get(FEEDBACK_API_BASE_URL);
  }

  async submitFeedback(rating, comment, userName) {
    const formData = new FormData();
    formData.append("rating", rating);
    formData.append("comment", comment);
    formData.append("userName", userName);

    try {
      const response = await axiosInstance.post(
        `${FEEDBACK_API_BASE_URL}submit`,
        formData,
      );
      return response.data;
    } catch (error) {
      console.error("Error submitting feedback:", error);
      throw error;
    }
  }
}

export default new FeedbackService();
