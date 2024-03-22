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
                  Tạo mới Item
                </li>
              </ol>
            </nav>
          </div>
        </div>
        <!--end breadcrumb-->
        <div class="card">
          <div class="card-body p-4">
            <h5 class="card-title">Tạo item mới</h5>
            <hr />
            <div class="form-body mt-4">
              <form
                class="row g-3 needs-validation was-validated"
                novalidate
                enctype="multipart/form-data"
                @submit.prevent="createNewItem"
              >
                <div class="row">
                  <div class="border border-3 p-4 rounded">
                    <div class="col-lg-12">
                      <div class="mb-3">
                        <div class="row g-3">
                          <div class="col-md-5">
                            <label for="itemName" class="form-label"
                              >Tên Xếp Hạng</label
                            >
                            <input
                              type="text"
                              v-model="itemData.name"
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
                              required
                            />
                            <div class="valid-feedback">Hợp lệ</div>
                            <div class="invalid-feedback">
                              Vui Lòng Nhập hình ảnh
                            </div>
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
                                v-model="formattedPrice"
                                id="priceImage"
                                class="form-control"
                                placeholder="Enter price title"
                                required
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
                                v-if="imageReview"
                                :src="imageReview"
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
                <button type="submit" class="btn btn-primary">Tạo Item</button>
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
import Swal from "sweetalert2";
import ItemService from "@/service/ItemService";
export default {
  name: "CreateItem",
  components: {
    switcher,
    
    slibarWrapper,
    startHeaderVue,
  },
  data() {
    return {
      imageReview: null,
      forms: [{}],
      itemData: {
        name: "",
        price: 0,
        imageUrl: null,
      },
      isLoading: false,
    };
  },
  methods: {
    addFormItem() {
      this.forms.push({});
    },

    async createNewItem() {
      try {
        // Kiểm tra điều kiện ràng buộc trước khi gửi yêu cầu
        if (!this.itemData.name) {
          // Sử dụng thư viện Swal để hiển thị thông báo lỗi
          await Swal.fire({
            icon: "error",
            title: "Lỗi",
            text: "Vui lòng nhập tên Item!",
          });
          return; // Ngừng thực hiện hàm nếu có lỗi
        }
        if (!this.itemData.imageUrl) {
          // Sử dụng thư viện Swal để hiển thị thông báo lỗi
          await Swal.fire({
            icon: "error",
            title: "Lỗi",
            text: "Vui lòng chọn ảnh!",
          });
          return; // Ngừng thực hiện hàm nếu có lỗi
        }
        // Kiểm tra nếu price
        if (parseFloat(this.itemData.price) <= 0 || !this.itemData.price) {
          // Sử dụng thư viện Swal để hiển thị thông báo lỗi
          await Swal.fire({
            icon: "error",
            title: "Lỗi",
            text: "Giá item không hợp lệ. Vui lòng lại!",
          });
          return; // Ngừng thực hiện hàm nếu có lỗi
        }
        Swal.fire({
          html: '<div class="spinner-border" style="width: 3rem; height: 3rem;" role="status"><span class="visually-hidden">Loading...</span></div>',
          showCancelButton: false,
          showConfirmButton: false,
          allowOutsideClick: false,
          willOpen: () => {
            const itemData = new FormData();
            itemData.append("name", this.itemData.name);
            itemData.append("price", this.itemData.price);
            itemData.append("imageFile", this.itemData.imageUrl);

            ItemService.addItem(itemData)
              .then(() => {
                // ẩn spinner
                Swal.close();
                Swal.fire({
                  icon: "success",
                  title: "Thành công",
                  text: "Sản phẩm đã được thêm thành công!",
                });
                this.itemData = { name: "", price: 0, imageUrl: null };
                this.imageReview = null;
              })
              .catch((error) => {
                Swal.close();
                Swal.fire({
                  icon: "error",
                  text: "Error updating item: " + error.message,
                });
              });
          },
        });
      } catch (error) {
        console.error("Error creating new game:", error);
        await Swal.fire({
          icon: "error",
          title: "Lỗi",
          text: "Đã xảy ra lỗi khi tạo sản phẩm!",
        });
      }
    },
    handleImageUpload(type) {
      const input = event.target;
      const file = input.files[0];

      if (file) {
        // Check which type of image is being uploaded and update the corresponding property
        if (type === "imageUrl") {
          this.itemData.imageUrl = file;
          this.imageReview = URL.createObjectURL(file);
        }
      }
    },
  },
  computed: {
    formattedPrice: {
      get() {
        // Hiển thị giá trị theo định dạng số thập phân và thêm đơn vị VNĐ
        return parseFloat(this.itemData.price).toLocaleString("en-US", {
          // style: "currency",
          // currency: "VND",
          minimumFractionDigits: 0, // Số lượng số thập phân tối thiểu
          maximumFractionDigits: 2,
        });
        // Đưa đơn vị tiền "VNĐ" về sau số thập phân
      },
      set(value) {
        // Lưu giá trị dưới dạng số khi người dùng nhập
        this.itemData.price = parseFloat(value.replace(/[^\d.]/g, ""));
        if (this.itemData.price > 999999999) {
          Swal.fire({
            icon: "error",
            title: "Lỗi",
            text: "Giá tiền ITEM vượt quá 100 triệu giới hạn khi nhập",
          });
          return this.itemData.price = 0;
        }
      },
    },
  },
};
</script>
