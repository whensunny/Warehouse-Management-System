// user.js
const state = {
    role: 'null', // 用户的角色
    // 其他的状态...
  }
  
  const mutations = {
    setRole(state, role) {
      state.role = role
      // 在设置角色的同时，将其存储到 localStorage 中，防止刷新页面后丢失
      localStorage.setItem('userRole', role);
    },
    // 定义其他的 mutations...
  }
  
  const actions = {
    login({ commit }, credentials) {
      // 使用你的登录 API
      return axios.post('/login', credentials)
        .then(response => {
        console.log(response.data);
          // 在这里，我们假设服务器返回的响应体包含一个 role 属性
          const role = response.data.role;
          commit('setRole', role);
        })
    },
    // 定义其他的 actions...
  }
  
  export default {
    namespaced: true,
    state,
    mutations,
    actions
  }