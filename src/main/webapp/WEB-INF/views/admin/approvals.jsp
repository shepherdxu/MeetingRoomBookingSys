<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>审批管理 - 管理员面板</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
<jsp:include page="../header.jsp" />
<div class="admin-container">
    <jsp:include page="admin-nav.jsp" />
    <div class="admin-content">
        <h2>待审批的预约</h2>
        <c:if test="${param.message == 'approved'}"><div class="message success">操作成功：预约已批准。</div></c:if>
        <c:if test="${param.message == 'rejected'}"><div class="message success">操作成功：预约已拒绝。</div></c:if>

        <table>
            <thead>
            <tr>
                <th>申请人</th>
                <th>会议主题</th>
                <th>会议室</th>
                <th>开始时间</th>
                <th>结束时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="booking" items="${pendingBookings}">
                <tr>
                    <td><c:out value="${booking.requester.fullName}"/></td>
                    <td><c:out value="${booking.title}"/></td>
                    <td><c:out value="${booking.room.roomName}"/></td>
                    <td><fmt:formatDate value="${booking.startTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td><fmt:formatDate value="${booking.endTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td class="actions">
                        <form action="${pageContext.request.contextPath}/admin" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="approve">
                            <input type="hidden" name="bookingId" value="${booking.bookingId}">
                            <button type="submit" class="btn btn-approve">批准</button>
                        </form>
                        <form action="${pageContext.request.contextPath}/admin" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="reject">
                            <input type="hidden" name="bookingId" value="${booking.bookingId}">
                            <button type="submit" class="btn btn-reject">拒绝</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty pendingBookings}">
                <tr>
                    <td colspan="6" style="text-align: center;">当前没有待审批的预约。</td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>