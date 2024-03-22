<template>
  <div class="wrapper">
    <!--sidebar wrapper -->
    <slibarWrapper></slibarWrapper>
    <!--end sidebar wrapper -->
    <!--start header -->
    <startHeaderVue></startHeaderVue>
    <!--end header -->

    <!--Start page wrapper  . Dữ liệu chính-->
    <div class="page-wrapper">
      <div class="page-content">
        <!--breadcrumb-->
        <div class="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
          <div class="breadcrumb-title pe-3">Rank</div>
          <div class="ps-3">
            <nav aria-label="breadcrumb">
              <ol class="breadcrumb mb-0 p-0">
                <li class="breadcrumb-item">
                  <a href="javascript:;"><i class="bx bx-home-alt"></i></a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">
                  Tạo rank mới
                </li>
              </ol>
            </nav>
          </div>
        </div>
        <!--end breadcrumb-->
        <div class="card">
          <div class="card-body p-4">
            <h5 class="card-title">Tạo rank mới</h5>
            <hr />
            <div class="form-body mt-4">
              <form
                class="row g-3 needs-validation was-validated"
                novalidate
                enctype="multipart/form-data"
                @submit.prevent="confirmCreateNewRank"
              >
                <div class="row">
                  <div class="col-lg-12">
                    <div class="border border-3 p-4 rounded">
                      <div class="mb-3">
                        <label for="rankName" class="form-label"
                          >Tên Xếp Hạng</label
                        >
                        <input
                          v-model="rankData.rank_name"
                          type="text"
                          id="rankName"
                          class="form-control"
                          placeholder="Enter product title"
                          required
                        />
                        <div class="valid-feedback">Hợp lệ</div>
                        <div class="invalid-feedback">
                          Vui Lòng Nhập Tên Xếp Hạng
                        </div>
                      </div>
                      <div class="mb-3">
                        <div class="row g-3">
                          <div class="col-md-3">
                            <label for="minimumBalance"
                              >Số Tiền Tối Thiểu</label
                            >
                            <input
                              type="text"
                              v-model="formattedPriceMinimum"
                              id="minimumBalance"
                              required
                            />
                            <div class="valid-feedback">Hợp lệ</div>
                            <div class="invalid-feedback">
                              Vui Lòng Nhập Số Tiền Nhỏ Nhất
                            </div>
                          </div>
                          <div class="col-md-3">
                            <label for="maximumBalance"
                              >Số Tiền Đạt Theo Yêu Cầu</label
                            >
                            <input
                              v-model="formattedPriceMaximum"
                              type="text"
                              id="maximumBalance"
                              required
                            />
                            <div class="valid-feedback">Hợp lệ</div>
                            <div class="invalid-feedback">
                              Vui Lòng Nhập Số Tiền Lớn Nhất
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="mb-3">
                        <div class="row g-6">
                          <label for="avatarImage" class="form-label"
                            >Khung hình avatar</label
                          >
                          <div class="col-md-3">
                            <input
                              id="avatarImage"
                              type="file"
                              accept=".jpg, .png, image/jpeg, image/png"
                              @change="handleImageUpload('avatarImage')"
                              multiple
                            />
                          </div>
                          <div class="col-md-6">
                            <img
                              id="previewImage"
                              class="img-fluid"
                              v-if="imageAvatar"
                              :src="imageAvatar"
                              alt="Preview"
                            />
                          </div>
                        </div>
                      </div>
                      <div class="mb-3">
                        <div class="row g-6">
                          <label for="backgroundImage" class="form-label"
                            >Hình nền</label
                          >
                          <div class="col-md-3">
                            <input
                              id="backgroundImage"
                              type="file"
                              accept=".xlsx,.xls,image/*,.doc,audio/*,.docx,video/*,.ppt,.pptx,.txt,.pdf"
                              @change="handleImageUpload('backgroundImage')"
                              multiple
                            />
                          </div>
                          <div class="col-md-6">
                            <img
                              id="previewImage"
                              class="img-fluid"
                              v-if="imageBackground"
                              :src="imageBackground"
                              alt="Preview"
                            />
                          </div>
                        </div>
                      </div>
                    </div>
                    <button
                      type="submit"
                      class="btn btn-primary px-5 radius-30"
                    >
                      Lưu Xếp Hạng
                    </button>
                  </div>
                </div>

                <button type="submit"></button>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--End page wrapper  . Dữ liệu chính-->

    <!-- search modal -->
    <!-- end search modal -->
    <!--start switcher-->
    <switcher></switcher>
    <!--end switcher-->
  </div>
</template>

<script>
import switcher from "@/pages/switcher.vue";
import slibarWrapper from "@/pages/sidebarWrapper.vue";
import startHeaderVue from "@/pages/startHeader.vue";

import RankService from "@/service/RankService.js";

import Swal from "sweetalert2";
export default {
  name: "createNewRank",
  components: {
    switcher,
    
    slibarWrapper,
    startHeaderVue,
  },
  data() {
    return {
      isEditDialogOpen: false,

      rankData: {
        rank_name: "",
        minimum_balance: 0,
        maximum_balance: 0,
        avatar_frame_image: null,
        background_image: null,
      },
      imageAvatar: null,
      imageBackground: null,
    };
  },
  methods: {
    async confirmCreateNewRank() {
      // Hiển thị popup xác nhận trước khi tạo rank
      const confirmResult = await Swal.fire({
        title: "Bạn có cần xem lại không?",
        text: "Nếu đã chắc chặn xin vui lòng chọn Yes hoặc No?",
        icon: "question",
        showCancelButton: true,
        confirmButtonText: "Yes",
        cancelButtonText: "No",
      });

      if (confirmResult.isConfirmed) {
        // Người dùng bấm Yes, tiến hành tạo rank
        await this.createNewRank();

        // Bạn cũng có thể thêm các hành động khác sau khi tạo rank thành công ở đây
      } else {
        // Người dùng bấm No hoặc đóng popup, không thực hiện gì cả
      }
    },
    async createNewRank() {
      try {
        if (
          !this.rankData.rank_name ||
          !this.rankData.minimum_balance ||
          !this.rankData.maximum_balance ||
          !this.rankData.avatar_frame_image
        ) {
          // Sử dụng thư viện Swal để hiển thị thông báo lỗi
          await Swal.fire({
            icon: "error",
            title: "Lỗi",
            text: "Không được bỏ trống. Vui lòng nhập tên Xếp Hạng",
          });
          return; // Ngừng thực hiện hàm nếu có lỗi
        }
        // Kiểm tra minimum_balance
        if (parseFloat(this.rankData.minimum_balance) < 0) {
          await Swal.fire({
            icon: "error",
            title: "Lỗi",
            text: "Minimum balance phải lớn hơn hoặc bằng 0",
          });
          return;
        }
        // Kiểm tra maximum_balance
        if (
          parseFloat(this.rankData.maximum_balance) <=
          parseFloat(this.rankData.minimum_balance)
        ) {
          await Swal.fire({
            icon: "error",
            title: "Lỗi",
            text: "Maximum balance phải lớn hơn minimum balance, nhập maxium trước để tránh lỗi xảy ra. Vui lòng nhập lại.",
          });
          return;
        }
        const formData = new FormData();
        formData.append("rank_name", this.rankData.rank_name);
        formData.append("minimum_balance", this.rankData.minimum_balance);
        formData.append("maximum_balance", this.rankData.maximum_balance);
        formData.append("adminFrameImage", this.rankData.avatar_frame_image);
        formData.append("backgroundImage", this.rankData.background_image);

        await RankService.createRank(formData);

        // Reset form data after successful submission
        this.rankData = {
          rank_name: "",
          minimum_balance: 0,
          maximum_balance: 0,
          avatar_frame_image: null,
          background_image: null,
        };
        // Hiển thị thông báo thành công
        Swal.fire({
          icon: "success",
          title: "Rank created successfully!",
          showConfirmButton: false,
          timer: 1500,
        });

        this.$router.push("/admin/rank");
      } catch (error) {
        console.error("Error creating new game:", error);
        // Hiển thị thông báo lỗi
        Swal.fire({
          icon: "error",
          title: "Error",
          text: "Failed to create rank. Please try again.",
        });
      }
    },
    handleImageUpload(type) {
      const input = event.target;
      const file = input.files[0];

      if (file) {
        // Check which type of image is being uploaded and update the corresponding property
        if (type === "avatarImage") {
          this.rankData.avatar_frame_image = file;
          this.imageAvatar = URL.createObjectURL(file);
        } else if (type === "backgroundImage") {
          this.rankData.background_image = file;
          this.imageBackground = URL.createObjectURL(file);
        }
      }
    },
  },
  computed: {
    formattedPriceMinimum: {
      get() {
        // Hiển thị giá trị theo định dạng số thập phân và thêm đơn vị VNĐ
        return parseFloat(this.rankData.minimum_balance).toLocaleString(
          "en-US",
          {
            // style: "currency",
            // currency: "VND",
            minimumFractionDigits: 0, // Số lượng số thập phân tối thiểu
            maximumFractionDigits: 2,
          }
        );
        // Đưa đơn vị tiền "VNĐ" về sau số thập phân
      },
      set(value) {
        // Lưu giá trị dưới dạng số khi người dùng nhập
        this.rankData.minimum_balance = parseFloat(
          value.replace(/[^\d.]/g, "")
        );
        if (this.rankData.minimum_balance > 999999999) {
          Swal.fire({
            icon: "error",
            title: "Lỗi",
            text: "Giá tiền rank không được vượt quá 1 tỷ",
          });
          return (this.rankData.minimum_balance = 0);
        }
      },
    },
    formattedPriceMaximum: {
      get() {
        // Hiển thị giá trị theo định dạng số thập phân và thêm đơn vị VNĐ
        return parseFloat(this.rankData.maximum_balance).toLocaleString(
          "en-US",
          {
            minimumFractionDigits: 0, // Số lượng số thập phân tối thiểu
            maximumFractionDigits: 2,
          }
        );
        // Đưa đơn vị tiền "VNĐ" về sau số thập phân
      },
      set(value) {
        // Lưu giá trị dưới dạng số khi người dùng nhập
        this.rankData.maximum_balance = parseFloat(
          value.replace(/[^\d.]/g, "")
        );
        if (this.rankData.maximum_balance > 999999999) {
          Swal.fire({
            icon: "error",
            title: "Lỗi",
            text: "Giá tiền rank không được vượt quá 1 tỷ",
          });
          return (this.rankData.maximum_balance = 0);
        }
      },
    },
  },
  created() {
    // this.createNewRank();
  },
};
</script>

<style scoped></style>
