const express = require('express')
//创建路由对象
const router = express.Router()
//导入用户路由处理函数对应的模块
const userHandler = require('../routerHandler/user')
//导入验证数据的中间件
const expressJoi = require('@escook/express-joi')
//导入需要的验证规则对象
const {loginRule,registerRule} = require('../schema/user')
//注册新用户
router.post('/register',expressJoi(registerRule),userHandler.register)
//登录接口
router.post('/login',expressJoi(loginRule),userHandler.login)
router.post('/phoneLogin',userHandler.phoneLogin)
  
module.exports=router