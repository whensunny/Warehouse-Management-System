//这是一个全局的配置文件
module.exports = {
    //这是加密和解密Token的密钥
    jwtSecretKey:'itheima NO1',
    //token的有效期
    expiresIn:'10h',
    algorithms:['HS256']
}