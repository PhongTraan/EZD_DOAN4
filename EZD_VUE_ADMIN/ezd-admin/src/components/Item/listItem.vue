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
            <div class="breadcrumb-title pe-3">Item</div>
            <div class="ps-3">
              <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0 p-0">
                  <li class="breadcrumb-item">
                    <a href="javascript:;"><i class="bx bx-home-alt"></i></a>
                  </li>
                  <li class="breadcrumb-item active" aria-current="page">
                    List Items
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
                        href="/admin/item/create"
                        class="btn btn-primary mb-3 mb-lg-0"
                        ><i class="bx bxs-plus-square"></i>Tạo item mới</a
                      >
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div> -->
          <div v-if="isEditDialogOpen" ref="editForm" class="card">
            <div class="card-body p-4">
              <h5 class="card-title">Chỉnh sửa item mới</h5>
              <hr />
              <div class="form-body mt-4">
                <form
                  class="row g-3 needs-validation was-validated"
                  novalidate
                  enctype="multipart/form-data"
                  @submit.prevent="updateItems"
                >
                  <div class="row">
                    <div class="border border-3 p-4 rounded">
                      <div class="col-lg-12">
                        <div class="mb-3">
                          <div class="row g-3">
                            <div class="col-md-5">
                              <label for="itemName" class="form-label"
                                >Tên Icon</label
                              >
                              <input
                                type="text"
                                v-bind="listItems.name"
                                v-model="editItemData.name"
                                id="itemName"
                                class="form-control"
                                placeholder="Enter product title"
                                required
                              />
                              <div class="valid-feedback">Hợp lệ</div>
                              <div class="invalid-feedback">
                                Vui Lòng Nhập Tên Item
                              </div>
                            </div>
                            <div class="col-md-7">
                              <label for="imageUrl" class="form-label"
                                >Hình ảnh Icon</label
                              >
                              <input
                                id="imageUrl"
                                @change="handleImageUpload('imageUrl')"
                                type="file"
                                accept=".jpg, .png, image/jpeg, image/png"
                                multiple
                              />
                            </div>
                          </div>
                          <br />
                          <div class="mb-3">
                            <div class="row g-3">
                              <div class="col-md-5">
                                <label for="priceImage" class="form-label"
                                  >Giá tiền của Item</label
                                >
                                <input
                                  type="text"
                                  v-bind="editItemData.price"
                                  v-model="formattedPrice"
                                  id="priceImage"
                                  class="form-control"
                                  placeholder="Enter product title"
                                />
                                <div class="valid-feedback">Hợp lệ</div>
                                <div class="invalid-feedback">
                                  Vui Lòng Nhập Giá Tiền
                                </div>
                              </div>
                              <div class="col-md-7">
                                <label for="imageReview" class="form-label"
                                  >Hiển thị hình ảnh</label
                                >
                                <img
                                  id="imageReview"
                                  v-if="isImageSelected"
                                  :src="imageReview"
                                  class="img-fluid"
                                  alt="Preview"
                                />
                                <img
                                  v-else
                                  id="imageReview"
                                  :src="editItemData.imageUrl"
                                  class="img-fluid"
                                  alt="Preview"
                                />
                              </div>
                            </div>
                          </div>
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
                        @click="closeDialog"
                      >
                        Đóng
                      </button>
                    </div>
                  </div>
                </form>
              </div>
            </div>
          </div>
          <hr />
          <h6 class="mb-0 text-uppercase">Danh sách Item đã tạo</h6>
          <br />
          <div class="card">
            <div class="card-body">
              <div class="table-responsive">
                <div class="row">
                  <div class="col-sm-12 col-md-6">
                    <div class="dataTables_length" id="example_length">
                      <a
                        href="/admin/item/create"
                        class="btn btn-primary mb-3 mb-lg-0"
                        ><i class="bx bxs-plus-square"></i>Tạo item mới</a
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
                          <th class="align-middle text-center">Tên item</th>
                          <th class="align-middle text-center">Số tiền</th>
                          <th class="align-middle text-center">Image</th>
                          <th class="align-middle text-center">Action</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr v-for="item in paginatedList" :key="item.id">
                          <td class="align-middle">{{ item.name }}</td>
                          <td class="align-middle text-center">
                            {{
                              item.price.toLocaleString("vi-VN", {
                                style: "currency",
                                currency: "VND",
                              })
                            }}
                          </td>
                          <td class="align-middle text-center">
                            <img
                              :src="item.imageUrl"
                              width="70"
                              class="border rounded cursor-pointer"
                            />
                          </td>
                          <td class="align-middle text-center">
                            <div class="d-flex justify-content-center">
                              <div class="me-3">
                                <button
                                  type="button"
                                  class="btn btn-outline-success"
                                  @click="openEditItem(item.id)"
                                >
                                  <i class="lni lni-pencil me-0"></i>
                                </button>
                              </div>
                              <!-- <div class="me-3">
                                <button
                                  type="button"
                                  class="btn btn-outline-danger"
                                  @click="deleteItem(item.id)"
                                >
                                  <i class="lni lni-trash me-0"></i>
                                </button>
                              </div> -->
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
  
  import ItemService from "@/service/ItemService";
  import Swal from "sweetalert2";
  
  export default {
    name: "ListItem",
    components: {
      switcher,
    
      slibarWrapper,
      startHeaderVue,

    },
    data() {
      return {
        isEditDialogOpen: false,
        itemsPerPage: 100,
        currentPage: 1,
        listItems: [],
        editItemData: {
          id: null,
          name: "",
          imageUrl: null,
          price: 0.0,
        },
        isLoading: false,
  
        imageReview: null,
        isImageSelected: false,
        selectedImageFile: null,
      };
    },
    methods: {
      openEditItem(item) {
        this.getItemById(item);
        this.isEditDialogOpen = true;
        this.editItemData = { ...item };
        this.scrollToEditForm();
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
      closeDialog() {
        this.isEditDialogOpen = false;
        this.editItemData = {
          id: null,
          name: "",
          imageUrl: null,
          price: 0,
        };
        this.imageReview = null;
        this.isImageSelected = true;
      },
  
      async getItemById(id) {
        try {
          const response = await ItemService.getItemById(id);
          this.editItemData = { ...response.data };
        } catch (error) {
          console.error("Error getting item by ID:", error);
        }
      },
      async getItems() {
        try {
          const response = await ItemService.getItem();
          const data = response.data;
  
          this.listItems = data;
        } catch (error) {
          console.error("Lỗi khi lấy danh sách trò chơi: ", error);
        }
      },
      async updateItems() {
        if (!this.editItemData.name) {
          // Sử dụng thư viện Swal để hiển thị thông báo lỗi
          await Swal.fire({
            icon: "error",
            title: "Lỗi",
            text: "Vui lòng nhập tên Item!",
          });
          return; // Ngừng thực hiện hàm nếu có lỗi
        }
        if (!this.editItemData.price) {
          // Sử dụng thư viện Swal để hiển thị thông báo lỗi
          await Swal.fire({
            icon: "error",
            title: "Lỗi",
            text: "Vui lòng nhập giá Item!",
          });
          return; // Ngừng thực hiện hàm nếu có lỗi
        }
        if (!this.selectedImageFile) {
          await Swal.fire({
            icon: "warning",
            text: "Vui lòng chọn lại icon",
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
                const itemDatas = new FormData();
                itemDatas.append("name", this.editItemData.name);
                itemDatas.append("price", this.editItemData.price);
                itemDatas.append("imageFile", this.selectedImageFile);
  
                await ItemService.updateItem(this.editItemData.id, itemDatas);
                this.closeDialog();
  
                await this.getItems();
                // await this.$router.push("/admin/item");
  
                Swal.close();
                await Swal.fire({
                  icon: "success",
                  title: "Thành công",
                  text: "Item đã được cập nhật thành công!",
                });
              } catch (error) {
                console.error("Lỗi khi cập nhật item: ", error);
                Swal.close();
                await Swal.fire({
                  icon: "error",
                  text: "Error updating item: " + error.message,
                });
              } finally {
                this.isLoading = false;
              }
            },
          });
        } catch (error) {
          console.error("Lỗi khi cập nhật item: ", error);
        }
      },
      handleImageUpload(type) {
        const input = event.target;
        const file = input.files[0];
  
        if (file) {
          // Check which type of image is being uploaded and update the corresponding property
          if (type === "imageUrl") {
            this.selectedImageFile = file;
            this.editItemData.imageUrl = null;
            this.imageReview = URL.createObjectURL(file);
            this.isImageSelected = true;
          }
        }
      },
  
      async deleteItem(id) {
        try {
          await ItemService.deleteItem(id);
  
          this.getItems();
        } catch (error) {
          console.error("Lỗi khi xóa item: ", error);
        }
      },
      changePage(page) {
        if (page >= 1 && page <= this.totalPages) {
          this.currentPage = page;
        }
      },
    },
    computed: {
      paginatedList() {
        const start = (this.currentPage - 1) * this.itemsPerPage;
        const end = start + this.itemsPerPage;
        return this.listItems.slice(start, end);
      },
      totalPages() {
        return Math.ceil(this.listItems.length / this.itemsPerPage);
      },
      pages() {
        return Array.from({ length: this.totalPages }, (_, index) => index + 1);
      },
      formattedPrice: {
        get() {
          // Hiển thị giá trị theo định dạng số thập phân và thêm đơn vị VNĐ
          return parseFloat(this.editItemData.price).toLocaleString("en-US", {
            // style: "currency",
            // currency: "VND",
            minimumFractionDigits: 0, // Số lượng số thập phân tối thiểu
            maximumFractionDigits: 2,
          });
          // Đưa đơn vị tiền "VNĐ" về sau số thập phân
        },
        set(value) {
          // Lưu giá trị dưới dạng số khi người dùng nhập
          this.editItemData.price = parseFloat(value.replace(/[^\d.]/g, ""));
          if (this.editItemData.price > 999999999) {
            Swal.fire({
              icon: "error",
              title: "Lỗi",
              text: "Giá tiền ITEM vượt quá giới hạn khi nhập",
            });
          }
        },
      },
    },
    created() {
      this.getItems();
    },
  };
  </script>
  <style></style>
  