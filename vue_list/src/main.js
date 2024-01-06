import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import axios from 'axios'
import qs from 'qs'
import './plugins/element.js'


Vue.config.productionTip = false

axios.interceptors.request.use(config=>{
  config.headers.Authorization=window.sessionStorage.getItem('token')
  return config
})
Vue.prototype.$axios=axios
Vue.prototype.$qs=qs

const storedRole = localStorage.getItem('userRole');
if (storedRole) {
  // 如果存在用户角色，则将其设置到 Vuex 中或当前页面所需的状态中
  store.commit('user/setRole', storedRole);
}

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
