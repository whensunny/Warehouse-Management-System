//导入数据库操作模块
const db = require('../dataBase/index')
//导入bcryptjs这个包
const bcrypt = require('bcryptjs')
//初始化导航区域
exports.menus=(req,res)=>{
    const sqlStr = 'select * from sp_permission'
    db.query(sqlStr,(err,results)=>{
        if(err) return res.cc(err)
        else{
            res.send({
                status:200,
                data:results
            })
        }
    })
}
//获取订单列表
exports.orders=(req,res)=>{
    const sqlStr = 'select * from orders'
    db.query(sqlStr,(err,results)=>{
        if(err) return res.cc(err)
        else{
            res.send({
                status:200,
                data:results
            })
        }
    })
}

//实现订单的插入
exports.addOrder=(req,res)=>{
    addInfo=req.body
    const sqlStr='insert into orders set ?'
    db.query(sqlStr,{order_number:addInfo.order_number,spid:addInfo.spid,order_price:addInfo.order_price,gtype:addInfo.gtype,gname:addInfo.gname,is_instock:addInfo.is_instock, note:addInfo.note},(err,results)=>{
        if(err){
            console.log(err)
            return res.cc(err)}
        res.send({
            status:200,
            data:results
        })
    })
}

exports.searchOrder = (req, res) => {
    const searchOrderInfo = req.body;
    const sqlStr = "select * from orders where gname like '%" + searchOrderInfo.searchOrder + "%' or order_id like '%" + searchOrderInfo.searchOrder + "%'";
    db.query(sqlStr, (err, results) => {
      if (err) {
        console.log(err);
        return res.cc(err);
      }
      res.send({
        status: 200,
        data: results
      });
    });
  };

exports.deleteOrder=(req,res)=>{
    deleteInfo=req.body
    // console.log(deleteInfo.deleteID)
    const sqlStr='delete from orders where order_id='+deleteInfo.deleteID
    db.query(sqlStr,(err,results)=>{
        if(err){
            console.log(err)
            return res.cc(err)}
        res.send({
            status:200,
            data:results
        })
    })
}

exports.editOrder=(req,res)=>{
    editInfo=req.body
    const sqlStr='UPDATE orders SET ? WHERE order_id = '+editInfo.order_id
    db.query(sqlStr,{spid:editInfo.spid,gtype:editInfo.gtype,gname:editInfo.gname,order_number:editInfo.order_number,order_price:editInfo.order_price,is_instock:editInfo.is_instock, note:editInfo.note},(err,results)=>{
        if(err){
            console.log(err)
            return res.cc(err)}
        res.send({
            status:200,
            data:results
        })
    })
}

//获取货物信息列表
exports.goods=(req,res)=>{
    // console.log(res)
    console.log("货物被访问")
    const sqlStr = 'select * from goods'
    db.query(sqlStr,(err,results)=>{
        if(err) return res.cc(err)
        else{
            res.send({
                status:200,
                data:results
            })
        }
    })
}

exports.addGood = (req, res) => {
    const addInfo = req.body;
    const sqlStr = 'INSERT INTO goods (gtype, gname, introduction, quantity) VALUES (?, ?, ?, ?)';
    db.query(sqlStr, [addInfo.gtype, addInfo.gname, addInfo.introduction, addInfo.quantity], (err, results) => {
      if (err) {
        console.log(err);
        return res.cc(err);
      }
      res.send({
        status: 200,
        data: results
      });
    });
  };

exports.searchGood=(req,res)=>{
    const searchInfo=req.body;
    const sqlStr = "select * from goods where gname like ? or gid like ?";
    db.query(sqlStr, [`%${searchInfo.searchGood}%`, `%${searchInfo.searchGood}%`], (err,results)=>{
        if(err){
            console.log(err);
            return res.cc(err);
        }
        res.send({
            status:200,
            data:results
        });
    });
}
exports.goodsalt = (req, res) => {
    const goodsInfo = req.body; // 获取请求中的修改信息
    // console.log('goodsInfo'); // 打印修改信息
    // console.log(goodsInfo); // 打印修改信息
    const { gname, gtype, quantity, introduction, gid } = goodsInfo;    // 从 goodsInfo 中提取所需的字段以及货物 ID 等信息
    // console.log(gname, gtype, quantity, introduction, gid); // 打印所需的信息
    const sqlStr = `UPDATE goods SET gname = ?, gtype = ?, quantity = ?, introduction = ? WHERE gid = ?`;
    db.query(sqlStr, [gname, gtype, quantity, introduction, gid], (err, results) => {
        if (err) {
            console.log(err);
            res.status(500).send({ status: 500, message: 'Database update failed' });
        }
        res.send({
            status: 200,
            data: results,
        });
    });
};

exports.deletegoods = (req, res) => {
    const deleteInfo = req.body;
    const deleteID = deleteInfo.deleteID;
  
    // 先删除 quantity_changes 表中所有引用这个 gid 的记录
    const sqlStr1 = 'DELETE FROM quantity_changes WHERE gid = ?';
    db.query(sqlStr1, deleteID, (err, results) => {
      if (err) {
        console.log(err);
        return res.cc(err);
      }
  
      // 然后删除 goods 表中的记录
      const sqlStr2 = 'DELETE FROM goods WHERE gid = ?';
      db.query(sqlStr2, deleteID, (err, results) => {
        if (err) {
          console.log(err);
          return res.cc(err);
        }
  
        res.send({
          status: 200,
          data: results
        });
      });
    });
  };

exports.quantityChange = (req, res) => {
    const gid = req.query.gid;
    // console.log('gid', gid); // 打印 gid
    const sqlStr = `SELECT * FROM quantity_changes WHERE gid = ${gid} ORDER BY change_date DESC LIMIT 30`;
    db.query(sqlStr, gid, (err, results) => {
      if (err) return res.cc(err);
      res.send({
        status: 200,
        data: results
      });
    });
  };
//获取角色列表
exports.roles=(req,res)=>{
    const sqlStr = 'select * from adminuser'
    db.query(sqlStr,(err,results)=>{
        if(err) return res.cc(err)
        else{
            res.send({
                status:200,
                data:results
            })
        }
    })
}

exports.addRole=(req,res)=>{
    // console.log(req.body.name)
    addInfo=req.body
    const sqlStr='insert into sp_role set ?'
    db.query(sqlStr,{role_name:addInfo.name,role_desc:addInfo.role},(err,results)=>{
        if(err){
            console.log(err)
            return res.cc(err)}
        res.send({
            status:200,
            data:results
        })
    })
}

//获取权限列表
// exports.rights=(req,res)=>{
//     const sqlStr = 'select * from sp_permission'
//     db.query(sqlStr,(err,results)=>{
//         if(err) return res.cc(err)
//         else{
//             res.send({
//                 status:200,
//                 data:results
//             })
//         }
//     })
// }

//获取用户列表
exports.users=(req,res)=>{
    const sqlStr='select * from adminuser'
    db.query(sqlStr,(err,results)=>{
        if(err)return res.cc(err)
        res.send({
            status:200,
            data:results
        })
    })
}

exports.addUser=(req,res)=>{
     const addInfo = req.body
     //定义sql语句，查询用户名是否被占用
     const sqlStr = 'select * from adminuser where username = ?'
     db.query(sqlStr,addInfo.account,(err,results)=>{
         if(err){
             return res.cc(err)
         }
         //判断用户名是否被占用
         if(results.length>0){
             return res.cc('用户名被占用')
         }
         //TODO用户名可以使用
         //调用bcrypt.hashSync()方法
         addInfo.password = bcrypt.hashSync(addInfo.password,10)
         //插入用户
         const sql = 'insert into adminuser set ?'
         //执行sql语句
         db.query(sql,{username:addInfo.account,password:addInfo.password,phonenum:addInfo.phonenum},(err,results)=>{
             //判断是否执行sql
             if(err) return res.cc(err)
             //判断影响行数是否唯一
             if(results.affectedRows!==1) return res.cc('添加用户失败')
             //注册成功
             res.cc('添加成功',200)
         })
 
     })
}

exports.editUser=(req,res)=>{
    editInfo=req.body
    // console.log(editInfo)
    const sqlStr='UPDATE adminuser SET ? WHERE uid = '+editInfo.userID
    db.query(sqlStr,{username:editInfo.name,phonenum:editInfo.phonenum,role:editInfo.role},(err,results)=>{
        if(err){
            console.log(err)
            return res.cc(err)}
        res.send({
            status:200,
            data:results
        })
    })
}

exports.deleteUser=(req,res)=>{
    deleteInfo=req.body
    // console.log(deleteInfo.deleteID)
    const sqlStr='delete from adminuser where uid='+deleteInfo.deleteID
    db.query(sqlStr,(err,results)=>{
        if(err){
            console.log(err)
            return res.cc(err)}
        res.send({
            status:200,
            data:results
        })
    })
}

exports.searchUser=(req,res)=>{
    searchInfo=req.body
    // console.log(searchInfo.searchUser)
    const sqlStr="select * from adminuser where username like '%"+searchInfo.searchUser+"%'"
    db.query(sqlStr,(err,results)=>{
        if(err){
            console.log(err)
            return res.cc(err)}
        res.send({
            status:200,
            data:results
        })
    })
}


//商品数据管理


exports.shortGoods=(req,res)=>{
    // console.log('Received request for short goods')
    const sqlStr = 'select * from goods where quantity<500'
    db.query(sqlStr, (err, results) => {
        if(err) {
            console.error('Error querying database:', err);
            return res.cc(err);
        } else {
            console.log('Sending response:', results);
            res.send({
                status: 200,
                data: results
            })
        }
    })
}


//=========================
exports.sql=(req,res)=>{
    const sqlStr = req.body.sql
    db.query(sqlStr,(err,results)=>{
        if(err) return res.cc(err)
        else{
            res.send({
                status:200,
                data:results
            })
        }
    })
}