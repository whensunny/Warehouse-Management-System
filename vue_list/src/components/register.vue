<template>
    <div class="register_container">
        <div class="register_box">
            <!-- 头像区域 -->
            <div class="avator_box">
                <img src="../assets/login.jpg">
            </div>
            <!-- 表单区域 -->
            <el-form :rules="rules" label-width="60px" :model="registerForm" ref="registerFormRef" class="register_form">
                <el-form-item label="账号" prop="account">
                    <el-input placeholder="请输入账号"
                    prefix-icon='el-icon-user' v-model="registerForm.account"></el-input>
                </el-form-item>
                <el-form-item label="密码" prop="password">
                    <el-input placeholder="请输入密码"
                    prefix-icon='el-icon-news' v-model="registerForm.password"
                    :type="showPassword ? 'text' : 'password'"
                    suffix-icon="el-icon-view"
                    @click.native="togglePassword"></el-input>
                </el-form-item>
                <el-form-item class="btns">
                    <el-button @click="goToLogin" type="info">返回登录</el-button>
                    <el-button type="primary" @click="register">确认注册</el-button>
                </el-form-item>
            </el-form>
        </div>
    </div>
</template>

<script>
import { RadioGroup, Radio } from 'element-ui';

export default {
    components: {
        'el-radio-group': RadioGroup,
        'el-radio': Radio
    },
    data(){
        return {
            showPassword: false,
            registerForm: {
                account: '',
                password: '',
                role:'guest'
            },
            rules:{
                account:[
                    {required: true, message:"账号不能为空",trigger:"blur"},
                    {min:3, max:10,message:"账号长度为3~10个字符",trigger:"blur"}
                ],
                password:[
                    {required: true,message:"密码不能为空",trigger:"blur"},
                    {min:6, max:15,message:"密码长度为6~15个字符",trigger:"blur"}
                ],
            },    // ...其他 数据属性
        }
    },
    
    methods: {
        togglePassword() {
            this.showPassword = !this.showPassword;
            console.log('togglePassword called, new value:', this.showPassword); // 新增的语句
    },
        register() {
            this.$refs.registerFormRef.validate((valid) => {
            if (valid) {
                var that = this;
                this.$axios({
                    method: 'post',
                    url: 'http://127.0.0.1:3007/register',
                    headers: {
                        'Content-type': 'application/x-www-form-urlencoded'
                    },
                    data: (() => {
                        return that.$qs.stringify(that.registerForm);
                    })()
                }).then(res => {
                    res = res.data;
                    if (res.success) {
                        this.$message.success('注册成功');
                        this.$router.push('/login');
                    } else {
                        this.$message.error('注册失败：' + res.message);
                    }
                }).catch(error => {
                    this.$message.error('注册失败：' + error.message);
                });
            } else {
                this.$message.error('请正确填写表单');
                return false;
            }
        });
    
    },
    goToLogin() {
            this.$router.push('/login');
        }
    
    // ...其他方法
}
}
</script>
<style lang="less" scoped>
.register_container{
    height: 100%;
    background: linear-gradient(rgb(18, 184, 118),rgb(255, 255, 255));
    display: flex;
    justify-content: center;
    align-items: center;
}
.register_box{
    background-color: rgb(255, 255, 255);
    height: 40%;
    width: 50%;
    border-radius: 8px;
    position: absolute;
    .avator_box{
        height: 130px;
        width: 130px;
        border: 1px solid rgb(76, 178, 255);
        border-radius: 50%;
        padding: 10px;
        box-shadow: 10px;
        position: absolute;
        left: 50%;
        transform: translate(-50%,-50%);
        background-color: rgb(255, 255, 255);
        img{
            object-fit: cover;
            height: 100%;
            width: 100%;
            border-radius: 50%;
            background-color: rgb(226, 255, 255);
            top: 20px;
        }
    }
}
.register_form{
    position: absolute;
    width: 100%;
    padding: 0 20px;
    bottom: 0;
    box-sizing: border-box;
}
.btns{
    display: flex;
    justify-content:flex-end;
}
</style>