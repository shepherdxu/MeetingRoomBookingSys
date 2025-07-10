// 功能特色页面专用JavaScript

// 页面加载完成后初始化
document.addEventListener('DOMContentLoaded', function() {
    initializeFeaturesPage();
    setupScrollAnimations();
    setupInteractiveElements();
});

// 初始化功能特色页面
function initializeFeaturesPage() {
    // 添加页面加载动画
    addPageLoadAnimation();

    // 设置导航高亮
    highlightCurrentNavigation();

    // 初始化计数器动画
    initializeCounters();
}

// 添加页面加载动画
function addPageLoadAnimation() {
    const sections = document.querySelectorAll('.bg-white.rounded-2xl');
    sections.forEach((section, index) => {
        section.style.opacity = '0';
        section.style.transform = 'translateY(30px)';

        setTimeout(() => {
            section.style.transition = 'opacity 0.8s ease, transform 0.8s ease';
            section.style.opacity = '1';
            section.style.transform = 'translateY(0)';
        }, index * 200);
    });
}

// 设置滚动动画
function setupScrollAnimations() {
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-fade-in');

                // 如果是统计卡片，启动计数动画
                if (entry.target.classList.contains('stats-card')) {
                    animateStatsCard(entry.target);
                }
            }
        });
    }, observerOptions);

    // 观察所有需要动画的元素
    const animatedElements = document.querySelectorAll('.bg-white, .bg-blue-50, .bg-green-50, .bg-purple-50, .bg-orange-50');
    animatedElements.forEach(el => {
        observer.observe(el);
    });
}

// 设置交互元素
function setupInteractiveElements() {
    // 功能卡片悬停效果
    const featureCards = document.querySelectorAll('.bg-white.rounded-2xl');
    featureCards.forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-5px)';
            this.style.boxShadow = '0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04)';
        });

        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
            this.style.boxShadow = '0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05)';
        });
    });

    // 状态指示器动画
    const statusIndicators = document.querySelectorAll('.w-3.h-3.rounded-full');
    statusIndicators.forEach(indicator => {
        // 添加脉冲动画
        if (indicator.classList.contains('bg-green-400')) {
            indicator.style.animation = 'pulse 2s infinite';
        } else if (indicator.classList.contains('bg-red-400')) {
            indicator.style.animation = 'pulse 2s infinite';
        }
    });

    // 审批流程步骤交互
    setupApprovalStepsInteraction();

    // 冲突检测示例交互
    setupConflictDetectionDemo();
}

// 设置审批流程步骤交互
function setupApprovalStepsInteraction() {
    const approvalSteps = document.querySelectorAll('.bg-yellow-50, .bg-blue-50, .bg-green-50');

    approvalSteps.forEach((step, index) => {
        step.addEventListener('click', function() {
            // 移除所有步骤的活动状态
            approvalSteps.forEach(s => s.classList.remove('ring-4', 'ring-blue-300'));

            // 添加当前步骤的活动状态
            this.classList.add('ring-4', 'ring-blue-300');

            // 显示步骤详情
            showStepDetails(index);
        });

        // 添加悬停效果
        step.addEventListener('mouseenter', function() {
            this.style.transform = 'scale(1.05)';
            this.style.cursor = 'pointer';
        });

        step.addEventListener('mouseleave', function() {
            this.style.transform = 'scale(1)';
        });
    });
}

// 显示步骤详情
function showStepDetails(stepIndex) {
    const stepDetails = [
        {
            title: '提交申请',
            description: '用户填写完整的预约信息，包括会议主题、时间、参会人员等，系统自动进行初步验证。',
            features: ['表单验证', '时间冲突检测', '自动保存草稿']
        },
        {
            title: '审批处理',
            description: '根据预约规则，系统自动分配给相应的审批人员，支持多级审批和并行审批。',
            features: ['智能分配', '邮件通知', '移动端审批']
        },
        {
            title: '确认完成',
            description: '审批通过后，系统发送确认通知，生成会议邀请，并同步到日历系统。',
            features: ['自动通知', '日历同步', '会议提醒']
        }
    ];

    const detail = stepDetails[stepIndex];
    if (detail) {
        showModal('审批流程详情', detail);
    }
}

// 设置冲突检测演示
function setupConflictDetectionDemo() {
    const conflictExamples = document.querySelectorAll('.border-l-4');

    conflictExamples.forEach(example => {
        example.addEventListener('click', function() {
            // 添加点击动画
            this.style.transform = 'scale(0.98)';
            setTimeout(() => {
                this.style.transform = 'scale(1)';
            }, 150);

            // 显示详细信息
            const conflictType = this.querySelector('.font-medium').textContent;
            showConflictDetails(conflictType);
        });
    });
}

// 显示冲突详情
function showConflictDetails(conflictType) {
    const conflictInfo = {
        '时间冲突警告': {
            description: '系统检测到您选择的时间段已有其他预约',
            solution: '建议选择其他时间段或查看相似会议室',
            prevention: '提前预约，使用日历同步功能'
        },
        '容量警告': {
            description: '参会人数超过会议室最大容量',
            solution: '推荐容量更大的会议室或分批次会议',
            prevention: '预约时准确填写参会人数'
        },
        '预约成功': {
            description: '所有检查通过，预约已成功创建',
            solution: '系统已发送确认邮件和日历邀请',
            prevention: '继续保持良好的预约习惯'
        }
    };

    const info = conflictInfo[conflictType];
    if (info) {
        showModal('冲突检测详情', info);
    }
}

// 显示模态框
function showModal(title, content) {
    // 创建模态框
    const modal = document.createElement('div');
    modal.className = 'fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50';
    modal.innerHTML = `
        <div class="bg-white rounded-lg p-6 max-w-md mx-4 transform transition-all">
            <div class="flex justify-between items-center mb-4">
                <h3 class="text-lg font-semibold text-gray-900">${title}</h3>
                <button class="text-gray-400 hover:text-gray-600" onclick="closeModal()">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                </button>
            </div>
            <div class="space-y-3">
                ${content.description ? `<p class="text-gray-600">${content.description}</p>` : ''}
                ${content.features ? `
                    <div>
                        <h4 class="font-medium text-gray-800 mb-2">主要功能：</h4>
                        <ul class="list-disc list-inside text-sm text-gray-600 space-y-1">
                            ${content.features.map(feature => `<li>${feature}</li>`).join('')}
                        </ul>
                    </div>
                ` : ''}
                ${content.solution ? `<p class="text-sm text-blue-600"><strong>解决方案：</strong> ${content.solution}</p>` : ''}
                ${content.prevention ? `<p class="text-sm text-green-600"><strong>预防措施：</strong> ${content.prevention}</p>` : ''}
            </div>
        </div>
    `;

    document.body.appendChild(modal);

    // 添加动画
    setTimeout(() => {
        modal.querySelector('.bg-white').style.transform = 'scale(1)';
    }, 10);

    // 点击背景关闭
    modal.addEventListener('click', function(e) {
        if (e.target === modal) {
            closeModal();
        }
    });
}

// 关闭模态框
function closeModal() {
    const modal = document.querySelector('.fixed.inset-0.bg-black');
    if (modal) {
        modal.querySelector('.bg-white').style.transform = 'scale(0.95)';
        modal.style.opacity = '0';
        setTimeout(() => {
            modal.remove();
        }, 200);
    }
}

// 高亮当前导航
function highlightCurrentNavigation() {
    const navLinks = document.querySelectorAll('nav a');
    navLinks.forEach(link => {
        if (link.href.includes('features.jsp')) {
            link.classList.add('bg-blue-100', 'text-blue-700');
            link.classList.remove('text-gray-600');
        }
    });
}

// 初始化计数器
function initializeCounters() {
    const counters = [
        { element: '.stats-rooms', target: 25, suffix: '间' },
        { element: '.stats-bookings', target: 156, suffix: '次' },
        { element: '.stats-users', target: 89, suffix: '人' },
        { element: '.stats-efficiency', target: 95, suffix: '%' }
    ];

    counters.forEach(counter => {
        const element = document.querySelector(counter.element);
        if (element) {
            animateCounter(element, 0, counter.target, counter.suffix, 2000);
        }
    });
}

// 动画计数器
function animateCounter(element, start, end, suffix, duration) {
    const startTime = performance.now();

    function updateCounter(currentTime) {
        const elapsed = currentTime - startTime;
        const progress = Math.min(elapsed / duration, 1);

        // 使用缓动函数
        const easeOutQuart = 1 - Math.pow(1 - progress, 4);
        const current = Math.floor(start + (end - start) * easeOutQuart);

        element.textContent = current + suffix;

        if (progress < 1) {
            requestAnimationFrame(updateCounter);
        }
    }

    requestAnimationFrame(updateCounter);
}

// 统计卡片动画
function animateStatsCard(card) {
    const icon = card.querySelector('.w-12.h-12');
    if (icon) {
        icon.style.animation = 'bounce 1s ease-in-out';
    }
}

// 添加CSS动画类
function addAnimationStyles() {
    const style = document.createElement('style');
    style.textContent = `
        .animate-fade-in {
            animation: fadeIn 0.8s ease-out forwards;
        }
        
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes pulse {
            0%, 100% {
                opacity: 1;
            }
            50% {
                opacity: 0.5;
            }
        }
        
        @keyframes bounce {
            0%, 20%, 53%, 80%, 100% {
                transform: translate3d(0,0,0);
            }
            40%, 43% {
                transform: translate3d(0, -10px, 0);
            }
            70% {
                transform: translate3d(0, -5px, 0);
            }
            90% {
                transform: translate3d(0, -2px, 0);
            }
        }
    `;
    document.head.appendChild(style);
}

// 键盘导航支持
document.addEventListener('keydown', function(event) {
    // ESC键关闭模态框
    if (event.key === 'Escape') {
        closeModal();
    }

    // 空格键暂停/继续动画
    if (event.key === ' ' && event.target === document.body) {
        event.preventDefault();
        toggleAnimations();
    }
});

// 切换动画
function toggleAnimations() {
    const animatedElements = document.querySelectorAll('[style*="animation"]');
    animatedElements.forEach(element => {
        const currentAnimation = element.style.animation;
        if (currentAnimation.includes('paused')) {
            element.style.animation = currentAnimation.replace('paused', 'running');
        } else {
            element.style.animation = currentAnimation + ' paused';
        }
    });
}

// 初始化动画样式
addAnimationStyles();

// 页面可见性变化时的处理
document.addEventListener('visibilitychange', function() {
    if (document.hidden) {
        // 页面隐藏时暂停动画
        toggleAnimations();
    } else {
        // 页面显示时恢复动画
        toggleAnimations();
    }
});

// 滚动到顶部功能
function scrollToTop() {
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    });
}

// 添加返回顶部按钮
function addBackToTopButton() {
    const button = document.createElement('button');
    button.innerHTML = '↑';
    button.className = 'fixed bottom-6 right-6 w-12 h-12 bg-blue-600 text-white rounded-full shadow-lg hover:bg-blue-700 transition-colors z-40';
    button.style.display = 'none';
    button.onclick = scrollToTop;

    document.body.appendChild(button);

    // 滚动时显示/隐藏按钮
    window.addEventListener('scroll', function() {
        if (window.pageYOffset > 300) {
            button.style.display = 'block';
        } else {
            button.style.display = 'none';
        }
    });
}

// 初始化返回顶部按钮
addBackToTopButton();