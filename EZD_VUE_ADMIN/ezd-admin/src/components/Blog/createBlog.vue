<template>
  <div class="wrapper">
    <!--sidebar wrapper -->
    <slibarWrapper></slibarWrapper>
    <!--end sidebar wrapper -->
    <!--start header -->
    <startHeaderVue></startHeaderVue>
    <div class="page-wrapper">
      <div class="page-content">
        <!--end header -->
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Add New Blog</h5>
            <hr />
            <div class="form-body">
              <div class="row">
                <form @submit.prevent="addBlog" enctype="multipart/form-data">
                  <div class="col-12">
                    <div class="border border-3 p-4 rounded">
                      <div class="mb-3">
                        <label for="inputName" class="form-label">Name</label>
                        <input
                          type="text"
                          class="form-control"
                          id="inputName"
                          v-model="newBlog.name"
                          
                          placeholder="Enter Name"
                          @input="validatename"
                          :class="{ 'is-invalid': errors.name }"
                        />
                        <p v-if="errors.name" style="color: red">
                          {{ errors.name }}
                        </p>
                      </div>
                      <div class="mb-3">
                        <label for="inputTitle" class="form-label">Title</label>
                        <input
                          type="text"
                          class="form-control"
                          id="inputTitle"
                          v-model="newBlog.title"
                          placeholder="Enter Title"
                          @input="validateTitle"
                          :class="{ 'is-invalid': errors.title }"
                        />
                        <p v-if="errors.title" style="color: red">
                          {{ errors.title }}
                        </p>
                      </div>
                      <div class="mb-3">
                        <label for="inputContent" class="form-label"
                          >Content</label
                        >
                        <textarea
                          class="form-control"
                          id="inputContent"
                          v-model="newBlog.content"
                          
                          rows="3"
                          @input="validatecontent"
                          :class="{ 'is-invalid': errors.content }"
                        ></textarea>
                        <p v-if="errors.content" style="color: red">
                          {{ errors.content }}
                        </p>
                      </div>
                      <div class="mb-3">
                        <label for="image-uploadify" class="form-label"
                          >Image</label
                        >
                        <input
                          id="image-uploadify"
                          type="file"
                          accept=".xlsx,.xls,image/*,.doc,audio/*,.docx,video/*,.ppt,.pptx,.txt,.pdf"
                          multiple
                          @change="onImageChange"
                         
                        />
                      </div>
                      <button
                        type="submit"
                        class="btn btn-primary px-5 radius-30"
                      >
                        Submit
                      </button>
                    </div>
                  </div>
                </form>
              </div>
              <!--end row-->
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--start page wrapper  . Dữ liệu chính-->
    <!--start page wrapper -->
    <div class="page-wrapper">
      <div class="page-content"></div>
    </div>
  </div>
  <!--start switcher-->
  <switcher></switcher>
</template>

<script>
import switcher from "@/pages/switcher.vue";
import Swal from "sweetalert2";
import slibarWrapper from "@/pages/sidebarWrapper.vue";
import BlogService from "@/service/BlogService.js";
import startHeaderVue from "@/pages/startHeader.vue";
export default {
  name: "createBlog",
  data() {
    return {
      errors: {
        name: "",
        content: "",
        title: "",
        image: "",
      },
      newBlog: {
        name: "",
        content: "",
        title: "",
        image: null,
      },
      blogList: [],
    };
  },
  components: {
    switcher,
    slibarWrapper,
    startHeaderVue,
  },
  methods: {
    validatename() {
      this.errors.name =
        this.newBlog.name.trim() === "" ? "không được bỏ trống." : "";
    },
    validatecontent() {
      this.errors.content =
        this.newBlog.content.trim() === "" ? "không được bỏ trống." : "";
    },
    validateTitle() {
      this.errors.title =
        this.newBlog.title.trim() === "" ? "Không được bỏ trống." : "";
    },
    onImageChange(event) {
      this.newBlog.image = event.target.files[0];
      if (this.newBlog.image) {
        // Nếu có hình ảnh được chọn, cập nhật trường "image" và imagePreviewUrl

        // Tạo một đối tượng FileReader để đọc hình ảnh
        let reader = new FileReader();

        // reader.onload = (e) => {
        //   this.imagePreviewUrl = e.target.result; // Cập nhật imagePreviewUrl với dữ liệu hình ảnh
        // };

        // Đọc hình ảnh được chọn
        reader.readAsDataURL(this.newBlog.image);
      }
    },
    async addBlog() {
      this.validatename();
      this.validatecontent();
      this.validateTitle();
      if (!this.errors.name && !this.errors.title && !this.errors.content) {
        try {
          const response = await BlogService.createNewBlog(
            this.newBlog.name,
            this.newBlog.title,
            this.newBlog.content,

            this.newBlog.image
          );

          console.log(response);
          if (response.id) {
            this.$router.push("/admin/blog");
            Swal.fire({
              position: "top-end",
              icon: "success",
              title: " Thành Công !",
              showConfirmButton: false,
              timer: 1500,
            });
          }
          // Xử lý kết quả hoặc điều hướng đến trang danh sách sản phẩm Banner sau khi thêm thành công
        } catch (error) {
          console.error("Lỗi khi thêm Banner mới: ", error);
        }
      }
    },
    async getAllBlogs() {
      try {
        const response = await BlogService.getAllBlogs();
        const data = response.data;
        //const data = response.data.sort((a, b) => b.id - a.id);
        // Gán giá trị cho cả bannerList và originalBannerList
        this.blogList = data;
        // this.originalBannerList = data;
      } catch (error) {
        console.error("Lỗi khi lấy danh sách banner: ", error);
      }
    },
    async created() {
      await this.getAllBlogs();
    },
  },
};
</script>
