<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .header { background-color: #333; color: white; padding: 10px 20px; display: flex; justify-content: space-between; align-items: center; }
    .header .logo { font-size: 1.5em; font-weight: bold; }
    .header nav a { color: white; text-decoration: none; margin: 0 15px; }
    .header nav a:hover { text-decoration: underline; }
    .header .user-info { font-size: 0.9em; }
    .admin-link { background-color: #dc3545; padding: 5px 10px; border-radius: 4px; }
</style>
<div class="header">
    <div class="logo">会议室预约系统</div>
    <nav>
        <a href="${pageContext.request.contextPath}/dashboard">我的预约</a>
        <a href="${pageContext.request.contextPath}/booking">预约会议室</a>
        <c:if test="${sessionScope.user.role == 'admin'}">
            <a href="${pageContext.request.contextPath}/admin" class="admin-link">管理员面板</a>
        </c:if>
    </nav>
    <div class="user-info">
        <span>欢迎, ${sessionScope.user.fullName}！</span>
        <a href="${pageContext.request.contextPath}/logout">退出</a>
    </div>
</div>