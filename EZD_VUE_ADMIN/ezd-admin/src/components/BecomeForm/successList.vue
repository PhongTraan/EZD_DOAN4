<template>
    <div class="wrapper">
      <!--sidebar wrapper -->
      <slibarWrapper></slibarWrapper>
      <!--end sidebar wrapper -->
      <!--start header -->
      <startHeaderVue></startHeaderVue>
  
      <div class="page-wrapper">
        <div class="page-content">
          <!--breadcrumb-->
          <div class="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
            <div class="breadcrumb-title pe-3">Danh Sách Chấp Nhận</div>
            <div class="ps-3">
              <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0 p-0">
                  <li class="breadcrumb-item">
                    <a href="javascript:;"><i class="bx bx-home-alt"></i></a>
                  </li>
                  <li class="breadcrumb-item active" aria-current="page">
                    Danh Sách Đơn
                  </li>
                </ol>
              </nav>
            </div>
          </div>
          <!--end breadcrumb-->
          <h6 class="mb-0 text-uppercase">Danh Sách Tất Cả Đơn</h6>
          <hr />
          <div class="card">
            <div class="card-body">
              <div class="table-responsive">
                <table
                  id="example"
                  class="table table-striped table-bordered"
                  style="width: 100%"
                >
                  <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên Đầy Đủ</th>
                        <th>Sinh Nhật</th>
                        <th>Nơi Ở</th>
                        <th>Ngày Tạo</th>                                          
                         <th>Status</th>
                        <th>Checked By Admin</th>
                        <th>Admin Check Time</th>
                    </tr>
                  </thead>
                <tbody>
                  <tr v-for="item in itemsPerPage" :key="item.id">
                    <td>{{ item.id }}</td>
                    <td>{{ item.fullName }}</td>
                    <td>{{ item.birthDay }}</td>
                    <td>{{ item.street }}</td>
                    <td>{{ item.becomeTime }}</td>
                    <td class="badge bg-gradient-quepal text-white shadow-sm w-100">{{ item.status }}</td>
                    <td>{{ item.checkedByAdmin }}</td>
                    <td>{{ item.adminCheckTime }}</td>
                  </tr>
                </tbody>
                  
                </table>
              </div>
            </div>
          </div>
          <div class="pagination-container">
            <vue-awesome-paginate :total-items="100" v-model="currentPage">
        
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
    <!--start switcher-->
    <switcher></switcher>
  </template>
  
  <script>
  import switcher from "@/pages/switcher.vue";
  import {ref} from "vue"
  // import Swal from "sweetalert2";
  import slibarWrapper from "@/pages/sidebarWrapper.vue";
  import startHeaderVue from "@/pages/startHeader.vue";
  
  import BecomeIdolService from "@/service/BecomeIdolService";
  export default {
    name: "listTranSaction",
    data() {
      return {
        SUCCESSlist: [],
      };
    },
  
    components: {
      switcher,
      slibarWrapper,
      startHeaderVue,
    },
    setup() {
      const currentPage = ref(1);
      const currentPageNew= ref(1);
      return {
        currentPage,
        currentPageNew
  
      };
    },
    methods: {
      async getTransactionsByStatusSUCCESS() {
    try {
      const status = "SUCCESS";
      const response = await BecomeIdolService.getBecomeListByStatus(status);
      this.SUCCESSlist = response; // Không cần .data ở đây
      console.log(this.SUCCESSlist);
      console.log("Ok");
    } catch (error) {
      console.error("Lỗi khi lấy danh sách : ", error);
    }
  },
  
    },
    async created() {
      await this.getTransactionsByStatusSUCCESS();
    },
    computed: {
    itemsPerPage() {
      const itemsPerPage = 10; // Number of items to display per page
      const startIndex = (this.currentPage - 1) * itemsPerPage;
      const endIndex = startIndex + itemsPerPage;
  
      // Use Array.slice() to get a subset of data
      return this.SUCCESSlist.slice(startIndex, endIndex);
    },
    pendingTransactionsToday() {
      const today = new Date(); // Get the current date
      return this.SUCCESSlist.filter((item) => {
        const transactionDate = new Date(item.becomeTime);
        return (
          item.status === 'SUCCESS' &&
          today.toDateString() === transactionDate.toDateString()
        );
      });
    },
    itemsPerPageToday() {
      const itemsPerPage = 10; // Number of items to display per page
      const startIndex = (this.currentPageNew - 1) * itemsPerPage;
      const endIndex = startIndex + itemsPerPage;
  
      // Use Array.slice() to get a subset of data
      return this.pendingTransactionsToday.slice(startIndex, endIndex);
    }
  },
    
    
  };
  </script>
  
  <style></style>
  