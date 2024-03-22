<template>
  <div>
    <startHeader></startHeader>
    <div class="cs-height_90 cs-height_lg_80"></div>

    <div class="cs-height_100 cs-height_lg_70"></div>
    <div class="container">
      <div class="cs-section_heading cs-style4">
        <h2 class="cs-section_title">Buy Coin</h2>
        <p class="cs-section_subtitle">
          Amet minim mollit non deserunt ullamco est sit aliqua dolor do <br />
          amet sint. Velit officia consequat duis enim velit mollit.
        </p>
      </div>
      <div class="cs-height_45 cs-height_lg_45"></div>
      <div class="row">
        <div class="col-lg-4 col-sm-4">
          <div
            class="cs-iconbox cs-style3 cs-box_shadow cs-white_bg"
            style="text-align: center"
          >
            <div
              class="cs-iconbox_img"
              style="
                font-size: medium;
                font-family: &quot;Segoe UI&quot;, Tahoma, Geneva, Verdana,
                  sans-serif;
              "
            >
              <h3>
                Nạp
                <img
                  width="30"
                  height="30"
                  src="https://img.icons8.com/nolan/64/diamond.png"
                  alt="diamond"
                />
                Qua PayPal
              </h3>
            </div>
            <hr />
            <div class="cs-iconbox_text">
              <form @submit.prevent="CheckOut">
                <div class="form-group">
                  <input
                    class="form-control"
                    type="number"
                    placeholder="Nhập số Tiền bạn muốn Nạp"
                    v-model="amount"
                    required
                    min="1"
                    max="1000"
                  />

                  <div v-if="amount < 1 || amount > 1000">
                    <div class="cs-height_30 cs-height_lg_30"></div>

                    <p style="color: red">Số tiền phải từ 1 đến 1000 USD.</p>
                  </div>
                
                <div v-if="user === null">
                  <p style="color: red">
                    Vui lòng đăng nhập để thực hiện thanh toán.
                    <router-link to="/login"> Log In</router-link>
                  </p>
                </div>
                <div v-else>
                  <div class="cs-height_30 cs-height_lg_30"></div>

                  <div for="">Tên Người Gửi :{{ user.name }}</div>
                  <div for="">Số Tiền :{{ formattedPrice }}</div>
                  <div class="cs-height_30 cs-height_lg_30"></div>
                </div>
              </div>
                <div v-if="!isAmountInvalid">
                  <div id="your-container-element"></div>
                </div>
              </form>
            </div>
          </div>
          <div class="cs-height_30 cs-height_lg_30"></div>
        </div>
        <div class="col-lg-4 col-sm-4">
          <div
            class="cs-iconbox cs-style3 cs-box_shadow cs-white_bg"
            style="text-align: center"
          >
            <div
              class="cs-iconbox_img"
              style="
                font-size: medium;
                font-family: &quot;Segoe UI&quot;, Tahoma, Geneva, Verdana,
                  sans-serif;
              "
            >
              <h3>
                Nạp
                <img
                  width="30"
                  height="30"
                  src="https://img.icons8.com/nolan/64/diamond.png"
                  alt="diamond"
                />
                Qua Ngân Hàng
              </h3>
            </div>
            <hr />
            <div class="cs-iconbox_text">
              <form @submit.prevent="CheckOutBank">
                <div class="form-group">
                  <input
                    class="form-control"
                    type="number"
                    placeholder="Nhập số Tiền bạn muốn Nạp"
                    v-model="amountBank"
                    required
                    min="1"
                    max="1000"
                  />

                  <div v-if="amountBank < 20000 || amountBank > 20000000">
                    <div class="cs-height_30 cs-height_lg_30"></div>

                    <p style="color: red">Số tiền phải từ 20,000 đến 20,000,000 VND.</p>
                  </div>
                </div>

                <div v-if="user === null">
                  <div class="cs-height_30 cs-height_lg_30"></div>

                  <p style="color: red">
                    Vui lòng đăng nhập để thực hiện thanh toán.
                    <router-link to="/login"> Log In</router-link>
                  </p>
                </div>
                <div v-else>
                  <div class="cs-height_30 cs-height_lg_30"></div>

                  <div for="">Tên Người Gửi :{{ user.name }}</div>
                  <div for="">Số Tiền :{{ amountBank.toLocaleString("vi-VN", {
                    style: "currency",
                    currency: "VND",
                  })  }}</div>
                  <div class="cs-height_30 cs-height_lg_30"></div>
                </div>
                
              </form>
            </div>
          </div>
          <div class="cs-height_30 cs-height_lg_30"></div>
        </div>
      </div>
    </div>
    <div class="cs-height_70 cs-height_lg_40"></div>

    <footerHome></footerHome>
  </div>
</template>

<script>
import { onMounted } from "vue";
import { userInfo } from "@/store";
import { loadScript } from "@paypal/paypal-js";
import TransactiomService from "@/service/TransactionService";
import Swal from "sweetalert2";
import footerHome from "@/pages/footer.vue";
import startHeader from "@/pages/startHeader.vue";

export default {
  name: "coinPage",
  components: {
    startHeader,
    footerHome,
  },

  data() {
    return {
      user: userInfo.value,
      isAmountInvalid: false,
      amount: 0,
      amountBank:0
    };
  },

  methods: {
    handlePayPalSuccess() {
      // Xử lý thành công khi thanh toán PayPal ở đây
      const price = this.amount * 24582.5;
      console.log(price);
      if (this.amount >= 1 && this.amount <= 1000) {
        TransactiomService.saveTransaction(this.user.id, price)
          .then(() => {
            this.amount = 0;
            Swal.fire("", "Đơn Của Bạn Đang Đợi Duyệt", "success");
          })
          .catch(() => {
            Swal.fire("", "Lỗi Thanh Toán", "error");
          });
      } else {
        Swal.fire("", "Giá Trị Không Hợp Lệ", "error");
      }
    },

    async setupPayPal() {
      onMounted(async () => {
        let paypal;

        try {
          paypal = await loadScript({
            clientId:
              "AbLBGB3RVnQp5QZ6hEGgXxNAu1v0VKydgPZD2_uOqQ_ti-ZQQrRoUXJWUCHW9OFg51fm9goR6dEHB87b",
          });
        } catch (error){
          console.error(error);
        }

        if (paypal) {
          try {
            await paypal
              .Buttons({
                createOrder: (data, actions) => {
                  if (this.amount < 1) {
                    this.amount=1;
                  
                  } if (this.amount > 1000) {
                    this.amount=1000;
                  
                  } 
                    return actions.order.create({
                      intent: "CAPTURE",
                      purchase_units: [
                        {
                          amount: {
                            currency_code: "USD",
                            value: this.amount.toString(),
                          },
                        },
                      ],
                    });
                  
                },
                onApprove: (data, actions) => {
                  return actions.order.capture().then(() => {
                    this.handlePayPalSuccess();
                    Swal.fire("", "Thanh Toán Thành Công", "success");
                    console.log("Payment successful!");
                  });
                },
              })
              .render("#your-container-element");
          } catch (error) {
            console.error("Failed to render the PayPal Buttons", error);
          }
        }
      });
    },

    validateInput() {
      if (this.amount <= 0 || this.amount === "") {
        this.isAmountInvalid = false;
      } else {
        this.isAmountInvalid = true;
      }
    },
  },

  computed: {
    formattedPrice() {
      return new Intl.NumberFormat("vi-VN", {
        style: "currency",
        currency: "VND",
      }).format(this.amount * 24582.5);
    },
    
  },
  async created() {
    await this.setupPayPal();
  },
};
</script>
