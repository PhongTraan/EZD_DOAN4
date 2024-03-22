<template>
  <startHeader></startHeader>
  <div class="cs-height_90 cs-height_lg_80"></div>
  <div class="cs-height_80 cs-height_lg_80"></div>
  <div class="container">
    <div class="row">
      <div class="col-lg-8 offset-lg-2">
        <h3 class="cs-feedback_title">Feedback</h3>
        <div class="cs-contact_card_wrap"></div>

        <div class="cs-height_50 cs-height_lg_50"></div>
        <button class="cs-btn cs-style1 cs-btn_lg" @click="toggleFeedbackForm">Open/Close Feedback Form</button>
        <div class="cs-height_45 cs-height_lg_45"></div>
        <div class="cs-contact_box"  v-if="showFeedbackForm">
          
          <form
          
            class="cs-contact_form"
            @submit.prevent="submitFeedback"
            enctype="multipart/form-data"
          >
            <div class="row">
              <div class="col-lg-12">
                <div class="custom-star-rating">
                  <span v-for="star in 5" :key="star" @click="setRating(star)">
                    <!-- Display a filled star if the current rating is greater than or equal to the star index -->
                    <i :class="{ filled: feedback.rating >= star }">★</i>
                  </span>
                </div>
              </div>
              <div class="cs-height_20 cs-height_lg_20"></div>
              <div class="col-lg-12">
                <div class="cs-form_field_wrap">
                  <input
                    type="text"
                    class="cs-form_field"
                    placeholder="Write Subject"
                    v-model="feedback.userName"
                  />
                </div>

                <div class="cs-height_20 cs-height_lg_20"></div>
              </div>
              <div class="col-lg-12">
                <div class="cs-form_field_wrap">
                  <textarea
                    cols="30"
                    rows="5"
                    placeholder="Message..."
                    class="cs-form_field"
                    v-model="feedback.comment"
                  ></textarea>
                </div>

                <div class="cs-height_20 cs-height_lg_20"></div>
              </div>
              <div class="col-lg-12">
                <button class="cs-btn cs-style1 cs-btn_lg" type="submit">
                  Send Message
                </button>
              </div>
            </div>
          </form>
        </div>
        <div class="cs-profile_right">
          <div class="cs-height_30 cs-height_lg_30"></div>
          <h3 class="cs-section_heading cs-style1">
            <template
              v-for="i in Array.from({ length: averageRating })"
              :key="i"
            >
              <i class="bx bx-star font-20 mx-2 yellow-star">★</i>
            </template>
            {{ averageRating }}
          </h3>
          <h6>(Total feedback: {{ totalRatings }})</h6>
          <div class="cs-height_25 cs-height_lg_25"></div>
          <ul class="cs-activity_list cs-mp0">
            <li v-for="a in list" :key="a.id">
              <div class="cs-activity cs-white_bg cs-type1">
                <div class="cs-activity_avatar">
                  <img
                    src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/10/avatar-trang-1.jpg"
                    alt=""
                  />
                </div>
                <div class="cs-activity_right">
                  <!-- Display star icons based on the user's rating -->
                  <p class="cs-activity_text">{{ a.userName }}</p>
                  <template
                    v-for="i in Array.from({ length: a.rating })"
                    :key="i"
                  >
                    <i class="bx bx-star font-20 mx-2 yellow-star">★</i>
                  </template>

                  <p class="cs-activity_posted_by">{{ a.comment }}</p>
                </div>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>

  <div class="cs-height_70 cs-height_lg_40"></div>
  <footerHome></footerHome>
</template>

<script>
import startHeader from "@/pages/startHeader.vue";
import footerHome from "@/pages/footer.vue";
import FeedbackService from "@/service/FeedbackService.js";
import Swal from "sweetalert2";
import { userInfo } from "@/store.js";
export default {
  name: "FeedbackForm",
  components: {
    startHeader,
    footerHome,
  },
  data() {
    return {
      userinfordata: userInfo.value,
      feedback: {
        rating: null,
        comment: "",
        userName: "",
      },
      list: [],
      showFeedbackForm: false,
      
    };
  },
  created() {
    // Nếu userInfo khác null, gán giá trị mặc định cho fullName
    if (userInfo.value) {
      this.feedback.userName = userInfo.value.name;
    }
    this.getAllContacts();
  },
  computed: {
     
    // Compute the average rating
    averageRating() {
      if (this.list.length === 0) {
        return 0; // Default to 0 if there are no ratings
      }

      const totalRating = this.list.reduce(
        (sum, feedback) => sum + feedback.rating,
        0,
      );

      const average = totalRating / this.list.length;

      return average.toFixed(1);
    },
    // Compute the total number of ratings
    totalRatings() {
      return this.list.length;
    },
  },
  methods: {
    toggleFeedbackForm() {
      this.showFeedbackForm = !this.showFeedbackForm;
    },
    
    setRating(rating) {
      // Update the feedback rating when a star is clicked
      this.feedback.rating = rating;
    },
    async getAllContacts() {
      try {
        const response = await FeedbackService.getAllFeedbacks();

        this.list = response.data.sort((a, b) => b.id - a.id);
      } catch (error) {
        console.error("Lỗi khi lấy danh sách Contact: ", error);
      }
    },

    async submitFeedback() {
      try {
        // Check if feedback is null before accessing its properties
        if (
          this.feedback &&
          this.feedback.rating !== null &&
          this.feedback.userName.length > 0
        ) {
          const savedFeedback = await FeedbackService.submitFeedback(
            this.feedback.rating,
            this.feedback.comment,
            this.feedback.userName,
          );
          this.$router.push("/feedback");
          Swal.fire({
            
            icon: "success",
            title: "success",
          });
          

          console.log("Submit Feedback Successful:", savedFeedback);

          this.feedback.rating = null;
          this.feedback.comment = "";
          this.feedback.userName = "";
        } else {
          Swal.fire({
            icon: "error",
            title: "error",
            text: "Feedback is null or rating or userName is null",
          });
          console.error("Feedback is null or rating is null");
        }
      } catch (error) {
        console.error("Error submitting feedback:", error);
      }
    },
  },
};
</script>

<style scoped>
/* Styling for the custom star rating */
.custom-star-rating {
  display: flex;

  font-size: 48px; /* Increase the size of stars */
}

/* Styling for filled stars with smooth transition */
.filled {
  color: gold;
  transition: color 0.3s ease; /* Add a smooth color transition effect */
  cursor: pointer; /* Display a hand cursor on hover */
}

/* Hover effect to change color when users hover over the star */
.filled:hover {
  color: #ffcc00; /* Change the color on hover */
}
.cs-feedback_title {
  text-align: center; /* Center the text */
  margin-top: 20px; /* Add some top margin for spacing */
  cursor: pointer; /* Display a hand cursor on hover */
  transition: color 0.3s ease; /* Add a smooth color transition effect */
}

/* Hover effect to change color when users hover over the title */
.cs-feedback_title:hover {
  color: blue; /* Change the color on hover */
}
.yellow-star {
  color: yellow;
}
</style>
