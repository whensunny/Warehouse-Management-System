import Vue from 'vue'
import VueRouter from 'vue-router'
import login from '../components/login'
import home from '../components/home'
import users from '../components/user/users'
import orders from '../components/order/orders'
import goods from '../components/good/goods'
import goodItem from '../components/good/goodItem'
import rights from '../components/power/rights'
import roles from '../components/power/roles'
import register from '../components/register'


Vue.use(VueRouter)

const routes = [
  {
    path: '/login',
    name: 'login',
    component: login
  },
  {
    path: '/register',
    name: 'register',
    component: register
  },
  {
    path: '/home',
    name: 'home',
    component: home,
    children:[{path:'/users',component:users},
              {path:'/orders',component:orders},
              {path:'/goods',component:goods},
              {path:'/roles',component:roles},
  ]
  },
  {path:'/goodItem',name:goodItem,component:goodItem},
]

const router = new VueRouter({
  routes
})

router.beforeEach((to,from,next)=>{
  if(to.path === '/login' || to.path === '/register') return next();
  const tokenStr=window.sessionStorage.getItem('token')
  if(!tokenStr) return next('/login')
  next();
})

export default router