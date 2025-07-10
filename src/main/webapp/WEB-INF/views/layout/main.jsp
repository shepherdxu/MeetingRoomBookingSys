<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title} - 会议室预约管理系统</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        /* 基础样式 */
        .sidebar-active {
            background-color: #e6f7ff;
            color: #1890ff;
            box-shadow: 0 0 15px rgba(24, 144, 255, 0.3);
        }
        .notification-badge {
            position: absolute; top: -5px; right: -5px; padding: 2px 6px;
            border-radius: 50%; background: #ff4d4f; color: white; font-size: 10px;
            box-shadow: 0 0 10px rgba(255, 77, 79, 0.5);
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(255, 77, 79, 0.5); }
            70% { box-shadow: 0 0 0 6px rgba(255, 77, 79, 0); }
            100% { box-shadow: 0 0 0 0 rgba(255, 77, 79, 0); }
        }

        /* 加载动画 */
        #loading-overlay {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background-color: rgba(255, 255, 255, 0.7);
            display: flex; justify-content: center; align-items: center;
            z-index: 9999; transition: opacity 0.3s; pointer-events: none; opacity: 0;
        }
        #loading-overlay.visible { opacity: 1; pointer-events: auto; }
        .spinner {
            border: 4px solid rgba(24, 144, 255, 0.1);
            width: 36px; height: 36px; border-radius: 50%;
            border-left-color: #1890ff;
            animation: spin 1s ease infinite;
            box-shadow: 0 0 15px rgba(24, 144, 255, 0.3);
        }
        @keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }

        /* 流光光效核心样式 */
        .shine-effect {
            position: relative;
            overflow: hidden;
        }
        .shine-effect::after {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(
                    to right,
                    rgba(255, 255, 255, 0) 0%,
                    rgba(255, 255, 255, 0.3) 50%,
                    rgba(255, 255, 255, 0) 100%
            );
            transform: rotate(30deg);
            animation: shine 3s infinite;
        }
        @keyframes shine {
            0% { transform: translateX(-100%) rotate(30deg); }
            100% { transform: translateX(100%) rotate(30deg); }
        }

        /* 侧边栏样式 */
        aside {
            background-color: #ffffff;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.05);
            border-right: 1px solid #f0f0f0;
        }

        /* 导航链接样式 */
        #main-nav a {
            color: #595959;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        #main-nav a:hover {
            background-color: #f5f7fa;
            color: #1890ff;
            transform: translateX(2px);
        }
        #main-nav a svg {
            stroke-width: 1.7;
        }

        /* 顶部导航 */
        header {
            background-color: #ffffff;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }
        #page-title-container h1 {
            color: #1f2329;
            text-shadow: 0 0 8px rgba(24, 144, 255, 0.1);
        }

        /* 通知按钮 */
        #notification-bell {
            transition: all 0.3s ease;
            color: #595959;
        }
        #notification-bell:hover {
            color: #1890ff;
            transform: scale(1.1);
            background-color: #f0f7ff;
        }

        /* 通知下拉框 */
        #notification-dropdown {
            background-color: #ffffff;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            border: 1px solid #e8e8e8;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        #notification-dropdown .border-b {
            border-color: #f0f0f0;
        }

        /* 通知项样式 */
        #notification-list a {
            color: #595959;
            transition: all 0.2s ease;
        }
        #notification-list a:hover {
            background-color: #f0f7ff;
            color: #1890ff;
        }

        /* 主内容区 */
        main {
            background-color: #fafafa;
        }

        /* 卡片组件样式 */
        .content-card {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);
            transition: all 0.3s ease;
            border: 1px solid #f0f0f0;
        }
        .content-card:hover {
            box-shadow: 0 4px 20px rgba(24, 144, 255, 0.1);
            transform: translateY(-2px);
        }

        /* 按钮样式 */
        .btn {
            transition: all 0.3s ease;
        }
        .btn-primary {
            background-color: #1890ff;
            color: white;
        }
        .btn-primary:hover {
            background-color: #40a9ff;
            box-shadow: 0 2px 8px rgba(24, 144, 255, 0.3);
        }
    </style>
</head>
<body class="bg-gray-50 font-sans text-gray-800">
<!-- Loading Animation -->
<div id="loading-overlay">
    <div class="spinner"></div>
</div>

<div class="flex h-screen">
    <!-- Sidebar -->
    <aside class="w-64 flex flex-col fixed h-full z-10">
        <div class="h-16 flex items-center justify-center text-gray-800 text-xl font-bold border-b border-gray-200 shine-effect">
            <span class="text-2xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-blue-500 via-purple-500 to-pink-500 animate-gradient bg-[length:200%_auto] filter blur-[0.5px] inline-block">会议室预约管理系统</span>
        </div>

        <nav id="main-nav" class="flex-1 px-4 py-4 space-y-1">
            <a href="${pageContext.request.contextPath}/dashboard" class="flex items-center px-4 py-2.5 rounded-lg transition-all duration-300 ${page == 'dashboard' ? 'sidebar-active' : ''}">
                <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"></path></svg>
                仪表盘
            </a>
            <a href="${pageContext.request.contextPath}/booking" class="flex items-center px-4 py-2.5 rounded-lg transition-all duration-300 ${page == 'booking' ? 'sidebar-active' : ''}">
                <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                房间预定
            </a>
            <a href="${pageContext.request.contextPath}/management" class="flex items-center px-4 py-2.5 rounded-lg transition-all duration-300 ${page == 'management' ? 'sidebar-active' : ''}">
                <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01"></path></svg>
                预定管理
            </a>
            <c:if test="${sessionScope.user.role == 'admin'}">
                <div class="pt-4 mt-4 space-y-1 border-t border-gray-200">
                    <p class="px-4 text-xs font-semibold text-gray-500 uppercase">管理员</p>
                    <a href="${pageContext.request.contextPath}/admin?action=approvals" class="flex items-center px-4 py-2.5 rounded-lg transition-all duration-300 ${(page == 'admin' && (param.action == 'approvals' || empty param.action)) ? 'sidebar-active' : ''}">
                        <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                        申请审批
                    </a>
                    <a href="${pageContext.request.contextPath}/admin?action=manageRooms" class="flex items-center px-4 py-2.5 rounded-lg transition-all duration-300 ${(page == 'admin' && param.action == 'manageRooms') ? 'sidebar-active' : ''}">
                        <svg class="w-5 h-5 mr-3" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M2.25 21h19.5m-18-18v18m10.5-18v18m6-13.5V21M6.75 6.75h.75v.75h-.75V6.75zm.75 4.5h-.75v.75h.75v-.75zm-.75 4.5h.75v.75h-.75v-.75zm10.5-11.25h.75v.75h-.75V6.75zm.75 4.5h-.75v.75h.75v-.75zm-.75 4.5h.75v.75h-.75v-.75z" /></svg>
                        会议室管理
                    </a>
                    <a href="${pageContext.request.contextPath}/admin?action=manageUsers" class="flex items-center px-4 py-2.5 rounded-lg transition-all duration-300 ${(page == 'admin' && param.action == 'manageUsers') ? 'sidebar-active' : ''}">
                        <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M15 21a6 6 0 00-9-5.197M15 12a4 4 0 11-8 0 4 4 0 018 0z"></path></svg>
                        员工管理
                    </a>
                </div>
            </c:if>
        </nav>
    </aside>

    <!-- Main Content -->
    <div class="flex-1 flex flex-col overflow-hidden ml-64">
        <!-- Header -->
        <header class="h-16 flex items-center justify-between px-6">
            <div id="page-title-container" class="opacity-0 translate-y-2 transition-all duration-500">
                <h1 class="text-xl font-semibold">${title}</h1>
            </div>
            <div class="flex items-center space-x-4">
                <div class="relative">
                    <button id="notification-bell" class="p-2 rounded-full hover:bg-gray-100 focus:outline-none transition-transform duration-200">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"></path></svg>
                        <span id="notification-badge" class="notification-badge hidden"></span>
                    </button>
                    <div id="notification-dropdown" class="absolute right-0 mt-2 w-80 rounded-lg overflow-hidden z-10 hidden transform opacity-0 translate-y-2 transition-all duration-300">
                        <div class="py-2 px-4 text-sm font-semibold text-gray-700 border-b">通知中心</div>
                        <div id="notification-list" class="divide-y max-h-96 overflow-y-auto"></div>
                    </div>
                </div>
                <div class="flex items-center">
                    <span class="text-gray-600 mr-2">欢迎, ${sessionScope.user.fullName}</span>
                    <a href="${pageContext.request.contextPath}/logout" class="text-sm text-blue-600 hover:text-blue-800 hover:underline transition-colors duration-300">退出</a>
                </div>
            </div>
        </header>

        <!-- Content Body -->
        <main class="flex-1 overflow-x-hidden overflow-y-auto p-6 shine-effect">
            <jsp:include page="${contentPage}" />
        </main>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const loadingOverlay = document.getElementById('loading-overlay');
        const navLinks = document.querySelectorAll('#main-nav a');
        const bell = document.getElementById('notification-bell');
        const dropdown = document.getElementById('notification-dropdown');
        const list = document.getElementById('notification-list');
        const badge = document.getElementById('notification-badge');

        let notificationCache = JSON.parse(localStorage.getItem('lastNotificationList')) || [];
        let hasViewed = localStorage.getItem('notificationHasViewed') === 'true';

        // 导航链接点击加载效果
        navLinks.forEach(link => {
            link.addEventListener('click', function(e) {
                if (link.target === '_blank' || link.href.startsWith('javascript:')) return;
                loadingOverlay.classList.add('visible');
            });
        });

        // 页面加载完成隐藏加载动画
        window.addEventListener('pageshow', function() {
            loadingOverlay.classList.remove('visible');
        });

        // 标题淡入动画
        document.getElementById('page-title-container').classList.remove('opacity-0', 'translate-y-2');

        // 通知下拉框交互
        bell.addEventListener('click', (event) => {
            event.stopPropagation();
            dropdown.classList.toggle('hidden');
            if (!dropdown.classList.contains('hidden')) {
                setTimeout(() => {
                    dropdown.classList.remove('opacity-0', 'translate-y-2');
                }, 50);
                badge.classList.add('hidden');
                hasViewed = true;
                localStorage.setItem('notificationHasViewed', 'true');
            } else {
                dropdown.classList.add('opacity-0', 'translate-y-2');
            }
        });

        // 渲染通知列表
        function renderNotificationList(notifications) {
            list.innerHTML = '';
            if (notifications.length > 0) {
                notifications.forEach((n, index) => {
                    const item = document.createElement('a');
                    item.href = '#';
                    item.className = `block px-4 py-3 text-sm transition-all duration-200 ${n.read ? 'text-gray-400' : ''}`;
                    item.textContent = n.message;
                    item.dataset.id = n.notificationId;

                    // 通知项淡入动画
                    item.style.opacity = '0';
                    item.style.transform = 'translateX(-10px)';
                    list.appendChild(item);

                    setTimeout(() => {
                        item.style.opacity = '1';
                        item.style.transform = 'translateX(0)';
                        item.style.transition = 'all 0.3s ease';
                    }, 100 * index);
                });
            } else {
                list.innerHTML = '<p class="text-center text-gray-500 py-4">没有新通知</p>';
            }
        }

        // 获取通知
        function fetchNotifications() {
            fetch('${pageContext.request.contextPath}/notifications')
                .then(response => response.json())
                .then(notifications => {
                    const currentHash = JSON.stringify(notifications);
                    const previousHash = JSON.stringify(notificationCache);

                    const isNew = currentHash !== previousHash;
                    if (isNew) {
                        localStorage.setItem('notificationHasViewed', 'false');
                        localStorage.setItem('lastNotificationList', currentHash);
                        hasViewed = false;
                        notificationCache = notifications;

                        // 新通知提示动画
                        if (!dropdown.classList.contains('hidden')) {
                            bell.classList.add('animate-pulse');
                            setTimeout(() => bell.classList.remove('animate-pulse'), 1000);
                        }
                    }

                    // 更新通知徽章
                    if (!hasViewed && notifications.length > 0) {
                        badge.textContent = notifications.filter(n => !n.read).length;
                        badge.classList.remove('hidden');
                    } else {
                        badge.classList.add('hidden');
                    }

                    renderNotificationList(notifications);
                });
        }

        // 标记通知为已读
        list.addEventListener('click', (event) => {
            event.preventDefault();
            const target = event.target;
            if (target.dataset.id) {
                const notificationId = target.dataset.id;
                fetch('${pageContext.request.contextPath}/notifications', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: `action=markAsRead&id=${notificationId}`
                }).then(response => {
                    if(response.ok) {
                        // 已读动画效果
                        target.classList.add('text-gray-400');
                        target.style.transition = 'all 0.3s ease';
                        target.style.backgroundColor = '#f0f7ff';
                        setTimeout(() => {
                            target.style.backgroundColor = '';
                        }, 500);
                        setTimeout(fetchNotifications, 300);
                    }
                });
            }
        });

        // 点击外部关闭下拉框
        window.addEventListener('click', (e) => {
            if (!bell.contains(e.target) && !dropdown.contains(e.target) && !dropdown.classList.contains('hidden')) {
                dropdown.classList.add('opacity-0', 'translate-y-2');
                setTimeout(() => {
                    dropdown.classList.add('hidden');
                }, 300);
            }
        });

        // 初始化加载通知
        fetchNotifications();
        // 定时刷新通知
        setInterval(fetchNotifications, 30000);
    });
</script>

</body>
</html>