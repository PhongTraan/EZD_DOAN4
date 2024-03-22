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
            <div class="form-body">
              <div class="row" v-if="isEditing">
                <form
                  @submit.prevent="updateBlog"
                  enctype="multipart/form-data"
                >
                  <div class="col-12">
                    <div class="border border-3 p-4 rounded">
                      <div class="mb-3">
                        <label for="inputName" class="form-label">Name</label>
                        <input
                          type="text"
                          class="form-control"
                          id="inputName"
                          v-model="editBlog.name"
                          placeholder="Enter Name"
                        />
                      </div>
                      <div class="mb-3">
                        <label for="inputTitle" class="form-label">Title</label>
                        <input
                          type="text"
                          class="form-control"
                          id="inputTitle"
                          v-model="editBlog.title"
                          placeholder="Enter Title"
                        />
                      </div>
                      <div class="mb-3">
                        <label for="inputContent" class="form-label"
                          >Content</label
                        >
                        <textarea
                          class="form-control"
                          id="inputContent"
                          v-model="editBlog.content"
                          rows="3"
                        ></textarea>
                      </div>
                      <div class="mb-3">
                        <label for="image-uploadify" class="form-label"
                          >Image</label
                        >
                        <input
                          type="file"
                          id="image"
                          
                          @change="handleImageChange"
                          class="form-control"
                          accept=".jpg, .png, image/jpeg, image/png"
                          required
                        />
                      </div>
                      <button
                        type="submit"
                        class="btn btn-primary px-5 radius-30"
                      >
                        update
                      </button>
                    </div>
                  </div>
                </form>
              </div>
              <!--end row-->
            </div>
          </div>
        </div>

        <div class="row">
          <div class="col-12">
            <!-- danh sách -->
            <div>
              <h1>Danh sách mục</h1>
              <table class="table">
                <thead>
                  <tr>
                    <th scope="col">Name</th>
                    <th scope="col">Title</th>
                    <th scope="col">Content</th>
                    <th scope="col">Image</th>
                    <th scope="col"></th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="item in blogList" :key="item.id">
                    <td>
                      {{ item.name }}
                    </td>
                    <td>
                      {{ item.title }}
                    </td>
                    <td>
                    <p  @click="showContent(item.name, item.content)">bấm vào để xem chi tiết</p>
                      
                       
                    </td>
                    <td>
                      <img
                        :src="item.image"
                        class="d-block"
                        style="height: 120px; width: 250px"
                        alt="..."
                        @click="showImage(item.name, item.image)"
                      />
                    </td>
                    <td>
                      <a
                        class="btn btn-success"
                        @click="startEditingBlog(item.id)"
                      >
                        update
                      </a>
                    </td>
                    <td>
                      <button
                        class="btn btn-danger"
                        @click="deleteBlog(item.id)"
                      >
                        delete
                      </button>
                    </td>
                  </tr>
                </tbody>
              </table>
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
      
      newBlog: {
        name: "",
        content: "",
        title: "",
        image: null,
      },
      isEditing: false,
      editBlog: {
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
    async deleteBlog(id) {
      try {
        await BlogService.deleteBlog(id);
        // Sau khi xóa thành công, bạn có thể cập nhật lại danh sách banner
        this.getAllBlogs();

        Swal.fire({
          position: "top-end",
          icon: "success",
          title: " Thành Công !",
          showConfirmButton: false,
          timer: 1500,
        });
      } catch (error) {
        console.error("Lỗi khi xóa Blog: ", error);
      }
    },
    handleImageChange(event) {
      this.editBlog.image = event.target.files[0];
      // Tạo một đối tượng FileReader để đọc hình ảnh
      let reader = new FileReader();

      reader.onload = (e) => {
        this.imagePreviewUrl = e.target.result; // Cập nhật imagePreviewUrl với dữ liệu hình ảnh
      };

      // Đọc hình ảnh được chọn
      reader.readAsDataURL(this.editBlog.image);
    },
    async startEditingBlog(id) {
      try {
        if (this.blogList) {
          this.isEditing = !this.isEditing;
          // Gọi API hoặc thực hiện bất kỳ xử lý nào để lấy thông tin của banner theo id
          const blog = await BlogService.getBlogById(id);

          // Gán thông tin banner vào biến editedBanner
          this.editBlog = blog;
        }
        console.log(this.editBlog);
      } catch (error) {
        console.error("Lỗi khi lấy chi tiết blog: ", error);
      }
    },
    async updateBlog() {
      // Thực hiện logic cập nhật banner dựa trên this.editedBanner
      // Gọi API hoặc sử dụng BannerService.editBanner để cập nhật banner
      try {
        // Gọi API hoặc BannerService.editBanner để cập nhật banner

        const updateBlog = await BlogService.editBlog(
          this.editBlog.id,
          this.editBlog.name,
          this.editBlog.title,
          this.editBlog.content,
          this.editBlog.image
        );

        // Xử lý kết quả sau khi cập nhật thành công (nếu cần)
        // console.log("Banner đã được cập nhật thành công", updatedBanner);
        if (updateBlog.id) {
          this.getAllBlogs();
          Swal.fire({
            position: "top-end",
            icon: "success",
            title: " Thành Công !",
            showConfirmButton: false,
            timer: 1500,
          });
        }
        this.isEditing = !this.isEditing;

        // Đặt lại giá trị của this.editedBanner để xóa dữ liệu trong form
        this.editBlog = {
          name: "",
          title: "",
          content: "",
          image: null,
        };
      } catch (error) {
        console.error("Lỗi khi cập nhật banner: ", error);
      }
    },
    showContent(name, content) {
      Swal.fire({
        title: name,
        html:content,
      });
    },
    showImage(name, imageUrl) {
      Swal.fire({
        title: name,
        imageUrl: imageUrl,
        imageWidth: 600,
        imageHeight: 400,
      });
    },

    onImageChange(event) {
      this.newBlog.image = event.target.files[1];
    },
    
    async addBlog() {
      //kiểm ta bỏ trống
      
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
    },
    async getAllBlogs() {
      try {
        const response = await BlogService.getAllBlogs();
        const data = response.data;
        //const data = response.data.sort((a, b) => b.id - a.id);
        // Gán giá trị cho cả bannerList và originalBannerList
        this.blogList = data;
        console.log(this.blogList);
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
