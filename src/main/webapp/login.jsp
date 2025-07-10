<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>登录系统 - 会议室预约管理系统</title>
  <%-- <link rel="stylesheet" href="style.css"> --%>
  <script src="https://cdn.tailwindcss.com"></script>
  <!-- 引入 Inter 字体 -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
  <style>
    @keyframes gradientShift {
      0% { background-position: 0% center; }
      50% { background-position: 100% center; }
      100% { background-position: 0% center; }
    }
    .animate-gradient {
      animation: gradientShift 3s ease infinite;
    }
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

    /* Header Navigation Links Hover Effect */
    header nav a {
      position: relative;
      overflow: hidden;
      transition: all 0.3s ease;
    }

    header nav a:hover {
      color: #1890ff; /* Blue hover color */
      transform: translateY(-2px);
      box-shadow: 0 4px 10px rgba(24, 144, 255, 0.1);
      border-radius: 0.5rem;
    }

    header nav a.bg-blue-600:hover {
      background-color: #40a9ff; /* Darker blue for button */
      box-shadow: 0 6px 15px rgba(24, 144, 255, 0.4);
    }

    /* Enhanced Login Card */
    .login-card-enhanced {
      transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
    }

    .login-card-enhanced:hover {
      transform: translateY(-5px) scale(1.01);
      box-shadow: 0 15px 30px rgba(24, 144, 255, 0.2);
    }

    /* Input Field Focus Effect */
    input[type="text"]:focus,
    input[type="password"]:focus {
      border-color: #1890ff; /* Blue border on focus */
      box-shadow: 0 0 0 4px rgba(24, 144, 255, 0.3); /* Blue ring on focus */
      outline: none;
    }

    /* Login Button Hover Effect */
    .btn-login-enhanced {
      background-color: #1890ff;
      color: white;
      transition: all 0.3s ease;
      box-shadow: 0 4px 10px rgba(24, 144, 255, 0.2);
    }

    .btn-login-enhanced:hover {
      background-color: #40a9ff;
      transform: translateY(-2px) scale(1.01);
      box-shadow: 0 8px 20px rgba(24, 144, 255, 0.4);
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

    /* Login Tips Card Hover Effect */
    .tips-card-enhanced {
      transition: all 0.3s ease;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    }

    .tips-card-enhanced:hover {
      transform: translateY(-3px);
      box-shadow: 0 6px 15px rgba(24, 144, 255, 0.1);
    }

    /* Footer Links Hover Effect */
    footer a {
      transition: all 0.2s ease;
    }

    footer a:hover {
      color: #60A5FA; /* Light blue */
      text-decoration: underline;
    }
  </style>
</head>
<body class="min-h-screen bg-gradient-to-br from-blue-50 via-white to-purple-50">
<!-- Background Halo Effect Container -->
<div id="halo-effect-container">
  <div class="halo-blob halo-blob-1"></div>
  <div class="halo-blob halo-blob-2"></div>
  <div class="halo-blob halo-blob-3"></div>
  <div class="halo-blob halo-blob-4"></div>
  <div class="halo-blob halo-blob-5"></div>
</div>

<!-- Header -->
<header class="bg-white/80 backdrop-blur-sm shadow-sm sticky top-0 z-50">
  <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
    <div class="flex justify-between items-center py-4">
      <div class="flex items-center space-x-3">
        <h1 class="text-2xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-blue-500 via-purple-500 to-pink-500 animate-gradient bg-[length:200%_auto] filter blur-[0.5px] inline-block">
          会议室预约管理系统
        </h1>
      </div>
      <nav class="hidden md:flex space-x-8">
        <a href="index.jsp" class="px-3 py-2 rounded-lg transition-colors text-gray-600 hover:text-gray-900">
          首页
        </a>
        <a href="features.jsp" class="px-3 py-2 rounded-lg transition-colors text-gray-600 hover:text-gray-900">
          功能特色
        </a>
        <a href="login.jsp" class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors">
          登录系统
        </a>
      </nav>
    </div>
  </div>
</header>

<!-- Main Content -->
<main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 relative z-0">
  <div class="max-w-md mx-auto">
    <div class="bg-white rounded-2xl shadow-xl p-8 login-card-enhanced">
      <div class="text-center mb-8">
        <div class="w-16 h-16 bg-gradient-to-r from-blue-500 to-purple-600 rounded-full flex items-center justify-center mx-auto mb-4 shadow-lg">
          <span class="text-white text-2xl font-bold">👥</span>
        </div>
        <h2 class="text-2xl font-bold text-gray-900">系统登录</h2>
        <c:if test="${not empty message}">
          <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded-lg relative mb-4 alert" role="alert">
            <span class="block sm:inline">${message}</span>
          </div>
        </c:if>
        <c:if test="${not empty error}">
          <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-lg relative mb-4 alert" role="alert">
            <span class="block sm:inline">${error}</span>
          </div>
        </c:if>
      </div>

      <form action="${pageContext.request.contextPath}/login" method="post" id="login-form" class="space-y-6">
        <!-- Username -->
        <div>
          <label for="username" class="block text-sm font-medium text-gray-700 mb-2">
            用户名 <span class="text-red-500">*</span>
          </label>
          <input type="text" id="username" name="username" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent" placeholder="请输入用户名">
        </div>

        <!-- Password -->
        <div>
          <label for="password" class="block text-sm font-medium text-gray-700 mb-2">
            密码 <span class="text-red-500">*</span>
          </label>
          <input type="password" id="password"  name="password" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent" placeholder="请输入密码">
        </div>

        <!-- Remember Me -->
        <div class="flex items-center justify-between">
          <div class="flex items-center">
            <input id="remember-me" type="checkbox" class="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded">
            <label for="remember-me" class="ml-2 block text-sm text-gray-900">
              记住我
            </label>
          </div>
          <div class="text-sm">
            <a href="${pageContext.request.contextPath}/register" class="font-medium text-blue-600 hover:text-blue-500 hover:underline transition-colors">
              忘记密码？
            </a>
          </div>
        </div>

        <!-- Login Button -->
        <button type="submit" class="w-full py-3 px-4 rounded-lg font-medium btn-login-enhanced">
          登录系统
        </button>
      </form>

      <div class="mt-6">
        <div class="relative">
          <div class="absolute inset-0 flex items-center">
            <div class="w-full border-t border-gray-300"></div>
          </div>
          <div class="relative flex justify-center text-sm">
            <span class="px-2 bg-white text-gray-500">或者</span>
          </div>
        </div>
      </div>

      <div class="mt-6 text-center">
        <p class="text-sm text-gray-500">
          还没有账号？
          <a href="${pageContext.request.contextPath}/register" class="text-blue-600 hover:text-blue-700 ml-1 hover:underline transition-colors">注册</a>
        </p>
      </div>
    </div>

    <!-- Login Tips -->
    <div class="mt-8 bg-blue-50 rounded-lg p-6 tips-card-enhanced">
      <h3 class="text-lg font-semibold text-blue-900 mb-4">登录提示</h3>
      <ul class="space-y-2 text-sm text-blue-800">
        <li class="flex items-start">
          <span class="text-blue-600 mr-2">•</span>
          <span>普通员工：可以预订会议室，查看自己的预约记录</span>
        </li>
        <li class="flex items-start">
          <span class="text-blue-600 mr-2">•</span>
          <span>部门经理：拥有审批权限，可以管理部门预约</span>
        </li>
        <li class="flex items-start">
          <span class="text-blue-600 mr-2">•</span>
          <span>系统管理员：拥有最高权限，可以管理所有功能</span>
        </li>
        <li class="flex items-start">
          <span class="text-blue-600 mr-2">•</span>
          <span>访客：受邀参加会议，权限有限</span>
        </li>
      </ul>
    </div>
  </div>
</main>

<!-- Footer -->
<footer class="bg-gray-900 text-white py-12">
  <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
    <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
      <div>
        <h3 class="text-lg font-semibold mb-4">会议室预约系统</h3>
        <p class="text-gray-400">基于Servlet+JSP技术栈开发的企业级会议室管理解决方案</p>
      </div>
      <div>
        <h3 class="text-lg font-semibold mb-4">核心功能</h3>
        <ul class="space-y-2 text-gray-400">
          <li><a href="#" class="hover:text-blue-400 hover:underline">在线预约</a></li>
          <li><a href="#" class="hover:text-blue-400 hover:underline">冲突检测</a></li>
          <li><a href="#" class="hover:text-blue-400 hover:underline">审批管理</a></li>
          <li><a href="#" class="hover:text-blue-400 hover:underline">资源协调</a></li>
        </ul>
      </div>
      <div>
        <h3 class="text-lg font-semibold mb-4">联系我们</h3>
        <div class="space-y-2 text-gray-400">
          <p>📧 <a href="mailto:support@meetingroom.com" class="hover:text-blue-400 hover:underline">support@meetingroom.com</a></p>
          <p>📞 400-123-4567</p>
          <p>🏢 企业服务中心</p>
        </div>
      </div>
    </div>
    <div class="border-t border-gray-800 mt-8 pt-8 text-center text-gray-400">
      <p>&copy; 2024 会议室预约管理系统. 保留所有权利.</p>
    </div>
  </div>
</footer>

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
