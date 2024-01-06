//数据库的登录，选择的为mysql
const mysql = require('mysql')

const dataBase = mysql.createPool({
    host:'localhost',
    port:3306,
    user:'root',
    password:'111222qq',
    database:'wmh'
})

module.exports = dataBase