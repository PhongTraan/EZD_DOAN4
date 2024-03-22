<template>
  <div class="wrapper">
    <slibarWrapper></slibarWrapper>
    <startHeaderVue></startHeaderVue>
    <div class="page-wrapper">
      <div class="page-content">
        <!-- <div class="card"> -->
        <div class="container-fluid">
          <div class="row">
            <div class="col-sm-6">
              <form @submit.prevent="addBanner" enctype="multipart/form-data">
                <div class="form-group">
                  <label for="name">Name</label>
                  <input
                    @input="validatename"
                    v-model="newBanner.name"
                    type="text"
                    id="name"
                    class="form-control"
                    :class="{ 'is-invalid': errors.name }"
                  />
                  <p v-if="errors.name" style="color: red">{{ errors.name }}</p>
                </div>

                <div class="form-group">
                  <label for="title">Title</label>
                  <input
                    v-model="newBanner.title"
                    @input="validateTitle"
                    type="text"
                    id="title"
                    class="form-control"
                    :class="{ 'is-invalid': errors.title }"
                  />
                  <p v-if="errors.title" style="color: red">
                    {{ errors.title }}
                  </p>
                </div>

                <div class="form-group">
                  <label for="image">Image</label>
                  <input
                    type="file"
                    id="image"
                    @change="onImageChange"
                    class="form-control"
                    :class="{ 'is-invalid': errors.image }"
                  />
                  <p v-if="errors.image" style="color: red">
                    {{ errors.image }}
                  </p>
                </div>
                <div class="form-group">
                  <img
                    :src="imagePreviewUrl"
                    alt="Image Preview"
                    style="width: 360px; height: 180px"
                  />
                </div>
                <div class="form-group">
                  <label></label>
                  <button type="submit" class="btn btn-primary">
                    Thêm Banner
                  </button>
                </div>
              </form>
              <br />
            </div>
            <div class="col-sm-6" v-if="isEditing">
              <form
                @submit.prevent="updateBanner"
                enctype="multipart/form-data"
              >
                <div class="form-group">
                  <label for="name">Name</label>
                  <input
                    v-model="editedBanner.name"
                    type="text"
                    id="name"
                    class="form-control"
                    required
                  />
                </div>

                <div class="form-group">
                  <label for="title">Title</label>
                  <input
                    v-model="editedBanner.title"
                    type="text"
                    id="title"
                    class="form-control"
                    required
                  />
                </div>

                <div class="form-group">
                  <label for="image">Image</label>
                  <input
                    type="file"
                    id="image"
                    @change="handleImageChange"
                    class="form-control"
                    accept=".jpg, .png, image/jpeg, image/png"
                    :src="editedBanner.image"
                  />
                </div>
                <div class="form-group">
                  <label></label>
                  <button type="submit" class="btn btn-primary">Update</button>
                </div>
              </form>
              <br />
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
                    <th scope="col">Image</th>
                    <th scope="col">status</th>
                    <th scope="col"></th>
                  </tr>
                </thead>
                <tbody>
  <tr v-for="item in displayedBanners" :key="item.id">
                    <td>
                      {{ item.name }}
                    </td>
                    <td>
                      {{ item.title }}
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
                      <button
                        class="btn btn-outline-danger"
                        @click="
                          showChangeStatusConfirmDialog(item.id, 'DISABLE')
                        "
                        :disabled="item.status === 'DISABLE'"
                        style="margin-right: 5px"
                      >
                        Disable
                      </button>
                      <button
                        class="btn btn-outline-success"
                        @click="
                          showChangeStatusConfirmDialog(item.id, 'PENDING')
                        "
                        :disabled="item.status === 'PENDING'"
                        style="margin-right: 5px"
                      >
                        Pending
                      </button>
                      <button
                        class="btn btn-outline-primary"
                        @click="
                          showChangeStatusConfirmDialog(item.id, 'ACTIVE')
                        "
                        :disabled="item.status === 'ACTIVE'"
                      >
                        Active
                      </button>
                    </td>

                    <td>
                      <a
                        class="btn btn-success"
                        @click="startEditingBanner(item.id)"
                      >
                        {{ item.editing ? "Save" : "Edit" }}
                      </a>
                    </td>
                    <td>
                      <button
                        class="btn btn-danger"
                        @click="deleteBanner(item.id)"
                      >
                        Delete
                      </button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <div class="pagination-container">
          <vue-awesome-paginate
            :total-rows="bannerList.length"
            v-model="currentPage"
            :per-page="itemsPerPage"
            :number-of-pages="totalPages"
            aria-controls="my-table"
            @page-change="handlePageChange"
          >
            <template #prev-button>
              <span>
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  fill="black"
                  width="8"
                  height="8"
                  viewBox="0 0 24 24"
                >
                  <path d="M8.122 24l-4.122-4 8-8-8-8 4.122-4 11.878 12z" />
                </svg>
                Prev
              </span>
            </template>
            <template #next-button>
              <span>
                Next
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  fill="black"
                  width="8"
                  height="8"
                  viewBox="0 0 24 24"
                >
                  <path d="M8.122 24l-4.122-4 8-8-8-8 4.122-4 11.878 12z" />
                </svg>
              </span>
            </template>
          </vue-awesome-paginate>
        </div>
      </div>
    </div>
  </div>

  <!-- end search modal -->
  <!--start switcher-->
  <switcher></switcher>
</template>

<script>
import switcher from "@/pages/switcher.vue";

import Swal from "sweetalert2";
import slibarWrapper from "@/pages/sidebarWrapper.vue";
import BannerService from "@/service/BannerService.js";
import startHeaderVue from "@/pages/startHeader.vue";
import "sweetalert2/dist/sweetalert2.min.css";

export default {
  name: "createBanner",
 

  data() {
    return {
      itemsPerPage: 10, // Số lượng mục trên mỗi trang
      totalPages: 0, // Tổng số trang
      currentPage: 1, // Trang hiện tại
      displayedBanners: [], // Mản

      errors: {
        name: "",
        title: "",
        image: "",
      },
      imagePreviewUrl: null,
      submitted: false,
      newBanner: {
        name: "",
        title: "",
        image: null,
      },

      editedBanner: {
        name: "",
        title: "",
        image: "",
      },
      selectedStatus: "PENDING",
      isEditing: false,
      visible: false,
      bannerList: [],
      // newBanner:[],
    };
  },
  components: {
    switcher,
    slibarWrapper,
    startHeaderVue,
  },
  methods: {
    updateDisplayedBanners() {
      const startIndex = (this.currentPage - 1) * this.itemsPerPage;
      const endIndex = startIndex + this.itemsPerPage;
      this.displayedBanners = this.bannerList.slice(startIndex, endIndex);
    },
    handlePageChange(page) {
      this.currentPage = page;
      this.updateDisplayedBanners();
    },

    // Hàm này sẽ được gọi khi danh sách banner thay đổi
    updatePagination() {
      this.totalPages = Math.ceil(this.bannerList.length / this.itemsPerPage);
      this.updateDisplayedBanners();
    },

    validatename() {
      this.errors.name =
        this.newBanner.name.trim() === "" ? "không được bỏ trống." : "";
    },
    validateTitle() {
      this.errors.title =
        this.newBanner.title.trim() === "" ? "Không được bỏ trống." : "";
    },

    async showChangeStatusConfirmDialog(id, status) {
      const result = await Swal.fire({
        title: "Xác nhận thay đổi trạng thái",
        text: "Bạn có chắc chắn muốn thay đổi trạng thái của banner?",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Có",
        cancelButtonText: "Không",
      });

      if (result.isConfirmed) {
        // Nếu người dùng xác nhận, thực hiện thay đổi trạng thái
        this.changeBannerStatus(id, status); // Truyền trạng thái vào đây
      }
    },
    async changeBannerStatus(id, status) {
      try {
        if (!id) {
          console.error("Không có ID banner được chọn.");
          return;
        }

        await BannerService.changeStatus(id, status);
        this.getAllBanners();

        Swal.fire({
          position: "top-end",
          icon: "success",
          title: "Thay đổi trạng thái thành công!",
          showConfirmButton: false,
          timer: 1500,
        });
      } catch (error) {
        console.error("Lỗi khi thay đổi trạng thái banner: ", error);
        Swal.fire({
          icon: "error",
          title: "Lỗi",
          text: "Có lỗi xảy ra khi thay đổi trạng thái banner",
        });
      }
    },
    handleImageChange(event) {
      const selectedImage = event.target.files[0]; // Lấy hình ảnh đầu tiên trong danh sách chọn

      if (selectedImage) {
        // Nếu có hình ảnh được chọn, cập nhật trường "image" và imagePreviewUrl
        this.editedBanner.image = selectedImage;
        // this.editedBanner.image = URL.createObjectURL(selectedImage);

        // Tạo một đối tượng FileReader để đọc hình ảnh
        let reader = new FileReader();

        reader.onload = (e) => {
          this.imagePreviewUrl = e.target.result; // Cập nhật imagePreviewUrl với dữ liệu hình ảnh
        };

        // Đọc hình ảnh được chọn
        reader.readAsDataURL(selectedImage);
      }
      // Nếu không có hình ảnh được chọn, không cần thực hiện cập nhật
    },

    async startEditingBanner(id) {
      try {
        if (this.bannerList) {
          this.isEditing = !this.isEditing;
          // Gọi API hoặc thực hiện bất kỳ xử lý nào để lấy thông tin của banner theo id
          const banner = await BannerService.getBannerById(id);

          // Gán thông tin banner vào biến editedBanner
          this.editedBanner = banner;
        }
      } catch (error) {
        console.error("Lỗi khi lấy chi tiết banner: ", error);
      }
    },
    async updateBanner() {
      // Thực hiện logic cập nhật banner dựa trên this.editedBanner
      // Gọi API hoặc sử dụng BannerService.editBanner để cập nhật banner
      try {
        // Gọi API hoặc BannerService.editBanner để cập nhật banner

        const updatedBanner = await BannerService.editBanner(
          this.editedBanner.id,
          this.editedBanner.name,
          this.editedBanner.title,
          this.editedBanner.image
        );

        // Xử lý kết quả sau khi cập nhật thành công (nếu cần)
        // console.log("Banner đã được cập nhật thành công", updatedBanner);
        if (updatedBanner.id) {
          this.getAllBanners();
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
        this.editedBanner = {
          name: "",
          title: "",
          image: null,
        };
      } catch (error) {
        console.error("Lỗi khi cập nhật banner: ", error);
      }
    },
    async deleteBanner(id) {
      try {
        await BannerService.deleteBanner(id);
        // Sau khi xóa thành công, bạn có thể cập nhật lại danh sách banner
        this.getAllBanners();

        Swal.fire({
          position: "top-end",
          icon: "success",
          title: " Thành Công !",
          showConfirmButton: false,
          timer: 1500,
        });
      } catch (error) {
        console.error("Lỗi khi xóa Banner: ", error);
      }
    },
    showImage(name, imageUrl) {
      Swal.fire({
        title: name,
        imageUrl: imageUrl,
        imageWidth: 600,
        imageHeight: 400,
      });
    },
   async getAllBanners() {
  try {
    const response = await BannerService.getAllBanners();
    const data = response.data;
    this.bannerList = data;
    this.updatePagination(); // Thêm dòng này để cập nhật phân trang
  } catch (error) {
    console.error("Lỗi khi lấy danh sách banner: ", error);
  }
},

    async addBanner() {
      this.validatename();
      this.validateTitle();

      if (!this.errors.name && !this.errors.title) {
        // Nếu không có lỗi, tiến hành xử lý submit form ở đây.
        try {
          const response = await BannerService.createNewBanner(
            this.newBanner.name,
            this.newBanner.title,
            this.newBanner.image
          );

          console.log(response);
          if (response.id) {
            this.$router.push("/admin/banner");
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
          Swal.fire({
            position: "top-end",
            icon: "error",
            title: " đã có lỗi xảy ra vui lòng kiểm tra lại",
            showConfirmButton: false,
            timer: 1500,
          });
        }
      }
    },
    onImageChange(event) {
      this.newBanner.image = event.target.files[0];
      if (this.newBanner.image) {
        // Nếu có hình ảnh được chọn, cập nhật trường "image" và imagePreviewUrl

        // Tạo một đối tượng FileReader để đọc hình ảnh
        let reader = new FileReader();

        reader.onload = (e) => {
          this.imagePreviewUrl = e.target.result; // Cập nhật imagePreviewUrl với dữ liệu hình ảnh
        };

        // Đọc hình ảnh được chọn
        reader.readAsDataURL(this.newBanner.image);
      }
    },
    // Trong tệp .vue của trang hiện tại

    redirectToListPage() {
      this.$router.push({ name: "listbanner" });
    },
  },
  async created() {
    await this.getAllBanners();
  },
};
</script>
