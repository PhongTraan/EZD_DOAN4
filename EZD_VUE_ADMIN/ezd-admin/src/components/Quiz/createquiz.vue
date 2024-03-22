<template>
  <div class="wrapper">
    <slibarWrapper></slibarWrapper>
    <!--end sidebar wrapper -->
    <!--start header -->
    <startHeaderVue></startHeaderVue>
    <div class="page-wrapper">
      <div class="page-content">
        <!-- Form to add new quiz -->
        <div class="container">
          <div class="row">
            <div class="col-xl-6 col-md-8 offset-xl-3 offset-md-2">
              <div class="cs-form_card_in">
                <h3 class="cs-form_title text-center">Add New Quiz</h3>
                <form @submit.prevent="addQuiz" enctype="multipart/form-data">
                  <div class="cs-form_field_wrap">
                    <label for="question">Question:</label>
                    <input
                      type="text"
                      class="form-control"
                      v-model="newQuiz.question"
                      required
                    />
                  </div>
                  <label for="answer1">Answer 1:</label>
                  <input
                    type="text"
                    class="form-control"
                    v-model="newQuiz.answers[0]"
                    required
                  />

                  <label for="answer2">Answer 2:</label>
                  <input
                    type="text"
                    class="form-control"
                    v-model="newQuiz.answers[1]"
                    required
                  />

                  <label for="answer3">Answer 3:</label>
                  <input
                    type="text"
                    class="form-control"
                    v-model="newQuiz.answers[2]"
                    required
                  />

                  <label for="correctAnswerIndex">Correct Answer :</label>
                  <!-- <input
            type="number"
             
            v-model="newQuiz.correctAnswerIndex"
            required
            min="0"
            max="2"
          /> -->
                  <select
                    class="form-control"
                    v-model="newQuiz.correctAnswerIndex"
                    required
                  >
                    <option value="0">Answer 1</option>
                    <option value="1">Answer 2</option>
                    <option value="2">Answer 3</option>
                  </select>
                  <br />

                  <button class="form-control" type="submit">Add Quiz</button>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!--start switcher-->
  <switcher></switcher>
</template>

<script>
import QuizService from "@/service/QuizService.js";
import switcher from "@/pages/switcher.vue";

import slibarWrapper from "@/pages/sidebarWrapper.vue";

import startHeaderVue from "@/pages/startHeader.vue";
export default {
  name: "listQuiz",
  data() {
    return {
      quizzes: [],
      newQuiz: {
        question: "",
        answers: [],
        correctAnswerIndex: 0,
      },
    };
  },
  components: {
    switcher,
    slibarWrapper,
    startHeaderVue,
  },
  mounted() {
    this.loadQuizzes();
  },
  methods: {
    async loadQuizzes() {
      try {
        const response = await QuizService.getAllQuizzes();
        this.quizzes = response;
      } catch (error) {
        console.error("Error loading quizzes:", error);
      }
    },
    async addQuiz() {
      try {
        // Filter out any empty answers before sending to the backend
        //   const nonEmptyAnswers = this.newQuiz.answers.filter(answer => answer.trim() !== "");
        console.log(this.newQuiz.answers);
        await QuizService.createNewQuiz(
          this.newQuiz.question,
          this.newQuiz.answers,
          // this.newQuiz.answers[1],
          // this.newQuiz.answers[2],
          this.newQuiz.correctAnswerIndex
        );

        //Clear form and reload quizzes
        this.newQuiz = {
          question: "",
          answers: ["", "", ""], // Reset mảng answers
          correctAnswerIndex: 0,
        };
        this.loadQuizzes();
        this.$router.push("/admin/quiz");
      } catch (error) {
        console.error("Error adding quiz:", error);
      }
    },
  },
  async created() {
    await this.addQuiz();
  },
};
</script>

<style>
/* Add your styles here if needed */
</style>
