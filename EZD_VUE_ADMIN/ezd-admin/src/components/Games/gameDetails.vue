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
        <!--breadcrumb-->
        <div class="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
          <div class="breadcrumb-title pe-3">Danh Sách Game</div>
          <div class="ps-3">
            <nav aria-label="breadcrumb">
              <ol class="breadcrumb mb-0 p-0">
                <li class="breadcrumb-item">
                  <a href="javascript:;"><i class="bx bx-home-alt"></i></a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">
                  Game Chi Tiết
                </li>
              </ol>
            </nav>
          </div>
          <div class="ms-auto">
            <div class="btn-group">
              <button type="button" class="btn btn-primary">Settings</button>
              <button
                type="button"
                class="btn btn-primary split-bg-primary dropdown-toggle dropdown-toggle-split"
                data-bs-toggle="dropdown"
              >
                <span class="visually-hidden">Toggle Dropdown</span>
              </button>
              <div
                class="dropdown-menu dropdown-menu-right dropdown-menu-lg-end"
              >
                <a class="dropdown-item" href="javascript:;">Action</a>
                <a class="dropdown-item" href="javascript:;">Another action</a>
                <a class="dropdown-item" href="javascript:;"
                  >Something else here</a
                >
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="javascript:;">Separated link</a>
              </div>
            </div>
          </div>
        </div>
        <!--end breadcrumb-->

        <div class="card">
          <div class="row g-0">
            <div class="col-md-4 border-end">
              <img :src="game.imageName" class="img-fluid" alt="..." />
            </div>
            <div class="col-md-8">
              <div class="card-body">
                <h4 class="card-title">{{ game.nameGame }}</h4>
                <div class="d-flex gap-3 py-3">
                  <div class="cursor-pointer">
                    <i class="bx bxs-star text-warning"></i>
                    <i class="bx bxs-star text-warning"></i>
                    <i class="bx bxs-star text-warning"></i>
                    <i class="bx bxs-star text-warning"></i>
                    <i class="bx bxs-star text-secondary"></i>
                  </div>
                  <div>142 reviews</div>
                  <div class="text-success">
                    <i class="bx bxs-cart-alt align-middle"></i> 134 orders
                  </div>
                </div>

                <!-- Bảng hiển thị Roles -->
                <div>
                  <H6
                    style="color: rgb(18, 143, 201); border-bottom: 2px solid rgb(18, 143, 201;"
                  >
                    Vị Trí
                    <img
                      width="25"
                      height="25"
                      src="https://img.icons8.com/nolan/64/new-world.png"
                      alt="new-world"
                    />:
                  </H6>
                  <div class="d-flex flex-wrap">
                    <div
                      class="col-3"
                      v-for="role in game.roles"
                      :key="role.id"
                    >
                      {{ role.name }}
                    </div>
                  </div>
                </div>

                <!-- Bảng hiển thị Genders -->
                <div>
                  <H6
                    style="color: rgb(201, 18, 140); border-bottom: 2px solid rgb(201, 18, 140;"
                  >
                    Giới Tính
                    <img
                      width="25"
                      height="25"
                      src="https://img.icons8.com/nolan/64/gender.png"
                      alt="gender"
                    />:
                  </H6>
                  <div class="d-flex flex-wrap">
                    <div
                      class="col-3"
                      v-for="gender in game.genders"
                      :key="gender.id"
                    >
                      {{ gender.name }}
                    </div>
                  </div>
                </div>

                <!-- Bảng hiển thị Levels -->
                <div>
                  <H6
                    style="color: rgb(9, 172, 123); border-bottom: 2px solid rgb(9, 172, 123;"
                  >
                    Cấp Độ
                    <img
                      width="25"
                      height="25"
                      src="https://img.icons8.com/nolan/64/final-fantasy-xiv.png"
                      alt="final-fantasy-xiv"
                    />:
                  </H6>
                  <div class="d-flex flex-wrap">
                    <div
                      class="col-3"
                      v-for="level in game.levels"
                      :key="level.id"
                    >
                      {{ level.name }}
                    </div>
                  </div>
                </div>

                <hr />

                <div class="d-flex gap-3 mt-3">
                  <a @click="deleteGame(game.id)" class="btn btn-primary">
                    Xóa Game
                  </a>
                </div>
              </div>
            </div>
          </div>
          <hr />
        </div>
        <div class="card">
          <div class="card-body p-4">
            <div>
              <h6 class="card-title">
                Sửa Chi Tiết Trò Chơi :
                <img
                  width="50"
                  height="50"
                  src="https://img.icons8.com/dusk/64/new-world.png"
                  alt="new-world"
                />
              </h6>
            </div>
            <hr />
            <div class="form-body mt-4">
              <div class="row">
                
                <!-- Form for editing the game name -->
                <div class="col-sm-4">
                  <form
                    class="row g-3 needs-validation was-validated"
                    novalidate
                    enctype="multipart/form-data"
                    @submit.prevent="updateGameName"
                  >
                    <div class="col-lg-12">
                      <div class="mb-3">
                        <label for="nameGame" class="form-label"
                          >Tên Trò Chơi</label
                        >
                        <input type="hidden" v-model="game.id" />
                        <input
                          type="text"
                          class="form-control"
                          id="nameGame"
                          v-model="editingGame.nameGame"
                          required
                        />
                        <div class="valid-feedback">Looks good!</div>
                        <div class="invalid-feedback">Vui Lòng Nhập Tên</div>
                      </div>
                    </div>
                    <div class="col-lg-4">
                      <div class="d-grid">
                        <button type="submit" class="btn btn-primary">
                          Lưu
                        </button>
                      </div>
                    </div>
                  </form>
                </div>

                <div class="col-sm-4">
                  <form
                    class="row g-3 needs-validation was-validated"
                    novalidate
                    enctype="multipart/form-data"
                    @submit.prevent="updateGameImage"
                  >
                    <div class="col-lg-12">
                      <div class="mb-3">
                        <label for="image" class="form-label"
                          >Ảnh Trò Chơi</label
                        >
                        <input type="hidden" v-model="game.id" />
                        <input
                          type="file"
                          class="form-control"
                          id="image"
                          @change="handleImageChange"
                          required
                        />
                        <div class="valid-feedback">Looks good!</div>
                        <div class="invalid-feedback">Vui Lòng Chọn File</div>
                      </div>
                    </div>
                    
                    <div class="col-lg-4">
                      <div class="d-grid">
                        <button type="submit" class="btn btn-primary">
                          Lưu
                        </button>
                      </div>
                    </div>
                  </form>
                </div>
                <!-- Form for editing the game image -->
                <div class="col-sm-4">
                <div class="col-lg-12">
                  <div class="mb-3" v-if="!imagePreviewUrl">
                  
                    <img
                      :src="game.imageName"
                      style="width: 200px; height: 160px"
                    />
                  </div>
                  <div class="mb-3" v-if="imagePreviewUrl">
                    <img
                      :src="imagePreviewUrl"
                      style="width: 200px; height: 160px"
                    />
                  </div>
                </div>
                </div>
                <hr />
              </div>
              <div class="row">
                <div class="col-sm-4">
                  <form
                    class="row g-3 needs-validation was-validated"
                    novalidate
                    enctype="multipart/form-data"
                    @submit.prevent="updateGameLevels"
                  >
                    <div class="col-lg-12">
                      <div class="mb-3">
                        <label for="nameGame" class="form-label">
                          Danh Sách Cấp Độ Trò Chơi :</label
                        >
                        <input type="hidden" v-model="game.id" />
                        <select
                          id="bsValidation10"
                          class="form-select"
                          style="height: 250px"
                          required
                          multiple
                          v-model="editingGame.levels"
                        >
                          <option disabled>Lựa Chọn Dưới Đây...</option>
                          <option
                            v-for="level in levelList"
                            :key="level.id"
                            :value="level.id"
                          >
                            {{ level.name }}
                          </option>
                        </select>
                        <div class="valid-feedback">Looks good!</div>
                        <div class="invalid-feedback">Vui Lòng Chọn</div>
                      </div>
                    </div>
                    <div class="col-lg-4">
                      <div class="d-grid">
                        <button type="submit" class="btn btn-primary">
                          Lưu
                        </button>
                      </div>
                    </div>
                  </form>
                </div>

                <div class="col-sm-4">
                  <form
                    class="row g-3 needs-validation was-validated"
                    novalidate
                    enctype="multipart/form-data"
                    @submit.prevent="updateGameRoles"
                  >
                    <div class="col-lg-12">
                      <div class="mb-3">
                        <label for="role" class="form-label"
                          >Chỉnh Sửa Roles Trò Chơi :</label
                        >
                        <input type="hidden" v-model="game.id" />
                        <select
                          id="bsValidationRoles"
                          class="form-select"
                          required
                          multiple
                          style="height: 250px"
                          v-model="editingGame.roles"
                        >
                          <option disabled>Lựa Chọn Dưới Đây...</option>
                          <option
                            v-for="role in roleList"
                            :key="role.id"
                            :value="role.id"
                          >
                            {{ role.name }}
                          </option>
                        </select>
                        <div class="valid-feedback">Looks good!</div>
                        <div class="invalid-feedback">Vui Lòng Chọn</div>
                      </div>
                    </div>
                    <div class="col-lg-4">
                      <div class="d-grid">
                        <button type="submit" class="btn btn-primary">
                          Lưu
                        </button>
                      </div>
                    </div>
                  </form>
                </div>
                <div class="col-sm-4">
                  <form
                    class="row g-3 needs-validation was-validated"
                    novalidate
                    enctype="multipart/form-data"
                    @submit.prevent="updateGameGenders"
                  >
                    <div class="col-lg-12">
                      <div class="mb-3">
                        <label for="gender" class="form-label"
                          >Chỉnh Sửa Genders Trò Chơi :</label
                        >
                        <input type="hidden" v-model="game.id" />
                        <select
                          id="bsValidationGenders"
                          class="form-select"
                          required
                          multiple
                          style="height: 250px"
                          v-model="editingGame.genders"
                        >
                          <option disabled>Lựa Chọn Dưới Đây...</option>
                          <option
                            v-for="gender in genderList"
                            :key="gender.id"
                            :value="gender.id"
                          >
                            {{ gender.name }}
                          </option>
                        </select>
                        <div class="valid-feedback">Looks good!</div>
                        <div class="invalid-feedback">Vui Lòng Chọn</div>
                      </div>
                    </div>
                    <div class="col-lg-4">
                      <div class="d-grid">
                        <button type="submit" class="btn btn-primary">
                          Lưu
                        </button>
                      </div>
                    </div>
                  </form>
                </div>
              </div>
              <!--end row-->
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--end page wrapper -->
    <!--start overlay-->
    <div class="overlay toggle-icon"></div>
    <!--end overlay-->
    <!--Start Back To Top Button-->
    <a href="javaScript:;" class="back-to-top"
      ><i class="bx bxs-up-arrow-alt"></i
    ></a>
    <!--End Back To Top Button-->
    <footer class="page-footer">
      <p class="mb-0">Copyright © 2022. All right reserved.</p>
    </footer>
  </div>
  <!--end wrapper-->
  <!--start switcher-->
  <switcher></switcher>
  <!--end switcher-->
  <!-- Các phần tử khác của trang gameDetails -->
</template>
<script>
import ForGameService from "@/service/ForGameService";
import GameService from "@/service/GameService";
import Swal from "sweetalert2";

import switcher from "@/pages/switcher.vue";
import slibarWrapper from "@/pages/sidebarWrapper.vue";
import startHeaderVue from "@/pages/startHeader.vue";
export default {
  name: "gameDetails",
  props: ["id"], // Nhận tham số id từ URL
  components: {
    switcher,
    slibarWrapper,
    startHeaderVue,
  },
  data() {
    return {
      imagePreviewUrl: null, // Sử dụng để hiển thị hình ảnh được chọn

      selectedLevels: [],
      showEditForm: false,
      game: {}, // Để lưu trữ thông tin chi tiết của trò chơi
      //editing
      editingGame: {},
      roleList: [], // Make sure you initialize this with your data
      levelList: [],
      genderList: [],
      gamelist: [],
    };
  },

  methods: {
    async updateGameGenders() {
      try {
        const response = await GameService.updateGameGenders(
          this.game.id,
          this.editingGame.genders
        );

        if (response.id) {
          // Cập nhật trò chơi
          this.getGameDetails(this.id);
          Swal.fire({
            position: "top-end",
            icon: "success",
            title: "Cập nhật Genders thành công!",
            showConfirmButton: false,
            timer: 1500,
          });
        }
      } catch (error) {
        console.error("Error updating Game Genders:", error);
      }
    },

    async updateGameRoles() {
      try {
        // Lấy giá trị đã chọn từ editingGame.roles và chuyển thành một mảng các IDs

        const response = await GameService.updateGameRoles(
          this.game.id,
          this.editingGame.roles
        );

        if (response.id) {
          // Cập nhật trò chơi
          this.getGameDetails(this.id);
          Swal.fire({
            position: "top-end",
            icon: "success",
            title: "Cập nhật Roles thành công!",
            showConfirmButton: false,
            timer: 1500,
          });
        }
      } catch (error) {
        console.error("Error updating Game Roles:", error);
      }
    },

    async updateGameLevels() {
      try {
        const response = await GameService.updateGameLevels(
          this.game.id,
          this.editingGame.levels
        );
        // Xử lý kết quả từ API nếu cần
        if (response.id) {
          // Cập nhật trò chơi
          this.getGameDetails(this.id);
          Swal.fire({
            position: "top-end",
            icon: "success",
            title: "Cập nhật Cấp Độ Thành Công!",
            showConfirmButton: false,
            timer: 1500,
          });
        }
      } catch (error) {
        console.error("Error updating Game Levels:", error);
      }
    },
    handleImageChange(event) {
      if (event.target.files.length > 0) {
        this.imagePreviewUrl = null; // Đặt lại imagePreviewUrl
        this.editedImage = event.target.files[0]; // Lưu ảnh chỉnh sửa vào biến

        // Tạo một đối tượng FileReader để xem trước hình ảnh
        const reader = new FileReader();
        reader.onload = (e) => {
          this.imagePreviewUrl = e.target.result; // Cập nhật imagePreviewUrl với dữ liệu hình ảnh
        };
        reader.readAsDataURL(this.editedImage); // Đọc hình ảnh và gọi hàm onload
      }
    },
    async updateGameImage() {
      if (!this.editedImage) {
        Swal.fire({
          icon: "warning",
          text: "Vui lòng chọn ảnh trò chơi",
        });
        return;
      }

      try {
        const response = await GameService.updateGameImage(
          this.game.id,
          this.editedImage
        );

        if (response.id) {
          this.editedImage = null;
          this.imagePreviewUrl = null;
          // Cập nhật trò chơi sau khi cập nhật ảnh (nếu cần)
          this.getGameDetails(this.id);
          Swal.fire({
            position: "top-end",
            icon: "success",
            title: "Cập nhật ảnh thành công!",
            showConfirmButton: false,
            timer: 1500,
          });
        }
        // Xử lý phản hồi từ máy chủ (nếu cần)
      } catch (error) {
        console.error("Error updating game image:", error);
      }
    },

    async updateGameName() {
      try {
        if (!this.editingGame.nameGame) {
          Swal.fire({
            icon: "warning",
            text: "Vui lòng điền tên trò chơi",
          });
          return;
        }

        // Check if the new name is already in use by other games (excluding the current game)
        const isNameOfGameExist = this.gamelist.some(
          (game) =>
            game.id !== this.editingGame.id && // Exclude the current game from the check
            game.nameGame.toLowerCase() ===
              this.editingGame.nameGame.toLowerCase()
        );

        if (isNameOfGameExist) {
          // Handle the error when a different game is using the new name
          Swal.fire({
            icon: "error",
            title: "Trùng tên",
            text: "Tên này đã được sử dụng bởi trò chơi khác!",
          });
          return;
        }
        const response = await GameService.updateGameName(
          this.game.id,
          this.editingGame.nameGame
        );
        if (response.id) {
          this.editingGame.nameGame = null;
          this.getGameDetails(this.id);
          Swal.fire({
            position: "top-end",
            icon: "success",
            title: "Cập nhật thành công!",
            showConfirmButton: false,
            timer: 1500,
          });
        }
        // Xử lý phản hồi từ máy chủ (nếu cần)
      } catch (error) {
        console.error("Error updating game name:", error);
      }
    },

    async getAllGames() {
      try {
        const response = await GameService.getAllGames();
        this.gamelist = response.data.sort((a, b) => b.id - a.id);
      } catch (error) {
        console.error("Lỗi khi lấy danh sách trò chơi: ", error);
      }
    },
    // get all
    async getAllLevels() {
      try {
        const response = await ForGameService.getAllLevelGames();
        this.levelList = response.data.sort((a, b) => b.id - a.id);
      } catch (error) {
        console.error("Error fetching levels:", error);
      }
    },
    async getAllRoles() {
      try {
        const response = await ForGameService.getAllRoleGames();
        this.roleList = response.data.sort((a, b) => b.id - a.id);
      } catch (error) {
        console.error("Error fetching roles:", error);
      }
    },
    async getAllGenders() {
      try {
        const response = await ForGameService.getAllGenderGames();
        this.genderList = response.data.sort((a, b) => b.id - a.id);
      } catch (error) {
        console.error("Error fetching genders:", error);
      }
    },
    async deleteGame(id) {
      try {
        const result = await Swal.fire({
          title: "Xác nhận xóa",
          text: "Bạn có chắc muốn xóa game này?",
          icon: "warning",
          showCancelButton: true,
          confirmButtonText: "Xóa",
          cancelButtonText: "Hủy",
        });

        if (result.isConfirmed) {
          // Nếu người dùng xác nhận xóa
          await GameService.deleteGame(id);
          await Swal.fire({
            icon: "success",
            title: "Xóa thành công",
            text: "Game đã được xóa thành công!",
          });

          // Sau khi xóa thành công, chuyển về trang /game
          this.$router.push("/admin/game");
        } else if (result.dismiss === Swal.DismissReason.cancel) {
          // Nếu người dùng từ chối xóa
          await Swal.fire({
            icon: "info",
            title: "Hủy thao tác",
            text: "Bạn đã hủy thao tác xóa game.",
          });
        }
      } catch (error) {
        console.error("Lỗi khi xóa game:", error);
      }
    },

    async getGameDetails(id) {
      try {
        // Sử dụng GameService để lấy thông tin game theo id
        const response = await GameService.getGameById(id);
        this.game = response; // Lưu thông tin game vào biến game
      } catch (error) {
        console.error("Lỗi khi lấy chi tiết trò chơi: ", error);
      }
    },
  },
  async created() {
    // Gọi phương thức để lấy thông tin game dựa vào id
    this.getGameDetails(this.id);
    await this.getAllGames();
    await this.getAllLevels();
    await this.getAllRoles();
    await this.getAllGenders();
  },
};
</script>
