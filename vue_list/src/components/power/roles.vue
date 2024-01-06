<template>
<div>
    <el-breadcrumb separator="/">
    <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
    <el-breadcrumb-item>权限管理</el-breadcrumb-item>
    <el-breadcrumb-item>角色列表</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card class="box-card">
            <div slot="header"><el-row>
                <el-col><el-button icon="el-icon-circle-plus"  @click="toAddRole">添加角色</el-button></el-col>
            </el-row></div>
            <el-table :data="rolesList"
            height="800"
                border
                style="width: 100%">
                <el-table-column type="expand">
                    <template slot-scope="scope">{{scope.row.ps_ids}}</template>
                </el-table-column>
                <el-table-column
                prop="role_id"
                label="编号"
                width="80">
                </el-table-column>
                <el-table-column
                prop="role_name"
                label="姓名">
                </el-table-column>
                <el-table-column
                prop="role_desc"
                label="职位">
                </el-table-column>
                <el-table-column
                label="操作">
                    <template slot-scope="scope">
                        <el-button type="warning" icon="el-icon-setting" circle @click="toEdit()"></el-button>
                        <el-button type="danger" icon="el-icon-delete" circle @click="toDelete(scope.row.role_id)"></el-button>
                    </template>
                </el-table-column>
            </el-table>
            <!-- 添加角色对话框 -->
            <el-dialog
            title="添加角色"
            :visible.sync="addDialogVisible"
            width="30%">
                <el-form label-width="60px" :model="addRoleFrom" ref="addRoleFromRef">
                    <el-form-item label="姓名">
                        <el-input placeholder="请输入姓名"
                        prefix-icon='el-icon-user' v-model="addRoleFrom.name"></el-input>
                    </el-form-item>
                    <el-form-item label="职位">
                        <el-input placeholder="请输入职位"
                        prefix-icon='el-icon-news' v-model="addRoleFrom.role"></el-input>
                    </el-form-item>
                </el-form>
                <span slot="footer" class="dialog-footer">
                    <el-button @click="addDialogVisible = false">取 消</el-button>
                    <el-button type="primary" @click="submitAddRole">确 定</el-button>
                </span>
            </el-dialog>
            <!-- 编辑对话框 -->
            <el-dialog
            title="编辑角色"
            :visible.sync="editDialogVisible"
            width="30%">
                <el-form label-width="60px" :model="editRoleFrom" ref="editRoleFromRef">
                    <el-form-item label="姓名">
                        <el-input placeholder="请输入姓名"
                        prefix-icon='el-icon-user' v-model="editRoleFrom.name"></el-input>
                    </el-form-item>
                    <el-form-item label="职位">
                        <el-input placeholder="请输入职位"
                        prefix-icon='el-icon-news' v-model="editRoleFrom.role"></el-input>
                    </el-form-item>
                </el-form>
                <span slot="footer" class="dialog-footer">
                    <el-button @click="editDialogVisible = false">取 消</el-button>
                    <el-button type="primary" @click="submitEditRole">确 定</el-button>
                </span>
            </el-dialog>
            <!-- 删除对话框 -->
            <el-dialog
            title="删除角色"
            :visible.sync="deleteDialogVisible"
            width="30%">
                <span>确认删除{{deleteID}}号角色？（该操作不可重置）</span>
                <span slot="footer" class="dialog-footer">
                    <el-button @click="deleteDialogVisible = false">取 消</el-button>
                    <el-button type="primary" @click="deleRole">确 定</el-button>
                </span>
            </el-dialog>
        </el-card>
</div>
</template>

<script>
export default {
    data(){
        return{
            editDialogVisible:false,
            deleteDialogVisible:false,
            addDialogVisible:false,
            deleteID:'',
            rolesList:[],
            addRoleFrom:{
                name:'',
                role:''
            },
             editRoleFrom:{
                name:'',
                role:''
            }
        }
    },
    methods:{
        toDelete(ID){
            this.deleteDialogVisible=true;
            this.deleteID=ID
        },
        deleRole(){
            this.deleteDialogVisible=true;
            var that=this;
            this.$axios({
                method:'post',
                url:'http://127.0.0.1:3007/deleRole',
                data:that.deleteID
            }).then(res=>{
                res=res.data;
                if(res.status!==200)return this.$message.error("删除失败")
                this.$message.success("删除成功")
            })
        },
        toEdit(){
            this.editDialogVisible=true;
        },
        submitEditRole(){
            this.editDialogVisible=false;
            var that=this;
            this.$axios({
                method:'post',
                url:'http://127.0.0.1:3007/editRole',
                data:(()=>{
                    return that.$qs.stringify(this.editRoleFrom)
                })()
            }).then(res=>{
                res=res.data;
                if(res.status!==200)return this.$message.error("编辑失败")
                this.$message.success("编辑成功")
            })
        },
        toAddRole(){
            this.addDialogVisible=true;
        },
        submitAddRole(){
            this.addDialogVisible=false;
            var that=this;
            this.$axios({
                method:'post',
                url:'http://127.0.0.1:3007/addRole',
                data:(()=>{
                    return that.$qs.stringify(this.addRoleFrom)
                })()
            }).then(res=>{
                res=res.data;
                if(res.status!==200)return this.$message.error("添加失败")
                this.$message.success("添加成功")
            })
        },
        getRolesList(){
            var that=this;
            this.$axios({
                method:'get',
                url:'http://127.0.0.1:3007/roles',
            }).then(res=>{
                res=res.data;
                this.rolesList=res.data;
            })
        }
    },
    created(){
        this.getRolesList()
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