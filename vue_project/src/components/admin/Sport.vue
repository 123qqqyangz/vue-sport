<template>
  <div>
    <!-- 面包屑导航 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>权限管理</el-breadcrumb-item>
      <el-breadcrumb-item>运动模块</el-breadcrumb-item>
    </el-breadcrumb>
    <el-row :gutter="25">
      <el-col :span="10">
        <!-- 搜索添加 -->
        <el-input placeholder="请输入搜索内容" v-model="queryInfo.query" clearable @clear="getSportList">
          <el-button slot="append" icon="el-icon-search" @click="getSportList"></el-button>
        </el-input>
      </el-col>
    </el-row>
    <el-table
        :data="tableData"
        border
        style="width: 100%">
      <el-table-column
          fixed
          prop="sportclass"
          label="运动类型"
          width="150">
      </el-table-column>
      <el-table-column
          prop="times"
          label="运动时长"
          width="120">
      </el-table-column>
      <el-table-column
          fixed="right"
          label="操作"
          width="200">
        <template slot-scope="scope">
          <el-button @click="showEditDialog(scope.row.id)" type="primary" size="small">课程详情</el-button>
          <el-button type="danger" size="small">退选课程</el-button>
        </template>
      </el-table-column>
      <span>{{tableData}}</span>
    </el-table>

    <el-dialog title="修改用户信息" :visible.sync="editDialogVisible" width="50%" @colse="editDialogClosed">
      <el-form :model="editForm" :rules="editFormRules" ref="editFormRef" label-width="70px">
        <!-- 用户名 -->
        <el-form-item label="用户名" prop="username">
          <el-input v-model="editForm.username" disabled></el-input>
        </el-form-item>
        <!-- 密码 -->
        <el-form-item label="密码" prop="password">
          <el-input v-model="editForm.password"></el-input>
        </el-form-item>
        <!-- 邮箱 -->
        <el-form-item label="邮箱" prop="email">
          <el-input v-model="editForm.email"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="editDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="editUserInfo">确 定</el-button>
      </span>
    </el-dialog>

  </div>
</template>

<script>
export default {


    created() {
      this.getSportList();
    },
    data() {

      return {
          tableData: [],
          // 请求数据
          //查询信息封装的信息实体
          queryInfo: {
            query: "",
            pageNum: 1,
            pageSize: 5
          },
          total: 0, // 最大数据记录
          addDialogVisible: false,// 对话框显示
          editDialogVisible:false,
          editForm:{},
      }
    },
    methods: {
      async getSportList() {
        // 调用post请求
        const { data: res } = await this.$http.get("allSport", {
          params: this.queryInfo
        });
        this.tableData = res.data; // 将返回数据赋值
        this.total = res.numbers; // 总个数
      },
      async showEditDialog(id){

        const {data:res} = await this.$http.get("getUpdate?id="+id);
        // if (res != "success") {
        // userinfo.state = !userinfo.state;
        // return this.$message.error("操作失败！！！");
        // }
        // this.$message.success("操作成功！！！");

        this.editForm = res;
        this.editDialogVisible = true;
      },
    },


}
</script>

<style scoped>

.el-table{

}
</style>