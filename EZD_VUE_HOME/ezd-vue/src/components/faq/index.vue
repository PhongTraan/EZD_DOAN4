<template>
  <div>
    <startHeader></startHeader>
    <div class="cs-height_100 cs-height_lg_70"></div>
    <topScore></topScore>
    <section class="cs-page_head cs-bg" data-src="assets/img/page_head_bg.svg">
      <div class="container">
        <div class="text-center">
          <h1 class="cs-page_title">Frequently Asked Questions</h1>
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.html">Home</a></li>
            <li class="breadcrumb-item active">FAQ</li>
          </ol>
        </div>
      </div>
    </section>
    <!-- End Page Head -->
    <div class="cs-height_100 cs-height_lg_70"></div>
    <div class="container">
      <div class="row cs-col_reverse_lg">
        <div class="col-lg-6">
          <div class="cs-faq">
            <div class="cs-section_heading cs-style3">
              <button class="cs-btn cs-style1 cs-btn_lg" @click="toggleCollapse">Join Quizz</button>
              
            </div>
            <div class="cs-height_30 cs-height_lg_30"></div>
            
            <div v-if="isCollapsed" class="cs-accordians">
              <section class="quiz" v-if="!quizCompleted">
                <div class="quiz-info">
                  <span
                    class="question"
                    style="font-size: 21px; font-weight: bold"
                    >{{ getCurrentQuestion.question }}</span
                  >
                </div>

                <div class="options">
                  <label
                    class="options-container"
                    v-for="(option, index) in getCurrentQuestion.answers"
                    :for="'option' + index"
                    :class="`option ${
                      getCurrentQuestion.selected == index
                        ? index == getCurrentQuestion.correctAnswerIndex
                          ? 'correct'
                          : 'wrong'
                        : ''
                    } ${
                      getCurrentQuestion.selected != null &&
                      index != getCurrentQuestion.selected
                        ? 'disabled'
                        : ''
                    }`"
                    :key="index"
                  >
                    <input
                      type="radio"
                      :id="'option' + index"
                      :name="getCurrentQuestion.index"
                      :value="index"
                      v-model="getCurrentQuestion.selected"
                      :disabled="getCurrentQuestion.selected"
                      @change="SetAnswer"
                    />
                    <span>{{ option }}</span>
                  </label>
                </div>

                <button class="btn btn-primary" @click="NextQuestion">
                  {{
                    getCurrentQuestion.index === questions.length - 1
                      ? "Finish"
                      : "Next question"
                  }}
                </button>
              </section>

              <section v-else>
                <h2>You have finished the quiz!</h2>
                <p>Your score is {{ score }}/{{ questions.length }}</p>
              </section>
            </div>
            <!-- .cs-accordians -->
          </div>
        </div>
        <div class="col-lg-6">
          <div class="text-center">
            <img src="assets/img/faq_1.svg" alt="faq" />
          </div>
          <div class="cs-height_0 cs-height_lg_30"></div>
        </div>
      </div>
    </div>
    <div class="cs-height_80 cs-height_lg_70"></div>
    <div class="container">
      <div class="row">
        <div class="col-lg-6">
          <div class="text-center">
            <img src="assets/img/faq_2.svg" alt="faq" />
          </div>
          <div class="cs-height_0 cs-height_lg_30"></div>
        </div>
        <div class="col-lg-6">
          <div class="cs-faq">
            <div class="cs-section_heading cs-style3">
              <h2 class="cs-section_title">Safety, Security, and Policies</h2>
              <div class="cs-section_seperator"></div>
            </div>
            <div class="cs-height_30 cs-height_lg_30"></div>
            <div class="cs-accordians">
              <div class="cs-accordian active">
                <div class="cs-accordian_head">
                  <h2 class="cs-accordian_title">
                    How do I get started in NFT?
                  </h2>
                  <span class="cs-accordian_toggle">
                    <svg
                      width="13"
                      height="7"
                      viewBox="0 0 13 7"
                      fill="none"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <path
                        d="M1.62109 0.750977L6.95443 6.08431L12.2878 0.750977"
                        stroke="currentColor"
                        stroke-width="1.33333"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                    </svg>
                  </span>
                </div>
                <div class="cs-accordian-body">
                  <b>Step 1:</b> Decide on the concept. <b>Step 2:</b> Decide on
                  the platform. <br />
                  <b>Step 3:</b> Connect and build community.
                  <b>Step 4:</b> Create your art. <br />
                  <b>Step 5:</b> Mint and share. <b>The final step:</b> Selling
                  your NFT.
                </div>
              </div>
              <!-- .cs-accordian -->
              <div class="cs-accordian">
                <div class="cs-accordian_head">
                  <h2 class="cs-accordian_title">
                    How much does the average NFT sell for?
                  </h2>
                  <span class="cs-accordian_toggle">
                    <svg
                      width="13"
                      height="7"
                      viewBox="0 0 13 7"
                      fill="none"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <path
                        d="M1.62109 0.750977L6.95443 6.08431L12.2878 0.750977"
                        stroke="currentColor"
                        stroke-width="1.33333"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                    </svg>
                  </span>
                </div>
                <div class="cs-accordian-body">
                  <p>
                    Once you have minted a piece of artwork on a marketplace as
                    an <br />NFT, you should never mint it on another platform.
                    If you ever decide <br />to do so, note that most platforms
                    reserve
                  </p>
                </div>
              </div>
              <!-- .cs-accordian -->
              <div class="cs-accordian">
                <div class="cs-accordian_head">
                  <h2 class="cs-accordian_title">
                    What kind of NFTs sell best?
                  </h2>
                  <span class="cs-accordian_toggle">
                    <svg
                      width="13"
                      height="7"
                      viewBox="0 0 13 7"
                      fill="none"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <path
                        d="M1.62109 0.750977L6.95443 6.08431L12.2878 0.750977"
                        stroke="currentColor"
                        stroke-width="1.33333"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                    </svg>
                  </span>
                </div>
                <div class="cs-accordian-body">
                  <p>
                    Once you have minted a piece of artwork on a marketplace as
                    an <br />NFT, you should never mint it on another platform.
                    If you ever decide <br />to do so, note that most platforms
                    reserve
                  </p>
                </div>
              </div>
              <!-- .cs-accordian -->
              <div class="cs-accordian">
                <div class="cs-accordian_head">
                  <h2 class="cs-accordian_title">
                    How to make money with NFTs as a beginner?
                  </h2>
                  <span class="cs-accordian_toggle">
                    <svg
                      width="13"
                      height="7"
                      viewBox="0 0 13 7"
                      fill="none"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <path
                        d="M1.62109 0.750977L6.95443 6.08431L12.2878 0.750977"
                        stroke="currentColor"
                        stroke-width="1.33333"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                    </svg>
                  </span>
                </div>
                <div class="cs-accordian-body">
                  <p>
                    Once you have minted a piece of artwork on a marketplace as
                    an <br />NFT, you should never mint it on another platform.
                    If you ever decide <br />to do so, note that most platforms
                    reserve
                  </p>
                </div>
              </div>
              <!-- .cs-accordian -->
              <div class="cs-accordian">
                <div class="cs-accordian_head">
                  <h2 class="cs-accordian_title">
                    Who owns the most expensive NFT?
                  </h2>
                  <span class="cs-accordian_toggle">
                    <svg
                      width="13"
                      height="7"
                      viewBox="0 0 13 7"
                      fill="none"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <path
                        d="M1.62109 0.750977L6.95443 6.08431L12.2878 0.750977"
                        stroke="currentColor"
                        stroke-width="1.33333"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                    </svg>
                  </span>
                </div>
                <div class="cs-accordian-body">
                  <p>
                    Once you have minted a piece of artwork on a marketplace as
                    an <br />NFT, you should never mint it on another platform.
                    If you ever decide <br />to do so, note that most platforms
                    reserve
                  </p>
                </div>
              </div>
              <!-- .cs-accordian -->
            </div>
            <!-- .cs-accordians -->
          </div>
        </div>
      </div>
    </div>
    <footerHome></footerHome>
  </div>
</template>

<script>
import { ref, computed, onMounted } from "vue";
import QuizService from "@/service/QuizService.js";
import topScore from "@/pages/topScoreFaq.vue";
import startHeader from "@/pages/startHeader.vue";
import footerHome from "@/pages/footer.vue";
import { collection, addDoc } from "firebase/firestore";
import db from "@/firebase/init.js";
import { userInfo } from "@/store";

function shuffleArray(array) {
  for (let i = array.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [array[i], array[j]] = [array[j], array[i]];
  }
}

export default {
  name: "blogDetails",
  components: {
    startHeader,
    footerHome,
    topScore,
  },
  setup() {
    const questions = ref([]);
    const quizCompleted = ref(false);
    const currentQuestion = ref(0);
    const score = ref(0);
    const isCollapsed = ref(false);

    const toggleCollapse = () => {
      isCollapsed.value = !isCollapsed.value;
    };
    const saveScoreToFaq = async (userId, userName, score) => {
      try {
        // Thêm dữ liệu vào collection "scoreFaq"
        const docRef = await addDoc(collection(db, "scoreFaq"), {
          userId: userInfo.value.id,
          userName: userInfo.value.name,
          score: score,
        });

        console.log("Document written with ID: ", docRef.id);
      } catch (error) {
        console.error("Error adding document: ", error);
      }
    };
    const loadQuizzes = async () => {
      try {
        const response = await QuizService.getAllQuizzes();
        const shuffledQuizzes = response.data.map((quiz) => {
          const shuffledAnswers = [...quiz.answers];
          shuffleArray(shuffledAnswers);
          return { ...quiz, shuffledAnswers };
        });

        shuffleArray(shuffledQuizzes);

        questions.value = shuffledQuizzes;
      } catch (error) {
        console.error("Error loading quizzes:", error);
      }
    };

    onMounted(() => {
      loadQuizzes();
    });

    const getCurrentQuestion = computed(() => {
      const question = questions.value[currentQuestion.value];
      const questionWithIndex = { ...question, index: currentQuestion.value };
      return questionWithIndex;
    });

    const SetAnswer = () => {
      // Your logic for handling selected answer
      getCurrentQuestion.value.shuffledAnswers;
    };

    const NextQuestion = () => {
      if (getCurrentQuestion.value.selected !== null) {
        // Check if the selected answer index is equal to the actual correctAnswerIndex
        if (
          getCurrentQuestion.value.selected ===
          getCurrentQuestion.value.correctAnswerIndex
        ) {
          score.value++;
        }

        // Reset the selected property to null for the current question
        getCurrentQuestion.value.selected = null;

        // Move to the next question
        currentQuestion.value++;

        if (currentQuestion.value < questions.value.length) {
          // Load the next question
          loadCurrentQuestion();
        } else {
          // Quiz completed
          quizCompleted.value = true;
          saveScoreToFaq(userInfo.value.id, userInfo.value.name, score.value);
        }
      }
    };

    const loadCurrentQuestion = () => {
      getCurrentQuestion.value = questions.value[currentQuestion.value];
    };

    return {
      questions,
      currentQuestion,
      score,
      getCurrentQuestion,
      quizCompleted,
      SetAnswer,
      NextQuestion,
      saveScoreToFaq,
      isCollapsed,
      toggleCollapse,
    };
  },
};
</script>

<style scoped>
.options-container {
  display: flex;
  gap: 10px; /* Adjust the gap as needed */
}
</style>
