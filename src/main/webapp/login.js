document.addEventListener('DOMContentLoaded', function () {
    const userTypeButtons = document.querySelectorAll('.user-type-btn');
    const userTypeInput = document.getElementById('userTypeInput');
    const loginForm = document.getElementById('login-form');

    let selectedUserType = '';

    // 设置选中样式和隐藏字段值
    userTypeButtons.forEach(button => {
        button.addEventListener('click', function () {
            selectedUserType = this.dataset.type;
            userTypeInput.value = selectedUserType;

            // 移除所有 active 类
            userTypeButtons.forEach(btn => btn.classList.remove('border-blue-500', 'bg-blue-50'));
            // 添加选中样式
            this.classList.add('border-blue-500', 'bg-blue-50');
        });
    });

    // 表单提交前验证用户类型是否已选
    loginForm.addEventListener('submit', function (e) {
        if (!selectedUserType) {
            e.preventDefault();
            alert('请选择一个用户类型！');
        }
    });
});
