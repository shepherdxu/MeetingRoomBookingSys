document.addEventListener('DOMContentLoaded', function() {
    // 日历状态管理
    let selectedDate = null;
    let currentMonth = new Date();
    let currentTarget = null; // 当前操作的日期目标 (startDate 或 endDate)
    const calendarPopup = document.getElementById('calendarPopup');
    const monthYearElement = document.getElementById('monthYear');
    const daysGrid = document.getElementById('daysGrid');
    const startDateDisplay = document.getElementById('startDateDisplay');
    const endDateDisplay = document.getElementById('endDateDisplay');
    const startDateInput = document.getElementById('startDate');
    const endDateInput = document.getElementById('endDate');

    // 初始化时间输入框
    const now = new Date();
    const currentTime = `${String(now.getHours()).padStart(2, '0')}:${String(now.getMinutes()).padStart(2, '0')}`;
    document.getElementById('startTime').value = currentTime;
    document.getElementById('endTime').value = currentTime;

    // 获取所有日历按钮
    const calendarButtons = document.querySelectorAll('.calendar-icon-btn');

    // 为每个日历按钮添加点击事件
    calendarButtons.forEach((button, index) => {
        button.addEventListener('click', function(e) {
            e.stopPropagation();

            // 确定当前操作的目标
            currentTarget = index === 0 ? 'startDate' : 'endDate';

            // 获取按钮位置
            const rect = button.getBoundingClientRect();

            // 设置日历位置
            calendarPopup.style.top = `${rect.bottom + window.scrollY + 10}px`;
            calendarPopup.style.left = `${rect.left + window.scrollX - 100}px`;

            // 显示日历
            calendarPopup.classList.remove('hidden');

            // 渲染日历
            renderCalendar();
        });
    });

    // 关闭日历（点击外部）
    document.addEventListener('click', function(e) {
        if (!calendarPopup.contains(e.target) &&
            !Array.from(calendarButtons).some(btn => btn.contains(e.target))) {
            calendarPopup.classList.add('hidden');
        }
    });

    // 月份导航
    document.getElementById('prevMonth').addEventListener('click', function(e) {
        e.stopPropagation();
        currentMonth = new Date(currentMonth.getFullYear(), currentMonth.getMonth() - 1, 1);
        renderCalendar();
    });

    document.getElementById('nextMonth').addEventListener('click', function(e) {
        e.stopPropagation();
        currentMonth = new Date(currentMonth.getFullYear(), currentMonth.getMonth() + 1, 1);
        renderCalendar();
    });

    // 清除日期
    document.getElementById('clearDate').addEventListener('click', function(e) {
        e.stopPropagation();
        if (currentTarget === 'startDate') {
            startDateDisplay.textContent = '请选择日期';
            startDateInput.value = '';
        } else {
            endDateDisplay.textContent = '请选择日期';
            endDateInput.value = '';
        }
        calendarPopup.classList.add('hidden');
    });

    // 选择今天
    document.getElementById('selectToday').addEventListener('click', function(e) {
        e.stopPropagation();
        const today = new Date();
        updateDateDisplay(today);
        calendarPopup.classList.add('hidden');
    });

    // 渲染日历
    function renderCalendar() {
        const today = new Date();
        const year = currentMonth.getFullYear();
        const month = currentMonth.getMonth();

        // 设置月份标题
        const monthNames = ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'];
        monthYearElement.textContent = `${year}年${monthNames[month]}`;

        // 获取当月第一天是星期几
        const firstDayOfMonth = new Date(year, month, 1).getDay();
        // 获取当月天数
        const daysInMonth = new Date(year, month + 1, 0).getDate();

        // 清空日期网格
        daysGrid.innerHTML = '';

        // 添加空白占位
        for (let i = 0; i < firstDayOfMonth; i++) {
            const emptyDay = document.createElement('div');
            emptyDay.className = 'w-8 h-8';
            daysGrid.appendChild(emptyDay);
        }

        // 添加日期
        for (let day = 1; day <= daysInMonth; day++) {
            const dayElement = document.createElement('button');
            dayElement.className = 'calendar-day w-8 h-8 text-sm rounded-lg transition-all duration-200 flex items-center justify-center text-gray-700 hover:bg-blue-100 hover:text-blue-700';
            dayElement.textContent = day;

            // 检查是否是今天
            const date = new Date(year, month, day);
            if (date.toDateString() === today.toDateString()) {
                dayElement.classList.add('bg-gradient-to-r', 'from-blue-400', 'to-blue-600', 'text-white');
            }

            // 添加点击事件
            dayElement.addEventListener('click', function(e) {
                e.stopPropagation();
                updateDateDisplay(new Date(year, month, day));
                calendarPopup.classList.add('hidden');
            });

            daysGrid.appendChild(dayElement);
        }
    }

    // 更新日期显示
    function updateDateDisplay(date) {
        const formattedDate = `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')}`;
        const displayText = `${date.getFullYear()}年${date.getMonth() + 1}月${date.getDate()}日`;

        if (currentTarget === 'startDate') {
            startDateDisplay.textContent = displayText;
            startDateInput.value = formattedDate;
        } else {
            endDateDisplay.textContent = displayText;
            endDateInput.value = formattedDate;
        }
    }

    // 初始化日历
    renderCalendar();

    // 表单验证
    document.getElementById('bookingForm').addEventListener('submit', function(e) {
        const startDate = startDateInput.value;
        const endDate = endDateInput.value;
        const startTime = document.getElementById('startTime').value;
        const endTime = document.getElementById('endTime').value;

        if (!startDate || !endDate) {
            alert('请选择开始日期和结束日期');
            e.preventDefault();
            return;
        }

        if (startDate > endDate) {
            alert('结束日期不能早于开始日期');
            e.preventDefault();
            return;
        }

        if (startDate === endDate && startTime >= endTime) {
            alert('结束时间必须晚于开始时间');
            e.preventDefault();
        }
    });
});