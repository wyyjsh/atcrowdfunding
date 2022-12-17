// 生成树形结构的函数
function generateTree() {
    // 1.准备要生成树形结构的JSON数据,数据的来源是发送Ajax请求
    $.ajax({
        "url": "menu/get/whole/tree.json",
        "type": "post",
        "dataType": "json",
        "success": function (response) {
            var result = response.result;
            if (result == "SUCCESS") {

                // 2.创建JSON对象用于存储对zTree所作的设置
                var setting = {
                    "view": {
                        "addDiyDom": myAddDiyDom,
                        "addHoverDom": myAddHoverDom,
                        "removeHoverDom": myRemoveHoverDom
                    },
                    "data": {
                        "key": {
                            "url": "maomi"
                        }
                    }
                };

                // 3.从响应体里获取用来生成树形结构的JSON数据
                var zNodes = response.data;

                // 4.初始化树形结构
                $.fn.zTree.init($("#treeDemo"), setting, zNodes);
            }

            if (result == "FAILED") {
                layer.msg(response.message);
            }
        }

    });
}

// 在鼠标移出节点范围时删除按钮组
function myRemoveHoverDom(treeId, treeNode) {

    // 拼接按钮组的id
    var btnGroupId = treeNode.tId + "_btnGrp";

    // 移除对应的元素
    $("#" + btnGroupId).remove();

}

// 在鼠标移入节点范围时添加按钮组
function myAddHoverDom(treeId, treeNode) {
    // 为了在需要移除按钮组的时候能够精确定位到按钮组所在的span,需要给span设置有规律的id
    var btnGroupId = treeNode.tId + "_btnGrp";

    // 按钮组的标签结构:  <span><a><i></i></a><a><i></i></a></span>
    // 按钮出现的位置: 节点中treeDemo_n_a超链接后面
    var tId = treeNode.tId + "_a";

    //判断之前是否已经添加了按钮组
    if ($("#" + btnGroupId).length > 0) {
        return;
    }

    // 准备各个按钮的html标签
    var addBtn = "<a id='" + treeNode.id + "' class='addBtn btn btn-info dropdown-toggle btn-xs' style='margin-left:10px;padding-top:0px;' href='#' title='添加子节点'>&nbsp;&nbsp;<i class='fa fa-fw fa-plus rbg'></i></a>";
    var removeBtn = "<a id='" + treeNode.id + "' class='removeBtn btn btn-info dropdown-toggle btn-xs' style='margin-left:10px;padding-top:0px;' href='#' title=' 删 除 节 点 '>&nbsp;&nbsp;<i class='fa fa-fw fa-times rbg'></i></a>";
    var editBtn = "<a id='" + treeNode.id + "' class='editBtn btn btn-info dropdown-toggle btn-xs' style='margin-left:10px;padding-top:0px;' href='#' title=' 修 改 节 点 '>&nbsp;&nbsp;<i class='fa fa-fw fa-edit rbg'></i></a>";

    // 获取当前节点的级别数据
    var level = treeNode.level;

    // 声名变量存储拼装好的按钮代码
    var btnHTML = "";

    // 判断该节点的级别
    if (level == 0) {
        //级别为0时是根节点,只能添加子节点
        btnHTML = addBtn;
    }

    //级别为1时,可以添加和修改
    if (level == 1) {
        btnHTML = addBtn + " " + editBtn;
        // 获取当前子节点的数量
        var length = treeNode.children.length;

        // 如果没有子节点可以删除
        if (length == 0) {
            btnHTML = btnHTML + " " + removeBtn;
        }

    }

    // 级别为2时,可以修改删除
    if (level == 2) {
        btnHTML = editBtn + " " + removeBtn;
    }

    // 执行超链接后面附加span元素的操作
    $("#" + tId).after("<span id='" + btnGroupId + "'>" + btnHTML + "</span>");

}

//修改默认的图标
function myAddDiyDom(treeId, treeNode) {

    // treeId是整个树形结构附着的ul的id
    console.log("treeId=", treeId);

    // treeNode当前树节点的全部数据,包括后端查到的Menu对象的全部属性
    console.log(treeNode);

    // zTree生成id的规则
    // 例子: treeDemo_7_ico
    // 解析: ul标签的id_当前节点的序号_功能
    // 提示: "ul标签的id_当前节点的序号_功能"可以通过访问tNode的tId属性得到
    var spanId = treeNode.tId + "_ico";

    // 根据控制标签的id找到这个span标签
    // 删除旧的class
    // 添加新的class

    $("#" + spanId).removeClass().addClass(treeNode.icon);


}