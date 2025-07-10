<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>预约会议室 - 会议室预约系统</title>
    <style>
        body {
            font-family: "Segoe UI", sans-serif;
            margin: 0;
            background: linear-gradient(to right, #e0eafc, #cfdef3);
            backdrop-filter: blur(3px);
        }
        .container {
            padding: 30px;
            max-width: 1000px;
            margin: 50px auto;
            background: rgba(255, 255, 255, 0.85);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
            animation: fadeIn 1s ease-in-out;
        }
        h2, h3 {
            color: #2c3e50;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
        }
        .search-form, .booking-form {
            background: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .search-form:hover, .booking-form:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 24px rgba(0,0,0,0.15);
        }
        .form-group {
            margin-bottom: 20px;
            display: flex;
            align-items: flex-start;
        }
        .form-group label {
            width: 100px;
            font-weight: bold;
            padding-top: 10px;
            color: #34495e;
        }
        .form-group input, .form-group select, .form-group textarea {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            flex-grow: 1;
            transition: box-shadow 0.3s;
        }
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
            box-shadow: 0 0 5px rgba(0,123,255,0.5);
            border-color: #007bff;
        }
        .btn {
            padding: 12px 18px;
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: #fff;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 15px;
            transition: background 0.3s, transform 0.2s;
        }
        .btn:hover {
            background: linear-gradient(135deg, #0056b3, #004080);
            transform: scale(1.05);
        }
        .error {
            color: #721c24;
            background: rgba(248, 215, 218, 0.85);
            border: 1px solid #f5c6cb;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            animation: shake 0.3s ease-in-out;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: rgba(255,255,255,0.95);
            border-radius: 12px;
            overflow: hidden;
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
            color: #333;
        }
        tr:hover {
            background-color: #eef5ff;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes shake {
            0% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            50% { transform: translateX(5px); }
            75% { transform: translateX(-5px); }
            100% { transform: translateX(0); }
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp" />
<div class="container">
    <h2>查找并预约会议室</h2>

    <c:if test="${not empty error}"><div class="error">${error}</div></c:if>

    <div class="search-form">
        <form action="${pageContext.request.contextPath}/booking" method="get">
            <input type="hidden" name="action" value="search">
            <div class="form-group">
                <label for="startTime">开始时间:</label>
                <input type="datetime-local" id="startTime" name="startTime" value="${startTime}" required>
            </div>
            <div class="form-group">
                <label for="endTime">结束时间:</label>
                <input type="datetime-local" id="endTime" name="endTime" value="${endTime}" required>
            </div>
            <div class="form-group">
                <label></label>
                <button type="submit" class="btn">查询可用会议室</button>
            </div>
        </form>
    </div>

    <c:if test="${not empty availableRooms}">
        <h3>查询结果：可用会议室列表</h3>
        <p>请选择一个会议室，并填写信息以完成预约。</p>

        <form class="booking-form" action="${pageContext.request.contextPath}/booking" method="post">
            <input type="hidden" name="startTime" value="${startTime}">
            <input type="hidden" name="endTime" value="${endTime}">

            <div class="form-group">
                <label for="roomId">选择会议室:</label>
                <select id="roomId" name="roomId" required>
                    <c:forEach var="room" items="${availableRooms}">
                        <option value="${room.roomId}">${room.roomName} (${room.location.locationName}, 容量: ${room.capacity})</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label for="title">会议主题:</label>
                <input type="text" id="title" name="title" required>
            </div>
            <div class="form-group">
                <label for="attendees">添加参会人:</label>
                <select id="attendees" name="attendees" multiple size="5">
                    <c:forEach var="employee" items="${employees}">
                        <c:if test="${employee.userId != sessionScope.user.userId}">
                            <option value="${employee.userId}">${employee.fullName}</option>
                        </c:if>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label for="notes">备注:</label>
                <textarea id="notes" name="notes" rows="3"></textarea>
            </div>
            <div class="form-group">
                <label></label>
                <button type="submit" class="btn">提交预约申请</button>
            </div>
        </form>
    </c:if>

    <c:if test="${empty availableRooms and not empty startTime and empty error}">
        <p>抱歉，您选择的时间段内没有可用的会议室。</p>
    </c:if>
</div>
</body>
</html>
