<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="viz" value="${vizData}" />

<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>会议室审批管理</title>
    <!-- 引入 Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- 引入 Inter 字体 -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

        /* Enhanced table row hover effect */
        .table-row-hover:hover {
            background-color: #f5f7fa;
            transform: scale(1.005);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        /* Button hover effects */
        .btn-action {
            transition: all 0.2s ease-in-out;
            padding: 0.375rem 0.75rem; /* py-1.5 px-3 */
            border-radius: 0.375rem; /* rounded-md */
            font-size: 0.875rem; /* text-sm */
            font-weight: 500; /* font-medium */
        }

        .btn-approve {
            color: #10B981; /* green-600 */
            border: 1px solid #10B981;
        }
        .btn-approve:hover {
            background-color: #D1FAE5; /* green-100 */
            color: #065F46; /* green-900 */
            box-shadow: 0 2px 8px rgba(16, 185, 129, 0.3);
            transform: translateY(-1px);
        }

        .btn-reject {
            color: #EF4444; /* red-600 */
            border: 1px solid #EF4444;
        }
        .btn-reject:hover {
            background-color: #FEE2E2; /* red-100 */
            color: #991B1B; /* red-900 */
            box-shadow: 0 2px 8px rgba(239, 68, 68, 0.3);
            transform: translateY(-1px);
        }

        /* Message alerts */
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

        /* Table container styling for rounded corners and shadow */
        .table-wrapper {
            border-radius: 0.5rem; /* rounded-lg */
            overflow: hidden; /* Ensures child elements respect border-radius */
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        }

        /* Chart container styling */
        .chart-container {
            position: relative;
            height: 120px; /* max-h-32 */
            width: 100%;
            padding: 1rem; /* p-4 */
            box-sizing: border-box;
            display: flex;
            justify-content: center;
            align-items: center;
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

<div class="container mx-auto space-y-8 relative z-0">
    <!-- Viz & Pending Table -->
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <div class="lg:col-span-2 bg-white p-8 rounded-lg shadow-md content-card-enhanced">
            <h2 class="text-2xl font-bold text-gray-800 mb-6">待审批的预约</h2>
            <c:if test="${param.message == 'approved'}">
                <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded-lg relative mb-6 alert" role="alert">
                    操作成功：预约已批准。
                </div>
            </c:if>
            <c:if test="${param.message == 'rejected'}">
                <div class="bg-yellow-100 border border-yellow-400 text-yellow-700 px-4 py-3 rounded-lg relative mb-6 alert" role="alert">
                    操作成功：预约已拒绝。
                </div>
            </c:if>
            <div class="overflow-x-auto table-wrapper">
                <table class="w-full text-sm text-left text-gray-500">
                    <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                    <tr>
                        <th class="px-6 py-3">申请人</th>
                        <th class="px-6 py-3">主题</th>
                        <th class="px-6 py-3">开始时间</th>
                        <th class="px-6 py-3">结束时间</th>
                        <th class="px-6 py-3 text-center">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="booking" items="${pendingBookings}">
                        <tr class="bg-white border-b hover:bg-gray-50 table-row-hover">
                            <td class="px-6 py-4">${booking.requester.fullName}</td>
                            <td class="px-6 py-4 font-medium text-gray-900">
                                    ${booking.title}
                                <div class="text-xs text-gray-500">${booking.room.roomName}</div>
                            </td>
                            <td class="px-6 py-4"><fmt:formatDate value="${booking.startTime}" pattern="MM-dd HH:mm"/></td>
                            <td class="px-6 py-4"><fmt:formatDate value="${booking.endTime}" pattern="MM-dd HH:mm"/></td>
                            <td class="px-6 py-4 text-center space-x-2">
                                <form action="${pageContext.request.contextPath}/admin" method="post" class="inline">
                                    <input type="hidden" name="action" value="approve"/>
                                    <input type="hidden" name="bookingId" value="${booking.bookingId}"/>
                                    <button type="submit" class="btn-action btn-approve">批准</button>
                                </form>
                                <span class="text-gray-300">|</span>
                                <form action="${pageContext.request.contextPath}/admin" method="post" class="inline">
                                    <input type="hidden" name="action" value="reject"/>
                                    <input type="hidden" name="bookingId" value="${booking.bookingId}"/>
                                    <button type="submit" class="btn-action btn-reject">拒绝</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty pendingBookings}">
                        <tr>
                            <td colspan="5" class="text-center py-10 text-gray-500">当前没有待审批的预约。</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="lg:col-span-1 space-y-6">
            <div class="bg-white p-6 rounded-lg shadow-md content-card-enhanced">
                <h4 class="text-sm font-semibold text-gray-500 mb-2">当前待审批总数</h4>
                <p class="text-3xl font-bold text-gray-800">${viz.pendingCount}</p>
            </div>
            <div class="bg-white p-6 rounded-lg shadow-md content-card-enhanced">
                <h4 class="text-sm font-semibold text-gray-500 mb-2">待审批总时长 (小时)</h4>
                <p class="text-3xl font-bold text-gray-800"><fmt:formatNumber value="${viz.pendingTotalHours}" maxFractionDigits="1"/></p>
            </div>
            <div class="bg-white p-6 rounded-lg shadow-md content-card-enhanced">
                <h4 class="text-sm font-semibold text-gray-500 mb-2">全公司审批状态</h4>
                <div class="chart-container">
                    <canvas id="approvalStatusPieChart"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- Approval History -->
    <div class="bg-white p-8 rounded-lg shadow-md content-card-enhanced">
        <h2 class="text-2xl font-bold text-gray-800 mb-6">近期审批历史</h2>
        <div class="overflow-x-auto table-wrapper">
            <table class="w-full text-sm text-left text-gray-500">
                <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                <tr>
                    <th class="px-6 py-3">会议主题</th>
                    <th class="px-6 py-3">申请人</th>
                    <th class="px-6 py-3">审批状态</th>
                    <th class="px-6 py-3">审批时间</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="h" items="${viz.approvalHistory}">
                    <tr class="bg-white border-b hover:bg-gray-50 table-row-hover">
                        <td class="px-6 py-4 font-medium text-gray-900">${h.title}</td>
                        <td class="px-6 py-4">${h.requester.fullName}</td>
                        <td class="px-6 py-4">
                            <c:if test="${h.status == 'confirmed'}">
                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">已批准</span>
                            </c:if>
                            <c:if test="${h.status == 'rejected'}">
                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-100 text-red-800">已驳回</span>
                            </c:if>
                        </td>
                        <td class="px-6 py-4"><fmt:formatDate value="${h.createdAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                    </tr>
                </c:forEach>
                <c:if test="${empty viz.approvalHistory}">
                    <tr>
                        <td colspan="4" class="text-center py-10 text-gray-500">暂无历史记录。</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function () {
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

        const pieCtx = document.getElementById('approvalStatusPieChart').getContext('2d');
        const pieData = JSON.parse('${viz.approvalStatusPieChart}');

        new Chart(pieCtx, {
            type: 'doughnut',
            data: {
                labels: Object.keys(pieData),
                datasets: [{
                    data: Object.values(pieData),
                    backgroundColor: ['#FBBF24', '#8B5CF6'], // Yellow for pending, Purple for rejected
                    hoverOffset: 8, // Increased hover offset for better visual
                    borderColor: 'rgba(255, 255, 255, 0.8)', // White border for slices
                    borderWidth: 2
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: true, // Display legend
                        position: 'right', // Position legend to the right
                        labels: {
                            font: {
                                size: 12,
                                family: 'Inter, sans-serif'
                            },
                            color: '#4B5563' // Gray-700
                        }
                    },
                    tooltip: {
                        enabled: true,
                        callbacks: {
                            label: function(context) {
                                let label = context.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed !== null) {
                                    label += context.parsed;
                                }
                                return label;
                            }
                        },
                        backgroundColor: 'rgba(0,0,0,0.7)',
                        titleFont: { size: 14, family: 'Inter, sans-serif' },
                        bodyFont: { size: 12, family: 'Inter, sans-serif' },
                        padding: 10,
                        cornerRadius: 6
                    }
                },
                layout: {
                    padding: {
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0
                    }
                }
            }
        });

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
