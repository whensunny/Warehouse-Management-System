<template>
    <div>
      <!-- 面包屑导航 -->
      <el-breadcrumb separator="/">
        <!-- 面包屑项 -->
        <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>订单管理</el-breadcrumb-item>
        <el-breadcrumb-item>订单列表</el-breadcrumb-item>
      </el-breadcrumb>
  
      <!-- 卡片容器 -->
      <el-card class="box-card">
        <!-- 头部搜索栏 -->
        <div slot="header" class="clearfix">
          <el-row>
            <!-- 搜索框 -->
            <el-col :span="12">
              <div class="grid-content">
                <el-input
                  placeholder="请输入订单信息"
                  prefix-icon="el-icon-search"
                  v-model="searchOrderFrom.searchOrder">
                </el-input>
              </div>
            </el-col>
            <!-- 搜索按钮 -->
            <el-col :span="6">
              <div class="grid-content">
                <el-button icon="el-icon-search" @click="toSearchOrder">搜索订单</el-button>
              </div>
            </el-col>
            <!-- 添加按钮 -->
            <el-col :span="6">
              <div class="grid-content">
                <el-button icon="el-icon-circle-plus" v-if="isAdmin" @click="toAddOrder">添加订单</el-button>
              </div>
            </el-col>
          </el-row>
        </div>
  
        <!-- 订单列表 -->
        <el-table :data="ordersList" height="800" border style="width: 100%">
          <!-- 订单ID列 -->
          <el-table-column prop="order_id" label="订单ID" width="80"></el-table-column>
          <!-- 订单产品名称列 -->
          <el-table-column prop="gname" label="订单产品名称"></el-table-column>
          <!-- 订单产品类型列 -->
          <el-table-column prop="gtype" label="订单产品类型"></el-table-column>
          <!-- 供应商ID列 -->
          <el-table-column prop="spid" label="供应商ID" width="80"></el-table-column>
          <!-- 订单产品单价列 -->
          <el-table-column prop="order_price" label="订单产品单价"></el-table-column>
          <!-- 订单产品数量列 -->
          <el-table-column prop="order_number" label="订单产品数量"></el-table-column>
          <!-- 是否已送达列 -->
          <el-table-column prop="is_instock" label="是否已送达" width="100"></el-table-column>
          <!-- 是否已送达列 -->
          <el-table-column prop="local_time" label="订单时间" width="200"></el-table-column>
          <!-- 操作列 -->
          <el-table-column label="操作" width="150">
            <template slot-scope="scope">
              <el-button type="warning" icon="el-icon-setting" circle v-if="isAdmin" @click="toEdit(scope.row.order_id)"></el-button>
              <el-button type="danger" icon="el-icon-delete" circle v-if="isAdmin" @click="toDelete(scope.row.order_id)"></el-button>
              <el-button @click="openNoteDialog(scope.$index, scope.row)">备注</el-button>
            </template>
          </el-table-column>
        </el-table>
          <!-- 备注对话框 -->
          <el-dialog title="添加备注" :visible.sync="noteDialogVisible">
            <el-input v-model="noteText" placeholder="请输入备注"></el-input>
            <span slot="footer" class="dialog-footer">
              <el-button @click="noteDialogVisible = false">取消</el-button>
              <el-button type="primary" @click="addNote">确定</el-button>
            </span>
          </el-dialog>
        <!-- 添加订单对话框 -->
        <el-dialog title="添加订单" :visible.sync="addDialogVisible" width="30%">
          <!-- 表单 -->
          <el-form label-width="60px" :model="addOrderFrom" ref="addOrderFromRef" class="add_from">
            <!-- 订单号输入框 -->
            <el-form-item label="订单产品名称">
              <el-input placeholder="请输入订单产品名称" prefix-icon="el-icon-user" v-model="addOrderFrom.gname"></el-input>
            </el-form-item>
            <el-form-item label="订单产品类型">
              <el-input placeholder="请输入订单产品类型" prefix-icon="el-icon-user" v-model="addOrderFrom.gtype"></el-input>
            </el-form-item>
            <!-- 供应商输入框 -->
            <el-form-item label="供应商id">
              <el-input placeholder="请输入供应商id" prefix-icon="el-icon-news" v-model="addOrderFrom.spid"></el-input>
            </el-form-item>
            <!-- 数目输入框 -->
            <el-form-item label="数目">
              <el-input placeholder="请输入数目" prefix-icon="el-icon-news" v-model="addOrderFrom.order_number"></el-input>
            </el-form-item>
            <el-form-item label="订单产品单价">
              <el-input placeholder="请输入单价" prefix-icon="el-icon-news" v-model="addOrderFrom.order_price"></el-input>
            </el-form-item>
            <el-form-item label="是否入库">
                <el-select v-model="addOrderFrom.is_instock" placeholder="请选择" @change="updateTableData">
                  <el-option
                            v-for="item in is_instocks"
                            :key="item"
                            :label="item"
                            :value="item">
                  </el-option>
                </el-select>
              </el-form-item>
            </el-form>
          <!-- 对话框底部按钮 -->
          <span slot="footer" class="dialog-footer">
            <el-button @click="addDialogVisible = false">取消</el-button>
            <el-button type="primary" @click="submitAddOrder">确定</el-button>
          </span>
        </el-dialog>
  
        <!-- 编辑订单对话框 -->
        <el-dialog
        title="编辑订单"
        :visible.sync="editDialogVisible"
        width="30%"
        >
        <el-form
            label-width="60px"
            :model="editOrderFrom"
            ref="editOrderFromRef"
        >
            <!-- 订单名输入框 -->
            <el-form-item label="订单产品名称">
            <el-input
                placeholder="请输入订单产品名称"
                prefix-icon="el-icon-user"
                v-model="editOrderFrom.gname"
            ></el-input>
            </el-form-item>
            <!-- 订单类型输入框 -->
            <el-form-item label="订单产品类型">
            <el-input
                placeholder="请输入订单产品类型"
                prefix-icon="el-icon-user"
                v-model="editOrderFrom.gtype"
            ></el-input>
            </el-form-item>
            <!-- 供应商输入框 -->
            <el-form-item label="供应商">
            <el-input
                placeholder="请输入供应商id"
                prefix-icon="el-icon-news"
                v-model="editOrderFrom.spid"
            ></el-input>
            </el-form-item>
            <!-- 数目输入框 -->
            <el-form-item label="数目">
            <el-input
                placeholder="请输入数目"
                prefix-icon="el-icon-news"
                v-model="editOrderFrom.order_number"
            ></el-input>
            </el-form-item>
            <!-- 数目输入框 -->
            <el-form-item label="订单产品单价">
            <el-input
                placeholder="请输入订单产品单价"
                prefix-icon="el-icon-news"
                v-model="editOrderFrom.order_price"
            ></el-input>
            </el-form-item>
            <!-- 地址输入框 -->
            <el-form-item label="是否入库">
              <el-select v-model="editOrderFrom.is_instock" placeholder="请选择">
                <el-option
                  v-for="item in is_instocks"
                  :key="item"
                  :label="item"
                  :value="item">
                </el-option>
              </el-select>
            </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
            <el-button @click="editDialogVisible = false">取消</el-button>
            <el-button type="primary" @click="submitEditOrder">确定</el-button>
        </span>
        </el-dialog>

        <!-- 删除订单对话框 -->
        <el-dialog
        title="删除订单"
        :visible.sync="deleteDialogVisible"
        width="30%"
        >
        <span>确认删除{{ deleteIDFrom.deleteID }}号订单？<br>（该操作不可重置）</span>
        <span slot="footer" class="dialog-footer">
            <el-button @click="deleteDialogVisible = false">取消</el-button>
            <el-button type="primary" @click="deleteOrder">确定</el-button>
        </span>
        </el-dialog>
        
            </el-card>
            </div>
        </template>

<script>
import Vue from 'vue';
export default {
    data(){
        return{

            deleteDialogVisible:false,
            editDialogVisible:false,
            addDialogVisible:false,
            noteDialogVisible: false,
            deleteIDFrom:{
                deleteID:'',
            },
            searchOrderFrom:{
                searchOrder:''
            },
            ordersList:[],

            addOrderFrom:{
                spid:'',
                gtype:'',
                gname:'',
                order_number:'',
                order_price:'',
                is_instock:'',
                note: '',
            },

            editOrderFrom:{
                spid:'',
                gtype:'',
                gname:'',
                order_number:'',
                order_price:'',
                is_instock:'',
                note: '',
            },
            noteText: '',
            currentOrder: null,
            is_instocks: ['是','否'],
        };
    },

    computed: {
        isAdmin() {
            // 使用可选链语法
            return this.$store.state.user?.role === 'admin'
            }
        },

    created(){
      this.is_instocks=['是','否'];
      this.getOrdersList()
    },
    methods:{           
        //删除订单
        toDelete(ID){
            this.deleteDialogVisible=true;
            this.deleteIDFrom.deleteID=ID
        },
        deleteOrder(){
            this.deleteDialogVisible=false;
            var that=this;
            this.$axios({
                method:'post',
                url:'http://127.0.0.1:3007/deleteOrder',
                data:(()=>{
                    return that.$qs.stringify(this.deleteIDFrom)
                })()
            }).then(res=>{
                res=res.data;
                if(res.status!==200)return this.$message.error("删除失败")
                this.$message.success("删除成功")
                this.getOrdersList()
            })
        },
        //编辑订单
        toEdit(ID){
            const selectedOrder = this.ordersList.find(order => order.order_id === ID);
            this.editOrderFrom = {
                order_id: selectedOrder.order_id,
                gname: selectedOrder.gname,
                gtype: selectedOrder.gtype,
                spid: selectedOrder.spid,
                order_number: selectedOrder.order_number,
                order_price: selectedOrder.order_price,
                is_instock: selectedOrder.is_instock,
        },
            this.editDialogVisible=true;
        },
        //提交编辑订单
        submitEditOrder(){
            this.editDialogVisible=false;
            this.$axios({
                method:'post',
                url:'http://127.0.0.1:3007/editOrder',
                data:this.$qs.stringify(this.editOrderFrom),
            })
            .then((res)=>{
                res=res.data;
                if(res.status!==200)return this.$message.error("编辑失败")
                this.$message.success("编辑成功")
                this.getOrdersList();
            })
            .catch((error) => {
                    console.error('Error editing orders:', error);
                });
        },
        //添加订单
        toAddOrder(){
            this.addDialogVisible=true
        },
        submitAddOrder(){
            this.addDialogVisible=false
            var that=this;
            this.$axios({
                method:'post',
                url:'http://127.0.0.1:3007/addOrder',
                data:(()=>{
                    return that.$qs.stringify(this.addOrderFrom)
                })()
            }).then(res=>{
                res=res.data;
                if(res.status!==200)return this.$message.error("添加失败")
                this.$message.success("添加成功")
                this.getOrdersList()
            })
        },
        
        // 搜索订单
        toSearchOrder(){
            var that=this;
            this.$axios({
                method:'post',
                url:'http://127.0.0.1:3007/searchOrder',
                data:(()=>{
                    return that.$qs.stringify(this.searchOrderFrom)
                })()
            }).then(res=>{
                res=res.data;
                if(res.status!==200)return this.$message.error("查询失败")
                this.$message.success("查询成功")
                this.ordersList=res.data
            })
            this.searchOrderFrom.searchOrder=''
        },
        //渲染订单页表
        getOrdersList(){
            var that=this;
            this.$axios({
                method:'get',
                url:'http://127.0.0.1:3007/orders',
            }).then(res=>{
                res=res.data;
                this.ordersList=res.data;

                this.ordersList.forEach(order=>{
                    const utcTime =order.order_time;
                    const date = new Date(utcTime);
                    order.local_time = date.toLocaleString();
                });

            });
        },
        openNoteDialog(index, row) {
            this.noteDialogVisible = true;
            this.currentOrder = row;
            this.noteText = row.note; // 将当前订单的备注设置为noteText的值
          },
        addNote() {
            this.currentOrder.note = this.noteText;
            this.noteDialogVisible = false;
            this.noteText = '';
          },
          rowClassName({ row, rowIndex }) {
              if (row.note) {
                return 'note-row';
              }
              return '';
          }
    }
}
</script>

<style scoped>
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
  .el-table .warning-row {
  background: red;
  }
  .el-table .note-row {
    background: rgb(255, 0, 0);
  } 
</style>