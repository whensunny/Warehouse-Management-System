const express = require('express')
const app = express()
//导入规则包
const joi = require('joi')
//解决跨域问题
const cors = require('cors')
const fs = require('fs');
const db = require('./dataBase/index')



app.use(cors())


//解析表单数据,注意这个中间件只能解析application/x-www-form-urlencoded格式的表单数据
app.use(express.urlencoded({extended:true}))

//一定要在路由之前封装res.cc函数
app.use((req,res,next)=>{
    res.cc = function(err,status = 1){
        res.send({
            status,
            message:err instanceof Error ? err.message : err
        })
    }
    next()
})

//一定要在路由之前配置token中间件
const expressJWT = require('express-jwt')
const config = require('./config')

app.use(expressJWT({secret:config.jwtSecretKey}).unless({path:["/login","/register"]}))//全部/XXX路径:/^\/XXX/


//导入并使用user模块
const userRouter = require('./router/user')
app.use(userRouter)

//导入并使用管理平台模块
const platfromRouter = require('./router/platfrom')
app.use(platfromRouter)


//定义错误级别的中间件
app.use((err,req,res,next)=>{
    //验证失败导致的错误
    if(err instanceof joi.ValidationError) return res.cc(err)
    //身份认证失败后的错误
    if(err.name === 'UnauthorizedError')  return res.cc('身份认证失败')
    res.cc(err)
})

// startFileWatcher()
app.listen(3007,()=>{
    console.log('服务器运行在http://127.0.0.1:3007')
})