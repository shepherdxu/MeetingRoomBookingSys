<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>查找并预约会议室</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">

    <!-- 配置亮色主题 -->
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#4f94fc', // 亮蓝色主色调
                        secondary: '#7ccd7c', // 亮绿色辅助色
                        accent: '#ffb6c1', // 亮粉色强调色
                        light: '#f0f8ff',
                        'light-gray': '#e6e6fa',
                        'dark-text': '#333333'
                    },
                    animation: {
                        'float': 'float 6s ease-in-out infinite',
                        'glow': 'glow 2s ease-in-out infinite alternate',
                        'slide-in': 'slideIn 0.5s ease-out forwards',
                    },
                    keyframes: {
                        float: {
                            '0%, 100%': { transform: 'translateY(0)' },
                            '50%': { transform: 'translateY(-10px)' },
                        },
                        glow: {
                            '0%': { boxShadow: '0 0 5px rgba(79, 148, 252, 0.5)' },
                            '100%': { boxShadow: '0 0 20px rgba(79, 148, 252, 0.8), 0 0 30px rgba(124, 205, 124, 0.4)' },
                        },
                        slideIn: {
                            '0%': { transform: 'translateY(20px)', opacity: '0' },
                            '100%': { transform: 'translateY(0)', opacity: '1' },
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
            .text-glow {
                text-shadow: 0 0 10px rgba(79, 148, 252, 0.5), 0 0 20px rgba(79, 148, 252, 0.3);
            }
            .bg-glass {
                background: rgba(255, 255, 255, 0.9);
                backdrop-filter: blur(12px);
                -webkit-backdrop-filter: blur(12px);
            }
            .btn-gradient {
                background: linear-gradient(90deg, #4f94fc, #87cefa, #7ccd7c);
                background-size: 200% 200%;
                animation: gradientShift 3s ease infinite;
            }
            @keyframes gradientShift {
                0% { background-position: 0% 50%; }
                50% { background-position: 100% 50%; }
                100% { background-position: 0% 50%; }
            }
            .btn-pulse {
                animation: btnPulse 2s infinite;
            }
            @keyframes btnPulse {
                0% { box-shadow: 0 0 0 0 rgba(79, 148, 252, 0.7); }
                70% { box-shadow: 0 0 0 10px rgba(79, 148, 252, 0); }
                100% { box-shadow: 0 0 0 0 rgba(79, 148, 252, 0); }
            }
            .input-focus {
                transition: all 0.3s ease;
            }
            .input-focus:focus {
                transform: translateY(-2px);
                box-shadow: 0 0 10px rgba(79, 148, 252, 0.5), 0 0 20px rgba(79, 148, 252, 0.2);
            }
            .hover-scale {
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }
            .hover-scale:hover {
                transform: scale(1.02);
                box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            }
            .hover-glow {
                transition: all 0.3s ease;
            }
            .hover-glow:hover {
                box-shadow: 0 0 15px rgba(79, 148, 252, 0.7), 0 0 30px rgba(79, 148, 252, 0.4);
            }
            .particles-bg {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: -1;
                opacity: 0.2;
            }
        }
    </style>
</head>
<body class="bg-light min-h-screen font-sans text-dark-text overflow-x-hidden">
<!-- 背景粒子效果容器 -->
<div class="particles-bg" id="particles"></div>

<!-- 页面内容 -->
<div class="container mx-auto px-4 py-12 relative z-10">
    <!-- 主内容区 -->
    <main class="max-w-5xl mx-auto">
        <div class="bg-glass border border-primary/30 p-8 md:p-10 rounded-2xl shadow-xl hover-glow transition-all duration-700">
            <h2 class="text-3xl md:text-4xl font-extrabold text-transparent bg-clip-text bg-gradient-to-r from-primary to-secondary mb-8 text-glow animate-float text-center">
                查找并预约会议室
            </h2>

            <c:if test="${not empty error}">
                <div class="bg-red-50 border border-red-200 text-red-700 px-6 py-4 rounded-xl mb-6 shadow-md animate-shake flex items-center">
                    <i class="fa fa-exclamation-circle mr-3 text-xl text-red-500"></i>
                    <span class="block font-medium">${error}</span>
                </div>
            </c:if>

            <!-- Search Form -->
            <div class="bg-white/80 border border-primary/20 p-6 md:p-8 rounded-2xl shadow-lg hover-scale transition duration-500 mb-10">
                <div class="flex items-center mb-5">
                    <div class="w-10 h-10 rounded-full bg-primary/20 flex items-center justify-center mr-3">
                        <i class="fa fa-search text-primary"></i>
                    </div>
                    <h3 class="text-xl font-semibold text-gray-700">会议时间选择</h3>
                </div>
                <form action="${pageContext.request.contextPath}/booking" method="get">
                    <input type="hidden" name="action" value="search">
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 items-end">
                        <div class="space-y-2">
                            <label for="startTime" class="block text-sm font-semibold text-gray-700">开始时间</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fa fa-calendar text-primary/70"></i>
                                </div>
                                <input type="datetime-local" id="startTime" name="startTime" value="${startTime}"
                                       required
                                       class="w-full pl-10 pr-4 py-3 rounded-xl border border-gray-300 focus:border-primary bg-white text-dark-text input-focus">
                            </div>
                        </div>
                        <div class="space-y-2">
                            <label for="endTime" class="block text-sm font-semibold text-gray-700">结束时间</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fa fa-calendar text-primary/70"></i>
                                </div>
                                <input type="datetime-local" id="endTime" name="endTime" value="${endTime}"
                                       required
                                       class="w-full pl-10 pr-4 py-3 rounded-xl border border-gray-300 focus:border-primary bg-white text-dark-text input-focus">
                            </div>
                        </div>
                        <div>
                            <button type="submit"
                                    class="w-full btn-gradient text-white font-bold py-3 px-6 rounded-xl hover:scale-105 transition transform duration-300 flex items-center justify-center btn-pulse shadow-md">
                                <i class="fa fa-search mr-2"></i> 查询可用会议室
                            </button>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Booking Form -->
            <c:if test="${not empty availableRooms}">
                <div class="bg-white/80 border border-primary/20 p-6 md:p-8 rounded-2xl shadow-lg hover-scale transition duration-500 animate-slide-in">
                    <div class="flex items-center mb-6">
                        <div class="w-10 h-10 rounded-full bg-primary/20 flex items-center justify-center mr-3">
                            <i class="fa fa-calendar-plus-o text-primary"></i>
                        </div>
                        <h3 class="text-xl font-semibold text-gray-700">查询结果：请填写信息以完成预约</h3>
                    </div>
                    <form action="${pageContext.request.contextPath}/booking" method="post"
                          class="space-y-6 md:space-y-8">

                        <input type="hidden" name="startTime" value="${startTime}">
                        <input type="hidden" name="endTime" value="${endTime}">

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="space-y-2">
                                <label for="roomId" class="block text-sm font-semibold text-gray-700">选择会议室</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <i class="fa fa-building text-primary/70"></i>
                                    </div>
                                    <select id="roomId" name="roomId" required
                                            class="w-full pl-10 pr-4 py-3 rounded-xl border border-gray-300 focus:border-primary bg-white text-dark-text input-focus appearance-none">
                                        <c:forEach var="room" items="${availableRooms}">
                                            <option value="${room.roomId}">${room.roomName} (${room.location.locationName}, 容量: ${room.capacity})</option>
                                        </c:forEach>
                                    </select>
                                    <div class="absolute inset-y-0 right-0 flex items-center pr-3 pointer-events-none">
                                        <i class="fa fa-chevron-down text-gray-400"></i>
                                    </div>
                                </div>
                            </div>

                            <div class="space-y-2">
                                <label for="title" class="block text-sm font-semibold text-gray-700">会议主题</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <i class="fa fa-file-text-o text-primary/70"></i>
                                    </div>
                                    <input type="text" id="title" name="title" required
                                           class="w-full pl-10 pr-4 py-3 rounded-xl border border-gray-300 focus:border-primary bg-white text-dark-text input-focus">
                                </div>
                            </div>
                        </div>

                        <div class="space-y-2">
                            <label for="attendees" class="block text-sm font-semibold text-gray-700">添加参会人 (按住 Ctrl/Cmd 多选)</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fa fa-users text-primary/70"></i>
                                </div>
                                <select id="attendees" name="attendees" multiple
                                        class="w-full pl-10 pr-4 py-3 rounded-xl border border-gray-300 focus:border-primary bg-white text-dark-text input-focus h-32 appearance-none">
                                    <c:forEach var="employee" items="${employees}">
                                        <c:if test="${employee.userId != sessionScope.user.userId}">
                                            <option value="${employee.userId}">${employee.fullName}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="space-y-2">
                            <label for="notes" class="block text-sm font-semibold text-gray-700">备注 (如需特殊资源请在此说明)</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fa fa-sticky-note-o text-primary/70"></i>
                                </div>
                                <textarea id="notes" name="notes" rows="3"
                                          class="w-full pl-10 pr-4 py-3 rounded-xl border border-gray-300 focus:border-primary bg-white text-dark-text input-focus"></textarea>
                            </div>
                        </div>

                        <div class="flex justify-center pt-4">
                            <button type="submit"
                                    class="btn-gradient text-white font-bold py-3 px-12 rounded-xl hover:scale-105 hover:shadow-xl transition duration-300 flex items-center justify-center btn-pulse shadow-md">
                                <i class="fa fa-calendar-check-o mr-2"></i> 提交预约申请
                            </button>
                        </div>
                    </form>
                </div>
            </c:if>

            <c:if test="${empty availableRooms and not empty startTime and empty error}">
                <div class="bg-white/80 border border-primary/20 p-8 rounded-2xl shadow-lg text-center animate-fade-in-up">
                    <div class="w-16 h-16 rounded-full bg-blue-50 flex items-center justify-center mx-auto mb-5">
                        <i class="fa fa-calendar-times-o text-2xl text-primary/70"></i>
                    </div>
                    <h3 class="text-xl font-semibold mb-3 text-gray-700">暂无可用会议室</h3>
                    <p class="text-gray-600">抱歉，您选择的时间段内没有可用的会议室，请尝试其他时间。</p>
                </div>
            </c:if>
        </div>
    </main>
</div>

<!-- 粒子效果脚本 -->
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const roomSelect = document.getElementById('roomId');
        const amenitiesContainer = document.getElementById('amenities-container');
        const amenitiesCheckboxes = document.getElementById('amenities-checkboxes');

        roomSelect.addEventListener('change', function() {
            amenitiesCheckboxes.innerHTML = ''; // Clear previous checkboxes
            const selectedOption = this.options[this.selectedIndex];
            const amenities = selectedOption.dataset.amenities;

            if (amenities && amenities.trim() !== '') {
                amenitiesContainer.classList.remove('hidden');
                amenities.split(',').forEach(amenity => {
                    const trimmedAmenity = amenity.trim();
                    if(trimmedAmenity){
                        const div = document.createElement('div');
                        div.className = 'flex items-center';
                        const checkbox = document.createElement('input');
                        checkbox.type = 'checkbox';
                        checkbox.name = 'amenities';
                        checkbox.value = trimmedAmenity;
                        checkbox.id = 'amenity-' + trimmedAmenity;
                        checkbox.className = 'h-4 w-4 text-indigo-600 border-gray-300 rounded focus:ring-indigo-500';
                        const label = document.createElement('label');
                        label.htmlFor = 'amenity-' + trimmedAmenity;
                        label.textContent = trimmedAmenity;
                        label.className = 'ml-2 block text-sm text-gray-900';
                        div.appendChild(checkbox);
                        div.appendChild(label);
                        amenitiesCheckboxes.appendChild(div);
                    }
                });
            } else {
                amenitiesContainer.classList.add('hidden');
            }
        });
    });
    document.addEventListener('DOMContentLoaded', function() {
        const particlesContainer = document.getElementById('particles');
        const particleCount = 25;

        for (let i = 0; i < particleCount; i++) {
            const particle = document.createElement('div');

            // 随机大小和位置
            const size = Math.random() * 4 + 1;
            const posX = Math.random() * 100;
            const posY = Math.random() * 100;
            const delay = Math.random() * 5;
            const duration = Math.random() * 20 + 10;
            const opacity = Math.random() * 0.4 + 0.1;

            // 亮色主题粒子颜色
            const colors = ['#4f94fc', '#87cefa', '#7ccd7c', '#b5e3ff'];
            const color = colors[Math.floor(Math.random() * colors.length)];

            particle.style.cssText = `
                    position: absolute;
                    width: ${size}px;
                    height: ${size}px;
                    background: ${color};
                    border-radius: 50%;
                    top: ${posY}%;
                    left: ${posX}%;
                    opacity: ${opacity};
                    box-shadow: 0 0 ${size * 3}px ${color};
                    animation: float ${duration}s ease-in-out ${delay}s infinite;
                `;

            particlesContainer.appendChild(particle);
        }
    });
</script>
</body>
</html>