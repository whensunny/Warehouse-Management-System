const express = require('express')
//创建路由对象
const router = express.Router()
const platfromHandler = require('../routerHandler/platfrom')
router.get('/menus',platfromHandler.menus)

//货物管理
router.get('/goods',platfromHandler.goods)
router.get('/quantityChange',platfromHandler.quantityChange);
router.post('/addGood',platfromHandler.addGood)
router.post('/searchGood',platfromHandler.searchGood)
router.post('/goodsalt',platfromHandler.goodsalt)
router.post('/deletegoods',platfromHandler.deletegoods)

//订单管理
router.get('/orders',platfromHandler.orders)
router.post('/addOrder',platfromHandler.addOrder)
router.post('/searchOrder',platfromHandler.searchOrder)
router.post('/deleteOrder',platfromHandler.deleteOrder) 
router.post('/editOrder',platfromHandler.editOrder)

//权限管理
router.get('/roles',platfromHandler.roles)
router.post('/addRole',platfromHandler.addRole)


//用户管理
router.get('/users',platfromHandler.users)
router.post('/addUser',platfromHandler.addUser)
router.post('/editUser',platfromHandler.editUser)
router.post('/deleteUser',platfromHandler.deleteUser)
router.post('/searchUser',platfromHandler.searchUser)



//数据库
router.post('/sql',platfromHandler.sql)


module.exports=router