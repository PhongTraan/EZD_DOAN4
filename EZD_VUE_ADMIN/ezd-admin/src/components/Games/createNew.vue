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
          <div class="breadcrumb-title pe-3">Quản Lý Trò Chơi</div>
          <div class="ps-3">
            <nav aria-label="breadcrumb">
              <ol class="breadcrumb mb-0 p-0">
                <li class="breadcrumb-item">
                  <a href="javascript:;"><i class="bx bx-home-alt"></i></a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">
                  Tạo Mới
                </li>
              </ol>
            </nav>
          </div>

        </div>
        <!--end breadcrumb-->

        <div class="card">
          <div class="card-body p-4">
            <div @click="showCreateForm = !showCreateForm">
              <span class="card-title">
                <h6 class="card-title">
                  Thêm Mới Trò Chơi
                  <img
                    width="64"
                    height="64"
                    src="https://img.icons8.com/dusk/64/dota.png"
                    alt="dota"
                  />:
                </h6>
              </span>
            </div>
            <hr />
            <div class="form-body mt-4" v-if="showCreateForm">
              <div class="row">
                <form
                  class="row g-3 needs-validation was-validated"
                  novalidate
                  enctype="multipart/form-data"
                  @submit.prevent="createNewGame"
                >
                  <div class="col-lg-6">
                    <div class="mb-3">
                      <label for="bsValidation1" class="form-label"
                        ><strong>Tên Trò Chơi:</strong></label
                      >
                      <input
                        type="text"
                        class="form-control"
                        id="bsValidation1"
                        placeholder="Vui Lòng Nhập Tên"
                        v-model="nameOfGame"
                        required
                      />
                      <div class="valid-feedback">Looks good!</div>
                      <div class="invalid-feedback">
                        Vui Lòng Nhập Tên
                      </div>
                    </div>
                    <div class="mb-3">
                      <label for="bsValidation2" class="form-label"
                        ><strong>Ảnh Trò Chơi:</strong></label
                      >
                      <input
                        type="file"
                        class="form-control"
                        id="bsValidation2"
                        placeholder="Ảnh Trò Chơi"
                        @change="handleImageChange"
                        required
                      />
                      <div class="valid-feedback">Looks good!</div>
                      <div class="invalid-feedback">
                        Vui Lòng Chọn File
                     
                      </div>
                    </div>
                    <div class="mb-3">
                      <label for="bsValidation2" class="form-label"
                        ><strong>Ảnh Xem Trước:</strong></label
                      >

                      <img
                        id="previewImage"
                        class="img-fluid"
                        v-if="imagePreviewUrl"
                        :src="imagePreviewUrl"
                        style="width: 400px; height: 300px"
                      />
                    </div>
                  </div>

                  <div class="col-lg-6">
                    <div class="row g-3">
                      <div class="col-12">
                        <label for="bsValidation10" class="form-label"
                          ><strong>Cấp Độ:</strong></label
                        >
                        <select
                          id="bsValidation10"
                          class="form-select"
                          required
                          multiple
                          v-model="selectedLevelIds"
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
                        <div class="valid-feedback">
                          Looks good! Chọn Nhiều Bằng Ctrl +
                        </div>
                        <div class="invalid-feedback">
                          Vui Lòng Chọn Ít Nhất 1 Giá Trị
                          
                        </div>
                      </div>
                      <div class="col-12">
                        <label for="bsValidation11" class="form-label"
                          ><strong>Vị Trị:</strong></label
                        >
                        <select
                          id="bsValidation11"
                          class="form-select"
                          required
                          multiple
                          v-model="selectedRoleIds"
                        >
                          <option disabled>Lựa Chọn Dưới Đây...</option>
                          <option
                            v-for="role in allRoles"
                            :key="role.id"
                            :value="role.id"
                          >
                            {{ role.name }}
                          </option>
                        </select>
                        <div class="valid-feedback">
                          Looks good! Chọn Nhiều Bằng Ctrl +
                        </div>
                        <div class="invalid-feedback">
                          Vui Lòng Chọn Ít Nhất 1 Giá Trị
                          
                        </div>
                      </div>
                      <div class="col-12">
                        <label for="bsValidation12" class="form-label"
                          ><strong>Giới Tính:</strong></label
                        >
                        <select
                          id="bsValidation12"
                          class="form-select"
                          required
                          multiple
                          v-model="selectedGenderIds"
                        >
                          <option disabled>Lựa Chọn Dưới Đây...</option>
                          <option
                            v-for="gender in allGenders"
                            :key="gender.id"
                            :value="gender.id"
                          >
                            {{ gender.name }}
                          </option>
                        </select>
                        <div class="valid-feedback">
                          Looks good! Chọn Nhiều Bằng Ctrl +
                        </div>
                        <div class="invalid-feedback">
                          Vui Lòng Chọn Ít Nhất 1 Giá Trị
                          
                        </div>
                      </div>

                      <div class="col-12">
                        <div class="d-grid">
                          <button type="submit" class="btn btn-primary">
                            Lưu
                          </button>
                        </div>
                      </div>
                    </div>
                  </div>
                </form>
              </div>
              <!--end row-->
            </div>
          </div>
        </div>
        <div class="container-fluid">
          <div class="row">
            <!-- Create new Role-->
            <div class="col-sm-4">
              <div class="card">
                <div
                  class="card-header"
                  @click="showCreateRoleForm = !showCreateRoleForm"
                >
                  <h6 style="color: rgb(18, 143, 201)">
                    Tạo Mới Vị Trí :
                    <img
                      width="30"
                      height="30"
                      src="https://img.icons8.com/nolan/64/new-world.png"
                      alt="new-world"
                    />
                  </h6>
                </div>
                <div class="card-body" v-if="showCreateRoleForm">
                  <form
                    class="was-validated"
                    novalidate
                    enctype="multipart/form-data"
                    @submit.prevent="createNewRoleGame"
                  >
                    <div class="row g-3">
                      <div class="col-md-12">
                        <label class="form-label" for="nameOfGame"
                          ><strong>Tên Vị Trí:</strong></label
                        >
                        <input
                          class="form-control"
                          id="nameOfGame"
                          v-model="nameRole"
                          type="text"
                          required
                        />
                        <div class="invalid-feedback">
                          Vui Lòng Nhập Tên
                          
                        </div>
                        <div class="valid-feedback">Looks good!</div>
                      </div>
                      <div class="col-md-12">
                        <button class="btn btn-primary" type="submit">
                          Create
                        </button>
                      </div>
                    </div>
                  </form>
                </div>
              </div>
            </div>
            <!-- Create new Level-->
            <div class="col-sm-4">
              <div class="card">
                <div
                  class="card-header"
                  @click="showCreateLevelForm = !showCreateLevelForm"
                >
                  <h6 style="color: rgb(9, 172, 123)">
                    Tạo Mới Cấp Độ :
                    <img
                      width="30"
                      height="30"
                      src="https://img.icons8.com/nolan/64/final-fantasy-xiv.png"
                      alt="final-fantasy-xiv"
                    />
                  </h6>
                </div>
                <div class="card-body" v-if="showCreateLevelForm">
                  <form
                    class="was-validated"
                    novalidate
                    @submit.prevent="createNewLevelGame"
                  >
                    <div class="row g-3">
                      <div class="col-md-12">
                        <label class="form-label" for="nameLevel"
                          ><strong>Tên Cấp Độ:</strong></label
                        >
                        <input
                          class="form-control"
                          id="nameLevel"
                          v-model="nameLevel"
                          type="text"
                          required
                        />
                        <div class="invalid-feedback"></div>
                        <div class="invalid-feedback">
                          Vui Lòng Nhập Tên
                          
                        </div>
                        <div class="valid-feedback">Looks good!</div>
                      </div>
                      <div class="col-md-12">
                        <button class="btn btn-primary" type="submit">
                          Create
                        </button>
                      </div>
                    </div>
                  </form>
                </div>
              </div>
            </div>
            <!-- Create new Gender-->
            <div class="col-sm-4">
              <div class="card">
                <div
                  class="card-header"
                  @click="showCreateGenderForm = !showCreateGenderForm"
                >
                  <h6 style="color: rgb(9, 172, 123)">
                    Tạo Mới Gender :
                    <img
                      width="30"
                      height="30"
                      src="https://img.icons8.com/nolan/64/final-fantasy-xiv.png"
                      alt="final-fantasy-xiv"
                    />
                  </h6>
                </div>
                <div class="card-body" v-if="showCreateGenderForm">
                  <form
                    class="was-validated"
                    novalidate
                    enctype="multipart/form-data"
                    @submit.prevent="createNewGenderGame"
                  >
                    <div class="row g-3">
                      <div class="col-md-12">
                        <label class="form-label" for="nameOfGame"
                          ><strong>Tên Giới Tính:</strong></label
                        >
                        <input
                          class="form-control"
                          id="nameOfGame"
                          v-model="nameGender"
                          type="text"
                          required
                        />
                        <div class="invalid-feedback">
                          Vui Lòng Nhập Tên
                          
                        </div>
                        <div class="valid-feedback">Looks good!</div>
                      </div>
                      <div class="col-md-12">
                        <button class="btn btn-primary" type="submit">
                          Create
                        </button>
                      </div>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="container-fluid">
          <div class="row">
            <!-- Bảng hiển thị Roles -->

            <div class="col-4">
              <div class="card">
                <div class="card-header" @click="toggleTable('roles')">
                  <h6
                    style="
                      color: rgb(18, 143, 201);
                      border-bottom: 2px solid rgb(18, 143, 201);
                    "
                  >
                    Vị Trí
                    <img
                      width="25"
                      height="25"
                      src="https://img.icons8.com/nolan/64/new-world.png"
                      alt="new-world"
                    />:
                  </h6>
                </div>
                <div class="card-body" v-show="tables.roles">
                  <div
                    class="table-responsive"
                    style="max-height: 400px; overflow-y: scroll"
                  >
                    <table class="table table-bordered">
                      <thead class="table-danger">
                        <tr>
                          <th style="width: 75%">Tên</th>
                          <th style="width: 25%">Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr
                          v-for="role in allRoles.slice(0, 10)"
                          :key="role.id"
                        >
                          <td>{{ role.name }}</td>
                          <td>
                            <a @click="deleteRole(role.id)">
                              <img
                                width="25"
                                height="25"
                                src="https://img.icons8.com/arcade/64/waste.png"
                                alt="waste"
                              />
                            </a>
                          </td>
                          <!-- Repeat the above two columns to fill all 4 columns -->
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>

            <!-- Bảng hiển thị Levels -->
            <div class="col-4">   
              <div class="card">
              <div class="card-header" @click="toggleTable('levels')">
                <h6
                  style="color: rgb(9, 172, 123); border-bottom: 2px solid rgb(9, 172, 123;"
                >
                  Cấp Độ
                  <img
                    width="25"
                    height="25"
                    src="https://img.icons8.com/nolan/64/final-fantasy-xiv.png"
                    alt="final-fantasy-xiv"
                  />:
                </h6>
              </div>
              <div class="card-body" v-show="tables.levels">
                <div
                class="table-responsive"
                style="max-height: 400px; overflow-y: scroll"
              >
                <table class="table table-bordered">
                  <thead class="table-danger">
                      <tr>
                        <th style="width: 75%">Tên</th>
                        <th style="width: 25%">Actions</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr v-for="level in levelList" :key="level.id">
                        <td>{{ level.name }}</td>
                        <td>
                          <a @click="deleteLevel(level.id)">
                            <img
                              width="25"
                              height="25"
                              src="https://img.icons8.com/arcade/64/waste.png"
                              alt="waste"
                            />
                          </a>
                        </td>
                        <!-- Repeat the above two columns to fill all 4 columns -->
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
              <!-- Bảng hiển thị Genders -->
            </div>

            <!--Bảng Hiển Thị Gender-->
            <div class="col-4">

            
              <div class="card">
                <div class="card-header" @click="toggleTable('genders')">
                  <h6 style="color: rgb(201, 18, 140); border-bottom: 2px solid rgb(201, 18, 140);">
                    Giới Tính
                    <img
                      width="25"
                      height="25"
                      src="https://img.icons8.com/nolan/64/gender.png"
                      alt="gender"
                    />:
                  </h6>
                </div>
                <div class="card-body" v-show="tables.genders">
                  <div class="table-responsive" style="max-height: 400px; overflow-y: scroll;">
                    <table class="table table-bordered">
                      <thead class="table-danger">
                        <tr>
                          <th style="width: 75%">Tên</th>
                          <th style="width: 25%">Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr v-for="gender in allGenders" :key="gender.id">
                          <td>{{ gender.name }}</td>
                          <td>
                            <a @click="deleteGender(gender.id)">
                              <img
                                width="25"
                                height="25"
                                src="https://img.icons8.com/arcade/64/waste.png"
                                alt="waste"
                              />
                            </a>
                          </td>
                          <!-- Repeat the above two columns to fill all 4 columns -->
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </div>
                
              </div>
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
</template>

<script>
// import GameService from "@/service/GameService";
// import Swal from "sweetalert2";
// import ForGameService from "@/service/ForGameService";
import switcher from "@/pages/switcher.vue";

import slibarWrapper from "@/pages/sidebarWrapper.vue";

import startHeaderVue from "@/pages/startHeader.vue";

import GameService from "@/service/GameService";

import ForGameService from "@/service/ForGameService";

import Swal from "sweetalert2";
export default {
  name: "createNew",
  components: {
    switcher,
    slibarWrapper,
    startHeaderVue,
  },
  data() {
    return {
      tables: {
        roles: true,
        levels: true,
        genders: true,
      },

      //set giá trị cho trường create là rỗng
      nameOfGame: "",
      nameLevel: "",
      nameRole: "",
      nameGender: "",

      gameImage: null,
      imagePreviewUrl: null, // Sử dụng để hiển thị hình ảnh được chọn

      // ẩn hiển các form create
      showCreateForm: false, // Bổ sung giá trị mặc định
      showCreateLevelForm: true,
      showCreateRoleForm: true,
      showCreateGenderForm: true,

      // set giá trị cho việc create Game
      selectedLevelIds: [],
      selectedRoleIds: [],
      selectedGenderIds: [],
      levelList: [],
      allRoles: [],
      allGenders: [],
      gamelist: [],
    };
  },
  methods: {
    toggleTable(table) {
      this.tables[table] = !this.tables[table];
    },
    // Your deleteRole, deleteLevel, and deleteGender methods go here

    // for Gender
    async getAllGenders() {
      try {
        const response = await ForGameService.getAllGenderGames();
        this.allGenders = response.data.sort((a, b) => b.id - a.id);
      } catch (error) {
        console.error("Error fetching genders:", error);
      }
    },
    async createNewGenderGame() {
      if (!this.nameGender.trim()) {
        // Kiểm tra xem trường "Name" có giá trị không trống
        Swal.fire({
          icon: "warning",
          text: "Tên Giới Tính Đã Bị Bỏ Trống",
        });
        return; // Không làm gì nếu trường "Name" trống
      }

      // Chuẩn hóa tên Gender thành chữ thường để so sánh
      const nameGenderLowercase = this.nameGender.toLowerCase();

      // Kiểm tra xem tên Gender đã tồn tại trong danh sách hiện có
      const isNameGenderExist = this.allGenders.some(
        (gender) => gender.name.toLowerCase() === nameGenderLowercase
      );

      if (isNameGenderExist) {
        Swal.fire({
          icon: "error",
          text: "Tên Giới Tính Đã Tồn Tại !",
        });
        return; // Dừng quá trình tạo mới nếu tên đã tồn tại
      }

      try {
        // Gọi phương thức createGenderGame từ ForGameService
        const response = await ForGameService.createGenderGame(this.nameGender);
        // Xóa tên Gender sau khi đã tạo thành công
        if (response.id) {
          this.nameGender = "";
          this.getAllGenders();
          Swal.fire({
            position: "top-end",
            icon: "success",
            title: "Tạo Mới Thành Công!",
            showConfirmButton: false,
            timer: 1500,
          });
        }
      } catch (error) {
        console.error("Error creating new Gender:", error);
        // Xử lý lỗi nếu cần
      }
    },
    async deleteGender(genderId) {
      try {
        const response = await ForGameService.deleteGenderGame(genderId);
        if (response.status === 200) {
          // Sau khi xóa thành công, cập nhật lại danh sách Level bằng cách gọi phương thức lấy danh sách
          this.getAllGenders();
          Swal.fire({
            position: "top-end",
            icon: "success",
            title: "Xóa Thành Công !",
            showConfirmButton: false,
            timer: 1500,
          });
        }
      } catch (error) {
        Swal.fire({
          position: "top-end",
          icon: "error",
          title: "Xóa Lỗi! Giới Tính Đã Có Trong 1 Game .",
          showConfirmButton: false,
          timer: 1500,
        });
      }
    },

    // for Role
    async getAllRoles() {
      try {
        const response = await ForGameService.getAllRoleGames();
        this.allRoles = response.data.sort((a, b) => b.id - a.id);
      } catch (error) {
        console.error("Error fetching roles:", error);
      }
    },

    async createNewRoleGame() {
      if (!this.nameRole.trim()) {
        // Kiểm tra xem trường "Name" có giá trị không trống
        Swal.fire({
          icon: "warning",
          text: "Tên Vị Trí Đã Bị Bỏ Trống",
        });
        return; // Không làm gì nếu trường "Name" trống
      }

      // Chuẩn hóa tên Role thành chữ thường để so sánh
      const nameRoleLowercase = this.nameRole.toLowerCase();

      // Kiểm tra xem tên Role đã tồn tại trong danh sách hiện có
      const isNameRoleExist = this.allRoles.some(
        (role) => role.name.toLowerCase() === nameRoleLowercase
      );

      if (isNameRoleExist) {
        Swal.fire({
          icon: "error",
          text: "Tên Vị Trí Đã Tồn Tại !",
        });
        return; // Dừng quá trình tạo mới nếu tên đã tồn tại
      }

      try {
        // Gọi phương thức createRoleGame từ ForGameService
        const response = await ForGameService.createRoleGame(this.nameRole);
        // Xóa tên Role sau khi đã tạo thành công
        if (response.id) {
          this.nameRole = "";
          this.getAllRoles();
          Swal.fire({
            position: "top-end",
            icon: "success",
            title: "Tạo Mới Thành Công !",
            showConfirmButton: false,
            timer: 1500,
          });
        }
      } catch (error) {
        console.error("Error creating new Role:", error);
        // Xử lý lỗi nếu cần
      }
    },

    async deleteRole(roleId) {
      try {
        const response = await ForGameService.deleteRoleGame(roleId);
        if (response.status === 200) {
          // Sau khi xóa thành công, cập nhật lại danh sách Level bằng cách gọi phương thức lấy danh sách
          this.getAllRoles();
          Swal.fire({
            position: "top-end",
            icon: "success",
            title: "Xóa Thành Công !",
            showConfirmButton: false,
            timer: 1500,
          });
        }
      } catch (error) {
        Swal.fire({
          position: "top-end",
          icon: "error",
          title: "Xóa Lỗi! Vị Trí Đã Có Trong 1 Game .",
          showConfirmButton: false,
          timer: 1500,
        });
      }
    },
    // for Level
    async getAllLevels() {
      try {
        const response = await ForGameService.getAllLevelGames();
        this.levelList = response.data.sort((a, b) => b.id - a.id);
      } catch (error) {
        console.error("Error fetching levels:", error);
      }
    },
    async createNewLevelGame() {
      if (!this.nameLevel.trim()) {
        // Kiểm tra xem trường "Name" có giá trị không trống
        Swal.fire({
          icon: "warning",
          text: "Tên Cấp Độ Đã Bị Bỏ Trống",
        });
        return; // Không làm gì nếu trường "Name" trống
      }
      // Kiểm tra xem tên Level đã tồn tại trong danh sách hiện có
      const nameLevelUpperCase = this.nameLevel.toUpperCase();
      const isNameLevelExist = this.levelList.some(
        (level) => level.name.toUpperCase() === nameLevelUpperCase
      );

      if (isNameLevelExist) {
        Swal.fire({
          icon: "error",
          text: "Tên Level Đã Tồn Tại !",
        });
        return; // Dừng quá trình tạo mới nếu tên đã tồn tại
      }

      try {
        // Gọi phương thức createLevelGame từ ForGameService
        const response = await ForGameService.createLevelGame(this.nameLevel);
        // Xóa tên Level sau khi đã tạo thành công
        if (response.id) {
          this.nameLevel = "";
          this.getAllLevels();
          Swal.fire({
            position: "top-end",
            icon: "success",
            title: "Tạo Mới Thành Công!",
            showConfirmButton: false,
            timer: 1500,
          });
        } else {
          Swal.fire({
            position: "top-end",
            icon: "error",
            title: "Create error!",
            showConfirmButton: false,
            timer: 1500,
          });
        }
      } catch (error) {
        console.error("Error creating new Level:", error);
        // Xử lý lỗi nếu cần
      }
    },
    async deleteLevel(levelId) {
      try {
        const response = await ForGameService.deleteLevelGame(levelId);
        if (response.status === 200) {
          // Sau khi xóa thành công, cập nhật lại danh sách Level bằng cách gọi phương thức lấy danh sách
          this.getAllLevels();
          Swal.fire({
            position: "top-end",
            icon: "success",
            title: "Xóa Thành Công !",
            showConfirmButton: false,
            timer: 1500,
          });
        }
      } catch (error) {
        Swal.fire({
          position: "top-end",
          icon: "error",
          title: "Xóa Lỗi! Cấp Độ Đã Có Trong 1 Game .",
          showConfirmButton: false,
          timer: 1500,
        });
      }
    },
    // click Image get File
    handleImageChange(event) {
      this.gameImage = event.target.files[0];
      // Tạo một đối tượng FileReader để đọc hình ảnh
      let reader = new FileReader();
      
      reader.onload = (e) => {
        this.imagePreviewUrl = e.target.result; // Cập nhật imagePreviewUrl với dữ liệu hình ảnh
      };

      // Đọc hình ảnh được chọn
      reader.readAsDataURL(this.gameImage);
    },
    async createNewGame() {
      if (
        !this.nameOfGame ||
        !this.gameImage ||
        this.selectedLevelIds.length === 0 ||
        this.selectedRoleIds.length === 0 ||
        this.selectedGenderIds.length === 0
      ) {
        Swal.fire({
          icon: "warning",
          title: "Cảnh Báo",
          text: "Bạn Đã Để Trống Giá Trị Nào Đó",
        });
        return;
      }

      // Chuẩn hóa tên Game thành chữ thường để so sánh
      const nameOfGameLowercase = this.nameOfGame.toLowerCase();

      // Kiểm tra xem tên Game đã tồn tại trong danh sách hiện có
      const isNameOfGameExist = this.gamelist.some(
        (game) => game.nameGame.toLowerCase() === nameOfGameLowercase
      );

      if (isNameOfGameExist) {
        Swal.fire({
          icon: "error",
          text: "Tên Game Đã Tồn Tại !",
        });
        return; // Dừng quá trình tạo mới nếu tên đã tồn tại
      }

      try {
        const response = await GameService.createNewGame(
          this.nameOfGame,
          this.gameImage,
          this.selectedLevelIds,
          this.selectedRoleIds,
          this.selectedGenderIds
        );
        if (response.id) {
          this.nameOfGame = "";
          this.gameImage = "";
          this.selectedLevelIds = [];
          this.selectedRoleIds = [];
          this.selectedGenderIds = [];
          this.getAllGames(); // Cập nhật danh sách game sau khi tạo mới
          Swal.fire({
            position: "top-end",
            icon: "success",
            title: "Tạo Mới Thành Công!",
            showConfirmButton: false,
            timer: 1500,
          });
        }
      } catch (error) {
        console.error("Error creating new game:", error);
        Swal.fire({
          icon: "error",
          title: "Create Error",
          text: "An error occurred while creating the game.",
        });
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
  },
  async created() {
    await this.getAllLevels();
    await this.getAllRoles();
    await this.getAllGenders();
    await this.getAllGames();
  },
};
</script>
