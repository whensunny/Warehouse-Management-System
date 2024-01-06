import Vue from 'vue';
import Vuex from 'vuex';
import user from './modules/user';

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    // ...其他状态
  },
  getters: {
    // ...其他 getters
  },
  mutations: {
    // ...其他 mutations
  },
  actions: {
    // ...其他 actions
  },
  modules: {
    user
  }
});

// 应用初始化时，检查 localStorage 中是否有用户角色
const storedRole = localStorage.getItem('userRole');
if (storedRole) {
  // 如果存在用户角色，则将其设置到 Vuex 中或当前页面所需的状态中
  //store.commit('user/setRole', storedRole);
}
