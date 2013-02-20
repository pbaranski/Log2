<?xmlproject version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl">
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>
<div>
    <h1 style="text-align:center;">User list</h1>
    <h4 style="text-align:center;">Hello ${currentSessionUser.username}</h4>
</div>
<div>
    <jsp:include page="../logout.jsp"/>
</div>
<div>
    <input class="btn" type="submit" value="Go back to projects" ONCLICK="window.location.href='/projectList.pro'"/>
</div>
<div style="width: 50%; margin: 0 auto;">
    <c:if test='${isAdmin == true}'>
    <div>
        <input class="btn" type="submit" value="Add user" ONCLICK="window.location.href='/addUser.user'"/>
    </div>
    </c:if>
    <c:if test='${userList != null}'>
    <div>
        <table class="table" >
            <tr>
                <th>Id</th>
                <th>Nick</th>
                <th>Name</th>
                <th>Surname</th>
                <th></th>
                <th></th>
            </tr>
            <c:forEach items='${userList}' var='user'>
                <tr>
                    <td>${user.idu}</td>
                    <td>${user.username}</td>
                    <td>${user.firstName}</td>
                    <td>${user.lastName}</td>
                    <td><input class="btn btn-warning" type="submit" value="edit" ONCLICK="window.location.href='userEdit.user?idu=${user.idu}'"/></td>
                    <c:if test='${isAdmin == true}'>

                        <td>
                            <form accept-charset="ISO-8859-15" name="lol2${user.idu}" action="userDel.user">
                                <input type="hidden" name="idu" value="${user.idu}">
                                <td><input class="btn btn-danger" type="submit" value="delete" ONCLICK="return validateForm(${user.idu})"/></td>
                            </form>
                        </td>
                    </c:if>
                </tr>
            </c:forEach>
        </table>
    </div>


    </c:if>
</div>

</body>
<script>
    function validateForm(num) {
        if (confirm("Are you sure you want to delete user - all users project and task will be assigned to admin?")) {
            document.getElementsByName("lol2" + num).submit();
        }
        return false;
    }
</script>
</html>