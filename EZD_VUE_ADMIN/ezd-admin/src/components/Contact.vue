<template>
  <div class="wrapper">
    <!--sidebar wrapper -->
    <slibarWrapper></slibarWrapper>
    <!--end sidebar wrapper -->
    <!--start header -->
    <startHeaderVue></startHeaderVue>
    <!--end header -->
    <!--start page wrapper -->
    <div class="page-wrapper">
      <div class="page-content">
        <!--breadcrumb-->
        <div class="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
          <div class="breadcrumb-title pe-3">Components</div>
          <div class="ps-3">
            <nav aria-label="breadcrumb">
              <ol class="breadcrumb mb-0 p-0">
                <li class="breadcrumb-item">
                  <a href="javascript:;"><i class="bx bx-home-alt"></i></a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">
                  Progress Bars
                </li>
              </ol>
            </nav>
          </div>
          <div class="ms-auto">
            <div class="btn-group">
              <button type="button" class="btn btn-primary">Settings</button>
              <button
                type="button"
                class="btn btn-primary split-bg-primary dropdown-toggle dropdown-toggle-split"
                data-bs-toggle="dropdown"
              >
                <span class="visually-hidden">Toggle Dropdown</span>
              </button>
              <div
                class="dropdown-menu dropdown-menu-right dropdown-menu-lg-end"
              >
                <a class="dropdown-item" href="javascript:;">Action</a>
                <a class="dropdown-item" href="javascript:;">Another action</a>
                <a class="dropdown-item" href="javascript:;"
                  >Something else here</a
                >
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="javascript:;">Separated link</a>
              </div>
            </div>
          </div>
        </div>
        <!--end breadcrumb-->
    
            <div class="card">
              <div class="card-body">
                <div class="card-title">
                  <h5 class="mb-0">Striped</h5>

                  <canvas id="imageCanvas" style="height: 150px"></canvas>
                  <input id="imageUpload" type="file" @change="readURL" />

                  <div>Teachable Machine Image Model with upload</div>
                </div>
                <hr />

                <div v-for="(prediction, index) in predictions" :key="index">
                  <span
                    :style="{ width: '10%', color: getColorForClassName(prediction.className) }"
                  >
                    {{ prediction.className }}
                  </span>
                  :
                  <div class="progress mb-3" style="height: 20px">
                    <div
                      class="progress-bar progress-bar-striped progress-bar-animated"
                     
                      :style="{
                        width: prediction.probability * 100 + '%',
                        backgroundColor: getBackgroundColorForClassName(prediction.className),
                      }"
                      :aria-valuenow="(prediction.probability * 100).toFixed(2)"
                      aria-valuemin="0"
                    >
                      <span class="pr-2">{{ (prediction.probability * 100).toFixed(2) }}%</span>
                    </div>
                  </div>
                </div>
                <div v-if="isCheckMax" class="alert alert-warning">
                  "check" có xác suất lớn nhất: {{ maxCheckProbability.toFixed(2) }}%
                </div>
              </div>
            </div>
          </div>
          <!--end page wrapper -->
        
    </div>
  </div>

  <!-- search modal -->
  <searchModal></searchModal>
  <!-- end search modal -->
  <!--start switcher-->
  <switcher></switcher>
  <!--end switcher-->
</template>

<script>
import * as tmImage from "@teachablemachine/image";
import switcher from "@/pages/switcher.vue";
import searchModal from "@/pages/searchModal.vue";

import slibarWrapper from "@/pages/sidebarWrapper.vue";

import startHeaderVue from "@/pages/startHeader.vue";
export default {
  name: "contactPage",
  components: {
    switcher,
    searchModal,
    slibarWrapper,
    startHeaderVue,
  },

  data() {
    return {
      model: null,
      predictions: [],
    };
  },
  methods: {
    getColorForClassName(className) {
    switch (className) {
      case 'Nam':
        return '#E67701';
      case 'Nữ':
        return '#D84C6F';
      case 'wibu':
        return '#794AEF';
      case 'check':
        return '#e60101';
      default:
        return 'black'; // Màu mặc định hoặc giá trị màu bạn muốn
    }
  },
  getBackgroundColorForClassName(className) {
    switch (className) {
      case 'Nam':
        return '#E67701';
      case 'Nữ':
        return '#D84C6F';
      case 'wibu':
        return '#794AEF';
      case 'check':
        return '#e60101';
      default:
        return '#FFECE2'; // Màu nền mặc định hoặc giá trị màu bạn muốn
    }
  },
    async init() {
      const URL = "https://teachablemachine.withgoogle.com/models/3e70vOM44/";
      const modelURL = URL + "model.json";
      const metadataURL = URL + "metadata.json";

      this.model = Object.freeze(await tmImage.load(modelURL, metadataURL));
    },
    async predict(canvasElement) {
      const prediction = await this.model.predict(canvasElement, false);
      this.predictions = prediction;
    },
    readURL(event) {
      const input = event.target;
      if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
          const imageCanvas = document.getElementById("imageCanvas");
          const context = imageCanvas.getContext("2d");
          const image = new Image();

          image.onload = function () {
            imageCanvas.width = image.width;
            imageCanvas.height = image.height;
            context.drawImage(image, 0, 0, image.width, image.height);
            this.init().then(() => {
              this.predict(imageCanvas);
            });
          }.bind(this);

          image.src = e.target.result;
        }.bind(this);
        reader.readAsDataURL(input.files[0]);
      }
    },
  },
  computed: {
    isCheckMax() {
      // Tìm giá trị xác suất lớn nhất
      const maxProbability = Math.max(
        ...this.predictions.map((prediction) => prediction.probability)
      );
      return (
        maxProbability > 0 && // Đảm bảo có ít nhất một giá trị xác suất lớn hơn 0
        this.predictions.some(
          (prediction) =>
            prediction.className === "check" &&
            prediction.probability === maxProbability
        )
      );
    },
    maxCheckProbability() {
      // Lấy giá trị xác suất lớn nhất cho "check"
      const checkPrediction = this.predictions.find(
        (prediction) => prediction.className === "check"
      );
      return checkPrediction ? checkPrediction.probability * 100 : 0;
    },
  },
};
</script>

