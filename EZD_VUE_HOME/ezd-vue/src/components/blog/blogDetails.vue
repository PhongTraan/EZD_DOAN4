<template>
  <div>
    <startHeader></startHeader>

    <div class="cs-height_90 cs-height_lg_80"></div>
    <!-- Start Page Head -->
    <section class="cs-page_head cs-bg" data-src="assets/img/page_head_bg.svg">
      <div class="container">
        <div class="text-center">
          <h1 class="cs-page_title">Blog Details</h1>
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.html">Home</a></li>
            <li class="breadcrumb-item active">Blog Details</li>
          </ol>
        </div>
      </div>
    </section>
    <div class="cs-height_100 cs-height_lg_70"></div>
    <div class="container">
      <div class="row">
        <div class="col-lg-8 offset-lg-2">
          <div class="cs-single_post" v-if="blog && blog.image">
            <h2>{{ blog.name }}</h2>
            <h2>Title :{{ blog.title }}</h2>
            <img :src="blog.image" class="d-block" alt="..." />
            <p>
              {{ blog.content }}
            </p>

            <div class="cs-height_10 cs-height_lg_10"></div>
          </div>
          <div class="cs-height_60 cs-height_lg_30"></div>

          <div class="cs-height_60 cs-height_lg_30"></div>
        </div>
      </div>
    </div>

    <footerHome></footerHome>
  </div>
</template>

<script>
import startHeader from "@/pages/startHeader.vue";
import footerHome from "@/pages/footer.vue";
import BlogService from "@/service/BlogService.js";

export default {
  name: "blogDetails",
  components: {
    startHeader,
    footerHome,
  },
  data() {
    return {
      blog: {},
    };
  },

  methods: {
    async getBlogDetails() {
      const blogId = this.$route.params.id;
      try {
        const response = await BlogService.getBlogById(blogId);
        console.log("Blog Details:", response.data); // Log the response data
        this.blog = response.data;
      } catch (error) {
        console.error("Lỗi khi lấy chi tiết blog: ", error);
      }
    },
  },

  async created() {
    await this.getBlogDetails();
  },
};
</script>

<style></style>
