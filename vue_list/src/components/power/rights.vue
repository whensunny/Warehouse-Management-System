<template>
  <div>
    <el-breadcrumb separator="/">
    <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
    <el-breadcrumb-item>权限管理</el-breadcrumb-item>
    <el-breadcrumb-item>权限列表</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card class="box-card">
            <el-table :data="rightsList"
            height="800"
            border
            style="width: 100%">
                <el-table-column
                prop="ps_id"
                label="编号"
                width="80">
                </el-table-column>
                <el-table-column
                prop="ps_name"
                label="名称">
                </el-table-column>
                <el-table-column
                prop="ps_a"
                label="路径">
                </el-table-column>
                <el-table-column
                label="权限等级">
                <template slot-scope="scope">
                    <el-tag v-if="scope.row.ps_level==='2'">一级权限</el-tag>
                    <el-tag type="warning" v-else-if="scope.row.ps_level==='1'">二级权限</el-tag>
                    <el-tag type="danger" v-else>三级权限</el-tag>
                </template>
                </el-table-column>
            </el-table>
       </el-card>
  </div>
</template>

<script>
export default {
    data(){
        return{
            rightsList:[],
        }
    },
    methods:{
        getRightsList(){
            this.$axios({
                method:'get',
                url:'http://127.0.0.1:3007/rights',
            }).then(res=>{
                res=res.data;
                this.rightsList=res.data;
            })
        }
    },
    created(){
        this.getRightsList()
    }
}
</script>

<style>
.text {
    font-size: 14px;
  }

  .item {
    margin-bottom: 18px;
  }

  .clearfix:before,
  .clearfix:after {
    display: table;
    content: "";
  }
  .clearfix:after {
    clear: both
  }

  .box-card {
    width: 80%;
    margin: 20px;
  }
  .grid-content {
    border-radius: 4px;
    min-height: 36px;
    margin: 0 20px;
  }
</style>