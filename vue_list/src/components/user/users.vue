<template>
    <div>
        <!--面包屑导航区域-->
        <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item :to="{ path: '/user' }">用户管理</el-breadcrumb-item>
        <el-breadcrumb-item>用户列表</el-breadcrumb-item>
        </el-breadcrumb>
        <el-card class="box-card">
        <div slot="header">
            <el-row>
            <el-col :span="12"><div class="grid-content">
                <el-input
                placeholder="请输入所需查找的用户信息"
                prefix-icon="el-icon-search"
                v-model="searchUserFrom.searchUser">
                </el-input>
                </div>
            </el-col>
            <el-col :span="6"><div class="grid-content">
                    <el-button icon="el-icon-search" @click="toSearchUser">搜索用户</el-button>
                    </div>
            </el-col>
            <!-- <el-col :span="6"><div class="grid-content">
                    <el-button icon="el-icon-circle-plus"  @click="toAddUser">添加用户</el-button>
                    </div>
            </el-col> -->
            </el-row>
        </div>
            <el-table :data="usersList"
            height="800"
                border
                style="width: 100%">
                <el-table-column
                prop="uid"
                label="用户ID"
                width="80">
                </el-table-column>
                <el-table-column
                prop="username"
                label="账号">
                </el-table-column>
                <el-table-column
                prop="phonenum"
                label="电话">
                </el-table-column>
                <!-- <el-table-column
                label="在线状态">
                <template slot-scope="scope">
                    <el-tag type="succes" v-if="scope.row.is_active==='是'">是</el-tag>
                        <el-tag type="danger" v-else>否</el-tag>
                </template>
                </el-table-column> -->
                <el-table-column
                prop="role"
                label="身份">
                </el-table-column>
                <el-table-column
                label="操作">
                    <template slot-scope="scope">
                        <el-button type="warning" icon="el-icon-setting" v-if="isAdmin" circle @click="toEdit(scope.row.uid)"></el-button>
                        <el-button type="danger" icon="el-icon-delete" v-if="isAdmin" circle @click="toDelete(scope.row.uid)"></el-button>
                    </template>
                </el-table-column>
            </el-table>
            <!-- <el-dialog
            title="添加用户"
            :visible.sync="addDialogVisible"
            width="30%">
            <el-form label-width="60px" :model="addUserFrom" ref="addUserFromRef" class="add_from">
                <el-form-item label="账户">
                    <el-input placeholder="请输入账号"
                    prefix-icon='el-icon-user' v-model="addUserFrom.account"></el-input>
                </el-form-item>
                <el-form-item label="密码">
                    <el-input placeholder="请输入密码"
                    prefix-icon='el-icon-user' v-model="addUserFrom.password"></el-input>
                </el-form-item>
                <el-form-item label="性别">
                    <el-input placeholder="请输入性别"
                    prefix-icon='el-icon-news' v-model="addUserFrom.sex"></el-input>
                </el-form-item>
                <el-form-item label="电话">
                    <el-input placeholder="请输入电话"
                    prefix-icon='el-icon-news' v-model="addUserFrom.tel"></el-input>
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button @click="addDialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="submitAddUser">确 定</el-button>
            </span>
            </el-dialog> -->
            <!-- 编辑对话框 -->
            <el-dialog
            title="编辑用户"
            :visible.sync="editDialogVisible"
            width="30%">
                <el-form label-width="60px" :model="editUserFrom" ref="editUserFromRef">
                    <el-form-item label="姓名">
                        <el-input placeholder="请输入姓名"
                        prefix-icon='el-icon-user' v-model="editUserFrom.name"></el-input>
                    </el-form-item>
                    <el-form-item label="电话">
                        <el-input placeholder="请输入电话"
                        prefix-icon='el-icon-news' v-model="editUserFrom.phonenum"></el-input>
                    </el-form-item>
                    <el-form-item label="身份">
                    <el-select v-model="editUserFrom.role" placeholder="请选择">
                        <el-option
                            v-for="item in roles"
                            :key="item"
                            :label="item"
                            :value="item">
                        </el-option>
                    </el-select>
                </el-form-item>
                </el-form>
                <span slot="footer" class="dialog-footer">
                    <el-button @click="editDialogVisible = false">取 消</el-button>
                    <el-button type="primary" @click="submitEditUser">确 定</el-button>
                </span>
            </el-dialog>
            <!-- 删除对话框 -->
            <el-dialog
            title="删除角色"
            :visible.sync="deleteDialogVisible"
            width="30%">
                <span>确认删除{{deleteIDFrom.deleteID}}号用户？<br>（该操作不可重置）</span>
                <span slot="footer" class="dialog-footer">
                    <el-button @click="deleteDialogVisible = false">取 消</el-button>
                    <el-button type="primary" @click="deleteUser">确 定</el-button>
                </span>
            </el-dialog>
        </el-card>
    </div>
    
</template>

<script>
export default {
    data(){
        return{
            deleteDialogVisible:false,
            editDialogVisible:false,
            // addDialogVisible:false,
            searchUserFrom:{
                searchUser:''
            },
            deleteIDFrom:{
                deleteID:''
            },
            usersList:[],
            // addUserFrom:{
            //     account:'',
            //     password:'',
            //     sex:'',
            //     tel:'',
            //     role:''
            // },
            editUserFrom:{
                userID:'',
                name:'',
                phonenum:'',
                role:''
            },
            roles: ['guest', 'admin'],
            // sexs:['男','女']
        }
    },
    computed: {
        isAdmin() {
            // 使用可选链语法
            return this.$store.state.user?.role === 'admin'
            }
        },
        
    created() {
    this.roles = ['guest', 'admin'];
    this.getUsersList();
    },
    methods:{
        //删除用户
        toDelete(ID){
            this.deleteDialogVisible=true;
            this.deleteIDFrom.deleteID=ID
        },
        deleteUser(){
            this.deleteDialogVisible=false;
            //var that=this;
            this.$axios({
                method:'post',
                url:'http://127.0.0.1:3007/deleteUser',
                data:(()=>{
                    return this.$qs.stringify(this.deleteIDFrom)
                })()
            }).then(res=>{
                res=res.data;
                if(res.status!==200)return this.$message.error("删除失败")
                this.$message.success("删除成功")
                this.getUsersList()
            })
        },
        //编辑用户信息
        toEdit(ID){
            this.editDialogVisible=true;
            this.editUserFrom.userID=ID;

            const user = this.usersList.find(user => user.uid === ID);
            console.log('user',user)
            console.log('roles',this.roles)
            if (user) {
                console.log('user',user)
        // 将用户的信息设置到 editUserFrom 中
                this.editUserFrom.name = user.username;
                this.editUserFrom.phonenum = user.phonenum;
                this.editUserFrom.role = user.role;
    }
        },
        submitEditUser(){
            this.editDialogVisible=false;
            //var that=this;
            this.$axios({
                method:'post',
                url:'http://127.0.0.1:3007/editUser',
                data:(()=>{
                    return this.$qs.stringify(this.editUserFrom)
                })()
            }).then(res=>{
                res=res.data;
                if(res.status!==200)return this.$message.error("编辑失败")
                this.$message.success("编辑成功")
                this.getUsersList()
            })
        },
        //搜索用户
        toSearchUser(){
            var that=this
            this.$axios({
                method:'post',
                url:'http://127.0.0.1:3007/searchUser',
                data:(()=>{
                    return that.$qs.stringify(this.searchUserFrom)
                })()
            }).then(res=>{
                res=res.data
                if(res.status!==200)return this.$message.error("查询失败")
                this.$message.success("查询成功")
                this.usersList=res.data
            })
        },
        //添加用户
            //打开添加用户对话框
        // toAddUser(){
        //     this.addDialogVisible=true
        // },
        //     //呈交添加用户表单
        // submitAddUser(){
        //     this.addDialogVisible=false
        //     console.log(this.addUserFrom)
        //     //var that=this;
        //     this.$axios({
        //         method:'post',
        //         url:'http://127.0.0.1:3007/addUser',
        //         data:(()=>{
        //             return this.$qs.stringify(this.addUserFrom)
        //         })()
        //     }).then(res=>{
        //         res=res.data;
        //         console.log(this.addUserFrom); // 打印输入信息
        //         console.log(res)
        //         if(res.status!==200)return this.$message.error("添加失败")
        //         this.$message.success("添加成功")
        //         location.reload()
        //     })
        // },
        getUsersList(){
            //var that=this;
            this.$axios({
                method:'get',
                url:'http://127.0.0.1:3007/users',
            }).then(res=>{
                res=res.data;
                this.usersList=res.data;
                console.log(this.usersList)
            })
        }
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