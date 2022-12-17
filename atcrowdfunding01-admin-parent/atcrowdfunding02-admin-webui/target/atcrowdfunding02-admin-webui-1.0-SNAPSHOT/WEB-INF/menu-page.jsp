<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<%@include file="/WEB-INF/include-head.jsp" %>
<link rel="stylesheet" href="ztree/zTreeStyle.css">
<script type="text/javascript" src="ztree/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript" src="crowd/my-menu.js"></script>
<script type="text/javascript">
    $(function () {

        generateTree();

        // 给添加子节点设置绑定单击响应函数
        $("#treeDemo").on("click", ".addBtn", function () {

            // 将当前节点的id保存为新的节点的pid
            window.pid = this.id;
            $("#menuAddModal").modal("show");

            return false;
        });

        // 给添加子节点的模态框里的保存按钮添加单击相应函数
        $("#menuSaveBtn").click(function () {

            // 收集表单项中用户手机的数据
            var name = $.trim($("#menuAddModal [name=name]").val());
            var url = $.trim($("#menuAddModal [name=url]").val());

            // 单选按钮要定位到被选中的那一个
            var icon = $("#menuAddModal [name=icon]:checked").val();

            $.ajax({
                "url": "menu/save.json",
                "type": "post",
                "data": {
                    "pid": window.pid,
                    "name": name,
                    "url": url,
                    "icon": icon
                },
                "dataType": "json",
                "success": function (response) {

                    var result = response.result;

                    if (result == "SUCCESS") {
                        layer.msg("操作成功!");

                        // 重新生成树形结构 注意:在确认服务器端完成保存操作后再刷新
                        // 否则有可能导致用户无法获取到最新的数据
                        generateTree();
                    }

                    if (result == "FAILED") {
                        Layer.msg("操作失败!" + response.message);
                    }

                },
                "error": function (response) {
                    layer.msg(response.status + " " + response.statusText)
                }

            });

            // 关闭模态框
            $("#menuAddModal").modal("hide");


            // 清空表单
            // jQuery对象调用click()函数,里面不传任何参数,相当于用户点击了一下
            $("#menuResetBtn").click();

        });
        // 给编辑按钮设置绑定单击响应函数
        $("#treeDemo").on("click", ".editBtn", function () {

            //打开模态框
            $("#menuEditModal").modal("show");

            // 将当前节点的id保存为新的节点的id
            window.id = this.id;

            // 获取zTreeObj对象
            var zTreeObj = $.fn.zTree.getZTreeObj("treeDemo");

            // 根据id属性获取treeNode对象
            //用来搜索节点的属性名
            var key = "id";

            //用来搜索节点的属性值
            var value = window.id;

            var currentNode = zTreeObj.getNodeByParam(key, value);

            // 回显表单数据
            $("#menuEditModal [name=name]").val(currentNode.name);
            $("#menuEditModal [name=url]").val(currentNode.url);

            // 回显ridio的可以这么理解:被选中的radio的value属性可以组成一个数组,然后再用这个值设置回radio,就能够把值选中
            $("#menuEditModal [name=icon]").val([currentNode.icon]);

            return false;
        });

        // 给编辑按钮的模态框里的更新按钮添加单击相应函数
        $("#menuEditBtn").click(function () {

            // 收集表单项中用户手机的数据
            var name = $.trim($("#menuEditModal [name=name]").val());
            var url = $.trim($("#menuEditModal [name=url]").val());

            // 单选按钮要定位到被选中的那一个
            var icon = $("#menuEditModal [name=icon]:checked").val();

            $.ajax({
                "url": "menu/update.json",
                "type": "post",
                "data": {
                    "id": window.id,
                    "name": name,
                    "url": url,
                    "icon": icon
                },
                "dataType": "json",
                "success": function (response) {

                    var result = response.result;

                    if (result == "SUCCESS") {
                        layer.msg("操作成功!");

                        // 重新生成树形结构 注意:在确认服务器端完成保存操作后再刷新
                        // 否则有可能导致用户无法获取到最新的数据
                        generateTree();
                    }

                    if (result == "FAILED") {
                        Layer.msg("操作失败!" + response.message);
                    }

                },
                "error": function (response) {
                    layer.msg(response.status + " " + response.statusText)
                }

            });

            // 关闭模态框
            $("#menuEditModal").modal("hide");

        });

        // 给删除按钮绑定单击响应函数
        $("#treeDemo").on("click", ".removeBtn", function () {

            //打开模态框
            $("#menuConfirmModal").modal("show");

            // 将当前节点的id保存为新的节点的id
            window.id = this.id;

            // 获取zTreeObj对象
            var zTreeObj = $.fn.zTree.getZTreeObj("treeDemo");

            // 根据id属性获取treeNode对象
            //用来搜索节点的属性名
            var key = "id";

            //用来搜索节点的属性值
            var value = window.id;

            var currentNode = zTreeObj.getNodeByParam(key, value);

            // 回显表单数据
            $("#removeNodeSpan").html("{ <i class='" + currentNode.icon + "'></i>" + currentNode.name + " }");

            return false;


        });

        // 给确认模态框的中的ok按钮绑定单击响应函数
        $("#confirmBtn").click(function () {

            $.ajax({
                "url": "menu/remove.json",
                "type": "post",
                "data": {
                    "id": window.id,
                },
                "dataType": "json",
                "success": function (response) {

                    var result = response.result;

                    if (result == "SUCCESS") {
                        layer.msg("操作成功!");

                        // 重新生成树形结构 注意:在确认服务器端完成保存操作后再刷新
                        // 否则有可能导致用户无法获取到最新的数据
                        generateTree();
                    }

                    if (result == "FAILED") {
                        Layer.msg("操作失败!" + response.message);
                    }

                },
                "error": function (response) {
                    layer.msg(response.status + " " + response.statusText)
                }
            })

            // 关闭模态框
            $("#menuConfirmModal").modal("hide");

        });

    });
    // console.log(zNodes);
    // console.log("13465");

</script>
<body>
<%@ include file="/WEB-INF/include-nav.jsp" %>
<div class="container-fluid">
    <div class="row">
        <%@ include file="/WEB-INF/include-sidebar.jsp" %>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading"><i class="glyphicon glyphicon-th-list"></i> 权限菜单列表
                    <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i
                            class="glyphicon glyphicon-question-sign"></i></div>
                </div>
                <div class="panel-body">
                    <ul id="treeDemo" class="ztree">
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="modal-menu-add.jsp" %>
<%@ include file="modal-menu-edit.jsp" %>
<%@ include file="modal-menu-confirm.jsp" %>

</body>

</html>