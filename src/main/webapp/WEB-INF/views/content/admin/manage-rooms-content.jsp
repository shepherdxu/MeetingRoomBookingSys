<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>会议室资源管理</title>
    <!-- 引入 Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- 引入 Inter 字体 -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f4f7f6; /* Light background for the page */
            position: relative; /* Needed for halo effect z-index */
            overflow-x: hidden; /* Prevent horizontal scroll from halo */
        }
        /* Custom styles for rounded corners on table */
        .table-container {
            border-radius: 0.5rem; /* Equivalent to rounded-lg */
            overflow: hidden; /* Ensures child elements respect border-radius */
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06); /* Shadow for the table container */
        }

        /* Background Halo Effect */
        #halo-effect-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: -1; /* Ensure it stays behind all content */
            pointer-events: none; /* Allow clicks to pass through */
            opacity: 0.6; /* Subtle effect */
        }

        .halo-blob {
            position: absolute;
            border-radius: 50%;
            filter: blur(100px); /* Adjust blur for desired glow */
            opacity: 0.4; /* Individual blob opacity */
            animation: floatAndGlow 20s infinite ease-in-out alternate; /* Animation for movement */
        }

        /* Define individual blob styles and animations */
        .halo-blob-1 {
            background-color: #a7d9ff; /* Light blue */
            width: 300px;
            height: 300px;
            top: 10%;
            left: 5%;
            animation-duration: 25s;
            animation-delay: 0s;
        }

        .halo-blob-2 {
            background-color: #c9a7ff; /* Light purple */
            width: 400px;
            height: 400px;
            top: 60%;
            left: 70%;
            animation-duration: 30s;
            animation-delay: 5s;
        }

        .halo-blob-3 {
            background-color: #a7ffe0; /* Light green/cyan */
            width: 350px;
            height: 350px;
            top: 40%;
            left: 20%;
            animation-duration: 22s;
            animation-delay: 10s;
        }

        .halo-blob-4 {
            background-color: #ffc2a7; /* Light orange */
            width: 250px;
            height: 250px;
            top: 5%;
            left: 80%;
            animation-duration: 28s;
            animation-delay: 2s;
        }

        .halo-blob-5 {
            background-color: #ffb7e6; /* Light pink */
            width: 320px;
            height: 320px;
            top: 70%;
            left: 10%;
            animation-duration: 26s;
            animation-delay: 7s;
        }

        @keyframes floatAndGlow {
            0% {
                transform: translate(0, 0) scale(1);
            }
            25% {
                transform: translate(10%, 20%) scale(1.05);
            }
            50% {
                transform: translate(-15%, 30%) scale(0.95);
            }
            75% {
                transform: translate(20%, -10%) scale(1.1);
            }
            100% {
                transform: translate(0, 0) scale(1);
            }
        }

        /* Enhanced button styles */
        .btn-primary-enhanced {
            background-color: #1890ff;
            color: white;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(24, 144, 255, 0.2);
        }
        .btn-primary-enhanced:hover {
            background-color: #40a9ff;
            transform: translateY(-2px) scale(1.02);
            box-shadow: 0 8px 15px rgba(24, 144, 255, 0.3);
        }

        /* Enhanced input/select focus styles */
        input[type="text"]:focus,
        select:focus {
            border-color: #1890ff;
            box-shadow: 0 0 0 3px rgba(24, 144, 255, 0.2);
        }

        /* Enhanced card hover effect */
        .stat-card-enhanced {
            transition: all 0.3s ease;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);
            border: 1px solid #f0f0f0;
        }
        .stat-card-enhanced:hover {
            box-shadow: 0 8px 20px rgba(24, 144, 255, 0.15);
            transform: translateY(-5px);
        }

        /* Enhanced table row hover effect */
        .table-row-hover:hover {
            background-color: #f5f7fa;
            transform: scale(1.005);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        /* Confirmation dialog button styles */
        .dialog-btn {
            transition: all 0.2s ease-in-out;
        }
        .dialog-btn-cancel:hover {
            background-color: #e0e0e0;
            transform: translateY(-1px);
        }
        .dialog-btn-confirm:hover {
            background-color: #c53030;
            transform: translateY(-1px);
        }
    </style>
</head>
<body class="p-4 md:p-8 lg:p-12">
<!-- Background Halo Effect Container -->
<div id="halo-effect-container">
    <div class="halo-blob halo-blob-1"></div>
    <div class="halo-blob halo-blob-2"></div>
    <div class="halo-blob halo-blob-3"></div>
    <div class="halo-blob halo-blob-4"></div>
    <div class="halo-blob halo-blob-5"></div>
</div>

<div class="bg-white p-6 md:p-8 rounded-lg shadow-xl max-w-6xl mx-auto relative z-0">
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-6">
        <h2 class="text-2xl md:text-3xl font-extrabold text-gray-800 mb-4 md:mb-0">会议室资源管理</h2>
        <a href="${pageContext.request.contextPath}/admin?action=addRoomForm" class="btn-primary-enhanced font-bold py-2 px-4 rounded-lg transform hover:scale-105 shadow-md">新增会议室</a>
    </div>



    <!-- 消息提示区域 -->
    <c:if test="${param.message == 'saved'}">
        <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded-lg relative mb-6" role="alert">
            会议室信息已保存。
        </div>
    </c:if>
    <c:if test="${param.message == 'deleted'}">
        <div class="bg-yellow-100 border border-yellow-400 text-yellow-700 px-4 py-3 rounded-lg relative mb-6" role="alert">
            会议室已删除。
        </div>
    </c:if>

    <!-- 统计信息区域 -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <div class="bg-blue-50 p-6 rounded-lg shadow-md flex flex-col justify-between stat-card-enhanced">
            <h3 class="text-xl font-semibold text-blue-800 mb-2">总容纳人数</h3>
            <p class="text-4xl font-bold text-blue-600 mt-auto">${totalCapacity}</p>
        </div>
        <div class="bg-green-50 p-6 rounded-lg shadow-md flex flex-col justify-between stat-card-enhanced">
            <h3 class="text-xl font-semibold text-green-800 mb-2">总会议室数量</h3>
            <p class="text-4xl font-bold text-green-600 mt-auto">${fn:length(rooms)}</p>
        </div>
        <div class="bg-purple-50 p-6 rounded-lg shadow-md flex flex-col justify-between stat-card-enhanced">
            <h3 class="text-xl font-semibold text-purple-800 mb-2">总设施数量</h3>
            <%-- The totalAmenitiesCount is now passed directly from the backend --%>
            <p id="totalAmenitiesCount" class="text-4xl font-bold text-purple-600 mt-auto">${totalAmenities}</p>
        </div>
    </div>

    <!-- 会议室列表区域 -->
    <div class="overflow-x-auto table-container">
        <table class="min-w-full text-sm text-left text-gray-600">
            <thead class="text-xs text-gray-700 uppercase bg-gray-100">
            <tr>
                <th scope="col" class="px-6 py-3">会议室名称</th>
                <th scope="col" class="px-6 py-3">位置</th>
                <th scope="col" class="px-6 py-3">容量</th>
                <th scope="col" class="px-6 py-3">设施</th>
                <th scope="col" class="px-6 py-3 text-center">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="room" items="${rooms}">
                <tr class="bg-white border-b hover:bg-gray-50 transition duration-150 ease-in-out table-row-hover">
                    <td class="px-6 py-4 font-medium text-gray-900">${room.roomName}</td>
                    <td class="px-6 py-4">${room.location.locationName}</td>
                    <td class="px-6 py-4">${room.capacity}</td>
                    <td class="px-6 py-4">
                        <!-- Display amenities nicely, perhaps with commas -->
                            ${fn:replace(room.amenities, ',', ', ')}
                    </td>
                    <td class="px-6 py-4 text-center space-x-2">
                        <a href="${pageContext.request.contextPath}/admin?action=editRoomForm&roomId=${room.roomId}" class="font-medium text-blue-600 hover:text-blue-800 hover:underline transition duration-150 ease-in-out">编辑</a>
                        <span class="text-gray-300">|</span>
                        <form action="${pageContext.request.contextPath}/admin" method="post" class="inline" onsubmit="return showConfirmDialog(event, '${room.roomName}')">
                            <input type="hidden" name="action" value="deleteRoom">
                            <input type="hidden" name="roomId" value="${room.roomId}">
                            <button type="submit" class="font-medium text-red-600 hover:text-red-800 hover:underline transition duration-150 ease-in-out">删除</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            <!-- 如果会议室列表为空，显示提示信息 -->
            <c:if test="${empty rooms}">
                <tr>
                    <td colspan="5" class="text-center py-10 text-gray-500">暂无会议室数据。</td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>

<!-- 自定义确认对话框 -->
<div id="confirmDialog" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center z-50 hidden">
    <div class="bg-white p-6 rounded-lg shadow-xl max-w-sm w-full">
        <h3 class="text-lg font-semibold mb-4 text-gray-800">确认删除</h3>
        <p id="confirmMessage" class="mb-6 text-gray-700"></p>
        <div class="flex justify-end space-x-3">
            <button id="cancelDelete" class="px-4 py-2 bg-gray-200 text-gray-800 rounded-lg hover:bg-gray-300 transition duration-150 ease-in-out dialog-btn dialog-btn-cancel">取消</button>
            <button id="confirmDelete" class="px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 transition duration-150 ease-in-out dialog-btn dialog-btn-confirm">删除</button>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // --- Custom Confirmation Dialog Logic ---
        const confirmDialog = document.getElementById('confirmDialog');
        const confirmMessage = document.getElementById('confirmMessage');
        const cancelDeleteButton = document.getElementById('cancelDelete');
        const confirmDeleteButton = document.getElementById('confirmDelete');
        let currentForm = null; // To store the form that triggered the dialog

        window.showConfirmDialog = function(event, roomName) {
            event.preventDefault(); // Prevent the default form submission
            currentForm = event.target; // Store the current form

            confirmMessage.textContent = `确定要删除会议室“${roomName}”吗？所有相关预约也将被删除！`;
            confirmDialog.classList.remove('hidden'); // Show the dialog

            return false; // Prevent default form submission
        };

        cancelDeleteButton.addEventListener('click', function() {
            confirmDialog.classList.add('hidden'); // Hide the dialog
            currentForm = null; // Clear the stored form
        });

        confirmDeleteButton.addEventListener('click', function() {
            if (currentForm) {
                confirmDialog.classList.add('hidden'); // Hide the dialog
                currentForm.submit(); // Submit the form programmatically
            }
        });
    });
</script>
</body>
</html>
