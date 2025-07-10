<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的预订记录</title>
    <script src="https://cdn.tailwindcss.com "></script>
    <link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#3B82F6',
                        secondary: '#8B5CF6',
                        success: '#10B981',
                        warning: '#F59E0B',
                        danger: '#EF4444',
                        neutral: {
                            50: '#F9FAFB',
                            100: '#F3F4F6',
                            200: '#E5E7EB',
                            700: '#374151',
                            800: '#1F2937',
                            900: '#111827'
                        }
                    },
                    fontFamily: {
                        inter: ['Inter', 'system-ui', 'sans-serif']
                    },
                    animation: {
                        'fade-in': 'fadeIn 0.6s ease-out',
                        'slide-up': 'slideUp 0.4s ease-out',
                        'pulse-soft': 'pulseSoft 2s infinite',
                        'bounce-slow': 'bounceSlow 3s infinite',
                        'shimmer': 'shimmer 2s infinite linear',
                        'scale-in': 'scaleIn 0.3s ease-out'
                    },
                    keyframes: {
                        fadeIn: {
                            '0%': { opacity: '0' },
                            '100%': { opacity: '1' }
                        },
                        slideUp: {
                            '0%': { transform: 'translateY(20px)', opacity: '0' },
                            '100%': { transform: 'translateY(0)', opacity: '1' }
                        },
                        pulseSoft: {
                            '0%, 100%': { opacity: '1' },
                            '50%': { opacity: '0.7' }
                        },
                        bounceSlow: {
                            '0%, 100%': { transform: 'translateY(0)' },
                            '50%': { transform: 'translateY(-5px)' }
                        },
                        shimmer: {
                            '0%': { backgroundPosition: '-1000px 0' },
                            '100%': { backgroundPosition: '1000px 0' }
                        },
                        scaleIn: {
                            '0%': { transform: 'scale(0.95)', opacity: '0' },
                            '100%': { transform: 'scale(1)', opacity: '1' }
                        }
                    }
                }
            }
        }
    </script>
    <style type="text/tailwindcss">
        @layer utilities {
            .content-auto {
                content-visibility: auto;
            }
            .status-pill {
                @apply px-2 py-1 inline-flex text-xs leading-5 font-medium rounded-full transition-all duration-300;
            }
            .hover-scale {
                @apply transition-transform duration-300 hover:scale-[1.02];
            }
            .table-shadow {
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            }
        }
    </style>
</head>
<body class="bg-gray-50 font-inter">
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <div class="bg-white rounded-2xl shadow-xl overflow-hidden transform transition-all duration-500 hover:shadow-2xl animate-scale-in">
        <!-- 装饰性顶部条 -->
        <div class="h-1.5 bg-gradient-to-r from-primary to-secondary"></div>
        <!-- 标题区域 -->
        <div class="p-6 sm:p-8 border-b border-neutral-100 relative overflow-hidden">
            <!-- 装饰图案 -->
            <div class="absolute top-0 right-0 opacity-5 transform translate-x-1/4 -translate-y-1/4">
                <i class="fa fa-calendar text-[200px] text-primary"></i>
            </div>
            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between relative">
                <h2 class="text-[clamp(1.5rem,3vw,2.5rem)] font-bold text-neutral-800 flex items-center mb-4 sm:mb-0">
                    <i class="fa fa-calendar-check-o mr-3 text-primary text-2xl"></i>
                    <span class="text-transparent bg-clip-text bg-gradient-to-r from-primary to-secondary">我的预订记录</span>
                </h2>
                <div class="bg-neutral-50 px-4 py-2 rounded-lg border border-neutral-200 flex items-center shadow-sm">
                    <i class="fa fa-clock-o mr-2 text-primary"></i>
                    <span id="current-time" class="text-neutral-700 font-medium">加载中...</span>
                </div>
            </div>
        </div>
        <!-- 消息提示 -->
        <c:if test="${param.message == 'booking_submitted'}">
            <div class="bg-blue-50 border-l-4 border-blue-400 p-4 animate-slide-up">
                <div class="flex">
                    <div class="flex-shrink-0">
                        <i class="fa fa-info-circle text-blue-500 text-lg"></i>
                    </div>
                    <div class="ml-3">
                        <p class="text-sm text-blue-700">
                            <i class="fa fa-check-circle mr-1"></i>
                            您的预约已提交，请等待管理员审批
                        </p>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${param.message == 'cancel_success'}">
            <div class="bg-green-50 border-l-4 border-green-400 p-4 animate-slide-up">
                <div class="flex">
                    <div class="ml-3">
                        <p class="text-sm text-green-700">
                            <i class="fa fa-check-circle mr-1"></i>
                            预约已成功取消。
                        </p>
                    </div>
                </div>
            </div>
        </c:if>
        <!-- 预订表格 -->
        <div class="p-6">
            <div class="flex flex-col">
                <div class="-my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
                    <div class="py-2 align-middle inline-block min-w-full sm:px-6 lg:px-8">
                        <div class="shadow overflow-hidden border-b border-gray-200 rounded-lg table-shadow">
                            <table class="min-w-full divide-y divide-gray-200">
                                <thead class="bg-neutral-50">
                                <tr>
                                    <th scope="col" class="px-6 py-4 text-left text-xs font-semibold text-neutral-600 uppercase tracking-wider">
                                        <i class="fa fa-file-text-o mr-2 text-primary"></i>会议主题
                                    </th>
                                    <th scope="col" class="px-6 py-4 text-left text-xs font-semibold text-neutral-600 uppercase tracking-wider">
                                        <i class="fa fa-building-o mr-2 text-primary"></i>会议室
                                    </th>
                                    <th scope="col" class="px-6 py-4 text-left text-xs font-semibold text-neutral-600 uppercase tracking-wider">
                                        <i class="fa fa-calendar mr-2 text-primary"></i>开始时间
                                    </th>
                                    <th scope="col" class="px-6 py-4 text-left text-xs font-semibold text-neutral-600 uppercase tracking-wider">
                                        <i class="fa fa-calendar-check-o mr-2 text-primary"></i>结束时间
                                    </th>
                                    <th scope="col" class="px-6 py-4 text-left text-xs font-semibold text-neutral-600 uppercase tracking-wider">
                                        <i class="fa fa-flag mr-2 text-primary"></i>状态
                                    </th>
                                    <th scope="col" class="px-6 py-4 text-right text-xs font-semibold text-neutral-600 uppercase tracking-wider">
                                        <i class="fa fa-cog mr-2 text-primary"></i>操作
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="bg-white divide-y divide-gray-200 animate-fade-in">
                                <c:forEach var="booking" items="${myBookings}">
                                    <tr class="hover-scale hover:bg-gray-50 transition-colors duration-200">
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="flex items-center">
                                                <div class="ml-4">
                                                    <div class="text-sm font-medium text-neutral-700">${booking.title}</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="text-sm text-neutral-600">${booking.room.roomName}</div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="text-sm text-neutral-600">
                                                <fmt:formatDate value="${booking.startTime}" pattern="yyyy-MM-dd HH:mm"/>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="text-sm text-neutral-600">
                                                <fmt:formatDate value="${booking.endTime}" pattern="yyyy-MM-dd HH:mm"/>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <c:choose>
                                                <c:when test="${booking.status == 'confirmed'}">
                                                            <span class="status-pill bg-green-100 text-green-800 hover:bg-green-200">
                                                                <i class="fa fa-check-circle mr-1"></i>已确认
                                                            </span>
                                                </c:when>
                                                <c:when test="${booking.status == 'pending'}">
                                                            <span class="status-pill bg-yellow-100 text-yellow-800 hover:bg-yellow-200 animate-pulse-slow">
                                                                <i class="fa fa-clock-o mr-1"></i>待审批
                                                            </span>
                                                </c:when>
                                                <c:when test="${booking.status == 'cancelled'}">
                                                            <span class="status-pill bg-red-100 text-red-800 hover:bg-red-200">
                                                                <i class="fa fa-times-circle mr-1"></i>已取消
                                                            </span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                            <c:if test="${booking.status != 'cancelled'}">
                                                <a href="${pageContext.request.contextPath}/management?action=cancel&bookingId=${booking.bookingId}"
                                                   onclick="return confirm('您确定要取消这个预约吗？')"
                                                   class="text-danger hover:text-red-700 transition-colors duration-200 flex items-center justify-end">
                                                    <i class="fa fa-ban mr-1"></i>取消
                                                </a>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty myBookings}">
                                    <tr>
                                        <td colspan="6" class="px-6 py-12 text-center">
                                            <div class="flex flex-col items-center justify-center">
                                                <div class="w-16 h-16 bg-gray-100 rounded-full flex items-center justify-center mb-4">
                                                    <i class="fa fa-calendar-o text-gray-400 text-2xl"></i>
                                                </div>
                                                <h3 class="text-lg font-medium text-neutral-600 mb-2">您当前没有任何预约记录</h3>
                                                <p class="text-sm text-neutral-500 max-w-md">点击下方按钮可以查看可用会议室并进行预约</p>
                                                <a href="${pageContext.request.contextPath}/booking" class="mt-4 inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-primary hover:bg-primary/90 transition-colors duration-200">
                                                    <i class="fa fa-plus-circle mr-2"></i>创建新预约
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="p-4 bg-neutral-50 border-t border-neutral-100 flex justify-between items-center">
                <div class="text-xs text-neutral-500">
                    <i class="fa fa-info-circle mr-1"></i>
                    最后更新: <span id="last-update">刚刚</span>
                </div>
                <div class="text-xs text-neutral-500">
                    <i class="fa fa-refresh mr-1"></i>
                    <a href="#" class="hover:text-primary transition-colors">刷新记录</a>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    // 更新当前时间
    function updateCurrentTime() {
        const now = new Date();
        const options = { year: 'numeric', month: '2-digit', day: '2-digit',
            hour: '2-digit', minute: '2-digit', second: '2-digit',
            hour12: false };
        document.getElementById('current-time').textContent = now.toLocaleString('zh-CN', options);
    }
    // 初始更新时间
    updateCurrentTime();
    // 每秒更新一次
    setInterval(updateCurrentTime, 1000);
</script>
</body>
</html>