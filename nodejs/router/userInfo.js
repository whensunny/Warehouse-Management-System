const express = require('express')

const router = express.Router()

//导入路由处理函数模块
const userinfoHandler = require('../routerHandler/userInfo')

//导入验证数据的中间件
const expressJoi = require('@escook/express-joi')
//导入需要的验证规则对象
const {updateUserinfo,updatePassword,updateAvatar} = require('../schema/user')

//挂载获取用户信息的路由
router.get('/userinfo',userinfoHandler.getUserInfo)

//更新用户信息的路由
router.post('/update/userinfo',expressJoi(updateUserinfo),userinfoHandler.updateUserInfo)

//重置密码的路由
router.post('/update/updatepassword',expressJoi(updatePassword),userinfoHandler.updatePassword)

//更换头像的路由
router.post('/update/avatar',expressJoi(updateAvatar),userinfoHandler.updateAvatar)


module.exports = router