<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>问题来源</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/easyui/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/easyui/demo/demo.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/easyui/themes/color.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/common/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/common/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/common/easyui/easyloader.js"></script>

    <style type="text/css">
        #fm{
            margin:0;
            padding:10px 30px;
        }
        .ftitle{
            font-size:14px;
            font-weight:bold;
            padding:5px 0;
            margin-bottom:10px;
            border-bottom:1px solid #ccc;
        }
        .fitem{
            margin-bottom:5px;
        }
        .fitem label{
            display:inline-block;
            width:80px;
        }
        .fitem input{
            width:160px;
        }
    </style>

    <script type="text/javascript">
        var url;
        function newType(){
            $('#dlg').dialog('open').dialog('setTitle','添加来源');
            $('#fm').form('clear');
            url = '${pageContext.request.contextPath}/que/saveOrUpdateType.action';
        }
        function editType(){
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $('#dlg').dialog('open').dialog('setTitle','编辑来源');
                $('#fm').form('load',row);
                url = '${pageContext.request.contextPath}/que/saveOrUpdateType.action';
            }
        }
        function saveType(){
            $('#fm').form('submit',{
                url: url,
                onSubmit: function(){
                    return $(this).form('validate');
                },
                success: function(result){
                    $('#dlg').dialog('close');
                    dataLoads();
                }
            });
        }
        function destroyType(){
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $.messager.confirm('提示框','确定删除此记录吗?',function(r){
                    if (r){

                        $.ajax({
                            url:"${pageContext.request.contextPath}/que/deleteTypeById.action",
                            data:{id:row.id},
                            success:function(data){
                                dataLoads();
                            },
                            error:function(){
                                dataLoads();
                            }
                        });
                    }
                });
            }
        }
    </script>


    <script type="text/javascript">
        $(function(){
            dataLoads();
        });

        function dataLoads(){
            $.ajax({
                url:"${pageContext.request.contextPath}/que/findTypeList.action",
                dataType:"json",
                success:function(data){
                    $('#dg').datagrid({
                        data:data.map

                    })
                }
            });
        }
    </script>

</head>
<body>
<h2>来源管理</h2>
<p></p>

<table id="dg" title="来源列表" class="easyui-datagrid" style="width:900px;height:400px" toolbar="#toolbar" pagination="true"
       rownumbers="true" fitColumns="true" singleSelect="true">
    <thead>
    <tr>
        <th field="id" width="50" align="center">来源ID</th>
        <th field="name" width="50" align="center">来源类型</th>
    </tr>
    </thead>
</table>
<%--<div id="pp" class="easyui-pagination" style="background:#efefef;border:1px solid #ccc;"
     data-options="total:2000,pageSize:10">
</div>--%>
<div id="toolbar">
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newType()">添加来源</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editType()">编辑来源</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyType()">删除来源</a>
</div>

<div id="dlg" class="easyui-dialog" style="width:400px;height:200px;padding:10px 20px" closed="true" buttons="#dlg-buttons">
    <div class="ftitle">来源信息</div>
    <form id="fm" method="post" name="type">
        <div class="fitem" style="display: none;">
            <label>来源ID:</label>
            <input name="id" class="easyui-textbox">
        </div>
        <div class="fitem">
            <label>来源类型:</label>
            <input name="name" class="easyui-textbox">
        </div>
    </form>
</div>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveType()" style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')" style="width:90px">取消</a>
</div>
</body>
</html>