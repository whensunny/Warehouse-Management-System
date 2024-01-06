<template>
    <div class="login_container">
        <div class="login_box">
            <!-- 头像区域 -->
            <div class="avator_box">
            <img src="../assets/login.jpg" class="avatar">
        </div>
            <!-- 表单区域 -->
            <el-form :rules="rules" label-width="60px" :model="loginFrom" ref="loginFromRef" class="login_from">
                <el-form-item label="账号" prop="account">
                    <el-input placeholder="请输入账号"
                    prefix-icon='el-icon-user' v-model="loginFrom.account"></el-input>
                </el-form-item>
                <el-form-item label="密码" prop="password">
                    <el-input placeholder="请输入密码"
                    prefix-icon='el-icon-news' v-model="loginFrom.password"
                    :type="showPassword ? 'text' : 'password'"
                    suffix-icon="el-icon-view"
                    @click.native="togglePassword">
                    </el-input>
                </el-form-item>
                <el-form-item class="btns">
                    <el-button type="primary" @click="login">登录</el-button>
                    <el-button type="primary" @click="register">注册</el-button>
                </el-form-item>
            </el-form>
        </div>
    </div>
    
</template>

<script>
export default {
    data(){
        return{
            showPassword: false,
            loginFrom:{
                account:'',
                password:''
            },
            registerForm: {
                account: '',
                password: ''
            },
            //Vue校验规则
            rules:{
                account:[
                    {required: true, message:"账号不能为空",trigger:"blur"},
                    {min:3, max:10,message:"账号长度为3~10个字符",trigger:"blur"}
                ],
                password:[
                    {required: true,message:"密码不能为空",trigger:"blur"},
                    {min:6, max:15,message:"密码长度为6~15个字符",trigger:"blur"}
                ]
            },
        }
    },
    
    methods:{
        togglePassword() {
            this.showPassword = !this.showPassword;
        },
        login(){
            this.$refs.loginFromRef.validate(valid=>{
                if(valid){
                    var that=this
                    this.$axios({
                        method:'post',
                        url:'http://127.0.0.1:3007/login',
                        headers:{
                            'Content-type':'application/x-www-form-urlencoded'
                        },
                        data:(()=>{
                            return that.$qs.stringify(that.loginFrom)
                        })()
                    }).then(res=>{
                        res=res.data
                        if(res.status===0){
                            window.sessionStorage.setItem('token',res.token)
                            this.$store.commit('user/setRole', res.role) // 更新 role 状态
                            console.log('roles',this.$store.state.user.role) // 打印 Vuex 的 role 状态
                            this.$message.success("登录成功")
                            this.$router.push('/home')
                            console.log('res',res)
                        }
                        else{
                            return this.$message.error("登录失败")
                        }
                    })
                }else{
                    return this.$message.error("账号密码校验失败")
                }
            })
        },
        register() {
            this.$router.push('/register');
        }
    
    }
}
</script>

<style lang="less" scoped>
.login_container {
    height: 100%;
    background: linear-gradient(rgb(18, 184, 118),rgb(255, 255, 255));
    display: flex;
    justify-content: center;
    align-items: center;
}
.login_box{
    background-color: rgb(255, 255, 255);
    height: 40%;
    width: 50%;
    border-radius: 8px;
    position: absolute;
    // top: 50%;
    // left: 50%;
    // transform: translate(-50%,-50%);
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
.login_from{
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