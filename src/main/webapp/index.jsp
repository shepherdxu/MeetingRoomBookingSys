<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>会议室预约管理系统</title>
    <link rel="stylesheet" href="style.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">
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

        header nav a:not(.bg-gradient-to-r):hover {
            color: #1890ff; /* Blue hover color */
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(24, 144, 255, 0.1);
            border-radius: 0.5rem;
        }

        header nav a.bg-gradient-to-r:hover {
            box-shadow: 0 6px 15px rgba(24, 144, 255, 0.4);
        }

        /* Main Title Animation and Contrast */
        .main-title {
            font-size: 3.75rem; /* text-6xl */
            line-height: 1;
            text-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            animation: fadeInScale 1.5s ease-out forwards;
            opacity: 0;
            transform: scale(0.95);
        }

        .main-title .block {
            font-size: 3rem; /* text-5xl */
            color: #1890ff; /* blue-600 */
            text-shadow: 0 3px 10px rgba(24, 144, 255, 0.4);
        }

        @keyframes fadeInScale {
            0% { opacity: 0; transform: scale(0.95); }
            100% { opacity: 1; transform: scale(1); }
        }

        /* Card Hover Effects */
        .feature-card-enhanced {
            transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .feature-card-enhanced:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 15px 30px rgba(24, 144, 255, 0.2);
        }

        .feature-card-enhanced .group-hover\:bg-blue-100 {
            transition: all 0.5s ease;
        }

        /* Icon Animation within cards */
        .feature-card-enhanced .text-4xl {
            transition: transform 0.3s ease;
        }
        .feature-card-enhanced:hover .text-4xl {
            transform: rotateY(180deg) scale(1.1);
        }

        /* Call to Action Button Hover Effects */
        .cta-button-primary {
            background-color: #ffffff;
            color: #1890ff; /* blue-600 */
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .cta-button-primary:hover {
            background-color: #f0f7ff; /* light blue */
            transform: translateY(-2px) scale(1.01);
            box-shadow: 0 8px 20px rgba(24, 144, 255, 0.3);
        }

        .cta-button-secondary {
            border: 2px solid white;
            color: white;
            transition: all 0.3s ease;
        }
        .cta-button-secondary:hover {
            background-color: rgba(255, 255, 255, 0.15);
            transform: translateY(-2px) scale(1.01);
            box-shadow: 0 8px 20px rgba(24, 144, 255, 0.3);
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
<header class="bg-white/80 backdrop-blur-sm shadow-sm sticky top-0 z-50 transition-all duration-300">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center py-4">
            <div class="flex items-center space-x-3">
                <h1 class="text-2xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-blue-500 via-purple-500 to-pink-500 animate-gradient bg-[length:200%_auto] filter blur-[0.5px] inline-block">
                    会议室预约管理系统
                </h1>
            </div>
            <nav class="hidden md:flex space-x-8">
                <a href="index.jsp" class="px-3 py-2 rounded-lg transition-all duration-300 bg-blue-100 text-blue-700 hover:bg-blue-200">
                    首页
                </a>
                <a href="features.jsp" class="px-3 py-2 rounded-lg transition-all duration-300 text-gray-600 hover:text-gray-900 hover:bg-gray-100">
                    功能特色
                </a>
                <a href="login.jsp" class="px-4 py-2 bg-gradient-to-r from-blue-600 to-indigo-600 text-white rounded-lg hover:from-blue-700 hover:to-indigo-700 transition-all duration-300 shadow-sm hover:shadow">
                    登录系统
                </a>
            </nav>
        </div>
    </div>
</header>

<!-- Main Content -->
<main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 relative z-0">
    <div class="text-center">
        <h1 class="main-title font-bold text-gray-900 mb-6">
            智能会议室预约
            <span class="block text-blue-600">让会议更高效</span>
        </h1>
        <p class="text-xl text-gray-600 max-w-3xl mx-auto mb-12">
            基于Servlet+JSP的企业级会议室预约管理系统，实现在线预约、冲突检测、审批管理等功能，
            让企业员工足不出户即可查询和预约会议室，提高利用率并节省时间。
        </p>

        <!-- User Roles & Features Combined Grid -->
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 mb-16">
            <!-- 角色卡片 -->
            <div class="bg-white rounded-xl shadow-md p-6 feature-card-enhanced border border-gray-100 overflow-hidden relative group">
                <div class="absolute top-0 right-0 w-24 h-24 bg-blue-50 rounded-bl-full transition-all duration-500 group-hover:bg-blue-100"></div>
                <div class="text-4xl mb-4 text-blue-600 relative z-10">
                    <i class="fa fa-user-circle-o"></i>
                </div>
                <h3 class="text-xl font-semibold text-gray-900 mb-2 relative z-10">普通员工</h3>
                <p class="text-gray-600 relative z-10">系统基础用户，可预约会议室、查看个人预约记录并管理</p>
            </div>

            <div class="bg-white rounded-xl shadow-md p-6 feature-card-enhanced border border-gray-100 overflow-hidden relative group">
                <div class="absolute top-0 right-0 w-24 h-24 bg-indigo-50 rounded-bl-full transition-all duration-500 group-hover:bg-indigo-100"></div>
                <div class="text-4xl mb-4 text-indigo-600 relative z-10">
                    <i class="fa fa-cogs"></i>
                </div>
                <h3 class="text-xl font-semibold text-gray-900 mb-2 relative z-10">系统管理员</h3>
                <p class="text-gray-600 relative z-10">拥有最高权限，负责系统配置、用户管理和数据维护</p>
            </div>

            <div class="bg-white rounded-xl shadow-md p-6 feature-card-enhanced border border-gray-100 overflow-hidden relative group">
                <div class="absolute top-0 right-0 w-24 h-24 bg-purple-50 rounded-bl-full transition-all duration-500 group-hover:bg-purple-100"></div>
                <div class="text-4xl mb-4 text-purple-600 relative z-10">
                    <i class="fa fa-building-o"></i>
                </div>
                <h3 class="text-xl font-semibold text-gray-900 mb-2 relative z-10">会议室预订</h3>
                <p class="text-gray-600 relative z-10">按楼栋、楼层查找会议室，查看容量和设施详情</p>
            </div>

            <!-- 功能卡片 -->
            <div class="bg-white rounded-xl shadow-md p-6 feature-card-enhanced border border-gray-100 overflow-hidden relative group">
                <div class="absolute top-0 right-0 w-24 h-24 bg-green-50 rounded-bl-full transition-all duration-500 group-hover:bg-green-100"></div>
                <div class="text-4xl mb-4 text-green-600 relative z-10">
                    <i class="fa fa-mobile"></i>
                </div>
                <h3 class="text-xl font-semibold text-gray-900 mb-2 relative z-10">资源协调</h3>
                <p class="text-gray-600 relative z-10">申请移动设备和会议服务，一站式资源管理</p>
            </div>

            <div class="bg-white rounded-xl shadow-md p-6 feature-card-enhanced border border-gray-100 overflow-hidden relative group">
                <div class="absolute top-0 right-0 w-24 h-24 bg-amber-50 rounded-bl-full transition-all duration-500 group-hover:bg-amber-100"></div>
                <div class="text-4xl mb-4 text-amber-600 relative z-10">
                    <i class="fa fa-check-square-o"></i>
                </div>
                <h3 class="text-xl font-semibold text-gray-900 mb-2 relative z-10">审批流程</h3>
                <p class="text-gray-600 relative z-10">完整的预约审批和状态管理，流程可视化</p>
            </div>

            <div class="bg-white rounded-xl shadow-md p-6 feature-card-enhanced border border-gray-100 overflow-hidden relative group">
                <div class="absolute top-0 right-0 w-24 h-24 bg-red-50 rounded-bl-full transition-all duration-500 group-hover:bg-red-100"></div>
                <div class="text-4xl mb-4 text-red-600 relative z-10">
                    <i class="fa fa-exclamation-triangle"></i>
                </div>
                <h3 class="text-xl font-semibold text-gray-900 mb-2 relative z-10">冲突检测</h3>
                <p class="text-gray-600 relative z-10">自动检测时间冲突，防止重复预约，智能提醒</p>
            </div>
        </div>

        <!-- Call to Action -->
        <div class="mt-16">
            <div class="bg-gradient-to-r from-blue-600 to-indigo-600 rounded-2xl p-8 text-white shadow-lg transform transition-all duration-300 hover:shadow-xl hover:scale-[1.01]">
                <h3 class="text-2xl font-bold mb-4">立即开始使用</h3>
                <p class="text-blue-100 mb-6">体验智能化的会议室预约管理，提升您的工作效率</p>
                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <a href="login.jsp" class="px-6 py-3 rounded-lg font-medium shadow-sm hover:shadow cta-button-primary">
                        立即登录
                    </a>
                    <a href="features.jsp" class="px-6 py-3 rounded-lg font-medium cta-button-secondary">
                        了解更多
                    </a>
                </div>
            </div>
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
    });
</script>
</body>
</html>
