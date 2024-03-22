<template>
  <div>
    <slibarWrapper></slibarWrapper>
    <startHeaderVue></startHeaderVue>

    <div class="page-wrapper">
      <div class="page-content">
        <div class="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
          <div class="breadcrumb-title pe-3">Danh Sách User</div>
          <div class="ps-3">
            <nav aria-label="breadcrumb">
              <ol class="breadcrumb mb-0 p-0">
                <li class="breadcrumb-item">
                  <a href="javascript:;"><i class="bx bx-home-alt"></i></a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">
                  Danh Sách User
                </li>
              </ol>
            </nav>
          </div>
        </div>
        <div class="row">
          <div class="col-12 col-lg-8">
            <div class="card radius-10">
              <div class="card-body">
                <div>
                  <canvas id="myChart"></canvas>
                </div>
              </div>
            </div>
          </div>
          <div class="col-12 col-lg-3">
            <div class="col">
              <div class="card radius-4 bg-info">
                <div class="card-body">
                  <div class="d-flex align-items-center">
                    <div>
                      <p class="mb-0 text-white">Tổng Số User:</p>
                      <h4 class="my-1 text-white">{{ totalUsers }}</h4>
                    </div>
                    <div class="widgets-icons bg-white text-success ms-auto">
                      <i class="bx bx-user-circle"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="col">
              <div class="card radius-10 bg-info">
                <div class="card-body">
                  <div class="d-flex align-items-center">
                    <div>
                      <p class="mb-0 text-dark">Tổng User On :</p>
                      <h4 class="my-1 text-dark">{{ onlineUsers }}</h4>
                    </div>
                    <div class="widgets-icons bg-white text-dark ms-auto">
                      <i
                        class="fadeIn animated bx bx-disc"
                        style="color: green"
                      ></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="col">
              <div class="card radius-10 bg-info">
                <div class="card-body">
                  <div class="d-flex align-items-center">
                    <div>
                      <p class="mb-0 text-dark">Tổng User Off :</p>
                      <h4 class="my-1 text-dark">
                        {{ offlineUsers }}
                      </h4>
                    </div>
                    <div class="widgets-icons bg-white text-dark ms-auto">
                      <i
                        class="fadeIn animated bx bx-disc"
                        style="color: red"
                      ></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <h6 class="mb-0 text-uppercase">Danh Sách Tất Cả User</h6>
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
                    <th>Avarta</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Address</th>
                    <th>Phone Number</th>
                    <th>Gender</th>
                    <th>Balance</th>
                    <th>Status</th>
                    <th>BirthDay</th>
                    <th>Created Date</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="item in displayedUsers" :key="item.id">
                    <td>
                      <img
                        :src="item.avatars[0]"
                        :style="{ width: '40px', height: '30px' }"
                      />
                    </td>
                    <td>{{ item.name }}</td>
                    <td>{{ item.email }}</td>
                    <td>{{ item.address }}</td>
                    <td>{{ item.phoneNumber }}</td>
                    <td>{{ item.gender }}</td>
                    <td>
                      {{
                        item.balance.toLocaleString("vi-VN", {
                          style: "currency",
                          currency: "VND",
                        })
                      }}
                    </td>
                    <td v-if="item.status === 'ON' ">
                      <img width="16" height="16" src="https://img.icons8.com/tiny-color/16/connection-status-on.png" alt="connection-status-on"/>
                    </td>
                    <td v-else>
                      <img width="16" height="16" src="https://img.icons8.com/tiny-color/16/000000/connection-status-on.png" alt="connection-status-on"/>
                    </td>

                    <td>{{ item.formattedBirthDay }}</td>
                    <td>{{ item.formattedDate }}</td>
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
import { format } from "date-fns";

import { ref, onMounted, watch } from "vue";
import Chart from "chart.js/auto";
import AuthService from "@/service/AuthService";
import slibarWrapper from "@/pages/sidebarWrapper.vue";
import startHeaderVue from "@/pages/startHeader.vue";
import switcher from "@/pages/switcher.vue";

export default {
  name: "listTransaction",
  components: {
    switcher,
    slibarWrapper,
    startHeaderVue,
  },

  setup() {
    const totalUsers = ref(0);
    const onlineUsers = ref(0);
    const offlineUsers = ref(0);

    // Function to calculate user stats
    const calculateUserStats = () => {
      totalUsers.value = UserList.value.length;
      onlineUsers.value = UserList.value.filter(
        (user) => user.status === "ON"
      ).length;
      offlineUsers.value = UserList.value.filter(
        (user) => user.status === "OFF"
      ).length;
    };
    const currentPage = ref(1);
    const UserList = ref([]);
    const itemsPerPage = 10; // Số lượng mục hiển thị trên mỗi trang
    const totalItems = ref(0);
    const isDataLoaded = ref(false); // Flag để kiểm tra xem dữ liệu đã được tải xong

      const userCountByMonth = ref(new Array(12).fill(0));

      const getAllUsers = async () => {
        try {
          const role = "USER";
          const response = await AuthService.getAllUser(role);
          UserList.value = response;
          totalItems.value = UserList.value.length;
          isDataLoaded.value = true; // Đánh dấu rằng dữ liệu đã được tải xong
          // Sắp xếp dữ liệu theo id giảm dần
          UserList.value.sort((a, b) => b.id - a.id);
          UserList.value.forEach((user) => {
            const birthDay = new Date(...user.birthDay);
            const formattedBirthDay = format(birthDay, "dd/MM/yyyy");
            user.formattedBirthDay = formattedBirthDay; // Thêm trường mới để lưu trữ ngày sinh đã định dạng

            const creationDate = new Date(...user.createdDate);
            const formattedDate = format(creationDate, "dd/MM/yyyy HH:mm:ss");
            user.formattedDate = formattedDate; // Thêm trường mới để lưu trữ thời gian đã định dạng
            const month = creationDate.getMonth();
            userCountByMonth.value[month]++;
          });
          // Count the number of users for each month

          console.log(UserList.value);

          renderChart(userCountByMonth.value);
        } catch (error) {
          console.error("Error fetching the user list: ", error);
        }
      };

      const renderChart = (data) => {
        const ctx = document.getElementById("myChart");
        new Chart(ctx, {
          type: "line",

          data: {
            labels: [
              "January",
              "February",
              "March",
              "April",
              "May",
              "June",
              "July",
              "August",
              "September",
              "October",
              "November",
              "December",
            ],
            datasets: [
              {
                label: "User Creation by Month",
                data: data,
                borderColor: "rgb(201, 41, 230)",
                tension: 0.1,
              },
            ],
          },
          options: {
            animations: {
              tension: {
                duration: 1000,
                easing: "linear",
                from: 1,
                to: 0,
                loop: true,
              },
            },
            scales: {
              y: {
                min: 0,
              },
            },
          },
        });
      };

    onMounted(() => {
      getAllUsers();
    });
    const displayedUsers = ref([]);
    watch([currentPage, isDataLoaded], () => {
      if (isDataLoaded.value) {
        const startIndex = (currentPage.value - 1) * itemsPerPage;
        const endIndex = startIndex + itemsPerPage;
        displayedUsers.value = UserList.value.slice(startIndex, endIndex);
      }
    });
    watch(UserList, calculateUserStats, { immediate: true });

    return {
      totalUsers,
      onlineUsers,
      offlineUsers,
      currentPage,
      UserList,
      displayedUsers,
      totalItems,
    };
  },
};
</script>
