<template>
    <section>
        <div class="container">
          <div class="cs-section_heading cs-style2">
            <div class="cs-section_left">
              <h2 class="cs-section_title">TFT Live</h2>
            </div>
            <div class="cs-section_right">
              <a href="collection.html" class="cs-btn cs-style1"><span>Explore More</span></a>
            </div>
          </div>
          <div class="cs-height_45 cs-height_lg_45"></div>
          <div class="cs-grid_5 cs-gap_30"  >
            <div class="cs-card cs-style3 cs-box_shadow cs-white_bg" v-for="video in liveVideos" :key="video.id.videoId" >
            
                <iframe :src="getVideoEmbedURL(video.id.videoId)" frameborder="0" allowfullscreen></iframe>
              
            
              <div class="cs-card_info">
               
                <div class="cs-card_subtitle">
                  <i class="far fa-check-circle fa-fw"></i>
                  <span>Guarranted Authentic</span>
                </div>

           
              </div>
            </div>
          </div>
        </div>
      </section>


  </template>
  
  <script>
  import axios from 'axios';
  
  export default {
    name:'liveYoutube',
    data() {
      return {
        liveVideos: [],
      };
    },
    methods: {
      getVideoEmbedURL(videoId) {
        return `https://www.youtube.com/embed/${videoId}`;
      },
      videoTitle(video) {
        if (video && video.snippet && video.snippet.title) {
          return video.snippet.title;
        } else {
          return 'Video Title Not Available';
        }
      },
      async fetchLiveVideos() {
        try {
          const response = await axios.get('https://www.googleapis.com/youtube/v3/search', {
            params: {
              q: 'tft',
              type: 'video',
              eventType: 'live',
              key: process.env.VUE_APP_YOUTUBE_API_KEY,
              maxResults: 8, // Số lượng video tối đa bạn muốn lấy
            },
          });
  
          this.liveVideos = response.data.items;
        } catch (error) {
          console.error('Error fetching live videos:', error);
        }
      },
    },
    mounted() {
      this.fetchLiveVideos();
    },
  };
  </script>
  