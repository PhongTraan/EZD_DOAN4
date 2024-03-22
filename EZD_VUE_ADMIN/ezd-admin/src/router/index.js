
import { createRouter, createWebHistory } from "vue-router";

import HomePage from '@/components/Home.vue';
import listGame from '@/components/Games/listGame.vue';
import CreateGame from '@/components/Games/createNew.vue';
import GameDetails from '@/components/Games/gameDetails.vue';
import LoginAdmin from '@/components/Authen/Login.vue';
import ForgotPassword from '@/components/Authen/ForgotPassword.vue';
import ListBanner from '@/components/Banner/Index.vue';
import CreateBanner from '@/components/Banner/Create.vue';
import ListBlog from '@/components/Blog/listBlog.vue';
import CreateBlog from '@/components/Blog/createBlog.vue';
import testAdmin from '@/components/test.vue';
import PendingList from "@/components/Transaction/pendingList.vue";
import SuccessList from "@/components/Transaction/successList.vue";
import FailedList from "@/components/Transaction/failedList.vue";
import ListUser from "@/components/User/listUser.vue";
import ListStaf from "@/components/User/listStaf.vue";
import ListLucky from "@/components/LuckySpin/listLucky.vue"
import ListQuiz from '@/components/Quiz/listquiz.vue';
import CreateQuiz from '@/components/Quiz/createquiz.vue';
import PendingBecomeList from "@/components/BecomeForm/pendingList.vue"
import SuccessBecomeList from "@/components/BecomeForm/successList.vue"
import FailedBecomeList from "@/components/BecomeForm/failedList.vue"

import listItem from "@/components/Item/listItem.vue"
import createItem from "@/components/Item/createItem.vue"
import listRank from "@/components/Rank/listRank.vue"
import createRank from "@/components/Rank/rankCreate.vue"


const routes = [
  { path: '/', component: HomePage, meta: { requiresAuth: true } },
  { path: '/test', component: testAdmin },
  { path: '/login', component: LoginAdmin },
  { path: '/reset-pass', component: ForgotPassword},
  { path: '/admin/game', component: listGame, meta: { requiresAuth: true } },
  { path: '/admin/game/create', component: CreateGame, meta: { requiresAuth: true } },
  {path: '/admin/game/gameDetails/:id',component: GameDetails, name: "gameDetails",  meta: { requiresAuth: true },  props: true,  },
  { path: '/admin/banner', name: "listbanner", component: ListBanner, meta: { requiresAuth: true } },
  { path: '/admin/banner/create', component: CreateBanner, name: "createbanner", meta: { requiresAuth: true } },
  { path: '/admin/blog', name: "listblog", component: ListBlog, meta: { requiresAuth: true } },
  { path: '/admin/blog/create', name: "createblog", component: CreateBlog, meta: { requiresAuth: true } },
  { path: '/admin/transaction', component: PendingList, meta: { requiresAuth: true } },
  { path: '/admin/transaction/success', component: SuccessList, meta: { requiresAuth: true } },
  { path: '/admin/transaction/failed', component: FailedList, meta: { requiresAuth: true } },
  { path: '/admin/user/listUser', component: ListUser, meta: { requiresAuth: true } },
  { path: '/admin/user/listStaf', component: ListStaf, meta: { requiresAuth: true } },
  { path: '/admin/user/listLucky', component: ListLucky, meta: { requiresAuth: true } },
  { path: '/admin/become', component: PendingBecomeList, meta: { requiresAuth: true } },
  { path: '/admin/become/success', component: SuccessBecomeList, meta: { requiresAuth: true } },
  

  { path: '/admin/become/failed', component: FailedBecomeList, meta: { requiresAuth: true } },
  { path: '/admin/quiz', name: "listquiz", component: ListQuiz, meta: { requiresAuth: true } },
  { path: '/admin/quiz/create', name: "createquiz", component: CreateQuiz, meta: { requiresAuth: true } },

  {
    path: '/admin/item',
    component:listItem,
    meta:{requiresAuth:true}
  },
  {
    path: '/admin/item/create',
    component:createItem,
    meta:{requiresAuth:true}
  },
  {
    path: '/admin/rank',
    component:listRank,
    meta:{requiresAuth:true}
  },
  {
    path: '/admin/rank/create',
    component:createRank,
    meta:{requiresAuth:true}
  },

];

const router = createRouter({
  history: createWebHistory(),
  routes: routes,
});

router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
    const token = localStorage.getItem('token');
    if (!token) {
      if (to.path !== '/login') {
        // Use next(false) to prevent immediate redirection
        next(false);
        // Manually navigate to the login page after route change is confirmed
        router.push('/login');
      } else {
        // If already on the login page, allow the navigation
        next();
      }
    } else {
      next();
    }
  } else {
    next();
  }
});


export default router;
