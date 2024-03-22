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
                  List Rank
                </li>
              </ol>
            </nav>
          </div>
        </div>
        <!--end breadcrumb-->
        <!-- <div class="row">
          <div class="col-12">
            <div class="card">
              <div class="card-body">
                <div class="row align-items-center">
                  <div class="col-lg-3 col-xl-2">
                    <a
                      href="/admin/rank/create"
                      class="btn btn-primary mb-3 mb-lg-0"
                      ><i class="bx bxs-plus-square"></i>Tạo rank mới</a
                    >
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div> -->
        <!-- Start Edit Rank -->
        <div v-if="isEditDialogOpen" ref="editForm" class="card">
          <div class="card-body p-4">
            <h5 class="card-title">Cập nhật rank</h5>
            <hr />
            <div class="form-body mt-4">
              <form
                class="row g-3 needs-validation was-validated"
                novalidate
                enctype="multipart/form-data"
                @submit.prevent="updateRank"
              >
                <div class="row">
                  <div class="col-lg-12">
                    <div class="border border-3 p-4 rounded">
                      <div class="mb-3">
                        <label for="rankName" class="form-label"
                          >Tên Xếp Hạng</label
                        >
                        <input
                          v-model="editRankData.rank_name"
                          v-bind="listRanks.rank_name"
                          type="text"
                          id="rankName"
                          class="form-control"
                          placeholder="Enter product title"
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
                              v-bind="listRanks.minimum_balance"
                              v-model="formattedMinimumBalance"
                              type="text"
                              id="minimumBalance"
                              class="form-control"
                              placeholder="Enter product title"
                            />
                            <div class="valid-feedback">Hợp lệ</div>
                            <div class="invalid-feedback">
                              Vui Lòng Nhập Giá Tiền Nhỏ Nhất
                            </div>
                          </div>
                          <div class="col-md-3">
                            <label for="maximumBalance"
                              >Số Tiền Đạt Theo Yêu Cầu</label
                            >
                            <input
                              v-bind="listRanks.maximum_balance"
                              v-model="formattedMaximumBalance"
                              type="text"
                              id="maximumBalance"
                              class="form-control"
                              placeholder="Enter product title"
                            />
                            <div class="valid-feedback">Hợp lệ</div>
                            <div class="invalid-feedback">
                              Vui Lòng Nhập Giá Tiền Lớn Nhất
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
                          <div class="col-md-3">
                            <img
                              id="previewImage"
                              class="img-fluid"
                              v-if="avatarImage"
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
                          <div class="col-md-3">
                            <img
                              id="previewImage"
                              class="img-fluid"
                              v-if="backgroundImage"
                              :src="imageBackground"
                              alt="Preview"
                            />
                          </div>
                        </div>
                      </div>
                    </div>
                    <br/>
                    <div class="row">
                      <div class="col-md-6 text-md-end">
                        <button type="submit" class="btn btn-primary">
                          Cập nhật
                        </button>
                      </div>
                      <div class="col-md-6 text-md-start">
                        <button
                          type="submit"
                          class="btn btn-danger"
                          @click="closeEditDialog"
                        >
                          Đóng
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>
        <!-- End Edit Rank -->
        <hr />
        <h6 class="mb-0 text-uppercase">Danh sách Rank đã tạo</h6>
        <br />
        <div class="card">
          <div class="card-body">
            <div class="table-responsive">
              <div class="row">
                <div class="col-sm-12 col-md-6">
                  <div class="dataTables_length" id="example_length">
                    <a
                      href="/admin/rank/create"
                      class="btn btn-primary mb-3 mb-lg-0"
                      ><i class="bx bxs-plus-square"></i>Tạo rank mới</a
                    >
                  </div>
                </div>
                <!-- <div class="col-sm-12 col-md-6">
                  <div class="dataTables_filter">
                    <input
                      type="search"
                      class="form-control form-control-sm"
                      placeholder
                      aria-controls="example"
                    />
                  </div>
                </div> -->
              </div>
              <br />
              <div class="row">
                <div class="col-sm-12">
                  <table
                    id="example"
                    class="table table-striped table-bordered"
                    style="width: 100%"
                  >
                    <thead>
                      <tr>
                        <th class="align-middle text-center">Tên xếp hạng</th>
                        <th class="align-middle text-center">
                          Số tiền tối thiểu
                        </th>
                        <th class="align-middle text-center">
                          Số tiền cần đạt
                        </th>
                        <th class="align-middle text-center">Khung Avatar</th>
                        <th class="align-middle text-center">Hình nền</th>
                        <th class="align-middle text-center">Action</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr v-for="rank in paginatedList" :key="rank.id">
                        <!-- <td> {{rank.id}}</td> -->
                        <td class="align-middle">{{ rank.rank_name }}</td>
                        <td class="align-middle text-center">
                          {{
                            rank.minimum_balance.toLocaleString("vi-VN", {
                              style: "currency",
                              currency: "VND",
                            })
                          }}
                        </td>
                        <td class="align-middle text-center">
                          {{
                            rank.maximum_balance.toLocaleString("vi-VN", {
                              style: "currency",
                              currency: "VND",
                            })
                          }}
                        </td>
                        <td class="align-middle text-center">
                          <img
                            :src="rank.avatar_frame_image"
                            width="150"
                            height="150"
                            class="border rounded cursor-pointer"
                          />
                        </td>
                        <td class="align-middle text-center">
                          <img
                            :src="rank.background_image"
                            width="200"
                            height="50"
                            class="border rounded cursor-pointer"
                          />
                        </td>
                        <td class="align-middle text-center">
                          <div class="d-flex justify-content-center">
                            <div class="me-3">
                              <button
                                type="button"
                                class="btn btn-outline-success"
                              >
                                <i
                                  class="lni lni-pencil me-0"
                                  @click="openEditDialog(rank.id)"
                                ></i>
                              </button>
                            </div>
                            <div class="me-3">
                              <button
                                type="button"
                                class="btn btn-outline-danger"
                                @click="deleteRank(rank.id)"
                              >
                                <i class="lni lni-trash me-0"></i>
                              </button>
                            </div>
                          </div>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
              <!-- Phân trang -->
              <nav aria-label="Page navigation example">
                <ul class="pagination">
                  <li
                    class="page-item"
                    :class="{ disabled: currentPage === 1 }"
                  >
                    <a
                      class="page-link"
                      @click="changePage(currentPage - 1)"
                      aria-label="Previous"
                    >
                      <span aria-hidden="true">&laquo;</span>
                    </a>
                  </li>

                  <li
                    v-for="page in pages"
                    :key="page"
                    class="page-item"
                    :class="{ active: page === currentPage }"
                  >
                    <a class="page-link" @click="changePage(page)">{{
                      page
                    }}</a>
                  </li>

                  <li
                    class="page-item"
                    :class="{ disabled: currentPage === totalPages }"
                  >
                    <a
                      class="page-link"
                      @click="changePage(currentPage + 1)"
                      aria-label="Next"
                    >
                      <span aria-hidden="true">&raquo;</span>
                    </a>
                  </li>
                </ul>
              </nav>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--End page wrapper  . Dữ liệu chính-->

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
  name: "listRank",
  components: {
    switcher,
    slibarWrapper,
    startHeaderVue,
  },

  data() {
    return {
      isEditDialogOpen: false,
      isLoading: false,
      itemsPerPage: 3,
      currentPage: 1,
      listRanks: [],
      editRankData: {
        id: null,
        rank_name: "",
        minimum_balance: 0,
        maximum_balance: 0,
        avatar_frame_image: null,
        background_image: null,
      },
      avatarImage: null,
      backgroundImage: null,
      isImageSelected: false,
    };
  },

  methods: {
    openEditDialog(rank) {
      // Mở Dialog và gán dữ liệu của rank vào editRankData
      this.getRankById(rank);
      this.isEditDialogOpen = true;
      this.scrollToEditForm();
      this.editRankData = { ...rank };
      this.isImageSelected = true;
    },
    scrollToEditForm() {
      this.$nextTick(() => {
        this.$refs.editForm.scrollIntoView({
          behavior: "smooth",
          block: "start",
        });
      });
    },
    closeEditDialog() {
      // Đóng Dialog và làm sạch dữ liệu editRankData
      this.isEditDialogOpen = false;
      this.editRankData = {
        id: null,
        rank_name: "",
        minimum_balance: 0,
        maximum_balance: 0,
        avatar_frame_image: null,
        background_image: null,
      };
      (this.avatarImage = null), (this.backgroundImage = null);
      this.isImageSelected = true;
    },

    async getRankById(id) {
      try {
        const response = await RankService.getRankById(id);
        this.editRankData = { ...response.data }; // Lấy dữ liệu từ response và gán vào editRankData
        // Khởi tạo giá trị mặc định cho hình ảnh
      } catch (error) {
        console.error("Error getting rank by ID:", error);
      }
    },
    handleImageUpload(type) {
      const input = event.target;
      const file = input.files[0];

      if (file) {
        // Check which type of image is being uploaded and update the corresponding property
        if (type === "avatarImage") {
          this.avatarImage = file;
          this.editRankData.avatar_frame_image = null;
          this.imageAvatar = URL.createObjectURL(file);
        } else if (type === "backgroundImage") {
          this.backgroundImage = file;
          this.editRankData.avatar_frame_image = null;
          this.imageBackground = URL.createObjectURL(file);
        }
      }
    },
    async updateRank() {
      if (!this.editRankData.maximum_balance) {
        // Sử dụng thư viện Swal để hiển thị thông báo lỗi
        await Swal.fire({
          icon: "error",
          title: "Lỗi",
          text: "Vui lòng nhập số tiền lớn nhất!",
        });
        return; // Ngừng thực hiện hàm nếu có lỗi
      }
      if (!this.editRankData.minimum_balance) {
        // Sử dụng thư viện Swal để hiển thị thông báo lỗi
        await Swal.fire({
          icon: "error",
          title: "Lỗi",
          text: "Vui lòng nhập số tiền nhỏ nhất!",
        });
        return; // Ngừng thực hiện hàm nếu có lỗi
      }
      if (!this.editRankData.rank_name) {
        // Sử dụng thư viện Swal để hiển thị thông báo lỗi
        await Swal.fire({
          icon: "error",
          title: "Lỗi",
          text: "Vui lòng nhập tên xếp hạng!",
        });
        return; // Ngừng thực hiện hàm nếu có lỗi
      }
      if (!this.avatarImage) {
        await Swal.fire({
          icon: "warning",
          text: "Vui lòng chọn lại khung viền của avatar",
        });
        return;
      }
      if (!this.backgroundImage) {
        await Swal.fire({
          icon: "warning",
          text: "Vui lòng chọn bảng hiệu rank",
        });
        return;
      }

      try {
        Swal.fire({
          html: '<div class="spinner-border" style="width: 3rem; height: 3rem;" role="status"><span class="visually-hidden">Loading...</span></div>',
          showCancelButton: false,
          showConfirmButton: false,
          allowOutsideClick: false,
          willOpen: async () => {
            try {
              this.isLoading = true;
              const formData = new FormData();
              formData.append("rank_name", this.editRankData.rank_name);
              formData.append(
                "minimum_balance",
                this.editRankData.minimum_balance
              );
              formData.append(
                "maximum_balance",
                this.editRankData.maximum_balance
              );
              formData.append("adminFrameImage", this.avatarImage);
              formData.append("backgroundImage", this.backgroundImage);

              await RankService.updateRank(this.editRankData.id, formData);

              // Đóng Dialog và làm sạch dữ liệu editRankData sau khi cập nhật thành công
              this.closeEditDialog();

              // Refresh danh sách ranks sau khi cập nhật
              await this.getAllRanks();

              Swal.close();
              await Swal.fire({
                icon: "success",
                title: "Thành công",
                text: "Rank đã được cập nhật thành công!",
              });
            } catch (error) {
              console.error("Error updating rank:", error);
              Swal.close();
              await Swal.fire({
                icon: "error",
                text: "Error updating rank: " + error.message,
              });
            } finally {
              this.isLoading = false;
            }
          },
        });
      } catch (error) {
        console.error("Error updating rank:", error);
      }
    },

    async confirmDelete() {
      // Hiển thị popup xác nhận trước khi delete Rank
      const confirmResult = await Swal.fire({
        title: "Bạn có chắc sẽ xóa nó?",
        text: "Nếu đã chắc chắn xin vui lòng chọn Yes hoặc No?",
        icon: "question",
        showCancelButton: true,
        confirmButtonText: "Yes",
        cancelButtonText: "No",
      });
      if (confirmResult.isConfirmed) {
        // Người dùng bấm Yes, tiến hành tạo rank
        await this.deleteRank();

        // Bạn cũng có thể thêm các hành động khác sau khi tạo rank thành công ở đây
      } else {
        // Người dùng bấm No hoặc đóng popup, không thực hiện gì cả
      }
    },

    async getAllRanks() {
      try {
        const response = await RankService.getRank();
        const data = response.data;

        // Gán giá trị cho cả gamelist và originalGamelist
        this.listRanks = data;
        // this.originalGamelist = data;
      } catch (error) {
        console.error("Lỗi khi lấy danh sách trò chơi: ", error);
      }
    },
    async deleteRank(id) {
      try {
        await RankService.deleteRank(id);
        // Refresh the list after deletion
        this.getAllRanks();
      } catch (error) {
        console.error("Lỗi khi xóa xếp hạng: ", error);
      }
    },
    changePage(page) {
      if (page >= 1 && page <= this.totalPages) {
        this.currentPage = page;
      }
    },
  },

  computed: {
    formattedMinimumBalance: {
      get() {
        // Hiển thị giá trị theo định dạng số thập phân và thêm đơn vị VNĐ
        return parseFloat(this.editRankData.minimum_balance).toLocaleString(
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
        this.editRankData.minimum_balance = parseFloat(
          value.replace(/[^\d.]/g, "")
        );
        if (this.editRankData.minimum_balance > 999999999) {
          Swal.fire({
            icon: "error",
            title: "Lỗi",
            text: "Giá tiền vượt quá giới hạn khi nhập",
          });
        }
        return (this.editRankData.minimum_balance = 0);
      },
    },
    formattedMaximumBalance: {
      get() {
        // Hiển thị giá trị theo định dạng số thập phân và thêm đơn vị VNĐ
        return parseFloat(this.editRankData.maximum_balance).toLocaleString(
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
        this.editRankData.maximum_balance = parseFloat(
          value.replace(/[^\d.]/g, "")
        );
        if (this.editRankData.maximum_balance > 999999999) {
          Swal.fire({
            icon: "error",
            title: "Lỗi",
            text: "Giá tiền vượt quá giới hạn khi nhập",
          });
          return (this.editRankData.maximum_balance = 0);
        }
      },
    },
    paginatedList() {
      const start = (this.currentPage - 1) * this.itemsPerPage;
      const end = start + this.itemsPerPage;
      return this.listRanks.slice(start, end);
    },
    totalPages() {
      return Math.ceil(this.listRanks.length / this.itemsPerPage);
    },
    pages() {
      return Array.from({ length: this.totalPages }, (_, index) => index + 1);
    },
  },

  created() {
    this.getAllRanks();
  },
};
</script>


