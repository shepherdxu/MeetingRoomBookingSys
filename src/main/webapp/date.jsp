<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2025/7/8
  Time: 23:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8" />
    <title>会议预约系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="style.css" />
    <link rel="stylesheet" href="date.css" />
</head>
<body>
<div class="container">
    <!-- Main Content -->
    <main>
        <form id="bookingForm" autocomplete="off" action="/book" method="POST">
            <div class="left">
                <label for="dateInput">选择日期 *</label>
                <div id="datePicker">
                    <input type="text" id="dateInput" readonly placeholder="请选择日期" required />
                </div>
                <div>
                    <label for="startTime" class="block text-sm font-medium text-gray-700 mb-1">开始时间</label>
                    <input type="datetime-local" id="startTime" required   name="startTime"  value="${startTime}" readonly placeholder="请选择日期" required />
                </div>
                <div>
                    <label for="endTime" class="block text-sm font-medium text-gray-700 mb-1">结束时间</label>
                    <input type="datetime-local" id="endTime"   value="${endTime}"name="endTime"  readonly placeholder="请选择日期" required />
                </div>
                <label>选择时间 *</label>
                <div id="timeSlots"></div>

                <button type="submit">提交预约</button>
            </div>
        </form>
    </main>
</div>

<script src="script.js"></script>
<script src="date.js"></script>
</body>
</html>
