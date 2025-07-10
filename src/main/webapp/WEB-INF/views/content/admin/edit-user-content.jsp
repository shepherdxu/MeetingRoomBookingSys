<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>编辑员工信息</title>
  <script src="https://cdn.tailwindcss.com"></script>
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

    /* Enhanced card hover effect */
    .content-card-enhanced {
      transition: all 0.3s ease;
      box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);
      border: 1px solid #f0f0f0;
    }
    .content-card-enhanced:hover {
      box-shadow: 0 8px 20px rgba(24, 144, 255, 0.15);
      transform: translateY(-5px);
    }

    /* Button hover effects */
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

    .btn-cancel-enhanced {
      background-color: #e2e8f0; /* gray-200 */
      color: #4a5568; /* gray-700 */
      transition: all 0.3s ease;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    .btn-cancel-enhanced:hover {
      background-color: #cbd5e0; /* gray-300 */
      transform: translateY(-2px) scale(1.02);
      box-shadow: 0 8px 15px rgba(0, 0, 0, 0.15);
    }

    /* Enhanced input/select focus styles */
    input[type="text"]:focus,
    input[type="password"]:focus,
    select:focus {
      border-color: #1890ff;
      box-shadow: 0 0 0 3px rgba(24, 144, 255, 0.2);
      outline: none; /* Remove default outline */
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

<div class="bg-white p-8 rounded-lg shadow-md max-w-2xl mx-auto content-card-enhanced relative z-0">
  <h2 class="text-2xl font-bold text-gray-800 mb-6">编辑员工信息</h2>

  <form action="${pageContext.request.contextPath}/admin" method="post" class="space-y-6">
    <input type="hidden" name="action" value="saveUser">
    <input type="hidden" name="userId" value="${userToEdit.userId}">

    <div>
      <label for="fullName" class="block text-sm font-medium text-gray-700 mb-1">姓名</label>
      <input type="text" id="fullName" name="fullName" value="${userToEdit.fullName}" required
             class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm">
    </div>
    <div>
      <label for="username" class="block text-sm font-medium text-gray-700 mb-1">用户名</label>
      <input type="text" id="username" name="username" value="${userToEdit.username}" required
             class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm">
    </div>
    <div>
      <label for="departmentId" class="block text-sm font-medium text-gray-700 mb-1">部门</label>
      <select id="departmentId" name="departmentId" required
              class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md">
        <c:forEach var="dept" items="${departments}">
          <option value="${dept.departmentId}" ${dept.departmentId == userToEdit.department.departmentId ? 'selected' : ''}>${dept.departmentName}</option>
        </c:forEach>
      </select>
    </div>
    <div>
      <label for="role" class="block text-sm font-medium text-gray-700 mb-1">角色</label>
      <select id="role" name="role" required
              class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md">
        <option value="employee" ${userToEdit.role == 'employee' ? 'selected' : ''}>员工</option>
        <option value="admin" ${userToEdit.role == 'admin' ? 'selected' : ''}>管理员</option>
      </select>
    </div>
    <div>
      <label for="password" class="block text-sm font-medium text-gray-700 mb-1">新密码</label>
      <input type="password" id="password" name="password" placeholder="如不修改请留空"
             class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm">
    </div>
    <div class="flex justify-end space-x-4 pt-4">
      <a href="${pageContext.request.contextPath}/admin?action=manageUsers" class="btn-cancel-enhanced px-6 py-2 rounded-lg font-bold">取消</a>
      <button type="submit" class="btn-primary-enhanced px-6 py-2 rounded-lg font-bold">保存</button>
    </div>
  </form>
</div>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    // Add background halo effect container dynamically
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
  });
</script>
</body>
</html>
