<%--
  Created by IntelliJ IDEA.
  User: 17588
  Date: 2022/11/16
  Time: 1:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Title</title>
<%--    http://localhost:8080/atcrowdfunding02_admin_webui_war/test/ssm.html--%>
    <base href="http://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/"/>
    <script type="text/javascript" src="jquery/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="layer/layer.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#btn1").click(function () {
                $.ajax({
                    "url":"send/array/one.html",    //请求目标资源的地址
                    "type":"post",              //请求方式
                    "data":{
                        "array":[5,8,12]
                    },            //要发送的请求参数
                    "dataType":"text",          //如何对待服务器返回的数据
                    "success":function (response) {     //服务器处理请求成功后调用的回调函数
                        alert("success");

                    },
                    "error": function (response) {      //服务器处理请求失败后调用的回调函数
                        alert("error");
                    }
                })
            })
        })
        $(function () {
            $("#btn2").click(function () {
                $.ajax({
                    "url":"send/array/two.html",    //请求目标资源的地址
                    "type":"post",              //请求方式
                    "data":{
                        "array[0]":5,
                        "array[1]":8,
                        "array[2]":12
                    },            //要发送的请求参数
                    "dataType":"text",          //如何对待服务器返回的数据
                    "success":function (response) {     //服务器处理请求成功后调用的回调函数
                        alert("success");
                    },
                    "error": function (response) {      //服务器处理请求失败后调用的回调函数
                        alert("error");
                    }
                })
            })
        })
        $(function () {
            $("#btn3").click(function () {

                //准备好要发送到服务器端的数组
                var array = [5,8,12];
                console.log(array.length);

                //将JSON数组转换为JSON字符串
                var requestBody = JSON.stringify(array);
                console.log(requestBody.length);

                $.ajax({
                    "url":"send/array/three.html",    //请求目标资源的地址
                    "type":"post",              //请求方式
                    "data": requestBody,            //要发送的请求参数
                    "contentType":"application/json;charset=UTF-8", //设置请求体的内容类型
                    "dataType":"text",          //如何对待服务器返回的数据
                    "success":function (response) {     //服务器处理请求成功后调用的回调函数

                        alert("success");
                    },
                    "error": function (response) {      //服务器处理请求失败后调用的回调函数
                        alert("error");
                    }
                })
            })
        })
        $(function () {
            $("#btn4").click(function () {
                var student = {
                    "stuId": 5,
                    "stuName":"tom",
                    "address":{
                        "province":"广东",
                        "city": "深圳",
                        "street": "后端"
                    },
                    "subjectList": [
                        {
                            "subjectName":  "JavaSE",
                            "subjectScore": "99"
                        },{
                            "subjectName":  "SSM",
                            "subjectScore": "100"
                        }
                    ],
                    "map":  {
                        "k1":"v1",
                        "k2":"v2"
                    }
                };

                //将JSON对象转化为JSON字符串
                var requestBody = JSON.stringify(student);

                //发送Ajax请求
                $.ajax({
                    "url":  "send/compose/object.json",
                    "type": "post",
                    "data": requestBody,
                    "contentType":  "application/json;charset=UTF-8",
                    "dataType": "json",
                    "success":   function(response) {
                        console.log(response);
                    },
                    "error":    function (response) {
                        console.log(response);

                    }
                })
            });
        });
        $(function () {
            $("#btn5").click(function () {
                layer.msg("Layer的弹框!")
            });
        });
    </script>
</head>
<body>
    <a href="test/ssm.html">测试SSM整合环境</a>
    <br>

    <button id="btn1">Send [5,8,10] One</button>
    <br>
    <button id="btn2">Send [5,8,10] Two</button>
    <br>

    <button id="btn3">Send [5,8,10] Three</button>
    <br>

    <button id="btn4">Send compose Object</button>
    <br>

    <button id="btn5">点我弹框!</button>
    <br>

</body>
</html>
