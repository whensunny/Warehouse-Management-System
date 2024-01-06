//导入定义验证规则的包
const joi = require('joi')

//定义用户名和密码的验证规则
const account = joi.string().alphanum().min(1).max(10).required()
const password = joi.string().pattern(/^[\S]{6,12}$/).required()
const id = joi.number().integer().min(1).required()
const nickname = joi.string().required()
const email = joi.string().email().required()
const avatar = joi.string().dataUri().required()

//定义一个验证规则对象
exports.loginRule = {
    body:{
        account,
        password,
    }
}

//定义一个验证规则对象
exports.registerRule = {
    body:{
        account,
        password,
    }
}


//更新用户基本信息的验证规则对象
exports.updateUserInfo = {
    body:{
        nickname,
        email
    }
}

//更新密码
exports.updatePassword = {
    body:{
        oldPwd:password,
        //使用joi.not(joi.ref('oldPwd)).concat(password)规则，验证req.body.newPwd的值
        //joi.not(joi.ref('oldPwd'))表示newPwd的值不能等于oldPwd的值
        //.concat()用于合并joi.not(joi.ref('oldPwd'))和password这两条验证规则
        newPwd:joi.not(joi.ref('oldPwd')).concat(password)
    }
}

//验证对象-更新头像
exports.updateAvatar = {
    body:{
        avatar
    }
}