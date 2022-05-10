import Vue from 'vue'
import Router from 'vue-router'
import Home from '../views/Home.vue'
import Login from '../views/Login.vue'
import Logout from '../views/Logout.vue'
import Register from '../views/Register.vue'
import store from '../store/index'
import FoodIntakeView from '../views/FoodIntakeView.vue'
import Profile from '../views/Profile.vue'
import CreateProfile from "@/views/CreateProfile.vue"
import Nutrition from "@/views/Nutrition.vue"
import WeightTableView from '@/views/WeightTableView.vue'
import HydrationView from '@/views/HydrationView.vue'
import WeightInputView from '@/views/WeightInputView.vue'
import HydrationTableView from '@/views/HydrationTableView.vue'


Vue.use(Router)

/**
 * The Vue Router is used to "direct" the browser to render a specific view component
 * inside of App.vue depending on the URL.
 *
 * It also is used to detect whether or not a route requires the user to have first authenticated.
 * If the user has not yet authenticated (and needs to) they are redirected to /login
 * If they have (or don't need to) they're allowed to go about their way.
 */

const router = new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: "/login",
      name: "login",
      component: Login,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/logout",
      name: "logout",
      component: Logout,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/register",
      name: "register",
      component: Register,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/food-intake/:foodIntakeID",
      name: "food-intake",
      component: FoodIntakeView,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/create-profile', //Probably need to add :userid (or whatever) to this to get to a unique profile page.
      name: 'create-profile',
      component: CreateProfile,
      meta: {
        requiresAuth: true //Change this to true so only signed in users can access.
      }
    },
    {
      path: "/profile",
      name: "profile",
      component: Profile
    },
    {
      path: "/nutrition",
      name: "nutrition",
      component: Nutrition
    },
    {
      path: "/weight",
      name: "weight",
      component: WeightTableView
    },
    {
      path: "/weight/:weightInputID",
      name: "weightInputID",
      component: WeightInputView
    },
   
    {
      path: "/water",
      name: "water",
      component: HydrationTableView
    },

    {
      path: "/water/:hydrationID",
      name: "hydrationID",
      component: HydrationView
    }
  ]
})

router.beforeEach((to, from, next) => {
  // Determine if the route requires Authentication
  const requiresAuth = to.matched.some(x => x.meta.requiresAuth);

  // If it does and they are not logged in, send the user to "/login"
  if (requiresAuth && store.state.token === '') {
    next("/login");
  } else {
    // Else let them go to their next destination
    next();
  }
});

export default router;
