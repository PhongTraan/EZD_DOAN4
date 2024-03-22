<template>
  <start-header></start-header>
  <div class="cs-height_100 cs-height_lg_70"></div>

  <TopDonate></TopDonate>
  <div class="container">
    <div class="row">
      <div class="cs-author_right">
        <h4>{{ username }}</h4>
      </div>
      <div class="col-lg-4">
        <div class="row">
          <!-- Trong template -->
          <div class="col-lg-12 col-sm-4 col-6">
            <a
              href="#"
              class="cs-card cs-style1 cs-box_shadow text-center cs-white_bg"
            >
              <div class="cs-card_thumb">
                <img :src="selectedImage" alt="Image" class="cs-zoom_item" />
              </div>
            </a>
          </div>
          <div class="cs-height_30 cs-height_lg_30"></div>

          <!-- Hiển thị danh sách ảnh -->
          <div
            class="col-lg-4 col-sm-4 col-6"
            v-for="avatar in avatars"
            :key="avatar.id"
          >
            <a
              href="#"
              class="cs-card cs-style1 cs-box_shadow text-center cs-white_bg"
              @click="showSelectedImage(avatar)"
            >
              <div class="cs-card_thumb">
                <img :src="avatar" alt="Image" class="cs-zoom_item" />
              </div>
            </a>
          </div>
        </div>
        <div class="cs-height_30 cs-height_lg_30"></div>
      </div>
      <div class="col-lg-8">
        <div class="cs-height_0 cs-height_lg_40"></div>
        <div class="cs-single_product_head">
          <h2>Skills</h2>
          <p>On sale for</p>
          <span class="cs-card_like cs-primary_color cs-box_shadow">
            <i class="fas fa-heart fa-fw"></i>
            2.1K
          </span>
        </div>
        <div class="cs-height_25 cs-height_lg_25"></div>
        <div class="row">
          <Carousel
            :itemsToShow="3.25"
            :wrapAround="true"
            :transition="500"
            class="custom-carousel"
          >
            <Slide
              class="custom-slide"
              v-for="item in listProduct"
              :key="item.id"
            >
              <div class="carousel__item">
                <img :src="item.img_product" alt="Image" />
                <div class="cs-author_right">
                  {{ item.game_product.nameGame }}
                  <div>
                    <img
                      width="35"
                      height="35"
                      src="https://img.icons8.com/plasticine/100/brawl-stars.png"
                      alt="brawl-stars"
                    />
                    <b class="cs-primary_color"
                      >{{ item.price }} vnĐ / {{ item.hour }}.h</b
                    >
                  </div>
                </div>
              </div>
            </Slide>
            <template #addons>
              <navigation class="custom-navigation" />
            </template>
          </Carousel>
          <div>
            <div class="cs-height_25 cs-height_lg_25"></div>
          </div>
        </div>

        <div class="cs-tabs cs-fade_tabs cs-style1">
          <div class="cs-medium">
            <ul
              class="cs-tab_links cs-style1 cs-medium cs-primary_color cs-mp0 cs-primary_font"
            >
              <li class="active"><a href="#Description">Description</a></li>
              <li><a href="#Details">Details</a></li>
            </ul>
          </div>
          <div class="cs-height_20 cs-height_lg_20"></div>
          <div class="cs-tab_content">
            <div id="Description" class="cs-tab active">
              <div class="cs-white_bg cs-box_shadow cs-general_box_5">
                Amet lorem minim mollit non deserunt ullamco est sit aliqua
                dolor do amet sint. Velit officia consequat duis enim velit
                mollit. Amet lorem minim mollit nonese deserunt ullamco est sit
                aliqua dolor do amet sint. Velit officia consequat duis enim
                velit mollit Velit officia else est sit ullamco es duis.
              </div>
            </div>
            <!-- .cs-tab -->
            <div id="Details" class="cs-tab">
              <div class="cs-white_bg cs-box_shadow cs-general_box_5">
                Velit officia consequat duis enim velit mollit. Amet lorem minim
                mollit nonese deserunt ullamco est sit aliqua dolor do amet
                sint. Velit officia consequat duis enim velit mollit Velit
                officia else est sit ullamco es duis. Amet lorem minim mollit
                non deserunt ullamco est sit aliqua dolor do amet sint.
              </div>
            </div>
            <!-- .cs-tab -->
          </div>
        </div>
        <div class="cs-height_25 cs-height_lg_25"></div>

        <div class="row">
          <div class="col-6">
            <div
              class="cs-btn cs-style1 cs-btn_lg w-100 text-center"
              @click="showDonateForm"
            >
              <span>Donate</span>
            </div>
            <!-- Popup form donate -->
            <div id="donate-popup" class="donate-popup">
              <div class="donate-popup-content">
                <span class="donate-popup-close" @click="closeDonateForm"
                  >&times;</span
                >
                <label for="amount">Số tiền:</label>
                <input type="number" v-model="amount" required />
                <p v-if="amount != null">Bạn Đã Nhập: {{ formattedPrice }}</p>
                <p>Donate Cho:{{ username }}</p>
                <button @click="handleDonate">Donate</button>
              </div>
            </div>
          </div>
          <div class="col-6">
            <a href="#" class="cs-btn cs-style1 cs-btn_lg w-100 text-center"
              ><span>Place Bid</span></a
            >
          </div>
        </div>
        <div class="cs-height_25 cs-height_lg_25"></div>
        <div class="cs-tabs cs-fade_tabs cs-style1">
          <div class="cs-medium">
            <ul
              class="cs-tab_links cs-style1 cs-medium cs-primary_color cs-mp0 cs-primary_font"
            >
              <li class="active"><a href="#tab_one">History</a></li>
              <li><a href="#tab_two">Bid</a></li>
            </ul>
          </div>
          <div class="cs-height_20 cs-height_lg_20"></div>
          <div class="cs-tab_content">
            <div id="tab_one" class="cs-tab active">
              <ul class="cs-activity_list cs-mp0">
                <li>
                  <div class="cs-activity cs-white_bg cs-type1">
                    <div class="cs-activity_avatar"></div>
                    <div class="cs-activity_right">
                      <p class="cs-activity_text">
                        Bid accepted <span>9 ETH</span> by
                        <a href="#">@raymond</a>
                      </p>
                      <p class="cs-activity_posted_by">16 Mar 2022, 11:22 PM</p>
                    </div>
                    <div
                      class="cs-activity_icon cs-center cs-gray_bg cs-accent_color"
                    >
                      <svg
                        width="24"
                        height="24"
                        viewBox="0 0 24 24"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                      >
                        <path
                          fill-rule="evenodd"
                          clip-rule="evenodd"
                          d="M7.58321 0.709957C6.80344 0.874407 6.18914 1.21704 5.59168 1.82076C5.18675 2.22991 5.00479 2.50229 4.76907 3.05207C4.50504 3.66793 4.48083 3.89286 4.48083 5.73042V7.37635H3.41299C2.54968 7.37635 2.3136 7.3895 2.18057 7.44513C1.96981 7.53316 1.82838 7.66619 1.71925 7.87903C1.6398 8.03397 1.60008 8.62486 1.2546 14.7885C1.04683 18.4956 0.887802 21.6486 0.901176 21.7952C0.933924 22.154 1.17236 22.635 1.43954 22.8813C1.5516 22.9846 1.77688 23.1324 1.94009 23.2097L2.23691 23.3504L6.05108 23.3627L9.86525 23.375L9.73124 23.1405C9.51169 22.7562 9.36302 22.248 9.33844 21.7974C9.30778 21.2353 9.83037 13.8479 9.92639 13.4862C9.96527 13.3396 10.0588 13.1041 10.1341 12.9627C10.2958 12.6594 10.745 12.2223 11.058 12.0637C11.495 11.8422 11.7038 11.8211 13.4676 11.8204L15.1006 11.8198L15.1013 11.6976C15.1016 11.6304 15.0606 10.8055 15.01 9.86466C14.9095 7.99483 14.8896 7.87774 14.6301 7.62567C14.4029 7.40505 14.2408 7.37635 13.2221 7.37635H12.3092L12.2904 5.65453C12.2732 4.07388 12.2639 3.90467 12.1777 3.59066C11.6104 1.52377 9.62549 0.279258 7.58321 0.709957ZM8.86051 2.0029C9.75083 2.16326 10.5632 2.9018 10.8612 3.82163C10.9298 4.03349 10.9426 4.28614 10.9576 5.72118L10.9749 7.37635H11.6417H12.3085L12.2938 8.15083C12.2804 8.85049 12.2702 8.93709 12.1874 9.04787C11.8758 9.46484 11.3401 9.47515 11.0691 9.06938C10.9739 8.92692 10.9682 8.87498 10.9682 8.14737V7.37635H8.39471H5.82118L5.80643 8.15083C5.79305 8.85049 5.78279 8.93709 5.70001 9.04787C5.38839 9.46484 4.85274 9.47515 4.58169 9.06938C4.48651 8.92692 4.48083 8.87498 4.48083 8.14737V7.37635H5.14734H5.81385V5.80112C5.81385 4.10672 5.8302 3.93978 6.04233 3.46904C6.27632 2.94988 6.72745 2.48132 7.25 2.21472C7.68696 1.99179 8.3297 1.90728 8.86051 2.0029ZM11.7014 13.2364C11.4861 13.3362 11.3508 13.4769 11.2592 13.6961C11.1769 13.893 10.6373 21.2578 10.6707 21.7285C10.7251 22.4959 11.2453 23.1174 11.9949 23.3103C12.2061 23.3647 13.0058 23.3726 17.2603 23.3624L22.2767 23.3504L22.5735 23.2097C22.7367 23.1324 22.9614 22.9851 23.0729 22.8824C23.3192 22.6553 23.57 22.1737 23.6098 21.8513C23.6271 21.7113 23.5294 20.0574 23.3663 17.7295C23.0598 13.3569 23.0937 13.5829 22.7036 13.3087L22.5134 13.175L17.1962 13.1645C12.0992 13.1544 11.8717 13.1574 11.7014 13.2364ZM15.4736 15.253C15.7574 15.4157 15.8115 15.5711 15.8115 16.2241C15.8115 16.9539 15.8786 17.177 16.1929 17.4933C16.5907 17.8934 17.1539 17.9713 17.6468 17.6946C18.1309 17.4227 18.2998 17.0384 18.2998 16.2092C18.2998 15.6054 18.3481 15.4412 18.5725 15.2811C18.7704 15.14 19.126 15.1327 19.3047 15.2661C19.5817 15.4729 19.6094 15.5528 19.6248 16.1885C19.65 17.2283 19.439 17.8413 18.8537 18.4286C18.0668 19.2184 16.9536 19.4099 15.9495 18.9283C15.6546 18.7868 15.5055 18.6776 15.2373 18.4061C14.6651 17.8268 14.4806 17.3113 14.4792 16.2883C14.4786 15.8042 14.4924 15.6848 14.567 15.5307C14.7354 15.183 15.1369 15.06 15.4736 15.253Z"
                          fill="currentColor"
                        />
                      </svg>
                    </div>
                  </div>
                </li>
              </ul>
            </div>
            <!-- .cs-tab -->
            <div id="tab_two" class="cs-tab">
              <!-- <ul class="cs-activity_list cs-mp0">
                  <li>
                    <div class="cs-activity cs-white_bg cs-type1">
                      <div class="cs-activity_avatar">
                        <img src="<%= BASE_URL %>assets/img/avatar/avatar_27.png" alt="" />
                      </div>
                      <div class="cs-activity_right">
                        <p class="cs-activity_text">
                          Bid accepted <span>6 ETH</span> by
                          <a href="#">@clarence</a>
                        </p>
                        <p class="cs-activity_posted_by">
                          16 Mar 2022, 11:22 PM
                        </p>
                      </div>
                      <div
                        class="cs-activity_icon cs-center cs-gray_bg cs-accent_color"
                      >
                        <svg
                          width="24"
                          height="24"
                          viewBox="0 0 24 24"
                          fill="none"
                          xmlns="http://www.w3.org/2000/svg"
                        >
                          <path
                            fill-rule="evenodd"
                            clip-rule="evenodd"
                            d="M7.58321 0.709957C6.80344 0.874407 6.18914 1.21704 5.59168 1.82076C5.18675 2.22991 5.00479 2.50229 4.76907 3.05207C4.50504 3.66793 4.48083 3.89286 4.48083 5.73042V7.37635H3.41299C2.54968 7.37635 2.3136 7.3895 2.18057 7.44513C1.96981 7.53316 1.82838 7.66619 1.71925 7.87903C1.6398 8.03397 1.60008 8.62486 1.2546 14.7885C1.04683 18.4956 0.887802 21.6486 0.901176 21.7952C0.933924 22.154 1.17236 22.635 1.43954 22.8813C1.5516 22.9846 1.77688 23.1324 1.94009 23.2097L2.23691 23.3504L6.05108 23.3627L9.86525 23.375L9.73124 23.1405C9.51169 22.7562 9.36302 22.248 9.33844 21.7974C9.30778 21.2353 9.83037 13.8479 9.92639 13.4862C9.96527 13.3396 10.0588 13.1041 10.1341 12.9627C10.2958 12.6594 10.745 12.2223 11.058 12.0637C11.495 11.8422 11.7038 11.8211 13.4676 11.8204L15.1006 11.8198L15.1013 11.6976C15.1016 11.6304 15.0606 10.8055 15.01 9.86466C14.9095 7.99483 14.8896 7.87774 14.6301 7.62567C14.4029 7.40505 14.2408 7.37635 13.2221 7.37635H12.3092L12.2904 5.65453C12.2732 4.07388 12.2639 3.90467 12.1777 3.59066C11.6104 1.52377 9.62549 0.279258 7.58321 0.709957ZM8.86051 2.0029C9.75083 2.16326 10.5632 2.9018 10.8612 3.82163C10.9298 4.03349 10.9426 4.28614 10.9576 5.72118L10.9749 7.37635H11.6417H12.3085L12.2938 8.15083C12.2804 8.85049 12.2702 8.93709 12.1874 9.04787C11.8758 9.46484 11.3401 9.47515 11.0691 9.06938C10.9739 8.92692 10.9682 8.87498 10.9682 8.14737V7.37635H8.39471H5.82118L5.80643 8.15083C5.79305 8.85049 5.78279 8.93709 5.70001 9.04787C5.38839 9.46484 4.85274 9.47515 4.58169 9.06938C4.48651 8.92692 4.48083 8.87498 4.48083 8.14737V7.37635H5.14734H5.81385V5.80112C5.81385 4.10672 5.8302 3.93978 6.04233 3.46904C6.27632 2.94988 6.72745 2.48132 7.25 2.21472C7.68696 1.99179 8.3297 1.90728 8.86051 2.0029ZM11.7014 13.2364C11.4861 13.3362 11.3508 13.4769 11.2592 13.6961C11.1769 13.893 10.6373 21.2578 10.6707 21.7285C10.7251 22.4959 11.2453 23.1174 11.9949 23.3103C12.2061 23.3647 13.0058 23.3726 17.2603 23.3624L22.2767 23.3504L22.5735 23.2097C22.7367 23.1324 22.9614 22.9851 23.0729 22.8824C23.3192 22.6553 23.57 22.1737 23.6098 21.8513C23.6271 21.7113 23.5294 20.0574 23.3663 17.7295C23.0598 13.3569 23.0937 13.5829 22.7036 13.3087L22.5134 13.175L17.1962 13.1645C12.0992 13.1544 11.8717 13.1574 11.7014 13.2364ZM15.4736 15.253C15.7574 15.4157 15.8115 15.5711 15.8115 16.2241C15.8115 16.9539 15.8786 17.177 16.1929 17.4933C16.5907 17.8934 17.1539 17.9713 17.6468 17.6946C18.1309 17.4227 18.2998 17.0384 18.2998 16.2092C18.2998 15.6054 18.3481 15.4412 18.5725 15.2811C18.7704 15.14 19.126 15.1327 19.3047 15.2661C19.5817 15.4729 19.6094 15.5528 19.6248 16.1885C19.65 17.2283 19.439 17.8413 18.8537 18.4286C18.0668 19.2184 16.9536 19.4099 15.9495 18.9283C15.6546 18.7868 15.5055 18.6776 15.2373 18.4061C14.6651 17.8268 14.4806 17.3113 14.4792 16.2883C14.4786 15.8042 14.4924 15.6848 14.567 15.5307C14.7354 15.183 15.1369 15.06 15.4736 15.253Z"
                            fill="currentColor"
                          />
                        </svg>
                      </div>
                    </div>
                  </li>
                  <li>
                    <div class="cs-activity cs-white_bg cs-type1">
                      <div class="cs-activity_avatar">
                        <img src="<%= BASE_URL %>assets/img/avatar/avatar_28.png" alt="" />
                      </div>
                      <div class="cs-activity_right">
                        <p class="cs-activity_text">
                          Bid accepted <span>4 ETH</span> by
                          <a href="#">@bernard</a>
                        </p>
                        <p class="cs-activity_posted_by">
                          19 Feb 2022, 10:22 PM
                        </p>
                      </div>
                      <div
                        class="cs-activity_icon cs-center cs-gray_bg cs-accent_color"
                      >
                        <svg
                          width="24"
                          height="24"
                          viewBox="0 0 24 24"
                          fill="none"
                          xmlns="http://www.w3.org/2000/svg"
                        >
                          <path
                            fill-rule="evenodd"
                            clip-rule="evenodd"
                            d="M7.58321 0.709957C6.80344 0.874407 6.18914 1.21704 5.59168 1.82076C5.18675 2.22991 5.00479 2.50229 4.76907 3.05207C4.50504 3.66793 4.48083 3.89286 4.48083 5.73042V7.37635H3.41299C2.54968 7.37635 2.3136 7.3895 2.18057 7.44513C1.96981 7.53316 1.82838 7.66619 1.71925 7.87903C1.6398 8.03397 1.60008 8.62486 1.2546 14.7885C1.04683 18.4956 0.887802 21.6486 0.901176 21.7952C0.933924 22.154 1.17236 22.635 1.43954 22.8813C1.5516 22.9846 1.77688 23.1324 1.94009 23.2097L2.23691 23.3504L6.05108 23.3627L9.86525 23.375L9.73124 23.1405C9.51169 22.7562 9.36302 22.248 9.33844 21.7974C9.30778 21.2353 9.83037 13.8479 9.92639 13.4862C9.96527 13.3396 10.0588 13.1041 10.1341 12.9627C10.2958 12.6594 10.745 12.2223 11.058 12.0637C11.495 11.8422 11.7038 11.8211 13.4676 11.8204L15.1006 11.8198L15.1013 11.6976C15.1016 11.6304 15.0606 10.8055 15.01 9.86466C14.9095 7.99483 14.8896 7.87774 14.6301 7.62567C14.4029 7.40505 14.2408 7.37635 13.2221 7.37635H12.3092L12.2904 5.65453C12.2732 4.07388 12.2639 3.90467 12.1777 3.59066C11.6104 1.52377 9.62549 0.279258 7.58321 0.709957ZM8.86051 2.0029C9.75083 2.16326 10.5632 2.9018 10.8612 3.82163C10.9298 4.03349 10.9426 4.28614 10.9576 5.72118L10.9749 7.37635H11.6417H12.3085L12.2938 8.15083C12.2804 8.85049 12.2702 8.93709 12.1874 9.04787C11.8758 9.46484 11.3401 9.47515 11.0691 9.06938C10.9739 8.92692 10.9682 8.87498 10.9682 8.14737V7.37635H8.39471H5.82118L5.80643 8.15083C5.79305 8.85049 5.78279 8.93709 5.70001 9.04787C5.38839 9.46484 4.85274 9.47515 4.58169 9.06938C4.48651 8.92692 4.48083 8.87498 4.48083 8.14737V7.37635H5.14734H5.81385V5.80112C5.81385 4.10672 5.8302 3.93978 6.04233 3.46904C6.27632 2.94988 6.72745 2.48132 7.25 2.21472C7.68696 1.99179 8.3297 1.90728 8.86051 2.0029ZM11.7014 13.2364C11.4861 13.3362 11.3508 13.4769 11.2592 13.6961C11.1769 13.893 10.6373 21.2578 10.6707 21.7285C10.7251 22.4959 11.2453 23.1174 11.9949 23.3103C12.2061 23.3647 13.0058 23.3726 17.2603 23.3624L22.2767 23.3504L22.5735 23.2097C22.7367 23.1324 22.9614 22.9851 23.0729 22.8824C23.3192 22.6553 23.57 22.1737 23.6098 21.8513C23.6271 21.7113 23.5294 20.0574 23.3663 17.7295C23.0598 13.3569 23.0937 13.5829 22.7036 13.3087L22.5134 13.175L17.1962 13.1645C12.0992 13.1544 11.8717 13.1574 11.7014 13.2364ZM15.4736 15.253C15.7574 15.4157 15.8115 15.5711 15.8115 16.2241C15.8115 16.9539 15.8786 17.177 16.1929 17.4933C16.5907 17.8934 17.1539 17.9713 17.6468 17.6946C18.1309 17.4227 18.2998 17.0384 18.2998 16.2092C18.2998 15.6054 18.3481 15.4412 18.5725 15.2811C18.7704 15.14 19.126 15.1327 19.3047 15.2661C19.5817 15.4729 19.6094 15.5528 19.6248 16.1885C19.65 17.2283 19.439 17.8413 18.8537 18.4286C18.0668 19.2184 16.9536 19.4099 15.9495 18.9283C15.6546 18.7868 15.5055 18.6776 15.2373 18.4061C14.6651 17.8268 14.4806 17.3113 14.4792 16.2883C14.4786 15.8042 14.4924 15.6848 14.567 15.5307C14.7354 15.183 15.1369 15.06 15.4736 15.253Z"
                            fill="currentColor"
                          />
                        </svg>
                      </div>
                    </div>
                  </li>
  
                </ul> -->
            </div>
            <!-- .cs-tab -->
          </div>
        </div>
        <div class="cs-height_30 cs-height_lg_30"></div>
        <div class="row">
          <!-- <div class="col-xl-6">
            <div class="cs-general_box_4 cs-box_shadow cs-white_bg cs-center">
              <div class="cs-countdown" data-countdate="24 August 2022">
                <div class="cs-countdown_item">
                  <div class="cs-countdown_number">
                    <div class="cs-count_days"></div>
                  </div>
                  <h3 class="cs-countdown_text">Days</h3>
                </div>
                <div class="cs-countdown_item">
                  <div class="cs-countdown_number">
                    <div class="cs-count_hours"></div>
                  </div>
                  <h3 class="cs-countdown_text">Hours</h3>
                </div>
                <div class="cs-countdown_item">
                  <div class="cs-countdown_number">
                    <div class="cs-count_minutes"></div>
                  </div>
                  <h3 class="cs-countdown_text">Min</h3>
                </div>
                <div class="cs-countdown_item">
                  <div class="cs-countdown_number">
                    <div class="cs-count_seconds"></div>
                  </div>
                  <h3 class="cs-countdown_text">Sec</h3>
                </div>
              </div>
            </div>
            <div class="cs-height_30 cs-height_lg_30"></div>
          </div> -->
          <div class="col-xl-12">
            <div class="cs-white_bg cs-box_shadow cs-general_box_5">
              <div class="cs-social_widget justify-content-center">
                <a href="#"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
                <a href="#"><i class="fab fa-linkedin-in"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-youtube"></i></a>
              </div>
            </div>
            <div class="cs-height_30 cs-height_lg_30"></div>
          </div>
        </div>
        <div class="cs-height_10 cs-height_lg_10"></div>
      </div>
    </div>
  </div>
  <div class="cs-height_95 cs-height_lg_70"></div>

  <div class="container">
    <div class="row">
      <div class="col-lg-8 offset-lg-2">
        <div id="comments" class="comments-area">
          <h2 class="comments-title">Comments</h2>
          <ol class="comment-list">
            <li class="comment">
              <div class="comment-body">
                <div class="comment-author vcard">
                  <img
                    class="avatar"
                    src="assets/img/avatar/avatar_5.png"
                    alt="Author"
                  />
                  <a href="#" class="url">George Steven</a>
                </div>
                <div class="comment-meta">
                  <a href="#">Jan 24, 2022 at 9:59 am </a>
                </div>
                <p>
                  Donec pellentesque luctus tortor finibus blandit. Fusce
                  tincidunt lectus augue, quis commodo justo tincidunt eget.
                  Praesent at elit diam. Tortor finibus blandit
                </p>
                <div class="reply">
                  <a class="comment-reply-link" href="#">
                    Reply
                    <svg
                      width="16"
                      height="14"
                      viewBox="0 0 16 14"
                      fill="none"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <path
                        d="M1 5.74707H8.5C10.0913 5.74707 11.6174 6.37921 12.7426 7.50443C13.8679 8.62965 14.5 10.1558 14.5 11.7471V13.2471M1 5.74707L5.5 10.2471M1 5.74707L5.5 1.24707"
                        stroke="currentColor"
                        stroke-width="1.5"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                    </svg>
                  </a>
                </div>
              </div>
              <ol class="children">
                <li class="comment">
                  <div class="comment-body">
                    <div class="comment-author vcard">
                      <img
                        class="avatar"
                        src="assets/img/avatar/avatar_11.png"
                        alt="Author"
                      />
                      <a href="#" class="url">Sarah Taylor</a>
                    </div>
                    <div class="comment-meta">
                      <a href="#">Jan 24, 2022 at 9:59 am </a>
                    </div>
                    <p>Thanks bro 🙂</p>
                    <div class="reply">
                      <a class="comment-reply-link" href="#">
                        Reply
                        <svg
                          width="16"
                          height="14"
                          viewBox="0 0 16 14"
                          fill="none"
                          xmlns="http://www.w3.org/2000/svg"
                        >
                          <path
                            d="M1 5.74707H8.5C10.0913 5.74707 11.6174 6.37921 12.7426 7.50443C13.8679 8.62965 14.5 10.1558 14.5 11.7471V13.2471M1 5.74707L5.5 10.2471M1 5.74707L5.5 1.24707"
                            stroke="currentColor"
                            stroke-width="1.5"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                          />
                        </svg>
                      </a>
                    </div>
                  </div>
                </li>
                <!-- #comment-## -->
              </ol>
              <!-- .children -->
            </li>
            <!-- #comment-## -->
            <li class="comment cs-accent_4_bg">
              <div class="comment-body">
                <div class="comment-author vcard">
                  <img
                    class="avatar"
                    src="assets/img/avatar/avatar_7.png"
                    alt="Author"
                  />
                  <a href="#" class="url">Jhon Doe</a>
                </div>
                <div class="comment-meta">
                  <a href="#">Jan 24, 2022 at 9:59 am </a>
                </div>
                <p>
                  Fusce tincidunt lectus augue, quis commodo justo tincidunt
                  eget. Praesent at elit diam. Tortor finibus blandit. Donec
                  pellentesque luctus tortor finibus blandit.
                </p>
                <div class="reply">
                  <a class="comment-reply-link" href="#">
                    Reply
                    <svg
                      width="16"
                      height="14"
                      viewBox="0 0 16 14"
                      fill="none"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <path
                        d="M1 5.74707H8.5C10.0913 5.74707 11.6174 6.37921 12.7426 7.50443C13.8679 8.62965 14.5 10.1558 14.5 11.7471V13.2471M1 5.74707L5.5 10.2471M1 5.74707L5.5 1.24707"
                        stroke="currentColor"
                        stroke-width="1.5"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                    </svg>
                  </a>
                </div>
              </div>
            </li>
            <!-- #comment-## -->
          </ol>
          <!-- .comment-list -->
        </div>
        <div class="cs-height_60 cs-height_lg_30"></div>
        <h3 class="comment-reply-title cs-semi_bold">Leave a comment</h3>
        <div id="respond" class="comment-respond cs-box_shadow cs-white_bg">
          <form
            action="#"
            method="post"
            id="commentform"
            class="comment-form tb-comment-form cs-accent_4_bg"
          >
            <div class="cs-form_field_wrap">
              <input
                type="text"
                class="cs-form_field"
                placeholder="Your Name"
              />
            </div>
            <div class="cs-height_20 cs-height_lg_20"></div>
            <div class="cs-form_field_wrap">
              <input
                type="text"
                class="cs-form_field"
                placeholder="Your Email"
              />
            </div>
            <div class="cs-height_20 cs-height_lg_20"></div>
            <div class="cs-form_field_wrap">
              <textarea
                cols="30"
                rows="5"
                placeholder="Message..."
                class="cs-form_field"
              ></textarea>
            </div>
            <div class="cs-height_20 cs-height_lg_20"></div>
            <button class="cs-btn cs-style1 cs-btn_lg">
              <span>Post Comment</span>
            </button>
          </form>
        </div>
      </div>
    </div>
  </div>
  <div class="cs-height_100 cs-height_lg_70"></div>
  <div class="container">
    <h2 class="cs-section_heading cs-style1 text-center">
      Other Similar Posts
    </h2>
    <div class="cs-height_45 cs-height_lg_45"></div>
    <div class="row">
      <div class="col-lg-4">
        <div class="cs-post cs-style1">
          <a href="blog-details.html" class="cs-post_thumb">
            <div
              class="cs-post_thumb_in cs-bg"
              data-src="assets/img/general/general_16.jpeg"
            ></div>
          </a>
          <div class="cs-post_info">
            <h2 class="cs-post_title">
              <a href="blog-details.html"
                >Guide to Making, Buying and Selling NFT</a
              >
            </h2>
            <div class="cs-post_subtitle">
              It is a long established fact that a reader will be distrac by the
              readable content of a page...
            </div>
            <div class="cs-height_20 cs-height_lg_20"></div>
            <div class="cs-post_avatar">
              <a href="#" class="cs-post_avatar_img"
                ><img src="assets/img/avatar/avatar_18.png" alt="Avatr"
              /></a>
              <div class="cs-post_avatar_right">
                <h2 class="cs-post_avatar_name cs-semi_bold">
                  <a href="#">Marina G. Trujillo</a>
                </h2>
                <div class="cs-post_meta">
                  <span class="cs-post_meta_item">5 Mar 2022</span>
                  <span class="cs-post_meta_item">25 Comments</span>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="cs-height_30 cs-height_lg_30"></div>
      </div>
      <!-- .col -->
      <div class="col-lg-4">
        <div class="cs-post cs-style1">
          <a href="blog-details.html" class="cs-post_thumb">
            <div
              class="cs-post_thumb_in cs-bg"
              data-src="assets/img/general/general_17.jpeg"
            ></div>
          </a>
          <div class="cs-post_info">
            <h2 class="cs-post_title">
              <a href="blog-details.html">Why do NFTs even make sense?</a>
            </h2>
            <div class="cs-post_subtitle">
              It is a long established fact that a reader will be distrac by the
              readable content of a page...
            </div>
            <div class="cs-height_20 cs-height_lg_20"></div>
            <div class="cs-post_avatar">
              <a href="#" class="cs-post_avatar_img"
                ><img src="assets/img/avatar/avatar_19.png" alt="Avatr"
              /></a>
              <div class="cs-post_avatar_right">
                <h2 class="cs-post_avatar_name cs-semi_bold">
                  <a href="#">Author</a>
                </h2>
                <div class="cs-post_meta">
                  <span class="cs-post_meta_item">5 Mar 2022</span>
                  <span class="cs-post_meta_item">25 Comments</span>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="cs-height_30 cs-height_lg_30"></div>
      </div>
      <!-- .col -->
      <div class="col-lg-4">
        <div class="cs-post cs-style1">
          <a href="blog-details.html" class="cs-post_thumb">
            <div
              class="cs-post_thumb_in cs-bg"
              data-src="assets/img/general/general_18.jpeg"
            ></div>
          </a>
          <div class="cs-post_info">
            <h2 class="cs-post_title">
              <a href="blog-details.html">Why do NFTs even make sense?</a>
            </h2>
            <div class="cs-post_subtitle">
              It is a long established fact that a reader will be distrac by the
              readable content of a page...
            </div>
            <div class="cs-height_20 cs-height_lg_20"></div>
            <div class="cs-post_avatar">
              <a href="#" class="cs-post_avatar_img"
                ><img src="assets/img/avatar/avatar_19.png" alt="Avatr"
              /></a>
              <div class="cs-post_avatar_right">
                <h2 class="cs-post_avatar_name cs-semi_bold">
                  <a href="#">Author</a>
                </h2>
                <div class="cs-post_meta">
                  <span class="cs-post_meta_item">5 Mar 2022</span>
                  <span class="cs-post_meta_item">25 Comments</span>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="cs-height_30 cs-height_lg_30"></div>
      </div>
      <!-- .col -->
    </div>
  </div>
  <div class="cs-height_65 cs-height_lg_35"></div>
  <div class="container">
    <h2 class="cs-section_heading cs-style1">Similar Items</h2>
    <div class="cs-height_45 cs-height_lg_45"></div>
    <div class="cs-grid_5 cs-gap_30"></div>
  </div>

  <div class="cs-height_100 cs-height_lg_70"></div>
  <footerHome></footerHome>
</template>

<script>
import DonateService from "@/service/DonateService";
import footerHome from "@/pages/footer.vue";
import startHeader from "@/pages/startHeader.vue";
import ProductService from "@/service/ProductService";
import { Carousel, Navigation, Slide } from "vue3-carousel";
import { userInfo } from "@/store";
import Swal from "sweetalert2";
import RegisterService from "@/service/RegisterService";
// fire base
import db from "@/firebase/init.js";
import { collection, addDoc } from "firebase/firestore";
import TopDonate from "@/pages/topDonate.vue";

export default {
  name: "productDetails",
  props: ["id"], // Nhận tham số id từ URL
  data() {
    return {
      BASE_URL: process.env.BASE_URL,
      listProduct: [],
      avatars: [], // This should be "avatars" instead of "avartas"
      username: "",
      amount: null,
    };
  },
  components: {
    startHeader,
    footerHome,
    Carousel,
    Slide,
    Navigation,
    TopDonate,
  },
  methods: {
    showDonateForm() {
      const donatePopup = document.getElementById("donate-popup");
      donatePopup.style.display = "block";
    },
    closeDonateForm() {
      const donatePopup = document.getElementById("donate-popup");
      donatePopup.style.display = "none";
    },
    async handleDonate() {
      try {
        const fromUserId = userInfo.value.id;
        const toUserId = this.listProduct[0].user_product.id;
        const userBalance = userInfo.value.balance;
        if (userBalance < this.amount) {
          // Hiển thị thông báo lỗi nếu số dư không đủ
          Swal.fire({
            icon: "error",
            title: "Không đủ số dư",
            text: "Số dư của bạn không đủ để thực hiện giao dịch.",
          });
          return; // Dừng xử lý nếu số dư không đủ
        }

        if (this.amount < 1000 || this.amount > 10000000) {
          // Hiển thị thông báo lỗi nếu số dư không đủ
          Swal.fire({
            icon: "error",
            title: "Giá Trị Không Hợp Lệ",
            text: "Số Tiền Donate Từ 1000 đến 10 triệu vnđ",
          });
          return; // Dừng xử lý nếu số dư không đủ
        }
        // Thêm dữ liệu vào collection mới trong Firestore
        const donationData = {
          fromUserName: userInfo.value.name,
          toUserName: this.listProduct[0].user_product.name,
          amount: this.amount,
          timestamp: new Date(),
        };

        const donationRef = await addDoc(
          collection(db, "donations"),
          donationData,
        );
        console.log("Document ID: ", donationRef.id);

        // Gọi phương thức donate từ service và truyền thông tin donate
        await DonateService.saveTransaction(fromUserId, toUserId, this.amount);

        Swal.fire("", "Donate Thành Công ✔️", "success");
        const newRespone = await RegisterService.findByEmail(
          userInfo.value.email,
        );
        this.newUser = newRespone;
        userInfo.value = this.newUser;
        console.log("value new" + userInfo.value.balance);
        // Gọi các xử lý khác sau khi donate thành công nếu cần
        this.showDonateForm = false; // Ẩn form donate sau khi thành công
      } catch (error) {
        Swal.fire("", "Donate Lỗi ,Hãy Thử Lại ", "error");
        // Xử lý lỗi nếu có
      }
    },
    async getAllProductById(id) {
    try {
      console.log(id);
      const response = await ProductService.getProductsByUser(id);
      this.listProduct = response.sort((a, b) => b.id - a.id); // giảm dần
      this.avatars = this.listProduct[0].user_product.avatars;
      this.username = this.listProduct[0].user_product.name;
        // Gán ảnh đầu tiên làm ảnh mặc định
        if (this.avatars.length > 0) {
        this.selectedImage = this.avatars[0];
      }
    } catch (error) {
      console.error("Error fetching products by user:", error);
    }
  },
  showSelectedImage(imageUrl) {
    // Gán URL của ảnh được chọn vào trạng thái selectedImage
    this.selectedImage = imageUrl;
  },
  },
  async created() {
    await this.getAllProductById(this.id);
  },
  computed: {
    formattedPrice() {
      return new Intl.NumberFormat("vi-VN", {
        style: "currency",
        currency: "VND",
      }).format(this.amount);
    },
  },
};
</script>
<style scoped>
@import url("vue3-carousel/dist/carousel.css");
.carousel__image {
  width: 300px;
  height: 300px;
  border-radius: 10px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}
.custom-carousel {
  display: flex;
  justify-content: space-between;

  align-items: center;
  padding: 0 20px; /* Thêm padding nếu cần thiết */
}
.carousel__item {
  margin-right: 20px;
  margin-left: 20px; /* Thay đổi giá trị này để điều chỉnh khoảng cách giữa các item */
  box-sizing: border-box;
  background-color: rgb(50, 76, 148); /* Thêm background-color trắng */
}
.carousel__item img {
  width: 100%;
  height: 120px;
}
.carousel__item:last-child {
  margin-right: 0; /* Không cần margin cho item cuối cùng */
}
.custom-navigation {
  /* Thay đổi màu cho Navigation */
  background-color: #69d6a7; /* Màu nền */
  color: white; /* Màu chữ */
}

/* CSS tùy chỉnh cho Pagination */

.donate-popup {
  display: none;
  position: fixed;
  top: 200px;
  left: 350px;
  width: 50%;
  height: 250px;
  background-color: #cc6161;
  border-radius: 10px;
}

.donate-popup-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
}

.donate-popup-content {
  background-color: #fefefe;
  margin: 5% auto;
  padding: 20px;
  border: 1px solid #888;
  width: 100%;
  position: relative;
  color: black;
}

.donate-popup-close {
  color: #aaa;
  position: absolute;
  top: 10px;
  right: 10px;
  font-size: 24px;
  cursor: pointer;
}

.donate-popup-close:hover {
  color: black;
}

.donate-popup label {
  /* Điều chỉnh các thuộc tính của nhãn (label) */
  /* Ví dụ: */
  font-size: 16px;
  color: #555555;
}

.donate-popup input {
  /* Điều chỉnh các thuộc tính của ô input */
  /* Ví dụ: */
  height: 40px;
  width: 100%;
  border: 1px solid #cccccc;
  border-radius: 5px;
  margin-bottom: 15px;
  padding: 5px;
  font-size: 14px;
}
.donate-popup button {
  /* Điều chỉnh các thuộc tính của nút Donate */
  /* Ví dụ: */
  background-color: #e91e63;
  color: #ffffff;
  border: none;
  border-radius: 5px;
  height: 40px;
  cursor: pointer;
  font-size: 16px;
}
</style>
