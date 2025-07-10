// 全局数据存储
const AppData = {
    // 用户信息
    currentUser: null,
    isLoggedIn: false,

    // 模拟数据
    userTypes: [
        { id: 'employee', name: '普通员工', icon: '👤' },
        { id: 'guest', name: '访客', icon: '🎫' },
        { id: 'manager', name: '部门经理', icon: '👔' },
        { id: 'admin', name: '系统管理员', icon: '⚙️' },
    ],

    locations: [
        { id: 1, name: 'A栋-1楼', description: '主办公区域' },
        { id: 2, name: 'A栋-2楼', description: '技术部门' },
        { id: 3, name: 'A栋-3楼', description: '管理层办公区' },
        { id: 4, name: 'B栋-1楼', description: '会议中心' },
        { id: 5, name: 'B栋-2楼', description: '培训中心' },
    ],

    rooms: [
        {
            id: 1,
            name: '会议室101',
            capacity: 8,
            amenities: '投影仪, 白板',
            locationId: 1,
            status: 'available',
        },
        {
            id: 2,
            name: '会议室102',
            capacity: 12,
            amenities: '投影仪, 白板, 音响',
            locationId: 1,
            status: 'occupied',
        },
        {
            id: 3,
            name: '会议室201',
            capacity: 6,
            amenities: '电视, 白板',
            locationId: 2,
            status: 'available',
        },
        {
            id: 4,
            name: '会议室301',
            capacity: 20,
            amenities: '投影仪, 音响, 视频会议',
            locationId: 3,
            status: 'available',
        },
        {
            id: 5,
            name: '大会议室',
            capacity: 50,
            amenities: '投影仪, 音响, 舞台',
            locationId: 4,
            status: 'maintenance',
        },
        {
            id: 6,
            name: '培训室A',
            capacity: 30,
            amenities: '投影仪, 音响, 培训设备',
            locationId: 5,
            status: 'available',
        },
    ],

    bookings: [
        {
            id: 1,
            title: '项目启动会',
            roomId: 1,
            date: '2024-01-15',
            startTime: '09:00',
            endTime: '11:00',
            status: 'confirmed',
            requester: '张三',
            attendees: '张三, 李四, 王五',
            notes: '讨论新项目启动计划',
        },
        {
            id: 2,
            title: '技术评审',
            roomId: 3,
            date: '2024-01-15',
            startTime: '14:00',
            endTime: '16:00',
            status: 'pending',
            requester: '李四',
            attendees: '李四, 技术团队',
            notes: '代码评审会议',
        },
        {
            id: 3,
            title: '月度总结',
            roomId: 4,
            date: '2024-01-16',
            startTime: '10:00',
            endTime: '12:00',
            status: 'confirmed',
            requester: '王五',
            attendees: '王五, 各部门负责人',
            notes: '月度工作总结会议',
        },
    ],

    departments: [
        { id: 1, name: '技术部' },
        { id: 2, name: '市场部' },
        { id: 3, name: '人事部' },
        { id: 4, name: '财务部' },
    ],

    users: [
        { id: 1, username: 'zhangsan', fullName: '张三', role: 'employee', departmentId: 1 },
        { id: 2, username: 'lisi', fullName: '李四', role: 'employee', departmentId: 1 },
        { id: 3, username: 'wangwu', fullName: '王五', role: 'manager', departmentId: 2 },
        { id: 4, username: 'admin', fullName: '系统管理员', role: 'admin', departmentId: null },
    ],
};

// 工具函数
const Utils = {
    // 获取用户角色名称
    getUserRoleName(roleId) {
        const userType = AppData.userTypes.find(type => type.id === roleId);
        return userType ? userType.name : '未知';
    },

    // 获取位置名称
    getLocationName(locationId) {
        const location = AppData.locations.find(loc => loc.id === locationId);
        return location ? location.name : '未知位置';
    },

    // 获取会议室信息
    getRoomInfo(roomId) {
        return AppData.rooms.find(room => room.id === roomId);
    },

    // 格式化日期
    formatDate(dateString) {
        const date = new Date(dateString);
        return date.toLocaleDateString('zh-CN');
    },

    // 格式化时间
    formatTime(timeString) {
        return timeString;
    },

    // 获取状态标签HTML
    getStatusBadge(status, text) {
        return `<span class="status status-${status}">${text}</span>`;
    },

    // 显示消息
    showMessage(message, type = 'info') {
        const messageDiv = document.createElement('div');
        messageDiv.className = `alert alert-${type}`;
        messageDiv.textContent = message;
        messageDiv.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 1rem;
            border-radius: 0.5rem;
            color: white;
            z-index: 1000;
            max-width: 300px;
        `;

        if (type === 'success') {
            messageDiv.style.background = '#059669';
        } else if (type === 'error') {
            messageDiv.style.background = '#dc2626';
        } else {
            messageDiv.style.background = '#1e40af';
        }

        document.body.appendChild(messageDiv);

        setTimeout(() => {
            messageDiv.remove();
        }, 3000);
    },
};

// 用户认证管理
const Auth = {
    // 登录
    login(userType, username, password) {
        if (!userType || !username || !password) {
            Utils.showMessage('请填写所有必填项！', 'error');
            return false;
        }

        // 模拟登录验证
        const user = AppData.users.find(u => u.username === username);
        if (!user) {
            Utils.showMessage('用户名不存在！', 'error');
            return false;
        }

        AppData.currentUser = {
            ...user,
            userType: userType
        };
        AppData.isLoggedIn = true;

        // 保存到本地存储
        localStorage.setItem('currentUser', JSON.stringify(AppData.currentUser));
        localStorage.setItem('isLoggedIn', 'true');

        Utils.showMessage('登录成功！', 'success');
        return true;
    },

    // 登出
    logout() {
        AppData.currentUser = null;
        AppData.isLoggedIn = false;
        localStorage.removeItem('currentUser');
        localStorage.removeItem('isLoggedIn');
        window.location.href = 'index.jsp';
    },

    // 检查登录状态
    checkLoginStatus() {
        const isLoggedIn = localStorage.getItem('isLoggedIn');
        const currentUser = localStorage.getItem('currentUser');

        if (isLoggedIn === 'true' && currentUser) {
            AppData.isLoggedIn = true;
            AppData.currentUser = JSON.parse(currentUser);
            return true;
        }
        return false;
    },

    // 获取当前用户
    getCurrentUser() {
        return AppData.currentUser;
    },

    // 检查权限
    hasPermission(permission) {
        if (!AppData.currentUser) return false;

        const role = AppData.currentUser.role;
        const userType = AppData.currentUser.userType;

        switch (permission) {
            case 'approve':
                return role === 'manager' || role === 'admin';
            case 'manage_rooms':
                return role === 'admin';
            case 'manage_users':
                return role === 'admin';
            case 'view_reports':
                return role === 'admin';
            default:
                return true;
        }
    }
};

// 会议室管理
const RoomManager = {
    // 获取所有会议室
    getAllRooms() {
        return AppData.rooms;
    },

    // 根据位置筛选会议室
    getRoomsByLocation(locationId) {
        if (!locationId) return AppData.rooms;
        return AppData.rooms.filter(room => room.locationId === locationId);
    },

    // 获取会议室状态统计
    getRoomStats() {
        const total = AppData.rooms.length;
        const available = AppData.rooms.filter(room => room.status === 'available').length;
        const occupied = AppData.rooms.filter(room => room.status === 'occupied').length;
        const maintenance = AppData.rooms.filter(room => room.status === 'maintenance').length;

        return { total, available, occupied, maintenance };
    },

    // 获取位置统计
    getLocationStats() {
        return AppData.locations.map(location => {
            const locationRooms = AppData.rooms.filter(room => room.locationId === location.id);
            const availableRooms = locationRooms.filter(room => room.status === 'available');
            const occupiedRooms = locationRooms.filter(room => room.status === 'occupied');
            const maintenanceRooms = locationRooms.filter(room => room.status === 'maintenance');
            const totalCapacity = locationRooms.reduce((sum, room) => sum + room.capacity, 0);

            return {
                ...location,
                totalRooms: locationRooms.length,
                availableRooms: availableRooms.length,
                occupiedRooms: occupiedRooms.length,
                maintenanceRooms: maintenanceRooms.length,
                totalCapacity,
                utilizationRate: locationRooms.length > 0
                    ? Math.round((occupiedRooms.length / locationRooms.length) * 100)
                    : 0,
            };
        });
    }
};

// 预约管理
const BookingManager = {
    // 获取所有预约
    getAllBookings() {
        return AppData.bookings;
    },

    // 获取用户的预约
    getUserBookings(username) {
        return AppData.bookings.filter(booking => booking.requester === username);
    },

    // 获取待审批的预约
    getPendingBookings() {
        return AppData.bookings.filter(booking => booking.status === 'pending');
    },

    // 创建新预约
    createBooking(bookingData) {
        const newBooking = {
            id: AppData.bookings.length + 1,
            ...bookingData,
            status: 'pending',
            requester: AppData.currentUser.fullName,
        };

        AppData.bookings.push(newBooking);
        Utils.showMessage('预约申请已提交，等待审批！', 'success');
        return newBooking;
    },

    // 审批预约
    approveBooking(bookingId, action) {
        const booking = AppData.bookings.find(b => b.id === bookingId);
        if (!booking) {
            Utils.showMessage('预约不存在！', 'error');
            return false;
        }

        booking.status = action === 'approve' ? 'confirmed' : 'rejected';
        const actionText = action === 'approve' ? '批准' : '拒绝';
        Utils.showMessage(`预约已${actionText}！`, 'success');
        return true;
    },

    // 检查时间冲突
    checkTimeConflict(roomId, date, startTime, endTime, excludeBookingId = null) {
        return AppData.bookings.some(booking => {
            if (booking.roomId !== roomId || booking.date !== date) return false;
            if (excludeBookingId && booking.id === excludeBookingId) return false;
            if (booking.status === 'rejected') return false;

            const bookingStart = booking.startTime;
            const bookingEnd = booking.endTime;

            return (startTime < bookingEnd && endTime > bookingStart);
        });
    }
};

// 页面导航管理
const Navigation = {
    // 渲染侧边栏导航
    renderSidebar() {
        const sidebar = document.querySelector('.sidebar-nav');
        if (!sidebar) return;

        const currentUser = Auth.getCurrentUser();
        if (!currentUser) return;

        const navItems = this.getNavigationItems(currentUser);

        sidebar.innerHTML = `
            <ul class="nav-list">
                ${navItems.map(item => `
                    <li class="nav-item">
                        <a href="${item.href}" class="nav-link ${this.isCurrentPage(item.href) ? 'active' : ''}">
                            <span class="nav-icon">${item.icon}</span>
                            <span>${item.name}</span>
                        </a>
                    </li>
                `).join('')}
            </ul>
        `;
    },

    // 获取导航项
    getNavigationItems(user) {
        const items = [
            { name: '仪表板', href: 'dashboard.jsp', icon: '📊' },
            { name: '会议室浏览', href: 'rooms.jsp', icon: '🏢' },
            { name: '我的预约', href: 'my-bookings.jsp', icon: '📅' },
        ];

        if (Auth.hasPermission('approve')) {
            items.push({ name: '审批管理', href: 'approvals.jsp', icon: '✅' });
        }

        if (Auth.hasPermission('manage_rooms')) {
            items.push({ name: '会议室管理', href: 'room-management.jsp', icon: '⚙️' });
        }

        if (Auth.hasPermission('manage_users')) {
            items.push({ name: '用户管理', href: 'user-management.jsp', icon: '👥' });
        }

        if (Auth.hasPermission('view_reports')) {
            items.push({ name: '统计报表', href: 'reports.jsp', icon: '📈' });
        }

        return items;
    },

    // 检查当前页面
    isCurrentPage(href) {
        const currentPage = window.location.pathname.split('/').pop();
        return currentPage === href;
    },

    // 渲染头部
    renderHeader() {
        const header = document.querySelector('.header-content');
        if (!header) return;

        const currentUser = Auth.getCurrentUser();
        if (!currentUser) return;

        header.innerHTML = `
            <div class="flex items-center space-x-4">
                <h1 class="logo">会议室预约系统</h1>
                <span class="user-role">${Utils.getUserRoleName(currentUser.userType)}</span>
            </div>
            <div class="user-info">
                <span>欢迎，${currentUser.fullName}</span>
                <button class="logout-btn" onclick="Auth.logout()">退出登录</button>
            </div>
        `;
    }
};

// 页面初始化
const PageManager = {
    // 初始化页面
    init() {
        // 检查登录状态
        if (!Auth.checkLoginStatus()) {
            const currentPage = window.location.pathname.split('/').pop();
            if (currentPage !== 'index.jsp' && currentPage !== '' && currentPage !== 'login.jsp') {
                window.location.href = 'login.jsp';
                return;
            }
        }

        // 渲染导航
        Navigation.renderHeader();
        Navigation.renderSidebar();

        // 根据当前页面执行特定初始化
        const currentPage = window.location.pathname.split('/').pop();
        this.initPage(currentPage);
    },

    // 初始化特定页面
    initPage(pageName) {
        switch (pageName) {
            case 'dashboard.jsp':
                this.initDashboard();
                break;
            case 'rooms.jsp':
                this.initRooms();
                break;
            case 'booking.jsp':
                this.initBooking();
                break;
            case 'my-bookings.jsp':
                this.initMyBookings();
                break;
            case 'approvals.jsp':
                this.initApprovals();
                break;
            case 'room-management.jsp':
                this.initRoomManagement();
                break;
            case 'user-management.jsp':
                this.initUserManagement();
                break;
            case 'reports.jsp':
                this.initReports();
                break;
        }
    },

    // 初始化仪表板
    initDashboard() {
        const dashboardContent = document.getElementById('dashboard-content');
        if (!dashboardContent) return;

        const currentUser = Auth.getCurrentUser();
        const roomStats = RoomManager.getRoomStats();
        const locationStats = RoomManager.getLocationStats();
        const userBookings = BookingManager.getUserBookings(currentUser.fullName);

        dashboardContent.innerHTML = `
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">仪表板</h2>
                    <p class="card-subtitle">欢迎回来，${currentUser.fullName}</p>
                </div>
            </div>
            
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                <div class="stats-card">
                    <div class="stats-number">${roomStats.total}</div>
                    <div class="stats-label">总会议室数</div>
                </div>
                <div class="stats-card">
                    <div class="stats-number">${roomStats.available}</div>
                    <div class="stats-label">可用会议室</div>
                </div>
                <div class="stats-card">
                    <div class="stats-number">${userBookings.length}</div>
                    <div class="stats-label">我的预约</div>
                </div>
                <div class="stats-card">
                    <div class="stats-number">${userBookings.filter(b => b.status === 'confirmed').length}</div>
                    <div class="stats-label">已确认预约</div>
                </div>
            </div>
            
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">快速操作</h3>
                    </div>
                    <div class="grid grid-cols-2 gap-4">
                        <a href="rooms.jsp" class="btn btn-primary">
                            <span>🏢</span>
                            浏览会议室
                        </a>
                        <a href="my-bookings.jsp" class="btn btn-outline">
                            <span>📅</span>
                            我的预约
                        </a>
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">最近预约</h3>
                    </div>
                    <div class="space-y-3">
                        ${userBookings.slice(0, 3).map(booking => `
                            <div class="flex justify-between items-center p-3 bg-gray-50 rounded">
                                <div>
                                    <div class="font-medium">${booking.title}</div>
                                    <div class="text-sm text-gray-600">
                                        ${Utils.formatDate(booking.date)} ${booking.startTime}-${booking.endTime}
                                    </div>
                                </div>
                                ${Utils.getStatusBadge(booking.status,
            booking.status === 'confirmed' ? '已确认' :
                booking.status === 'pending' ? '待审批' : '已拒绝'
        )}
                            </div>
                        `).join('')}
                    </div>
                </div>
            </div>
        `;
    },

    // 初始化会议室页面
    initRooms() {
        const roomsContent = document.getElementById('rooms-content');
        if (!roomsContent) return;

        const rooms = RoomManager.getAllRooms();
        const locations = AppData.locations;

        roomsContent.innerHTML = `
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">会议室浏览</h2>
                    <p class="card-subtitle">查看和选择会议室</p>
                </div>
                
                <div class="mb-6">
                    <label class="form-label">按位置筛选：</label>
                    <select class="form-select" id="location-filter">
                        <option value="">所有位置</option>
                        ${locations.map(location => `
                            <option value="${location.id}">${location.name}</option>
                        `).join('')}
                    </select>
                </div>
            </div>
            
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6" id="rooms-grid">
                ${rooms.map(room => `
                    <div class="room-card" onclick="PageManager.selectRoom(${room.id})">
                        <div class="room-header">
                            <div>
                                <div class="room-name">${room.name}</div>
                                <div class="room-capacity">容量：${room.capacity}人</div>
                            </div>
                            ${Utils.getStatusBadge(room.status,
            room.status === 'available' ? '可用' :
                room.status === 'occupied' ? '占用' : '维护中'
        )}
                        </div>
                        <div class="room-amenities">设施：${room.amenities}</div>
                        <div class="text-sm text-gray-600">
                            位置：${Utils.getLocationName(room.locationId)}
                        </div>
                    </div>
                `).join('')}
            </div>
        `;

        // 绑定筛选事件
        document.getElementById('location-filter').addEventListener('change', (e) => {
            this.filterRooms(parseInt(e.target.value));
        });
    },

    // 筛选会议室
    filterRooms(locationId) {
        const rooms = locationId ? RoomManager.getRoomsByLocation(locationId) : RoomManager.getAllRooms();
        const roomsGrid = document.getElementById('rooms-grid');

        if (roomsGrid) {
            roomsGrid.innerHTML = rooms.map(room => `
                <div class="room-card" onclick="PageManager.selectRoom(${room.id})">
                    <div class="room-header">
                        <div>
                            <div class="room-name">${room.name}</div>
                            <div class="room-capacity">容量：${room.capacity}人</div>
                        </div>
                        ${Utils.getStatusBadge(room.status,
                room.status === 'available' ? '可用' :
                    room.status === 'occupied' ? '占用' : '维护中'
            )}
                    </div>
                    <div class="room-amenities">设施：${room.amenities}</div>
                    <div class="text-sm text-gray-600">
                        位置：${Utils.getLocationName(room.locationId)}
                    </div>
                </div>
            `).join('');
        }
    },

    // 选择会议室
    selectRoom(roomId) {
        const room = Utils.getRoomInfo(roomId);
        if (!room) return;

        if (room.status !== 'available') {
            Utils.showMessage('该会议室当前不可用！', 'error');
            return;
        }

        // 将会议室信息存储到sessionStorage
        sessionStorage.setItem('selectedRoom', JSON.stringify(room));
        window.location.href = 'booking.jsp';
    },

    // 初始化预约页面
    initBooking() {
        const bookingContent = document.getElementById('booking-content');
        if (!bookingContent) return;

        const selectedRoom = JSON.parse(sessionStorage.getItem('selectedRoom'));
        if (!selectedRoom) {
            window.location.href = 'rooms.jsp';
            return;
        }

        const today = new Date().toISOString().split('T')[0];

        bookingContent.innerHTML = `
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">预约会议室</h2>
                    <p class="card-subtitle">预约 ${selectedRoom.name}</p>
                </div>
                
                <div class="mb-6 p-4 bg-gray-50 rounded">
                    <h3 class="font-semibold mb-2">会议室信息</h3>
                    <div class="grid grid-cols-2 gap-4 text-sm">
                        <div>容量：${selectedRoom.capacity}人</div>
                        <div>设施：${selectedRoom.amenities}</div>
                        <div>位置：${Utils.getLocationName(selectedRoom.locationId)}</div>
                        <div>状态：${Utils.getStatusBadge(selectedRoom.status, '可用')}</div>
                    </div>
                </div>
                
                <form id="booking-form">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="form-group">
                            <label class="form-label">会议标题 *</label>
                            <input type="text" class="form-input" id="title" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">日期 *</label>
                            <input type="date" class="form-input" id="date" min="${today}" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">开始时间 *</label>
                            <input type="time" class="form-input" id="startTime" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">结束时间 *</label>
                            <input type="time" class="form-input" id="endTime" required>
                        </div>
                        
                        <div class="form-group md:col-span-2">
                            <label class="form-label">参会人员</label>
                            <input type="text" class="form-input" id="attendees" placeholder="请输入参会人员姓名，用逗号分隔">
                        </div>
                        
                        <div class="form-group md:col-span-2">
                            <label class="form-label">备注</label>
                            <textarea class="form-textarea" id="notes" placeholder="请输入会议备注信息"></textarea>
                        </div>
                    </div>
                    
                    <div class="flex gap-4 mt-6">
                        <button type="submit" class="btn btn-primary">提交预约</button>
                        <a href="rooms.jsp" class="btn btn-secondary">返回</a>
                    </div>
                </form>
            </div>
        `;

        // 绑定表单提交事件
        document.getElementById('booking-form').addEventListener('submit', (e) => {
            e.preventDefault();
            this.submitBooking(selectedRoom);
        });
    },

    // 提交预约
    submitBooking(room) {
        const formData = {
            title: document.getElementById('title').value,
            date: document.getElementById('date').value,
            startTime: document.getElementById('startTime').value,
            endTime: document.getElementById('endTime').value,
            attendees: document.getElementById('attendees').value,
            notes: document.getElementById('notes').value,
            roomId: room.id,
        };

        // 检查时间冲突
        if (BookingManager.checkTimeConflict(room.id, formData.date, formData.startTime, formData.endTime)) {
            Utils.showMessage('该时间段已被预约，请选择其他时间！', 'error');
            return;
        }

        // 创建预约
        BookingManager.createBooking(formData);

        // 清除sessionStorage
        sessionStorage.removeItem('selectedRoom');

        // 跳转到我的预约页面
        window.location.href = 'my-bookings.jsp';
    },

    // 初始化我的预约页面
    initMyBookings() {
        const myBookingsContent = document.getElementById('my-bookings-content');
        if (!myBookingsContent) return;

        const currentUser = Auth.getCurrentUser();
        const userBookings = BookingManager.getUserBookings(currentUser.fullName);

        myBookingsContent.innerHTML = `
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">我的预约</h2>
                    <p class="card-subtitle">查看和管理您的预约</p>
                </div>
            </div>
            
            <div class="card">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>会议标题</th>
                                <th>会议室</th>
                                <th>日期</th>
                                <th>时间</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            ${userBookings.map(booking => {
            const room = Utils.getRoomInfo(booking.roomId);
            return `
                                    <tr>
                                        <td>${booking.title}</td>
                                        <td>${room ? room.name : '未知'}</td>
                                        <td>${Utils.formatDate(booking.date)}</td>
                                        <td>${booking.startTime}-${booking.endTime}</td>
                                        <td>${Utils.getStatusBadge(booking.status,
                booking.status === 'confirmed' ? '已确认' :
                    booking.status === 'pending' ? '待审批' : '已拒绝'
            )}</td>
                                        <td>
                                            <button class="btn btn-sm btn-outline" onclick="PageManager.viewBookingDetails(${booking.id})">
                                                查看详情
                                            </button>
                                        </td>
                                    </tr>
                                `;
        }).join('')}
                        </tbody>
                    </table>
                </div>
            </div>
        `;
    },

    // 查看预约详情
    viewBookingDetails(bookingId) {
        const booking = AppData.bookings.find(b => b.id === bookingId);
        if (!booking) return;

        const room = Utils.getRoomInfo(booking.roomId);

        const details = `
会议标题：${booking.title}
会议室：${room ? room.name : '未知'}
日期：${Utils.formatDate(booking.date)}
时间：${booking.startTime}-${booking.endTime}
状态：${booking.status === 'confirmed' ? '已确认' : booking.status === 'pending' ? '待审批' : '已拒绝'}
参会人员：${booking.attendees || '无'}
备注：${booking.notes || '无'}
        `;

        alert(details);
    },

    // 初始化审批页面
    initApprovals() {
        if (!Auth.hasPermission('approve')) {
            window.location.href = 'dashboard.jsp';
            return;
        }

        const approvalsContent = document.getElementById('approvals-content');
        if (!approvalsContent) return;

        const pendingBookings = BookingManager.getPendingBookings();

        approvalsContent.innerHTML = `
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">审批管理</h2>
                    <p class="card-subtitle">审批待处理的预约申请</p>
                </div>
            </div>
            
            <div class="card">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>申请人</th>
                                <th>会议标题</th>
                                <th>会议室</th>
                                <th>日期</th>
                                <th>时间</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            ${pendingBookings.map(booking => {
            const room = Utils.getRoomInfo(booking.roomId);
            return `
                                    <tr>
                                        <td>${booking.requester}</td>
                                        <td>${booking.title}</td>
                                        <td>${room ? room.name : '未知'}</td>
                                        <td>${Utils.formatDate(booking.date)}</td>
                                        <td>${booking.startTime}-${booking.endTime}</td>
                                        <td>
                                            <button class="btn btn-sm btn-success" onclick="PageManager.approveBooking(${booking.id}, 'approve')">
                                                批准
                                            </button>
                                            <button class="btn btn-sm btn-danger" onclick="PageManager.approveBooking(${booking.id}, 'reject')">
                                                拒绝
                                            </button>
                                        </td>
                                    </tr>
                                `;
        }).join('')}
                        </tbody>
                    </table>
                </div>
            </div>
        `;
    },

    // 审批预约
    approveBooking(bookingId, action) {
        if (BookingManager.approveBooking(bookingId, action)) {
            // 重新渲染页面
            this.initApprovals();
        }
    },

    // 初始化会议室管理页面
    initRoomManagement() {
        if (!Auth.hasPermission('manage_rooms')) {
            window.location.href = 'dashboard.jsp';
            return;
        }

        const roomManagementContent = document.getElementById('room-management-content');
        if (!roomManagementContent) return;

        const rooms = RoomManager.getAllRooms();
        const locations = AppData.locations;

        roomManagementContent.innerHTML = `
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">会议室管理</h2>
                    <p class="card-subtitle">管理系统中的所有会议室</p>
                </div>
            </div>
            
            <div class="card">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>会议室名称</th>
                                <th>位置</th>
                                <th>容量</th>
                                <th>设施</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            ${rooms.map(room => `
                                <tr>
                                    <td>${room.name}</td>
                                    <td>${Utils.getLocationName(room.locationId)}</td>
                                    <td>${room.capacity}人</td>
                                    <td>${room.amenities}</td>
                                    <td>${Utils.getStatusBadge(room.status,
            room.status === 'available' ? '可用' :
                room.status === 'occupied' ? '占用' : '维护中'
        )}</td>
                                    <td>
                                        <button class="btn btn-sm btn-outline">编辑</button>
                                    </td>
                                </tr>
                            `).join('')}
                        </tbody>
                    </table>
                </div>
            </div>
        `;
    },

    // 初始化用户管理页面
    initUserManagement() {
        if (!Auth.hasPermission('manage_users')) {
            window.location.href = 'dashboard.jsp';
            return;
        }

        const userManagementContent = document.getElementById('user-management-content');
        if (!userManagementContent) return;

        const users = AppData.users;
        const departments = AppData.departments;

        userManagementContent.innerHTML = `
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">用户管理</h2>
                    <p class="card-subtitle">管理系统用户</p>
                </div>
            </div>
            
            <div class="card">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>用户名</th>
                                <th>姓名</th>
                                <th>角色</th>
                                <th>部门</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            ${users.map(user => {
            const department = departments.find(d => d.id === user.departmentId);
            return `
                                    <tr>
                                        <td>${user.username}</td>
                                        <td>${user.fullName}</td>
                                        <td>${Utils.getUserRoleName(user.role)}</td>
                                        <td>${department ? department.name : '无'}</td>
                                        <td>
                                            <button class="btn btn-sm btn-outline">编辑</button>
                                        </td>
                                    </tr>
                                `;
        }).join('')}
                        </tbody>
                    </table>
                </div>
            </div>
        `;
    },

    // 初始化统计报表页面
    initReports() {
        if (!Auth.hasPermission('view_reports')) {
            window.location.href = 'dashboard.jsp';
            return;
        }

        const reportsContent = document.getElementById('reports-content');
        if (!reportsContent) return;

        const roomStats = RoomManager.getRoomStats();
        const locationStats = RoomManager.getLocationStats();
        const allBookings = BookingManager.getAllBookings();

        reportsContent.innerHTML = `
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">统计报表</h2>
                    <p class="card-subtitle">系统使用情况统计</p>
                </div>
            </div>
            
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                <div class="stats-card">
                    <div class="stats-number">${roomStats.total}</div>
                    <div class="stats-label">总会议室数</div>
                </div>
                <div class="stats-card">
                    <div class="stats-number">${allBookings.length}</div>
                    <div class="stats-label">总预约数</div>
                </div>
                <div class="stats-card">
                    <div class="stats-number">${allBookings.filter(b => b.status === 'confirmed').length}</div>
                    <div class="stats-label">已确认预约</div>
                </div>
                <div class="stats-card">
                    <div class="stats-number">${allBookings.filter(b => b.status === 'pending').length}</div>
                    <div class="stats-label">待审批预约</div>
                </div>
            </div>
            
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">位置统计</h3>
                    </div>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>位置</th>
                                    <th>会议室数</th>
                                    <th>可用</th>
                                    <th>占用</th>
                                    <th>利用率</th>
                                </tr>
                            </thead>
                            <tbody>
                                ${locationStats.map(stat => `
                                    <tr>
                                        <td>${stat.name}</td>
                                        <td>${stat.totalRooms}</td>
                                        <td>${stat.availableRooms}</td>
                                        <td>${stat.occupiedRooms}</td>
                                        <td>${stat.utilizationRate}%</td>
                                    </tr>
                                `).join('')}
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">预约状态分布</h3>
                    </div>
                    <div class="space-y-4">
                        <div class="flex justify-between items-center">
                            <span>已确认</span>
                            <span class="font-semibold">${allBookings.filter(b => b.status === 'confirmed').length}</span>
                        </div>
                        <div class="flex justify-between items-center">
                            <span>待审批</span>
                            <span class="font-semibold">${allBookings.filter(b => b.status === 'pending').length}</span>
                        </div>
                        <div class="flex justify-between items-center">
                            <span>已拒绝</span>
                            <span class="font-semibold">${allBookings.filter(b => b.status === 'rejected').length}</span>
                        </div>
                    </div>
                </div>
            </div>
        `;
    }
};

// 页面加载完成后初始化
document.addEventListener('DOMContentLoaded', function() {
    PageManager.init();
});

// 全局函数，供HTML调用
window.Auth = Auth;
window.PageManager = PageManager;
window.Utils = Utils;