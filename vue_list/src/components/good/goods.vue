<template>
 <div>
        <!--导航区域-->
        <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>货物管理</el-breadcrumb-item>
        <el-breadcrumb-item>货物查询</el-breadcrumb-item>
        </el-breadcrumb>
        <el-card class="box-card">
        <div slot="header" class="clearfix">
            <el-row>
            <el-col :span="12">
                <div class="grid-content">
                    <el-input
                    placeholder="请输入所需查找的货物信息"
                    prefix-icon="el-icon-search"
                    v-model="searchGoodFrom.searchGood">
                    </el-input>
                </div>
            </el-col>
            <el-col :span="6"><div class="grid-content">
                    <el-button icon="el-icon-search" @click="toSearchGood">搜索货物</el-button>
                    </div>
            </el-col>
            <el-col :span="6"><div class="grid-content">
                    <el-button icon="el-icon-circle-plus"  v-if="isAdmin" @click="toAddGood">添加货物信息</el-button>
                    </div>
            </el-col>
            </el-row>
        </div>
            <el-table :data="goodsList"
            height="800"
            border
            style="width: 100%">
                <el-table-column
                prop="gid"
                label="货物编号"
                width="80">
                </el-table-column>
                <el-table-column
                prop="gtype"
                label="货物类型">
                </el-table-column>
                <el-table-column
                prop="gname"
                label="货物名称">
                </el-table-column>
                <el-table-column
                prop="introduction"
                label="货物简介">
                </el-table-column>
                <el-table-column
                prop="quantity"
                label="货物数量">
                </el-table-column>
                <el-table-column label="操作">
                    <template slot-scope="scope">
                        <el-button type="warning" icon="el-icon-setting" v-if="isAdmin" circle @click="handleEdit(scope.row)"></el-button>
                        <el-button type="danger" icon="el-icon-delete" v-if="isAdmin" circle @click="toDelete(scope.row.gid)"></el-button>
                        <el-button type="info" icon="el-icon-search" circle @click="quantityChange(scope.row)"></el-button>
                    </template>
                </el-table-column>
            
            </el-table>
            <!-- 编辑商品信息的对话框 -->
            <el-dialog
            title="编辑商品信息"
            :visible.sync="editDialogVisible"
            width="30%"
            >
            <el-form label-width="60px" :model="goodsaltForm" ref="editFromRef" class="edit_form">
                <!-- 在表单中显示商品信息，允许用户编辑 -->
                <el-form-item label="货物名称">
                <el-input v-model="goodsaltForm.gname"></el-input>
                </el-form-item>
                <el-form-item label="货物类型">
                <el-input v-model="goodsaltForm.gtype"></el-input>
                </el-form-item>
                <el-form-item label="货物数量">
                <el-input v-model="goodsaltForm.quantity"></el-input>
                </el-form-item>
                <el-form-item label="货物介绍">
                <el-input v-model="goodsaltForm.introduction" type="textarea" :rows="3"></el-input>
                </el-form-item>
                <el-form-item label="货物编号">
                <el-input v-model="goodsaltForm.gid"></el-input>
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button @click="editDialogVisible = false">取消</el-button>
                <el-button type="primary" @click="submitEdit">确认</el-button>
            </span>
            </el-dialog>
            <el-dialog
            title="添加货物信息"
            :visible.sync="addDialogVisible"
            width="30%">
            <el-form label-width="60px" :model="addGoodFrom" ref="addFromRef" class="add_from">
                <el-form-item label="货物">
                    <el-input placeholder="请输入货物名称"
                    prefix-icon='el-icon-user' v-model="addGoodFrom.gname"></el-input>
                </el-form-item>
                <el-form-item label="类型">
                    <el-input placeholder="请输入货物类型"
                    prefix-icon='el-icon-user' v-model="addGoodFrom.gtype"></el-input>
                </el-form-item>
                <el-form-item label="数量">
                    <el-input placeholder="请输入货物数量"
                    prefix-icon='el-icon-user' v-model="addGoodFrom.quantity"></el-input>
                </el-form-item>
                <el-form-item label="介绍">
                    <el-input
                    type="textarea"
                    :rows="3"
                    placeholder="请输入货物简介"
                    v-model="addGoodFrom.introduction">
                    </el-input>
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button @click="addDialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="submitaddGood">确 定</el-button>
            </span>
            </el-dialog>
            <el-dialog
        title="删除订单"
        :visible.sync="deleteDialogVisible"
        width="30%"
        >
        <span>确认删除{{ deleteIDFrom.deleteID }}号货物？<br>（该操作不可重置）</span>
        <span slot="footer" class="dialog-footer">
            <el-button @click="deleteDialogVisible = false">取消</el-button>
            <el-button type="primary" @click="deletegoods">确定</el-button>
        </span>
        </el-dialog>
        <el-dialog :visible.sync="dialogVisible" width="70%">
            <div id="echarts" style="width: 100%; height: 400px;"></div>
        </el-dialog>
        </el-card>
    </div>
</template>

<script>

import axios from 'axios';
export default {
    data(){
        return{
            deleteDialogVisible: false,
            addDialogVisible:false,
            editDialogVisible: false,
            dialogVisible: false,
            deleteIDFrom:{
                deleteID:'',
            },
            searchGoodFrom:{
                searchGood:''
            },
            goodsList:[],
            addGoodFrom:{
                gname:'',
                gtype:'',
                quantity:'',
                introduction:''
            },
             // 控制编辑对话框的显示与隐藏
            goodsaltForm: {
                gname: '',
                gtype: '',
                quantity: '',
                introduction: '',
                gid: '' // 假设 gid 是编辑商品的标识符
            
            },
            quantityChanges: [],
        }
        
    },
    computed: {
        isAdmin() {
            // 使用可选链语法
            return this.$store.state.user?.role === 'admin'
            }
        },
    created(){
        // console.log('role',this.$store.state.user);
        this.getGoodsList()
    },
    methods: {
        toDelete(ID){
            this.deleteDialogVisible=true;
            this.deleteIDFrom.deleteID=ID
        },
        deletegoods(){
            this.deleteDialogVisible=false;
            var that=this;
            this.$axios({
                method:'post',
                url:'http://127.0.0.1:3007/deletegoods',
                data:(()=>{
                    return that.$qs.stringify(this.deleteIDFrom)
                })()
            }).then(res=>{
                res=res.data;
                if(res.status!==200)return this.$message.error("删除失败")
                this.$message.success("删除成功")
                location.reload()
            })
        },
        toSearchGood() {
            var that = this;
            this.$axios({
                method: 'post',
                url: 'http://127.0.0.1:3007/searchGood',
                data: (() => {
                    return that.$qs.stringify(this.searchGoodFrom);
                })(),
            }).then((res) => {
                res = res.data;
                if (res.status !== 200) return this.$message.error('搜索失败');
                this.$message.success('搜索成功');
                this.goodsList = res.data;
            });
            this.searchGoodFrom.searchGood = '';
        },
        toAddGood() {
            this.addDialogVisible = true;
        },
        submitaddGood() {
            this.addDialogVisible = false;
            var that = this;
            this.$axios({
                method: 'post',
                url: 'http://127.0.0.1:3007/addGood',
                data: (() => {
                    return that.$qs.stringify(this.addGoodFrom);
                })(),
            }).then((res) => {
                res = res.data;
                if (res.status !== 200) return this.$message.error('添加失败');
                this.$message.success('添加成功');
            });
        },
        getGoodsList() {
            this.$axios({
                method: 'get',
                url: 'http://127.0.0.1:3007/goods',
            })
                .then((res) => {
                    console.log(res.data);
                    res = res.data;
                    this.goodsList = res.data;
                })
                .catch((error) => {
                    console.error('Error fetching goods:', error);
                });
        },
        handleEdit(row) {
            this.goodsaltForm = { ...row };
            this.editDialogVisible = true;
        },
        submitEdit() {
            console.log('Submitting:', this.goodsaltForm);
            this.$axios({
                method: 'post',
                url: 'http://127.0.0.1:3007/goodsalt',
                data:this.$qs.stringify(this.goodsaltForm),
            })
                .then((res) => {
                    console.log('Response:', res.data);
                    if (res.data.length > 0) {
                    console.log('First item:', res.data[0]);
                    }
                    res = res.data;
                    if (res.status !== 200) return this.$message.error('编辑失败');
                    this.$message.success('编辑成功');
                    this.editDialogVisible = false;
                    this.getGoodsList();
                })
                .catch((error) => {
                    console.error('Error editing goods:', error);
                });
                },
            quantityChange(row) {
                    this.dialogVisible = true; // 显示对话框
                    this.$axios({
                        method: 'get',
                        url: 'http://127.0.0.1:3007/quantityChange',
                        params: { gid: row.gid }
                     })
                     // 获取商品数量的变化数据
                    .then(res => {
                        if(Array.isArray(res.data)){
                        this.drawEcharts(res.data);
                        console.log(res.data) // 绘制趋势图
                    }else {
                        if(res.data){
                        console.log(res.data)
                        console.warn('服务器返回的数据不是数组，尝试转换为数组');
                        let dataArray = Object.values(res.data.data);
                        this.drawEcharts(dataArray);// 处理错误
                    }else{
                        console.error('服务器返回的数据为undifeined或null')
                    }
                }
            })
                    .catch(err => {
                        console.error(err);
                        alert('获取数据失败');
                    });
                },
                drawEcharts(data) {
                    console.log('data:', data);
                    const echarts = require('echarts'); // 引入 ECharts
                    const myChart = echarts.init(document.getElementById('echarts')); // 初始化图表
                    
                    // 按照 change_date 属性对数据进行排序
                    data.sort((a, b) => new Date(a.change_date) - new Date(b.change_date));

                    const xAxisData = data.map(item => new Date(item.change_date));
                    const seriesData = data.map(item => [new Date(item.change_date), item.change_amount]);
                    console.log('xAxis data:', xAxisData); // 查看 x 轴的数据
                    console.log('series data:', seriesData); // 查看 y 轴的数据
                    const option = {
                        title: {
                            text: '商品数量变化趋势'
                        },
                        xAxis: {
                            type: 'time',
                            data: xAxisData // 设置 x 轴的数据为日期对象
                        },
                        yAxis: {
                            type: 'value'
                        },
                        series: [{
                            data: seriesData,
                            type: 'line',
                            encode: {
                            x: 0, // 第一个维度（日期）对应 x 轴
                            y: 1  // 第二个维度（数据）对应 y 轴
                            }
                            
                        }]
                    };
                    myChart.setOption(option); // 设置图表的配置项
                }
                
    },

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