<template>
    <div v-html="goodItem.introduction">  
    </div>
</template>

<script>
export default {
    data(){
        return{
            goodItem:'',
            ID:this.$route.query.gid,
        }
    },
    created(){
        this.getGood()
    },
    methods:{
        getGood(){
            this.$axios({
                method:'get',
                url:'http://127.0.0.1:3007/goods',
            }).then(res=>{
                res=res.data;
                this.goodItem=res.data[this.ID-1];
            })
        }
    },
}
</script>

<style>

</style>