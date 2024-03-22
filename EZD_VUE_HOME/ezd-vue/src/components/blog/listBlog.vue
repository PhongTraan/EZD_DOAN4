<template>
  <div>
    <startHeader></startHeader>

    <div class="cs-height_90 cs-height_lg_80"></div>

    <div class="cs-height_100 cs-height_lg_70"></div>
    <div class="container">
    <div class="container">
    <div class="row">
      <div class="col-lg-12" v-if="newestBlog">
        <div class="cs-post cs-style1 cs-type1">
           <img class="cs-post_thumb"
                :src="newestBlog.image"
          
              @click="viewDetails(newestBlog.id)"
                alt="..."
              />
          <div class="cs-post_info">
            <h2 class="cs-post_title" ><a @click="viewDetails(newestBlog.id)" >{{newestBlog.name}}</a></h2>
            <div class="cs-post_subtitle">{{newestBlog.title}}</div>
              <div class="cs-height_20 cs-height_lg_20"></div>
             
          </div>
        </div>
        <div class="cs-height_30 cs-height_lg_30"></div>
      </div>
      <!-- .col -->
      
      <!-- .col -->
     
      <div class="col-lg-4 col-md-6"  v-for="blog in blogList" :key="blog.id">
        <div class="cs-post cs-style1" >
          <img
                :src="blog.image"
                class="d-block"
              @click="viewDetails(blog.id)"
              :style="{ color: blog.clicked ? 'red' : 'while', cursor: 'pointer' }"
                alt="..."
              />
          <div class="cs-post_info">
            <h2 class="cs-post_title"><a @click="viewDetails(blog.id)" 
            
            :style="{ color: blog.clicked ? 'red' : 'while', cursor: 'pointer' }">{{blog.name}}</a></h2>
            <div class="cs-post_subtitle">{{blog.title}}.</div>
              <div class="cs-height_20 cs-height_lg_20"></div>
              
          </div>
        </div>
        <div class="cs-height_30 cs-height_lg_30"></div>
      </div>
     
      <!-- .col -->
      
      
    </div>
    <div class="cs-height_10 cs-height_lg_10"></div>
    <!-- <div class="text-center">
      <a href="#" class="cs-btn cs-style1 cs-btn_lg"><span>Load More</span></a>
    </div> -->
  </div>
     

      <div class="cs-height_70 cs-height_lg_40"></div>
    </div>
    <footerHome></footerHome>
  </div>
</template>

<script>
import startHeader from "@/pages/startHeader.vue";
import footerHome from "@/pages/footer.vue";
import BlogService from "@/service/BlogService.js";

export default {
  name: "listBlog",
  components: {
    startHeader,
    footerHome,
  },
  data() {
    return {
      newestBlog: null,
      blogList: [],
    };
  },

  methods: {
  viewDetails(blogId) {
      // Chuyển hướng đến trang xem chi tiết, có thể sử dụng Vue Router hoặc window.location
      // Ví dụ sử dụng Vue Router:
      this.$router.push({ name: 'blogDetails', params: { id: blogId } });
    },
    async getAllBlogs() {
      try {
        const response = await BlogService.getAllBlogs();
        const data = response.data;
        //const data = response.data.sort((a, b) => b.id - a.id);
        // Gán giá trị cho cả bannerList và originalBannerList
        
         this.blogList = data.sort((a, b) => b.id - a.id);
         this.newestBlog = this.blogList.length > 0 ? this.blogList[0] : null;
        // this.originalBannerList = data;
      } catch (error) {
        console.error("Lỗi khi lấy danh sách banner: ", error);
      }
    },
  },

  async created() {
    await this.getAllBlogs();
  },
};
</script>

<style>
.card {
  border: 1px solid #ccc;
  padding: 10px;
  margin: 10px;
  width: 300px; /* Đặt chiều rộng của mỗi thẻ card */
  display: inline-block; /* Đảm bảo mỗi thẻ card nằm trên một dòng */
  vertical-align: top; /* Hiệu chỉnh căn chỉnh dọc */
  color: black;
}
</style>
