//导入数据库操作模块
const db = require('../dataBase/index')
//导入bcryptjs这个包
const bcrypt = require('bcryptjs')
//导入生成token的包
const jwt = require('jsonwebtoken')
//导入全局的配置文件
const config = require('../config')

//注册用户的方法
exports.register =(req,res)=>{
// 获取客户端提交到服务器的用户信息
        const userInfo = req.body
        
        // console.log('req.body:', req.body)

        // 为用户添加一个默认的角色
        userInfo.role = 'guest'

        // 定义插入新用户的 SQL 语句
        const sql = 'insert into adminuser (username, password, role) values (?, ?, ?)'
        const params = [userInfo.account, userInfo.password, userInfo.role]

        // 打印 SQL 语句和参数
        // console.log('SQL:', sql)
        // console.log('Params:', params)

        // 定义 SQL 语句，查询用户名是否被占用
        const sqlStr = 'select * from adminuser where username =?'
        db.query(sqlStr,userInfo.account,(err,results)=>{
            if(err){
                return res.cc(err)
            }
            // 判断用户名是否被占用
            if(results.length>0){
                return res.cc('用户名被占用')
            }
            // 用户名可以使用
            // 调用 bcrypt.hashSync() 方法对密码进行加密
            userInfo.password = bcrypt.hashSync(userInfo.password,10)

            // 执行 SQL 语句，插入新用户
            db.query(sql, params, (err, results) => {
                if (err) {
                    return res.cc(err)
                }
                if (results.affectedRows !== 1) {
                    return res.cc('注册用户失败，请稍后再试')
                }
                res.send({ success: true, message: '注册成功' })
            })
        })
    }

//登录的处理函数
exports.login = (req,res)=>{
    console.log("Login被访问")
    //接收表单数据
    const userInfo = req.body
    //定义sql语句
    const sql = 'select * from adminuser where username = ?'
    //执行sql语句
    db.query(sql,userInfo.account,(err,results)=>{
        //执行sql语句失败
        if(err){
            console.log('failed',err);
            return res.cc(err);
        } 
            
        //执行成功，但获取数据条数不为一
        if(results.length!==1) return res.cc('登陆失败!')

        //todo：判断密码是否正确
        const compareResult = userInfo.password === results[0].password
        if(!compareResult) return res.cc('密码错误')

        //TODO：在服务器端生成
        const user = {...results[0],password:'',user_pic:''}
        //对用户信息进行加密，生成token字符串
        const tokenStr = jwt.sign(user,config.jwtSecretKey,{expiresIn:config.expiresIn})
        //调用res.send()将token响应给客户端

        res.send({
            status:0,
            message:'登陆成功',
            token:'Bearer ' + tokenStr,
            role: user.role
        })
    })

}

exports.phoneLogin= (req,res)=>{
    console.log("PhoneLogin被访问")
    let data = '';

    // 监听请求数据的事件
    req.on('data', chunk => {
      // 将数据片段拼接起来
      data += chunk.toString();
    });
  
    // 请求结束事件
    req.on('end', () => {
      // 处理接收到的数据
      console.log('Received data:', data);
  
      // 发送响应
      res.send('Data received successfully');
    });
}
