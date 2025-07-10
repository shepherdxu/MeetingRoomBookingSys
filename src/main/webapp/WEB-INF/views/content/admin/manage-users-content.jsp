<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="viz" value="${vizData}" />

<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>员工账号信息管理</title>
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

        .btn-action {
            transition: all 0.2s ease-in-out;
            padding: 0.375rem 0.75rem; /* py-1.5 px-3 */
            border-radius: 0.375rem; /* rounded-md */
            font-size: 0.875rem; /* text-sm */
            font-weight: 500; /* font-medium */
            display: inline-block; /* For proper padding and hover area */
            text-decoration: none; /* Remove default underline */
        }

        .btn-edit {
            color: #1890ff; /* blue-600 */
            border: 1px solid #1890ff;
        }
        .btn-edit:hover {
            background-color: #E6F7FF; /* blue-100 */
            color: #096BDE; /* blue-800 */
            box-shadow: 0 2px 8px rgba(24, 144, 255, 0.3);
            transform: translateY(-1px);
        }

        .btn-delete {
            color: #EF4444; /* red-600 */
            border: 1px solid #EF4444;
        }
        .btn-delete:hover {
            background-color: #FEE2E2; /* red-100 */
            color: #991B1B; /* red-900 */
            box-shadow: 0 2px 8px rgba(239, 68, 68, 0.3);
            transform: translateY(-1px);
        }

        /* Enhanced input/select focus styles */
        input[type="text"]:focus,
        select:focus {
            border-color: #1890ff;
            box-shadow: 0 0 0 3px rgba(24, 144, 255, 0.2);
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
            height: 150px; /* max-h-64 */
            width: 100%;
            padding: 1rem; /* p-4 */
            box-sizing: border-box;
            display: flex;
            justify-content: center;
            align-items: center;
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

        /* Custom style for "管理员账号不可删除" text with animations */
        .admin-disabled-action {
            background: linear-gradient(90deg, #e0e7ff, #c7d2fe, #e0e7ff); /* Light blue gradient */
            background-size: 200% 100%; /* Make it wider than the element for animation */
            color: #4338ca; /* Indigo-700 for text */
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            position: relative; /* For pseudo-element glow */
            z-index: 1; /* Ensure text is above pseudo-element */
            display: inline-block; /* Required for padding and background */
            white-space: nowrap; /* Prevent text wrapping */
        }

        .admin-disabled-action:hover {
            background-position: -100% 0; /* Animate gradient */
            box-shadow: 0 4px 15px rgba(67, 56, 202, 0.2); /* Stronger shadow on hover */
            transform: translateY(-2px);
        }

        .admin-disabled-action::before {
            content: '';
            position: absolute;
            top: -5px;
            left: -5px;
            right: -5px;
            bottom: -5px;
            background: inherit; /* Inherit gradient from parent */
            filter: blur(10px); /* Apply blur to the pseudo-element */
            z-index: -1; /* Place behind the text */
            opacity: 0; /* Hidden by default */
            transition: opacity 0.3s ease;
            border-radius: inherit; /* Match parent's border-radius */
        }

        .admin-disabled-action:hover::before {
            opacity: 1; /* Show glow on hover */
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
    <!-- Viz Cards -->
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-6">
        <div class="lg:col-span-1 bg-white p-6 rounded-lg shadow-md flex flex-col justify-center items-center content-card-enhanced">
            <h4 class="text-lg font-semibold text-gray-500">员工总数</h4>
            <p class="text-5xl font-bold text-gray-800 mt-2">${viz.totalUsers}</p>
        </div>
        <div class="lg:col-span-1 bg-white p-6 rounded-lg shadow-md content-card-enhanced">
            <h4 class="text-lg font-semibold text-gray-800 mb-2 text-center">部门分布</h4>
            <div class="chart-container">
                <canvas id="usersByDeptPieChart"></canvas>
            </div>
        </div>
        <div class="lg:col-span-1 bg-white p-6 rounded-lg shadow-md content-card-enhanced">
            <h4 class="text-lg font-semibold text-gray-800 mb-2 text-center">角色分布</h4>
            <div class="chart-container">
                <canvas id="usersByRolePieChart"></canvas>
            </div>
        </div>
    </div>

    <!-- Main Table -->
    <div class="bg-white p-8 rounded-lg shadow-md content-card-enhanced">
        <!-- 员工账号信息管理标题 -->
        <div class="flex flex-col md:flex-row justify-between items-center mb-6 gap-4">
            <h2 class="text-2xl font-bold text-gray-800">员工账号信息管理</h2>

        </div>

        <!-- 消息提示区域 -->
        <c:if test="${param.message == 'saved'}">
            <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded-lg relative mb-6 alert" role="alert">用户信息已保存。</div>
        </c:if>
        <c:if test="${param.message == 'deleted'}">
            <div class="bg-yellow-100 border border-yellow-400 text-yellow-700 px-4 py-3 rounded-lg relative mb-6 alert" role="alert">用户已删除。</div>
        </c:if>

        <!-- 用户列表表格 -->
        <div class="overflow-x-auto table-wrapper">
            <table class="w-full text-sm text-left text-gray-500">
                <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                <tr>
                    <th class="px-6 py-3">ID</th>
                    <th class="px-6 py-3">姓名</th>
                    <th class="px-6 py-3">用户名</th>
                    <th class="px-6 py-3">部门</th>
                    <th class="px-6 py-3">角色</th>
                    <th class="px-6 py-3 text-center">操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="u" items="${users}">
                    <tr class="bg-white border-b hover:bg-gray-50 table-row-hover">
                        <td class="px-6 py-4">${u.userId}</td>
                        <td class="px-6 py-4 font-medium text-gray-900">${u.fullName}</td>
                        <td class="px-6 py-4">${u.username}</td>
                        <td class="px-6 py-4">${u.department.departmentName}</td>
                        <td class="px-6 py-4">
                            <c:if test="${u.role == 'admin'}">
                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-purple-100 text-purple-800">管理员</span>
                            </c:if>
                            <c:if test="${u.role == 'employee'}">
                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-gray-100 text-gray-800">员工</span>
                            </c:if>
                        </td>
                        <td class="px-6 py-4 text-center space-x-2">
                            <c:if test="${u.userId == sessionScope.user.userId}">
                                <!-- Current user's own account: always show edit/delete -->
                                <a href="${pageContext.request.contextPath}/admin?action=editUserForm&userId=${u.userId}" class="btn-action btn-edit">编辑</a>
                                <span class="text-gray-300">|</span>
                                <form action="${pageContext.request.contextPath}/admin" method="post" class="inline" onsubmit="return showConfirmDialog(event, '${u.fullName}')">
                                    <input type="hidden" name="action" value="deleteUser">
                                    <input type="hidden" name="userId" value="${u.userId}">
                                    <button type="submit" class="btn-action btn-delete">删除</button>
                                </form>
                            </c:if>
                            <c:if test="${u.userId != sessionScope.user.userId}">
                                <c:choose>
                                    <c:when test="${u.role == 'admin'}">
                                        <!-- Other admin accounts: show "不可删除" with animations -->
                                        <span class="admin-disabled-action px-3 py-1.5 rounded-md text-sm font-medium relative overflow-hidden">
                                            管理员账号不可删除
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Other non-admin accounts: show edit/delete -->
                                        <a href="${pageContext.request.contextPath}/admin?action=editUserForm&userId=${u.userId}" class="btn-action btn-edit">编辑</a>
                                        <span class="text-gray-300">|</span>
                                        <form action="${pageContext.request.contextPath}/admin" method="post" class="inline" onsubmit="return showConfirmDialog(event, '${u.fullName}')">
                                            <input type="hidden" name="action" value="deleteUser">
                                            <input type="hidden" name="userId" value="${u.userId}">
                                            <button type="submit" class="btn-action btn-delete">删除</button>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                <!-- 如果用户列表为空，显示提示信息 -->
                <c:if test="${empty users}">
                    <tr>
                        <td colspan="6" class="text-center py-10 text-gray-500">暂无用户数据。</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- 自定义确认对话框 -->
<div id="confirmDialog" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center z-50 hidden">
    <div class="bg-white p-6 rounded-lg shadow-lg max-w-sm w-full">
        <h3 class="text-lg font-semibold mb-4 text-gray-800">确认删除</h3>
        <p id="confirmMessage" class="mb-6 text-gray-700"></p>
        <div class="flex justify-end space-x-3">
            <button id="cancelDelete" class="px-4 py-2 bg-gray-200 text-gray-800 rounded-lg hover:bg-gray-300 transition duration-150 ease-in-out dialog-btn dialog-btn-cancel">取消</button>
            <button id="confirmDelete" class="px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 transition duration-150 ease-in-out dialog-btn dialog-btn-confirm">删除</button>
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

        const createPieChart = (ctx, chartData, title) => {
            const labels = chartData.map(d => d.name);
            const data = chartData.map(d => d.value);
            const backgroundColors = [
                '#60A5FA', /* blue-400 */
                '#A78BFA', /* purple-400 */
                '#34D399', /* green-400 */
                '#FCD34D', /* yellow-400 */
                '#FB923C', /* orange-400 */
                '#F87171', /* red-400 */
                '#818CF8', /* indigo-400 */
                '#EC4899', /* pink-400 */
            ];

            new Chart(ctx, {
                type: 'doughnut', /* Changed to doughnut for a modern look */
                data: {
                    labels: labels,
                    datasets: [{
                        data: data,
                        backgroundColor: backgroundColors.slice(0, labels.length), /* Use enough colors */
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
                                color: '#4B5563', /* Gray-700 */
                                boxWidth: 12
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
        };

        const deptCtx = document.getElementById('usersByDeptPieChart').getContext('2d');
        const deptData = JSON.parse('${viz.usersByDeptPieChart}');
        createPieChart(deptCtx, deptData, '部门分布');

        const roleCtx = document.getElementById('usersByRolePieChart').getContext('2d');
        const roleData = JSON.parse('${viz.usersByRolePieChart}');
        createPieChart(roleCtx, roleData, '角色分布');

        // --- Custom Confirmation Dialog Logic ---
        const confirmDialog = document.getElementById('confirmDialog');
        const confirmMessage = document.getElementById('confirmMessage');
        const cancelDeleteButton = document.getElementById('cancelDelete');
        const confirmDeleteButton = document.getElementById('confirmDelete');
        let currentForm = null; // To store the form that triggered the dialog

        window.showConfirmDialog = function(event, userName) {
            event.preventDefault(); // Prevent the default form submission
            currentForm = event.target; // Store the current form

            confirmMessage.textContent = `确定要删除用户“${userName}”吗？此操作不可逆。`;
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
