
<%--    Copyright 2025, The Ningxia University, Ningxia, China. @KyochiLian All rights reserved.--%>
<%--    This project is licensed under the Apache License, Version 2.0, see LICENSE for details.--%>
<%--    @Author: KyochiLian--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>我的预约 - 会议室预约系统</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background-color: #f9f9f9; }
        .container { padding: 20px; max-width: 1000px; margin: auto; }
        h2 { color: #333; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; background-color: #fff; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        th, td { padding: 12px 15px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #f2f2f2; }
        tr:hover { background-color: #f5f5f5; }
        .status-confirmed { color: green; font-weight: bold; }
        .status-cancelled { color: red; text-decoration: line-through; }
        .status-pending { color: orange; }
        .action-link { color: #007bff; text-decoration: none; cursor: pointer; }
        .action-link:hover { text-decoration: underline; }
        .message { padding: 10px; margin-bottom: 15px; border-radius: 4px; }
        .message.success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .message.error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }

        /* Modal styles */
        .modal { display: none; position: fixed; z-index: 9999; left: 0; top: 0; width: 100%; height: 100%; overflow: auto;
            background-color: rgba(0,0,0,0.4); }
        .modal-content { background-color: #fff; margin: 15% auto; padding: 20px; border: 1px solid #888;
            width: 400px; border-radius: 8px; box-shadow: 0 5px 15px rgba(0,0,0,0.3); text-align: center; }
        .modal-buttons { margin-top: 20px; }
        .modal-buttons button { padding: 8px 16px; margin: 0 10px; border: none; border-radius: 4px; cursor: pointer; }
        .btn-cancel { background-color: #dc3545; color: white; }
        .btn-confirm { background-color: #28a745; color: white; }
    </style>
    <script>
        function confirmCancel(bookingId) {
            const modal = document.getElementById("cancelModal");
            const confirmBtn = document.getElementById("confirmCancelBtn");
            confirmBtn.onclick = function () {
                window.location.href = '${pageContext.request.contextPath}/booking?action=cancel&bookingId=' + bookingId;
            };
            modal.style.display = "block";
        }

        function closeModal() {
            document.getElementById("cancelModal").style.display = "none";
        }
    </script>
</head>
<body>
<jsp:include page="header.jsp" />
<div class="container">
    <h2>我的预约记录</h2>

    <c:if test="${param.message == 'booking_success'}">
        <div class="message success">恭喜！会议室预约成功。</div>
    </c:if>
    <c:if test="${param.message == 'cancel_success'}">
        <div class="message success">预约已成功取消。</div>
    </c:if>

    <table>
        <thead>
        <tr>
            <th>会议主题</th>
            <th>会议室</th>
            <th>开始时间</th>
            <th>结束时间</th>
            <th>状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="booking" items="${myBookings}">
            <tr>
                <td><c:out value="${booking.title}"/></td>
                <td><c:out value="${booking.room.roomName}"/></td>
                <td><fmt:formatDate value="${booking.startTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                <td><fmt:formatDate value="${booking.endTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                <td>
                    <span class="status-${booking.status}"><c:out value="${booking.status}"/></span>
                </td>
                <td>
                    <c:if test="${booking.status == 'confirmed' or booking.status == 'pending'}">
                        <span class="action-link" onclick="confirmCancel(${booking.bookingId})">取消</span>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty myBookings}">
            <tr>
                <td colspan="6" style="text-align: center;">您当前没有任何预约记录。</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>

<!-- Modal -->
<div id="cancelModal" class="modal">
    <div class="modal-content">
        <p>您确定要取消这个预约吗？</p>
        <div class="modal-buttons">
            <button class="btn-confirm" id="confirmCancelBtn">确定</button>
            <button class="btn-cancel" onclick="closeModal()">取消</button>
        </div>
    </div>
</div>
</body>
</html>
