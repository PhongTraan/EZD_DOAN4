<template>
  <div class="wrapper">
    <slibarWrapper></slibarWrapper>
    <!--end sidebar wrapper -->
    <!--start header -->
    <startHeaderVue></startHeaderVue>
    <div class="page-wrapper">
      <div class="page-content">
        <div class="container">
          <div class="row">
           <div class="col-xl-4 col-md-6 offset-xl-3 offset-md-2">
              <div class="cs-form_card_in">
            <button  class="btn btn-primary">
              <router-link to="/admin/quiz/create">Tạo Mới FAQ</router-link>
            </button>
            </div>
        </div>
            <h2>Quiz List</h2>

            <!-- List all quizzes -->
            <ul class="list-group">
            
              <li v-for="(quiz, quizIndex) in quizzes" :key="quiz.id" class="list-group-item">
               <b>{{ quizIndex + 1 }}.{{ quiz.question }}</b> 
                <ul  class="list-group">
                  <li v-for="(answer, index) in quiz.answers" :key="index" class="list-group-item">
                    <!-- {{ removeDoubleQuotes(answer) }} -->
                    {{ answer }}
                  </li>
                  <li  class="list-group-item"><button class="btn btn-danger" @click="deleteQuiz(quiz.id)" >
                  Delete
                </button></li>
                </ul>

                
              </li>
            </ul>

            <!-- Form to add new quiz -->
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
    //  removeDoubleQuotes(str) {
    //    return str.replace(/["[\]]/g, '');
    // },
    async loadQuizzes() {
      try {
        const response = await QuizService.getAllQuizzes();

        this.quizzes = response.data;
      } catch (error) {
        console.error("Error loading quizzes:", error);
      }
    },

    async editQuiz(quizId) {
      // Implement edit functionality if needed
      console.log("Edit quiz with ID:", quizId);
    },
    async deleteQuiz(quizId) {
      try {
        await QuizService.deleteQuiz(quizId);
        this.loadQuizzes();
      } catch (error) {
        console.error("Error deleting quiz:", error);
      }
    },
  },
  async created() {
    await this.loadQuizzes();
  },
};
</script>

<style>
  
</style>