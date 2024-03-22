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
          <div class="breadcrumb-title pe-3">Nạp Coin</div>
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
        <h6 class="mb-0 text-uppercase">Danh Sách Đơn Ngày Hôm Nay</h6>
        <hr>
        <div class="card">
          <div class="card-body">
            <div class="table-responsive table-container">
              <table
                id="example"
                class="table table-striped table-bordered"
                style="width: 100%"
              >
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>User</th>
                    <th>Amount</th>
                    <th>Transaction Time</th>
                    <th>Status</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="item in itemsPerPageToday" :key="item.id">

                    <td>{{ item.id }}</td>
                    <td>{{ item.user_transaction.name }}</td>
                    <td>
                      {{
                        item.amount.toLocaleString("vi-VN", {
                          style: "currency",
                          currency: "VND",
                        })
                      }}
                    </td>
                    <td>{{ item.transactionTime }}</td>

                    <td>
                      <button
                        @click="showConfirmation(item.id)"
                        class="btn btn-outline-success px-5"
                      >
                        {{ item.status }}
                        <img class="image-right" :src="BASE_URL + 'assets/gif/200w.webp'" >
                      </button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <div class="pagination-container">
          <vue-awesome-paginate :total-items="100" v-model="currentPageNew">
      
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
        <hr>
        <h6 class="mb-0 text-uppercase">Danh Sách Tất Cả Đơn</h6>
        <hr />
        <div class="card">
          <div class="card-body">
            <div class="table-responsive table-container">
              <table
                id="example"
                class="table table-striped table-bordered"
                style="width: 100%"
              >
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>User</th>
                    <th>Amount</th>
                    <th>Transaction Time</th>
                    <th>Status</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="item in itemsPerPage" :key="item.id">
                    <td>{{ item.id }}</td>
                    <td>{{ item.user_transaction.name }}</td>
                    <td>
                      {{
                        item.amount.toLocaleString("vi-VN", {
                          style: "currency",
                          currency: "VND",
                        })
                      }}
                    </td>
                    <td>{{ item.transactionTime }}</td>

                    <td>
                      <button
                        @click="showConfirmation(item.id)"
                        class="btn btn-outline-success px-5"
                      >
                        {{ item.status }}
                        <img class="image-right" :src="BASE_URL + 'assets/gif/200w.webp'" >
                      </button>
                    </td>
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
        <hr>

      
        
      </div>
    </div>
  </div>
 
  <!--start switcher-->
  <switcher></switcher>
</template>

<script>
import { ref } from "vue";

import switcher from "@/pages/switcher.vue";
import Swal from "sweetalert2";
import slibarWrapper from "@/pages/sidebarWrapper.vue";
import startHeaderVue from "@/pages/startHeader.vue";
// Import the paginate component

import TransactionService from "@/service/TransactionService";
export default {
  name: "listTranSaction",
  data() {
    return {
      PENDINGlist: [],
      BASE_URL: process.env.BASE_URL,
    };
  },
  setup() {
    const currentPage = ref(1);
    const currentPageNew= ref(1);
    return {
      currentPage,
      currentPageNew

    };
  },
  components: {
    switcher,
    slibarWrapper,
    startHeaderVue,
    
  },
  methods: {
    async getTransactionsByStatusPENDING() {
      try {
        const status = "PENDING";
        const response = await TransactionService.getTransactionsByStatus(
          status
        );
        this.PENDINGlist = response; // Không cần .data ở đây
        console.log(this.PENDINGlist);
      } catch (error) {
        console.error("Lỗi khi lấy danh sách PENDING: ", error);
      }
    },
   
    async showConfirmation(id) {
      const { value } = await Swal.fire({
        title: "Chọn trạng thái mới",
        icon: "question",
        showCancelButton: true,
        confirmButtonText: "LƯU",
        cancelButtonText: "HỦY",
        input: "select",
        inputOptions: {
          SUCCESS: "SUCCESS",
          FAILED: "FAILED",
        },
      });

      if (value) {
        try {
          const lowercaseValue = (value || "").toLowerCase();

          if (lowercaseValue === "success") {
            const newStatus = "SUCCESS";
            Swal.fire(
              "Thành công!",
              `Trạng thái đã được cập nhật thành ${newStatus}`,
              "success"
            );
            await TransactionService.adminCheckTransaction(id, newStatus);
            this.getTransactionsByStatusPENDING();
          } else if (lowercaseValue === "failed") {
            const newStatus = "FAILED";
            Swal.fire(
              "Thành công!",
              `Trạng thái đã được cập nhật thành ${newStatus}`,
              "success"
            );
            await TransactionService.adminCheckTransaction(id, newStatus);
            this.getTransactionsByStatusPENDING();
          } else {
            throw new Error("Trạng thái không hợp lệ");
          }
        } catch (error) {
          console.error("Lỗi khi cập nhật trạng thái: ", error);
          Swal.fire(
            "Lỗi!",
            "Đã có lỗi xảy ra khi cập nhật trạng thái",
            "error"
          );
        }
      }
    },
  },
  async created() {
    await this.getTransactionsByStatusPENDING();
  },
  computed: {
  itemsPerPage() {
    const itemsPerPage = 10; // Number of items to display per page
    const startIndex = (this.currentPage - 1) * itemsPerPage;
    const endIndex = startIndex + itemsPerPage;

    // Use Array.slice() to get a subset of data
    return this.PENDINGlist.slice(startIndex, endIndex);
  },
  pendingTransactionsToday() {
    const today = new Date(); // Get the current date
    return this.PENDINGlist.filter((item) => {
      const transactionDate = new Date(item.transactionTime);
      return (
        item.status === 'PENDING' &&
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

<style>
.pagination-container .pagination-container {
  display: flex;
    justify-content: flex-end; /* This will move the pagination to the right */
    width: 100%; /* Set the container to full width */
    margin-top: 10px; /* Adjust the top margin as needed */
  
}
.pagination-container .paginate-buttons {
  width: 40px;
  height: 40px;
  margin-inline: 5px;
  cursor: pointer;
  border: none;
  background-color: transparent;
  border-radius: 2px;
}
.pagination-container .back-button {
  width: 70px;
}
.pagination-container .next-button {
  width: 70px;
}
.pagination-container .back-button svg {
  transform: rotate(180deg);
}
.pagination-container .active-page {
  background-color: #2980b9;
  color: #fff;
}

.pagination-container .paginate-buttons:hover {
  background-color: #e5e5e5;
}
.pagination-container .active-page:hover {
  background-color: #3b8cc3;
  color: #fff;
}
.pagination-container .back-button:active,
.pagination-container .next-button:active {
  background-color: #dedede;
}
.table-container {
  max-height: 700px ; /* Adjust the height as needed */
}
.image-right {
  float: right; /* Sử dụng float để đặt hình ảnh bên phải của button */
  margin-left: 10px; /* Để tạo khoảng cách giữa nút và hình ảnh */
  width: 30px;
  height: 30px;
}
</style>
