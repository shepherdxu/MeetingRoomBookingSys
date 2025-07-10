<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>注册 - 会议室预约管理系统</title>
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

        /* Enhanced Register Card */
        .register-card-enhanced {
            transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .register-card-enhanced:hover {
            transform: translateY(-5px) scale(1.01);
            box-shadow: 0 15px 30px rgba(24, 144, 255, 0.2);
        }

        /* Input Field Focus Effect */
        input[type="text"]:focus,
        input[type="password"]:focus,
        select:focus {
            border-color: #10B981; /* Green border on focus */
            box-shadow: 0 0 0 4px rgba(16, 185, 129, 0.3); /* Green ring on focus */
            outline: none;
        }

        /* Register Button Hover Effect */
        .btn-register-enhanced {
            background-color: #10B981; /* green-600 */
            color: white;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(16, 185, 129, 0.2);
        }

        .btn-register-enhanced:hover {
            background-color: #059669; /* green-700 */
            transform: translateY(-2px) scale(1.01);
            box-shadow: 0 8px 20px rgba(16, 185, 129, 0.4);
        }

        /* Message Alerts */
        .alert {
            animation: fadeInOut 4s forwards;
            opacity: 0;
        }

        @keyframes fadeInOut {
            0% { opacity: 0; transform: translateY(-10px); }
            10% { opacity: 1; transform: translateY(0); }
            90% { opacity: 1; transform: translateY(0); }
            100% { opacity: 0; transform: translateY(-10px); }
        }

        /* Link Hover Effect */
        .link-enhanced {
            transition: all 0.2s ease;
        }
        .link-enhanced:hover {
            color: #60A5FA; /* Light blue */
            text-decoration: underline;
        }
    </style>
</head>
<body class="bg-gray-100 flex items-center justify-center h-screen">
<!-- Background Halo Effect Container -->
<div id="halo-effect-container">
    <div class="halo-blob halo-blob-1"></div>
    <div class="halo-blob halo-blob-2"></div>
    <div class="halo-blob halo-blob-3"></div>
    <div class="halo-blob halo-blob-4"></div>
    <div class="halo-blob halo-blob-5"></div>
</div>

<div class="w-full max-w-md relative z-0">
    <div class="bg-white shadow-lg rounded-xl p-8 register-card-enhanced">
        <h2 class="text-2xl font-bold text-center text-gray-800 mb-2">创建新账户</h2>
        <p class="text-center text-gray-500 mb-8">加入我们，开始高效协作</p>

        <c:if test="${not empty error}">
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-lg relative mb-4 alert" role="alert">
                <span class="block sm:inline">${error}</span>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="mb-4">
                <label for="fullName" class="block text-gray-700 text-sm font-bold mb-2">姓名</label>
                <input type="text" id="fullName" name="fullName" required class="shadow-sm appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:ring-2 focus:ring-blue-300">
            </div>
            <div class="mb-4">
                <label for="username" class="block text-gray-700 text-sm font-bold mb-2">用户名 / 工号</label>
                <input type="text" id="username" name="username" required class="shadow-sm appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:ring-2 focus:ring-blue-300">
            </div>
            <div class="mb-4">
                <label for="password" class="block text-gray-700 text-sm font-bold mb-2">密码</label>
                <input type="password" id="password" name="password" required class="shadow-sm appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:ring-2 focus:ring-blue-300">
            </div>
            <div class="mb-6">
                <label for="departmentId" class="block text-gray-700 text-sm font-bold mb-2">所属部门</label>
                <select id="departmentId" name="departmentId" required class="shadow-sm appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:ring-2 focus:ring-blue-300">
                    <c:forEach var="dept" items="${departments}">
                        <option value="${dept.departmentId}">${dept.departmentName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="flex items-center justify-between">
                <button type="submit" class="w-full py-2 px-4 rounded-lg focus:outline-none focus:shadow-outline btn-register-enhanced">
                    注 册
                </button>
            </div>
        </form>
        <p class="text-center text-gray-500 text-sm mt-6">
            已有账户? <a href="${pageContext.request.contextPath}/login" class="font-bold text-blue-600 hover:text-blue-800 link-enhanced">返回登录</a>
        </p>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Background halo effect container
        const haloEffectContainer = document.createElement('div');
        haloEffectContainer.id = 'halo-effect-container';
        haloEffectContainer.innerHTML = `
            <div class="halo-blob halo-blob-1"></div>
            <div class="halo-blob halo-blob-2"></div>
            <div class="halo-blob halo-blob-3"></div>
            <div class="halo-blob halo-blob-4"></div>
            <div class="halo-blob halo-blob-5"></div>
        `;
        document.body.prepend(haloEffectContainer);

        // Hide alerts after a few seconds
        document.querySelectorAll('.alert').forEach(function(element) {
            setTimeout(function() {
                element.style.opacity = '0';
                element.style.transform = 'translateY(-10px)';
                setTimeout(function() {
                    element.remove();
                }, 500); // Remove after transition
            }, 3000); // Display for 3 seconds
        });
    });
</script>
</body>
</html>
