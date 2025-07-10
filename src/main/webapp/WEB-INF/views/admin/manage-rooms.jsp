<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>会议室管理 - 管理员面板</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
<jsp:include page="../header.jsp" />
<div class="admin-container">
    <jsp:include page="admin-nav.jsp" />
    <div class="admin-content">
        <div class="content-header">
            <h2>会议室资源管理</h2>
            <a href="${pageContext.request.contextPath}/admin?action=addRoomForm" class="btn btn-approve">新增会议室</a>
        </div>

        <c:if test="${param.message == 'saved'}"><div class="message success">会议室信息已保存。</div></c:if>
        <c:if test="${param.message == 'deleted'}"><div class="message success">会议室已删除。</div></c:if>

        <table>
            <thead>
            <tr>
                <th>会议室名称</th>
                <th>位置</th>
                <th>容量</th>
                <th>设施</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="room" items="${rooms}">
                <tr>
                    <td><c:out value="${room.roomName}"/></td>
                    <td><c:out value="${room.location.locationName}"/></td>
                    <td><c:out value="${room.capacity}"/></td>
                    <td><c:out value="${room.amenities}"/></td>
                    <td class="actions">
                        <a href="${pageContext.request.contextPath}/admin?action=editRoomForm&roomId=${room.roomId}" class="btn btn-edit">编辑</a>
                        <form action="${pageContext.request.contextPath}/admin" method="post" style="display:inline;" onsubmit="return confirm('确定要删除这个会议室吗？所有相关预约也将被删除！')">
                            <input type="hidden" name="action" value="deleteRoom">
                            <input type="hidden" name="roomId" value="${room.roomId}">
                            <button type="submit" class="btn btn-reject">删除</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>