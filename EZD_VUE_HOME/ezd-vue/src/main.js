import { createApp } from 'vue'
import App from './App.vue'
import { plugin, defaultConfig } from '@formkit/vue'
// import { createProPlugin, inputs } from '@formkit/pro'
import '@formkit/themes/genesis'
// const pro = createProPlugin('fk-679fdfaa9b4', inputs)
import config from './formkit.config'
import VueAwesomePaginate from "vue-awesome-paginate";
import "vue-awesome-paginate/dist/style.css";


import router from './router/index'
const app = createApp(App)
app.use(plugin, defaultConfig( config))
app.use(router)
.use(VueAwesomePaginate)
app.mount('#app')