<!-- <template>
    <div>
      <el-table :data="goodsList" style="width: 100%">
        <el-table-column prop="name" label="货物名称"></el-table-column>
        <el-table-column prop="stock" label="库存"></el-table-column>
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button @click="sendEmail">发送邮件</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
  </template>
  
  <script>
import axios from 'axios';

export default {
  data() {
    return {
      goodsList: []
    };
  },
  methods: {
    getGoodsList() {
        console.log('Sending request to /shortGoods');
        this.$axios({
            method:'get',
            url:'http://http://127.0.0.1:3007/shortGoods',
        })
            .then(res => {
                console.log('Received response:', res);
                res = res.data;
                this.goodsList = res.data;
            })
            .catch(error => {
            console.error('Error fetching goods:', error);
            });
        },
        sendEmail() {
                const nodemailer = require('nodemailer');

                let transporter = nodemailer.createTransport({
                    service: 'Outlook365',
                    auth: {
                    user: 'your-email@outlook.com',
                    pass: 'your-password'
                    }
                });

                let mailOptions = {
                    from: 'your-email@outlook.com',
                    to: 'receiver-email@gmail.com',
                    subject: 'Goods List',
                    text: 'Here is the list of goods: ' + JSON.stringify(this.goodsList)
                };

                transporter.sendMail(mailOptions, function(error, info){
                    if (error) {
                    console.log(error);
                    } else {
                    console.log('Email sent: ' + info.response);
                    }
                });
            }
    },
  created() {
    this.getGoodsList();
  }
};
</script> -->