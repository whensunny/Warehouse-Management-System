<template>
  <el-container class="home-container">
    <!-- 头部区域 -->
    <el-header>
      <div>
        <span>仓储管理平台</span>
      </div>
      <el-button @click="logout">退出</el-button>
    </el-header>
    <!-- 页面主体区域 -->
    <el-container>
      <!-- 侧边栏 -->
      <el-aside :width="isCollapse ? '64px' : '200px'">
        <div class="toggle-button" @click="toggleCollapse">《《     》》</div>

        <!-- 侧边栏菜单区域 -->
        <!-- <el-menu background-color="#0099ff" text-color="#fff" active-text-color="#409EFF" unique-opened :collapse="isCollapse" :collapse-transition="false" router :default-active="activePath"> -->
        <el-menu  unique-opened :collapse="isCollapse" :collapse-transition="false" router :default-active="activePath">
          <!-- 一级菜单 -->
          <div v-for="item in menulist" :key="item.ps_id">
            <el-submenu :index="item.ps_id + ''" v-if="item.ps_level===0+''">
              <!-- 一级菜单的模板区域 -->
              <template slot="title">
                <!-- 图标 -->
                <i :class="iconsObj[item.ps_id]"></i>
                <!-- 文本 -->
                <span v-if="!isCollapse">{{item.ps_name}}</span>
              </template>
              <!-- 二级菜单 -->
              <div v-for="subItem in menulist" :key="subItem.ps_id">
                <el-menu-item :index="'/' + subItem.ps_a" v-if="subItem.ps_pid===item.ps_id" @click="saveNavState('/' + subItem.ps_a)">
                  <template slot="title">
                    <!-- 图标 -->
                    <i class="el-icon-menu"></i>
                    <!-- 文本 -->
                    <span>{{subItem.ps_name}}</span>
                  </template>
                </el-menu-item>
              </div>
            </el-submenu>
          </div>
        </el-menu>
      </el-aside>
      <!-- 右侧内容主体 -->
      <el-main>
        <!-- 路由占位符 -->
        <router-view></router-view>
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
export default {
  data() {
    return {
      // 左侧菜单数据
      menulist: [],
      iconsObj: {
        '103': 'el-icon-setting',
        '101': 'el-icon-goods',
        '102': 'el-icon-tickets',
        // '145': 'el-icon-folder'
      },
      // 是否折叠
      isCollapse: false,
      // 被激活的链接地址
      activePath: ''
    }
  },
  created() {
    this.getMenuList()
    this.activePath = window.sessionStorage.getItem('activePath')
  },
  methods: {
    logout() {
      window.sessionStorage.clear()
      this.$router.push('/login')
    },
    // 获取所有的菜单
    getMenuList(){
      var that=this
      this.$axios({
        method:'get',
        url:'http://127.0.0.1:3007/menus'
      }).then(res=>{
        res=res.data
        if(res.status!==200) return this.$message.error(res.message)
        this.menulist = res.data
      })
    },
    // 点击按钮，切换菜单的折叠与展开
    toggleCollapse() {
      this.isCollapse = !this.isCollapse
    },
    // 保存链接的激活状态
    saveNavState(activePath) {
      // console.log(subItem.ps_pid)
      // console.log(item.ps_id)
      window.sessionStorage.setItem('activePath', activePath)
      this.activePath = activePath
    }
  }
}
</script>

<style lang="less" scoped>
.home-container {
  height: 100%;
}
.el-header {
  background-color: #02d58b;
  display: flex;
  justify-content: space-between;
  padding-left: 0;
  align-items: center;
  color: #fff;
  font-size: 20px;
  > div {
    display: flex;
    align-items: center;
    span {
      margin-left: 30px;
    }
  }
}


.el-aside {
  .el-menu {
    border-right: none;
  }
}

.el-main {
  background-color: #ffffff;
}

.iconfont {
  margin-right: 10px;
}

.toggle-button {
  background-color: #02d58b;
  font-size: 10px;
  line-height: 24px;
  color: #fff;
  text-align: center;
  letter-spacing: 0.2em;
  cursor: pointer;
}
</style>
