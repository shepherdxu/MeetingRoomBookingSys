<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>功能特色 - 会议室预约管理系统</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">
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

    /* Enhanced card hover effect for main feature blocks */
    .feature-block-enhanced {
      transition: all 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94); /* More sophisticated ease */
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08); /* Stronger initial shadow */
      border: 1px solid #f0f0f0; /* Subtle border */
    }
    .feature-block-enhanced:hover {
      box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15); /* Even stronger shadow on hover */
      transform: translateY(-8px) scale(1.01); /* More pronounced lift and slight scale */
    }

    /* Inner card hover effect */
    .inner-card-hover:hover {
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
      transform: translateY(-3px);
    }

    /* Button hover effects */
    .btn-gradient-hover:hover {
      transform: translateY(-2px) scale(1.02);
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
    }

    /* Header backdrop blur for a frosted glass effect */
    header {
      background-color: rgba(255, 255, 255, 0.85); /* Slightly less opaque */
      backdrop-filter: blur(8px); /* Increased blur */
      -webkit-backdrop-filter: blur(8px); /* For Safari */
    }

    /* Section title underline animation */
    .animated-underline {
      position: relative;
      display: inline-block;
    }
    .animated-underline::after {
      content: '';
      position: absolute;
      bottom: -8px;
      left: 0;
      width: 0;
      height: 4px;
      background: linear-gradient(to right, #6366F1, #8B5CF6); /* Indigo to Purple */
      border-radius: 2px;
      transition: width 0.4s ease-out;
    }
    .animated-underline:hover::after {
      width: 100%;
    }

    /* Icon circle pulse effect */
    .icon-circle-pulse {
      animation: iconPulse 2s infinite ease-in-out;
    }
    @keyframes iconPulse {
      0% { transform: scale(1); box-shadow: 0 0 0 0 rgba(24, 144, 255, 0.3); }
      50% { transform: scale(1.05); box-shadow: 0 0 15px rgba(24, 144, 255, 0.5); }
      100% { transform: scale(1); box-shadow: 0 0 0 0 rgba(24, 144, 255, 0.3); }
    }

    /* Feature point checkmark animation */
    .feature-point-checkmark {
      transition: transform 0.2s ease-out;
    }
    .feature-point-checkmark:hover {
      transform: scale(1.2);
    }

    /* Flow arrow animation */
    .flow-arrow-animate {
      animation: flowArrow 1.5s infinite ease-in-out alternate;
    }
    @keyframes flowArrow {
      0% { transform: translateX(0); opacity: 0.7; }
      100% { transform: translateX(5px); opacity: 1; }
    }

    /* Footer link hover */
    footer a:hover {
      color: #a7d9ff; /* Light blue */
      transform: translateX(3px);
    }
    footer li {
      transition: all 0.2s ease;
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
        <div class="w-10 h-10 bg-gradient-to-r from-blue-600 to-indigo-600 rounded-lg flex items-center justify-center shadow-md icon-circle-pulse">
          <span class="text-white font-bold text-lg">会</span>
        </div>
        <h1 class="text-2xl font-bold text-gray-900">会议室预约管理系统</h1>
      </div>
      <nav class="hidden md:flex space-x-8">
        <a href="index.jsp" class="px-3 py-2 rounded-lg transition-all duration-300 text-gray-600 hover:text-gray-900 hover:bg-gray-100">
          首页
        </a>
        <a href="features.jsp" class="px-3 py-2 rounded-lg transition-all duration-300 bg-blue-100 text-blue-700 hover:bg-blue-200">
          功能特色
        </a>
        <a href="login.jsp" class="px-4 py-2 bg-gradient-to-r from-blue-600 to-indigo-600 text-white rounded-lg hover:from-blue-700 hover:to-indigo-700 transition-all duration-300 shadow-sm hover:shadow btn-gradient-hover">
          登录系统
        </a>
      </nav>
    </div>
  </div>
</header>

<!-- Main Content -->
<main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 relative z-0">
  <div class="text-center mb-16">
    <h2 class="text-4xl font-bold text-gray-900 mb-6 animated-underline">
      核心功能特色
      <div class="absolute -bottom-3 left-1/2 transform -translate-x-1/2 w-24 h-1 bg-gradient-to-r from-blue-500 to-purple-500 rounded-full"></div>
    </h2>
    <p class="text-xl text-gray-600 max-w-3xl mx-auto mt-8">
      全面的会议室管理解决方案，从预约到审批，从资源协调到数据统计，一站式满足企业需求
    </p>
  </div>

  <div class="space-y-16">
    <!-- Meeting Room Booking -->
    <div class="bg-white rounded-2xl shadow-xl p-8 overflow-hidden relative group feature-block-enhanced">
      <div class="absolute top-0 right-0 w-40 h-40 bg-blue-50 rounded-full -mr-20 -mt-20 transition-all duration-700 group-hover:bg-blue-100"></div>

      <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 items-center relative z-10">
        <div>
          <h3 class="text-2xl font-bold text-gray-900 mb-4 flex items-center">
            <span class="w-10 h-10 bg-blue-100 rounded-full flex items-center justify-center mr-3 text-blue-600 icon-circle-pulse">
              <i class="fa fa-building-o"></i>
            </span>
            智能会议室预订
          </h3>
          <p class="text-gray-600 mb-6">
            通过直观的界面快速查找和预订会议室，支持多种筛选条件，让预订变得简单高效。
          </p>
          <ul class="space-y-3 text-gray-600">
            <li class="flex items-start space-x-2">
              <span class="text-blue-600 font-bold mt-1 feature-point-checkmark">✓</span>
              <span>按楼栋、楼层智能查找会议室</span>
            </li>
            <li class="flex items-start space-x-2">
              <span class="text-blue-600 font-bold mt-1 feature-point-checkmark">✓</span>
              <span>实时查看容量、固定设施和可用状态</span>
            </li>
            <li class="flex items-start space-x-2">
              <span class="text-blue-600 font-bold mt-1 feature-point-checkmark">✓</span>
              <span>灵活的时间段预订功能</span>
            </li>
            <li class="flex items-start space-x-2">
              <span class="text-blue-600 font-bold mt-1 feature-point-checkmark">✓</span>
              <span>支持邀请内部员工和外部访客</span>
            </li>
            <li class="flex items-start space-x-2">
              <span class="text-blue-600 font-bold mt-1 feature-point-checkmark">✓</span>
              <span>会议室详情预览和360度全景查看</span>
            </li>
          </ul>
        </div>
        <div class="bg-gray-50 rounded-xl p-6 shadow-sm transform transition-all duration-500 group-hover:shadow-md">
          <h4 class="font-semibold mb-4 text-gray-800">会议室状态一览</h4>
          <div class="space-y-4">
            <div class="bg-white rounded-lg p-4 shadow inner-card-hover">
              <div class="flex justify-between items-center">
                <span class="font-medium">A栋3楼-会议室301</span>
                <span class="w-3 h-3 bg-green-400 rounded-full"></span>
              </div>
              <p class="text-sm text-gray-600 mt-1">容量: 12人 | 投影仪, 白板, 视频会议</p>
              <div class="mt-2 flex space-x-2">
                <span class="text-xs bg-green-100 text-green-800 px-2 py-1 rounded">可用</span>
                <span class="text-xs bg-blue-100 text-blue-800 px-2 py-1 rounded">高级设备</span>
              </div>
            </div>
            <div class="bg-white rounded-lg p-4 shadow inner-card-hover">
              <div class="flex justify-between items-center">
                <span class="font-medium">B栋2楼-会议室205</span>
                <span class="w-3 h-3 bg-red-400 rounded-full"></span>
              </div>
              <p class="text-sm text-gray-600 mt-1">容量: 8人 | 投影仪, 白板</p>
              <div class="mt-2 flex space-x-2">
                <span class="text-xs bg-red-100 text-red-800 px-2 py-1 rounded">占用中</span>
                <span class="text-xs bg-gray-100 text-gray-800 px-2 py-1 rounded">14:00-16:00</span>
              </div>
            </div>
            <div class="bg-white rounded-lg p-4 shadow inner-card-hover">
              <div class="flex justify-between items-center">
                <span class="font-medium">C栋1楼-大会议室</span>
                <span class="w-3 h-3 bg-yellow-400 rounded-full"></span>
              </div>
              <p class="text-sm text-gray-600 mt-1">容量: 50人 | 舞台, 音响, 直播设备</p>
              <div class="mt-2 flex space-x-2">
                <span class="text-xs bg-yellow-100 text-yellow-800 px-2 py-1 rounded">可用</span>
                <span class="text-xs bg-purple-100 text-purple-800 px-2 py-1 rounded">可申请设备</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Approval Process -->
    <div class="bg-white rounded-2xl shadow-xl p-8 overflow-hidden relative group feature-block-enhanced">
      <div class="absolute top-0 right-0 w-40 h-40 bg-blue-50 rounded-full -mr-20 -mt-20 transition-all duration-700 group-hover:bg-blue-100"></div>

      <div class="text-center mb-8 relative z-10">
        <h3 class="text-2xl font-bold text-gray-900 mb-4 flex items-center justify-center">
          <span class="w-10 h-10 bg-blue-100 rounded-full flex items-center justify-center mr-3 text-blue-600 icon-circle-pulse">
            <i class="fa fa-check-square-o"></i>
          </span>
          智能审批流程
        </h3>
        <p class="text-gray-600 max-w-2xl mx-auto">
          完整的预约生命周期管理，多级审批机制，确保每个环节都有记录，提高管理效率和透明度
        </p>
      </div>

      <div class="flex flex-col md:flex-row justify-center items-center space-y-6 md:space-y-0 md:space-x-8 mb-8 relative z-10">
        <div class="bg-yellow-50 border-2 border-yellow-200 rounded-xl p-6 text-center max-w-xs inner-card-hover">
          <div class="w-16 h-16 bg-yellow-400 rounded-full flex items-center justify-center mx-auto mb-4 icon-circle-pulse">
            <span class="text-white font-bold text-xl">1</span>
          </div>
          <h4 class="font-semibold text-yellow-800 mb-2">提交申请</h4>
          <p class="text-sm text-yellow-600">用户填写预约信息并提交申请</p>
        </div>

        <div class="hidden md:block text-gray-400 text-2xl flow-arrow-animate">→</div>

        <div class="bg-blue-50 border-2 border-blue-200 rounded-xl p-6 text-center max-w-xs inner-card-hover">
          <div class="w-16 h-16 bg-blue-400 rounded-full flex items-center justify-center mx-auto mb-4 icon-circle-pulse">
            <span class="text-white font-bold text-xl">2</span>
          </div>
          <h4 class="font-semibold text-blue-800 mb-2">审批处理</h4>
          <p class="text-sm text-blue-600">管理员或部门经理进行审批</p>
        </div>

        <div class="hidden md:block text-gray-400 text-2xl flow-arrow-animate">→</div>

        <div class="bg-green-50 border-2 border-green-200 rounded-xl p-6 text-center max-w-xs inner-card-hover">
          <div class="w-16 h-16 bg-green-400 rounded-full flex items-center justify-center mx-auto mb-4 icon-circle-pulse">
            <span class="text-white font-bold text-xl">3</span>
          </div>
          <h4 class="font-semibold text-green-800 mb-2">确认完成</h4>
          <p class="text-sm text-green-600">预约确认，会议顺利进行</p>
        </div>
      </div>

      <div class="grid grid-cols-1 md:grid-cols-3 gap-6 relative z-10">
        <div class="bg-gray-50 rounded-lg p-4 inner-card-hover">
          <h5 class="font-semibold text-gray-800 mb-3 flex items-center">
            <i class="fa fa-refresh text-blue-600 mr-2"></i> 状态跟踪
          </h5>
          <ul class="text-sm text-gray-600 space-y-1">
            <li>• 实时状态更新</li>
            <li>• 邮件/短信通知</li>
            <li>• 审批历史记录</li>
          </ul>
        </div>
        <div class="bg-gray-50 rounded-lg p-4 inner-card-hover">
          <h5 class="font-semibold text-gray-800 mb-3 flex items-center">
            <i class="fa fa-bolt text-yellow-600 mr-2"></i> 快速审批
          </h5>
          <ul class="text-sm text-gray-600 space-y-1">
            <li>• 一键批准/拒绝</li>
            <li>• 批量处理功能</li>
            <li>• 自动化规则</li>
          </ul>
        </div>
        <div class="bg-gray-50 rounded-lg p-4 inner-card-hover">
          <h5 class="font-semibold text-gray-800 mb-3 flex items-center">
            <i class="fa fa-bar-chart text-purple-600 mr-2"></i> 数据分析
          </h5>
          <ul class="text-sm text-gray-600 space-y-1">
            <li>• 审批效率统计</li>
            <li>• 使用率分析</li>
            <li>• 趋势预测</li>
          </ul>
        </div>
      </div>
    </div>

    <!-- Conflict Detection -->
    <div class="bg-white rounded-2xl shadow-xl p-8 overflow-hidden relative group feature-block-enhanced">
      <div class="absolute top-0 right-0 w-40 h-40 bg-red-50 rounded-full -mr-20 -mt-20 transition-all duration-700 group-hover:bg-red-100"></div>

      <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 items-center relative z-10">
        <div>
          <h3 class="text-2xl font-bold text-gray-900 mb-4 flex items-center">
            <span class="w-10 h-10 bg-red-100 rounded-full flex items-center justify-center mr-3 text-red-600 icon-circle-pulse">
              <i class="fa fa-exclamation-triangle"></i>
            </span>
            智能冲突检测
          </h3>
          <p class="text-gray-600 mb-6">
            先进的算法自动检测时间冲突，防止重复预约，确保会议室使用的有序性和高效性。
          </p>
          <ul class="space-y-3 text-gray-600">
            <li class="flex items-start space-x-2">
              <span class="text-red-600 font-bold mt-1 feature-point-checkmark">⚠</span>
              <span>实时时间冲突检测</span>
            </li>
            <li class="flex items-start space-x-2">
              <span class="text-red-600 font-bold mt-1 feature-point-checkmark">⚠</span>
              <span>重复预约自动提醒</span>
            </li>
            <li class="flex items-start space-x-2">
              <span class="text-red-600 font-bold mt-1 feature-point-checkmark">⚠</span>
              <span>会议室容量超限警告</span>
            </li>
            <li class="flex items-start space-x-2">
              <span class="text-red-600 font-bold mt-1 feature-point-checkmark">⚠</span>
              <span>设备资源冲突检测</span>
            </li>
            <li class="flex items-start space-x-2">
              <span class="text-red-600 font-bold mt-1 feature-point-checkmark">⚠</span>
              <span>智能替代方案推荐</span>
            </li>
          </ul>
        </div>
        <div class="bg-red-50 rounded-xl p-6 shadow-sm transform transition-all duration-500 group-hover:shadow-md">
          <h4 class="font-semibold mb-4 text-red-800">冲突检测示例</h4>
          <div class="space-y-4">
            <div class="bg-white rounded-lg p-4 border-l-4 border-red-500 inner-card-hover">
              <div class="flex items-center justify-between mb-2">
                <span class="font-medium text-red-800">时间冲突警告</span>
                <span class="text-xs bg-red-100 text-red-800 px-2 py-1 rounded">冲突</span>
              </div>
              <p class="text-sm text-red-600">会议室301在14:00-16:00已被预订</p>
              <p class="text-xs text-red-500 mt-1">建议时间：16:00-18:00</p>
            </div>
            <div class="bg-white rounded-lg p-4 border-l-4 border-yellow-500 inner-card-hover">
              <div class="flex items-center justify-between mb-2">
                <span class="font-medium text-yellow-800">容量警告</span>
                <span class="text-xs bg-yellow-100 text-yellow-800 px-2 py-1 rounded">警告</span>
              </div>
              <p class="text-sm text-yellow-600">参会人数(15人)超过会议室容量(12人)</p>
              <p class="text-xs text-yellow-500 mt-1">推荐：大会议室(50人)</p>
            </div>
            <div class="bg-white rounded-lg p-4 border-l-4 border-green-500 inner-card-hover">
              <div class="flex items-center justify-between mb-2">
                <span class="font-medium text-green-800">预约成功</span>
                <span class="text-xs bg-green-100 text-green-800 px-2 py-1 rounded">通过</span>
              </div>
              <p class="text-sm text-green-600">会议室205预约成功</p>
              <p class="text-xs text-green-500 mt-1">时间：2024-01-15 09:00-11:00</p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Statistics and Reports -->
    <div class="bg-white rounded-2xl shadow-xl p-8 overflow-hidden relative group feature-block-enhanced">
      <div class="absolute top-0 right-0 w-40 h-40 bg-purple-50 rounded-full -mr-20 -mt-20 transition-all duration-700 group-hover:bg-purple-100"></div>

      <div class="text-center mb-8 relative z-10">
        <h3 class="text-2xl font-bold text-gray-900 mb-4 flex items-center justify-center">
          <span class="w-10 h-10 bg-purple-100 rounded-full flex items-center justify-center mr-3 text-purple-600 icon-circle-pulse">
            <i class="fa fa-bar-chart"></i>
          </span>
          数据统计与报表
        </h3>
        <p class="text-gray-600 max-w-2xl mx-auto">
          全面的数据分析和可视化报表，帮助管理者了解会议室使用情况，优化资源配置
        </p>
      </div>

      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 relative z-10">
        <div class="bg-blue-50 rounded-lg p-6 text-center inner-card-hover border border-blue-100">
          <div class="w-12 h-12 bg-blue-500 rounded-full flex items-center justify-center mx-auto mb-4 icon-circle-pulse">
            <i class="fa fa-line-chart text-white text-xl"></i>
          </div>
          <h4 class="font-semibold text-blue-800 mb-2">使用率分析</h4>
          <p class="text-sm text-blue-600">实时监控会议室使用情况</p>
        </div>
        <div class="bg-green-50 rounded-lg p-6 text-center inner-card-hover border border-green-100">
          <div class="w-12 h-12 bg-green-500 rounded-full flex items-center justify-center mx-auto mb-4 icon-circle-pulse">
            <i class="fa fa-calendar-check-o text-white text-xl"></i>
          </div>
          <h4 class="font-semibold text-green-800 mb-2">预约统计</h4>
          <p class="text-sm text-green-600">详细的预约数据分析</p>
        </div>
        <div class="bg-purple-50 rounded-lg p-6 text-center inner-card-hover border border-purple-100">
          <div class="w-12 h-12 bg-purple-500 rounded-full flex items-center justify-center mx-auto mb-4 icon-circle-pulse">
            <i class="fa fa-users text-white text-xl"></i>
          </div>
          <h4 class="font-semibold text-purple-800 mb-2">部门报表</h4>
          <p class="text-sm text-purple-600">按部门统计使用情况</p>
        </div>
        <div class="bg-orange-50 rounded-lg p-6 text-center inner-card-hover border border-orange-100">
          <div class="w-12 h-12 bg-orange-500 rounded-full flex items-center justify-center mx-auto mb-4 icon-circle-pulse">
            <i class="fa fa-clock-o text-white text-xl"></i>
          </div>
          <h4 class="font-semibold text-orange-800 mb-2">时段分析</h4>
          <p class="text-sm text-orange-600">热门时间段统计</p>
        </div>
      </div>
    </div>
  </div>

  <!-- Call to Action -->
  <div class="mt-16 text-center">
    <div class="bg-gradient-to-r from-blue-600 to-purple-600 rounded-2xl p-8 text-white shadow-xl transform transition-all duration-500 hover:shadow-2xl hover:scale-[1.01] relative overflow-hidden btn-gradient-hover">
      <!-- 装饰元素 -->
      <div class="absolute top-0 left-0 w-full h-full opacity-10">
        <div class="absolute top-10 left-10 w-40 h-40 bg-white rounded-full"></div>
        <div class="absolute bottom-10 right-10 w-60 h-60 bg-white rounded-full"></div>
      </div>

      <h3 class="text-2xl font-bold mb-4 relative z-10">准备好体验智能会议室管理了吗？</h3>
      <p class="text-blue-100 mb-6 max-w-2xl mx-auto relative z-10">
        立即登录系统，体验完整的会议室预约管理功能，让您的会议安排更加高效便捷
      </p>
      <div class="flex flex-col sm:flex-row gap-4 justify-center relative z-10">
        <a href="login.jsp" class="bg-white text-blue-600 px-8 py-3 rounded-lg font-medium hover:bg-gray-100 transition-all duration-300 transform hover:scale-105 shadow-md btn-gradient-hover">
          立即登录
        </a>
        <a href="index.jsp" class="border-2 border-white text-white px-8 py-3 rounded-lg font-medium hover:bg-white/10 transition-all duration-300 transform hover:scale-105 btn-gradient-hover">
          返回首页
        </a>
      </div>
    </div>
  </div>
</main>

<!-- Footer -->
<footer class="bg-gray-900 text-white py-12 mt-16">
  <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
    <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
      <div>
        <h3 class="text-lg font-semibold mb-4">会议室预约系统</h3>
        <p class="text-gray-400">基于Servlet+JSP技术栈开发的企业级会议室管理解决方案</p>
      </div>
      <div>
        <h3 class="text-lg font-semibold mb-4">核心功能</h3>
        <ul class="space-y-2 text-gray-400">
          <li><a href="#" class="hover:underline transition-all duration-200">在线预约</a></li>
          <li><a href="#" class="hover:underline transition-all duration-200">冲突检测</a></li>
          <li><a href="#" class="hover:underline transition-all duration-200">审批管理</a></li>
          <li><a href="#" class="hover:underline transition-all duration-200">资源协调</a></li>
        </ul>
      </div>
      <div>
        <h3 class="text-lg font-semibold mb-4">联系我们</h3>
        <div class="space-y-2 text-gray-400">
          <p>📧 support@meetingroom.com</p>
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
  // Add background halo effect container dynamically
  document.addEventListener('DOMContentLoaded', function() {
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

    // Add scroll animation effect
    const featureBlocks = document.querySelectorAll('.feature-block-enhanced');

    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('opacity-100');
          entry.target.classList.remove('opacity-0', 'translate-y-8');
        }
      });
    }, { threshold: 0.1 });

    featureBlocks.forEach(block => {
      block.classList.add('transition-all', 'duration-700', 'opacity-0', 'translate-y-8');
      observer.observe(block);
    });
  });
</script>

</body>
</html>
