<template>
  <!--wrapper-->
  <div class="wrapper">
    <!--sidebar wrapper -->
    <slibarWrapper></slibarWrapper>
    <!--end sidebar wrapper -->
    <!--start header -->
    <startHeaderVue></startHeaderVue>
    <!--end header -->

    <!--start page wrapper  . Dữ liệu chính-->

    <div class="page-wrapper">
      <div class="page-content">
        <div class="card">
          <div class="card-body">
            <!-- Breadcrumb or other content -->
            <div class="breadcrumb">
              <!-- Your breadcrumb content here -->
            </div>
  
            <!-- Carousel -->
            <div class="carousel-container">
              <carousel :items-to-show="1" :pagination="false">
                <slide v-for="slide in bannerList" :key="slide.id">
                  <div class="slide-content">
                    <img :src="slide.image" alt="" class="carousel-image" />
                  </div>
                  <div class="carousel-caption">
                    <div class="caption-overlay"></div>
                    <div class="caption-text">
                      <h3 class="slide-title">{{ slide.name }}</h3>
                      <p class="slide-description">{{ slide.title }}</p>
                    </div>
                  </div>
                </slide>
                <template #addons>
                  <navigation />
                  <pagination />
                </template>
              </carousel>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--end page wrapper -->
    <!--end page wrapper -->
  </div>
  <!--end wrapper-->
 
  <!--start switcher-->
  <switcher></switcher>
  <!--end switcher-->
</template>
<script>
import "vue3-carousel/dist/carousel.css";
import { Carousel, Slide, Pagination, Navigation } from "vue3-carousel";
import switcher from "@/pages/switcher.vue";

import slibarWrapper from "@/pages/sidebarWrapper.vue";
import BannerService from "@/service/BannerService.js";
import startHeaderVue from "@/pages/startHeader.vue";
export default {
  name: "listBanner",
  data() {
    return {
      bannerList: [],
    };
  },
  components: {
    switcher,
    slibarWrapper,
    startHeaderVue,
    Carousel,
    Slide,
    Pagination,
    Navigation,
  },
  methods: {
    async getAllBanners() {
      try {
        const response = await BannerService.getAllBanners();
        const data = response.data;
        //const data = response.data.sort((a, b) => b.id - a.id);
        // Gán giá trị cho cả bannerList và originalBannerList
console.log("ok");
        this.bannerList = data.filter((banner) => banner.status === "ACTIVE");
      } catch (error) {
        console.error("Lỗi khi lấy danh sách banner: ", error);
      }
    },
  },
  async created() {
    await this.getAllBanners();
  },
  prevCarousel() {
    const carousel = document.getElementById("carouselExampleDark");
    const activeIndex = this.getActiveIndex(carousel);
    if (activeIndex > 0) {
      this.goToSlide(activeIndex - 1, carousel);
    } else {
      this.goToSlide(this.bannerList.length - 1, carousel);
    }
  },

  nextCarousel() {
    const carousel = document.getElementById("carouselExampleDark");
    const activeIndex = this.getActiveIndex(carousel);
    if (activeIndex < this.bannerList.length - 1) {
      this.goToSlide(activeIndex + 1, carousel);
    } else {
      this.goToSlide(0, carousel);
    }
  },

  getActiveIndex(carousel) {
    return Array.from(carousel.querySelectorAll(".carousel-item")).findIndex(
      (item) => item.classList.contains("active")
    );
  },

  goToSlide(index, carousel) {
    const indicators = carousel.querySelectorAll(".carousel-indicators li");
    indicators[index].click();
  },
};
</script>
<style scoped>
.page-wrapper {
  /* Thiết lập cho page-wrapper */
  background-color: #f5f5f5;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
}

.page-content {
  max-width: 1200px;
  width: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
}

.card {
  /* Thiết lập cho card */
  background-color: #fff;
  border-radius: 15px;
  box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
  overflow: hidden;
}

.carousel-container {
  /* Thiết lập cho carousel-container */
  position: relative;
  border-radius: 15px;
  overflow: hidden;
}

.carousel-caption {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 20px;
}

.slide-title {
  /* Thiết lập cho slide-title */
  color:aqua;
  font-size: 24px;
  font-weight: 600;
}

.slide-description {
  /* Thiết lập cho slide-description */
  font-size: 16px;
}

.carousel-image {
  /* Thiết lập cho carousel-image */
  width: 100%;
  height: auto;
}
</style>