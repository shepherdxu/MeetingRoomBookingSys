<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="data" value="${dashboardData}" />

<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>仪表盘</title>
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

        /* Export Button Hover Effect */
        .btn-export-enhanced {
            background-color: #4B5563; /* gray-700 */
            color: white;
            font-weight: bold;
            padding: 0.5rem 1rem;
            border-radius: 0.5rem;
            display: flex;
            align-items: center;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .btn-export-enhanced:hover {
            background-color: #1F2937; /* gray-900 */
            transform: translateY(-2px) scale(1.02);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
            border-color: #6B7280; /* gray-500 */
            border-width: 2px;
        }

        /* Icon background gradients */
        .icon-bg-blue { background: linear-gradient(45deg, #3B82F6, #2563EB); } /* blue-500 to blue-600 */
        .icon-bg-green { background: linear-gradient(45deg, #22C55E, #16A34A); } /* green-500 to green-600 */
        .icon-bg-yellow { background: linear-gradient(45deg, #F59E0B, #D97706); } /* yellow-500 to yellow-600 */

        /* Table container styling for rounded corners and shadow */
        .table-wrapper {
            border-radius: 0.5rem; /* rounded-lg */
            overflow: hidden; /* Ensures child elements respect border-radius */
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        }

        /* Chart container styling */
        .chart-container {
            position: relative;
            height: 250px; /* max-h-64 */
            width: 100%;
            padding: 1rem; /* p-4 */
            box-sizing: border-box;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Status badges */
        .status-badge {
            transition: all 0.3s ease;
            animation: pulse-status 1.5s infinite;
        }

        .status-badge-occupied {
            background-color: #FEE2E2; /* red-100 */
            color: #EF4444; /* red-600 */
        }

        .status-badge-available {
            background-color: #D1FAE5; /* green-100 */
            color: #10B981; /* green-600 */
        }

        @keyframes pulse-status {
            0% { transform: scale(1); opacity: 1; }
            50% { transform: scale(1.05); opacity: 0.9; }
            100% { transform: scale(1); opacity: 1; }
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

<div class="container mx-auto relative z-0">
    <!-- Stat Cards -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-6">
        <!-- Card items with hover animations -->
        <div class="bg-white p-6 rounded-lg shadow-md flex items-center content-card-enhanced">
            <div class="icon-bg-blue p-3 rounded-full text-white mr-4 shadow-lg"><svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg></div>
            <div><p class="text-sm text-gray-500">今日已确认预约</p><p class="text-2xl font-bold text-gray-800">${data.todaysBookingsCount}</p></div>
        </div>
        <div class="bg-white p-6 rounded-lg shadow-md flex items-center content-card-enhanced">
            <div class="icon-bg-green p-3 rounded-full text-white mr-4 shadow-lg"><svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg></div>
            <div><p class="text-sm text-gray-500">可用会议室</p><p class="text-2xl font-bold text-gray-800">${data.availableRoomsCount} / ${data.totalRooms}</p></div>
        </div>
        <div class="bg-white p-6 rounded-lg shadow-md flex items-center content-card-enhanced">
            <div class="icon-bg-yellow p-3 rounded-full text-white mr-4 shadow-lg"><svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4"></path></svg></div>
            <div><p class="text-sm text-gray-500">待审批申请</p><p class="text-2xl font-bold text-gray-800">${data.pendingRequestsCount}</p></div>
        </div>
        <div class="bg-white p-6 rounded-lg shadow-md flex items-center justify-center content-card-enhanced">
            <a href="${pageContext.request.contextPath}/report?type=todays_bookings" class="btn-export-enhanced">
                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"></path></svg>
                导出报表
            </a>
        </div>
    </div>

    <!-- Charts and Live Status -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
        <div class="bg-white p-6 rounded-lg shadow-md content-card-enhanced">
            <h3 class="text-lg font-semibold text-gray-800 mb-4">会议室状态分布</h3>
            <div class="chart-container">
                <canvas id="roomStatusChart"></canvas>
            </div>
        </div>
        <div class="bg-white p-6 rounded-lg shadow-md content-card-enhanced">
            <h3 class="text-lg font-semibold text-gray-800 mb-4">近7日预定趋势</h3>
            <div class="chart-container">
                <canvas id="dailyBookingChart"></canvas>
            </div>
        </div>
    </div>

    <!-- Room Live Status Table -->
    <div class="bg-white p-6 rounded-lg shadow-md content-card-enhanced">
        <h3 class="text-lg font-semibold text-gray-800 border-b pb-2 mb-4">会议室实时状态</h3>
        <div class="overflow-x-auto table-wrapper">
            <table class="w-full text-sm text-left text-gray-500">
                <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                <tr>
                    <th class="px-6 py-3">会议室</th>
                    <th class="px-6 py-3">当前状态</th>
                    <th class="px-6 py-3">占用详情</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="room" items="${data.allRooms}">
                    <tr class="bg-white border-b hover:bg-gray-50 table-row-hover">
                        <td class="px-6 py-4 font-medium text-gray-900">${room.roomName} (${room.location.locationName})</td>
                        <c:set var="activeBooking" value="${data.activeBookingsMap[room.roomId]}"/>
                        <c:choose>
                            <c:when test="${not empty activeBooking}">
                                <td class="px-6 py-4">
                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full status-badge status-badge-occupied">使用中</span>
                                </td>
                                <td class="px-6 py-4">
                                    <p class="font-semibold">${activeBooking.title}</p>
                                    <p class="text-xs text-gray-600">
                                        by ${activeBooking.requester.fullName} |
                                        <fmt:formatDate value="${activeBooking.startTime}" pattern="HH:mm"/> - <fmt:formatDate value="${activeBooking.endTime}" pattern="HH:mm"/>
                                    </p>
                                </td>
                            </c:when>
                            <c:otherwise>
                                <td class="px-6 py-4">
                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full status-badge status-badge-available">空闲</span>
                                </td>
                                <td class="px-6 py-4 text-gray-400 italic">--</td>
                            </c:otherwise>
                        </c:choose>
                    </tr>
                </c:forEach>
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

        const pieCtx = document.getElementById('roomStatusChart').getContext('2d');
        const pieData = JSON.parse('${data.roomStatusChartData}');
        new Chart(pieCtx, {
            type: 'doughnut', /* Changed to doughnut for a modern look */
            data: {
                labels: Object.keys(pieData),
                datasets: [{
                    data: Object.values(pieData),
                    backgroundColor: ['#EF4444', '#22C55E'], /* Red for occupied, Green for available */
                    hoverOffset: 8, /* Increased hover offset for better visual */
                    borderColor: 'rgba(255, 255, 255, 0.8)', /* White border for slices */
                    borderWidth: 2
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: true,
                        position: 'bottom',
                        labels: {
                            font: {
                                size: 12,
                                family: 'Inter, sans-serif'
                            },
                            color: '#4B5563' /* Gray-700 */
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

        const lineCtx = document.getElementById('dailyBookingChart').getContext('2d');
        const lineData = JSON.parse('${data.dailyBookingChartData}');
        const labels = lineData.map(d => new Date(d.date).toLocaleDateString('zh-CN', { month: '2-digit', day: '2-digit' }));
        const counts = lineData.map(d => d.count);
        new Chart(lineCtx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [{
                    label: '每日新增预定数',
                    data: counts,
                    fill: true, /* Changed to true for area fill */
                    borderColor: '#3B82F6', /* blue-500 */
                    backgroundColor: 'rgba(59, 130, 246, 0.2)', /* blue-500 with transparency */
                    tension: 0.4, /* Increased tension for smoother curves */
                    pointBackgroundColor: '#3B82F6',
                    pointBorderColor: '#fff',
                    pointHoverBackgroundColor: '#fff',
                    pointHoverBorderColor: '#3B82F6',
                    pointBorderWidth: 2,
                    pointHoverRadius: 6,
                    pointHoverBorderWidth: 2,
                    pointRadius: 4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: '#E5E7EB' /* gray-200 */
                        },
                        ticks: {
                            color: '#6B7280' /* gray-500 */
                        }
                    },
                    x: {
                        grid: {
                            display: false
                        },
                        ticks: {
                            color: '#6B7280' /* gray-500 */
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        enabled: true,
                        callbacks: {
                            label: function(context) {
                                let label = context.dataset.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed.y !== null) {
                                    label += context.parsed.y;
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
                }
            }
        });
    });
</script>
</body>
</html>
