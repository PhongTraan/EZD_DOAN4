import { createRouter, createWebHistory } from "vue-router";

import HomePage from "@/components/Home.vue";
import AboutPage from "@/components/About.vue";
import BecomeIdol from "@/components/BecomeIdol.vue";
import GameIndex from "@/components/miniGame/index.vue";
import LoginPage from "@/components/auth/Login.vue";
import RegisterPage from "@/components/auth/Register.vue";
import ResetPassword from "@/components/auth/ResetPassword.vue";

import CoinPage from "@/components/BuyCoin.vue";
import Test from "@/components/test.vue"
import LuckySpin from "@/components/person/LuckySpin.vue"
import CreateProduct from "@/components/person/CreateProduct.vue"
import ProfileInfo from "@/components/person/ProfileInfo.vue"
import SettingAccount from "@/components/person/Setting.vue"

import ListBlog from "@/components/blog/listBlog.vue"
import BlogDetails from "@/components/blog/blogDetails.vue"
import IndexFaq from "@/components/faq/index.vue"
import Contact from "@/components/contact/homeContact.vue"
import MyItem from "@/components/person/MyItem.vue"
import ProductDetail from "@/components/product/productDetail.vue"
import Skill from "@/components/product/skill.vue"
import Feedback from "@/components/feedback/feedback.vue"



const routes = [
  { path: "/", component: HomePage },
  { path: "/test", component: Test },
  { path: "/about", component: AboutPage },
  { path: "/become", component: BecomeIdol },
  { path: "/game", component: GameIndex },
  { path: "/coin", component: CoinPage },
  { path: "/person/create", component: CreateProduct },
  { path: "/person/lucky", component: LuckySpin },
  { path: "/person/profile", component: ProfileInfo },
  { path: "/person/setting", component: SettingAccount },
  { path: "/person/item", component: MyItem },
  { path: "/product/productDetails/:id", component: ProductDetail , props: true, },
  { path: "/product/skill/:id", component: Skill , props: true, },

  { path: "/login", component: LoginPage },
  { path: "/register", component: RegisterPage },

  { path: "/blog", component: ListBlog },
  { path: "/blog/:id",name: 'blogDetails', component: BlogDetails },
  { path: "/faq", component: IndexFaq },
  { path: "/contact", component: Contact },
  { path: "/reset-password", component: ResetPassword },
  { path: "/feedback", component: Feedback },


];


const router = createRouter({
  history: createWebHistory(),
  routes: routes,
});

export default router;
