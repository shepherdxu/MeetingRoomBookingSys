<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="bg-white p-8 rounded-lg shadow-md max-w-2xl mx-auto">
    <h2 class="text-2xl font-bold text-gray-800 mb-6">${empty room ? '新增' : '编辑'}会议室</h2>

    <form action="${pageContext.request.contextPath}/admin" method="post">
        <input type="hidden" name="action" value="saveRoom">
        <c:if test="${not empty room}"><input type="hidden" name="roomId" value="${room.roomId}"></c:if>

        <div class="space-y-6">
            <div>
                <label for="roomName" class="block text-sm font-medium text-gray-700">会议室名称</label>
                <input type="text" id="roomName" name="roomName" value="${room.roomName}" required class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm">
            </div>
            <div>
                <label for="locationId" class="block text-sm font-medium text-gray-700">位置</label>
                <select id="locationId" name="locationId" required class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md">
                    <c:forEach var="loc" items="${locations}">
                        <option value="${loc.locationId}" ${loc.locationId == room.locationId ? 'selected' : ''}>${loc.locationName}</option>
                    </c:forEach>
                </select>
            </div>
            <div>
                <label for="capacity" class="block text-sm font-medium text-gray-700">容量</label>
                <input type="number" id="capacity" name="capacity" value="${room.capacity}" required min="1" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm">
            </div>
            <div>
                <label for="amenities" class="block text-sm font-medium text-gray-700">设施 (逗号分隔)</label>
                <input type="text" id="amenities" name="amenities" value="${room.amenities}" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm">
            </div>
            <div class="flex justify-end space-x-4">
                <a href="${pageContext.request.contextPath}/admin?action=manageRooms" class="bg-gray-200 hover:bg-gray-300 text-gray-800 font-bold py-2 px-4 rounded-lg transition duration-300">取消</a>
                <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-lg transition duration-300">保存</button>
            </div>
        </div>
    </form>
</div>