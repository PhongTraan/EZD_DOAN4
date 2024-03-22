<template>
  <div>
    <slibarWrapper></slibarWrapper>
    <startHeaderVue></startHeaderVue>

    <div class="page-wrapper">
      <div class="page-content">
        <div class="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
          <div class="breadcrumb-title pe-3">Danh Sách Lucky Spin</div>
          <div class="ps-3">
            <nav aria-label="breadcrumb">
              <ol class="breadcrumb mb-0 p-0">
                <li class="breadcrumb-item">
                  <a href="javascript:;"><i class="bx bx-home-alt"></i></a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">
                  Danh Sách Lucky Spins
                </li>
              </ol>
            </nav>
          </div>
        </div>

        <div class="card">
          <div class="card-body">
            <div>
              <canvas id="myChart"></canvas>
            </div>
          </div>
        </div>
        <!--end row-->
        <h6 class="mb-0 text-uppercase">Color Static Widgets</h6>
        <hr />
        <div class="row row-cols-1 row-cols-md-2 row-cols-xl-4">
          <div class="col">
            <div class="card radius-10 bg-info">
              <div class="card-body">
                <div class="d-flex align-items-center">
                  <div>
                    <p class="mb-0 text-white">Tổng Số Đơn :</p>
                    <h4 class="my-1 text-white">{{ totalItemCount }}</h4>
                  </div>
                  <div class="widgets-icons bg-white text-success ms-auto">
                    <i class="bx bxs-wallet"></i>
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
                    <p class="mb-0 text-dark">Tổng Số Tiền :</p>
                    <h4 class="my-1 text-dark">
                      {{
                        totalMoney.toLocaleString("vi-VN", {
                          style: "currency",
                          currency: "VND",
                        })
                      }}
                    </h4>
                  </div>
                  <div class="widgets-icons bg-white text-dark ms-auto">
                    <i class="bx bx-dollar"></i>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="row row-cols-1 row-cols-md-2 row-cols-xl-4">
          <div class="col">
            <div class="card radius-10 bg-danger">
              <div class="card-body">
                <div class="d-flex align-items-center">
                  <div>
                    <p class="mb-0 text-white">Số Đơn Trong Tháng:</p>
                    <h4 class="my-1 text-white">
                      {{ itemCountInCurrentMonth }}
                    </h4>
                  </div>
                  <div class="widgets-icons bg-white text-danger ms-auto">
                    <i class="bx bxs-binoculars"></i>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col">
            <div class="card radius-10 bg-danger">
              <div class="card-body">
                <div class="d-flex align-items-center">
                  <div>
                    <p class="mb-0 text-dark">Số Tiền Trong Tháng:</p>
                    <h4 class="my-1 text-dark">
                      {{
                        moneyInCurrentMonth.toLocaleString("vi-VN", {
                          style: "currency",
                          currency: "VND",
                        })
                      }}
                    </h4>
                  </div>
                  <div class="widgets-icons bg-white text-dark ms-auto">
                    <i class="bx bx-dollar"></i>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col">
            <div class="card radius-10 bg-warning">
              <div class="card-body">
                <div class="d-flex align-items-center">
                  <div>
                    <p class="mb-0 text-dark">Số Đơn Trong Ngày:</p>
                    <h4 class="my-1 text-dark">
                      {{ totalOrdersInCurrentDay }}
                    </h4>
                  </div>
                  <div class="widgets-icons bg-white text-dark ms-auto">
                    <i class="bx bx-line-chart-down"></i>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col">
            <div class="card radius-10 bg-warning">
              <div class="card-body">
                <div class="d-flex align-items-center">
                  <div>
                    <p class="mb-0 text-dark">Số Tiền Trong Ngày:</p>
                    <h4 class="my-1 text-dark">
                      {{
                        totalMoneyInCurrentDay.toLocaleString("vi-VN", {
                          style: "currency",
                          currency: "VND",
                        })
                      }}
                    </h4>
                  </div>
                  <div class="widgets-icons bg-white text-dark ms-auto">
                    <i class="bx bx-dollar"></i>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!--end row-->
        <h6 class="mb-0 text-uppercase">Danh Sách Tất Cả Lucky Spins</h6>
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
                    <th>User Name</th>
                    <th>Email</th>
                    <th>Điểm</th>
                    <th>Ngày Chơi</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="item in displayedUsers" :key="item.id">
                    <td>{{ item.id }}</td>
                    <td>{{ item.user_lucky.name }}</td>
                    <td>{{ item.user_lucky.email }}</td>
                    <td>
                      {{
                        item.point.toLocaleString("vi-VN", {
                          style: "currency",
                          currency: "VND",
                        })
                      }}
                    </td>
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
  <!-- end search modal -->
  <!--start switcher-->
  <switcher></switcher>
</template>

<script>
import { ref, onMounted, watch } from "vue";
import Chart from "chart.js/auto";
import slibarWrapper from "@/pages/sidebarWrapper.vue";
import startHeaderVue from "@/pages/startHeader.vue";
import switcher from "@/pages/switcher.vue";
import LuckySpinService from "@/service/LuckySpinService";
import { format } from "date-fns";

export default {
  name: "listLucky",
  components: {
    switcher,
    slibarWrapper,
    startHeaderVue,
  },

  setup() {
    const currentPage = ref(1);
    const LuckyList = ref([]);
    const itemsPerPage = 10; // Số lượng mục hiển thị trên mỗi trang
    const totalItems = ref(0);
    const isDataLoaded = ref(false); // Flag để kiểm tra xem dữ liệu đã được tải xong

    const userCountByMonth = ref(new Array(12).fill(0));

    const totalItemCount = ref(0);
    const totalMoney = ref(0);

    const calculateTotalItemCountAndMoney = () => {
      totalItemCount.value = LuckyList.value.length;
      totalMoney.value = LuckyList.value.reduce(
        (total, lucky) => total + lucky.point,
        0
      );
    };

    watch(LuckyList, calculateTotalItemCountAndMoney, { deep: true });

    // tổng item có trong tháng
    // Trong phần setup() của component listLucky.vue

    const currentDate = new Date();
    const currentMonth = currentDate.getMonth();
    const currentYear = currentDate.getFullYear();
    const startDateOfMonth = new Date(currentYear, currentMonth, 1);
    const endDate = currentDate;

    const itemCountInCurrentMonth = ref(0);
    const moneyInCurrentMonth = ref(0);

    const calculateItemCountAndMoneyForCurrentMonth = () => {
      itemCountInCurrentMonth.value = 0;
      moneyInCurrentMonth.value = 0;

      LuckyList.value.forEach((lucky) => {
        const luckyDate = new Date(...lucky.luckyTime);
        if (luckyDate >= startDateOfMonth && luckyDate <= endDate) {
          itemCountInCurrentMonth.value++;
          moneyInCurrentMonth.value += lucky.point;
        }
      });
    };

    watch(LuckyList, calculateItemCountAndMoneyForCurrentMonth, { deep: true });

    // Tổng Tiền , Số Lượng Trong Ngày

    const startDateOfToday = new Date(
      currentDate.getFullYear(),
      currentDate.getMonth(),
      currentDate.getDate()
    );
    const endDateOfToday = new Date(
      currentDate.getFullYear(),
      currentDate.getMonth(),
      currentDate.getDate() + 1
    );

    const ordersInCurrentDay = ref([]);
    const totalOrdersInCurrentDay = ref(0);
    const totalMoneyInCurrentDay = ref(0);

    const calculateOrdersAndMoneyForCurrentDay = () => {
      ordersInCurrentDay.value = LuckyList.value.filter((lucky) => {
        const luckyDate = new Date(lucky.luckyTime);
        return luckyDate >= startDateOfToday && luckyDate < endDateOfToday;
      });

      totalOrdersInCurrentDay.value = ordersInCurrentDay.value.length;
      totalMoneyInCurrentDay.value = ordersInCurrentDay.value.reduce(
        (totalMoney, lucky) => totalMoney + lucky.point,
        0
      );
    };

    watch(LuckyList, calculateOrdersAndMoneyForCurrentDay, { deep: true });

    // Gọi hàm calculateOrdersAndMoneyForCurrentDay() trong onMounted() để tính giá trị ban đầu.

    // methods get
    const getAllListLuckies = async () => {
      try {
        const response = await LuckySpinService.getAllLuckSpins();
        LuckyList.value = response.sort((a, b) => b.id - a.id);
        totalItems.value = LuckyList.value.length;
        isDataLoaded.value = true; // Đánh dấu rằng dữ liệu đã được tải xong

        // Count the number of users for each month
        LuckyList.value.forEach((lucky) => {
          const creationDate = new Date(...lucky.luckyTime);
            const formattedDate = format(creationDate, "dd/MM/yyyy ");
            lucky.formattedDate = formattedDate; // Thêm trường mới để lưu trữ thời gian đã định dạng
          const month = creationDate.getMonth();
          userCountByMonth.value[month]++;
        });
        console.log(LuckyList.value);

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
              label: "Lucky Spin Creation by Month",
              data: data,
              fill: "start",
              borderColor: "rgb(232, 49, 101)",
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
      getAllListLuckies();
      displayedUsers;
    });
    const displayedUsers = ref([]);
    watch([currentPage, isDataLoaded], () => {
      if (isDataLoaded.value) {
        const startIndex = (currentPage.value - 1) * itemsPerPage;
        const endIndex = startIndex + itemsPerPage;
        displayedUsers.value = LuckyList.value.slice(startIndex, endIndex);
      }
    });
    // Đặt sự kiện lắng nghe cho currentPage

    return {
      currentPage,
      LuckyList,
      displayedUsers,
      totalItems,
      totalItemCount,
      totalMoney,
      itemCountInCurrentMonth,
      moneyInCurrentMonth,
      ordersInCurrentDay,
      totalOrdersInCurrentDay,
      totalMoneyInCurrentDay,
    };
  },
};
</script>
