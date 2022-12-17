<%--
  Created by IntelliJ IDEA.
  User: 17588
  Date: 2022/11/25
  Time: 9:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<div id="editModal" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">尚筹网系统弹窗</h4>
            </div>
            <div class="modal-body">
                <form action="admin/save.html" method="post" role="form">
                    <div class="form-group">
                        <label for="exampleInputLoginAcct1">角色名称</label>
                        <input type="text" name="roleName" class="form-control" id="exampleInputLoginAcct1" placeholder="请输入角色名称">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button id="updateRoleBtn" type="button" class="btn btn-primary">更新</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
