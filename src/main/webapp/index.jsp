<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- verifica se o usuário está logado:
  se não estiver, redireciona para a página de login
  se estiver, redireciona para a home --%>
<c:choose>
    <c:when test="${empty sessionScope.usuarioLogado}">
        <c:redirect url="/login.jsp" />
    </c:when>
    <c:otherwise>
        <c:redirect url="${pageContext.request.contextPath}/home" />
    </c:otherwise>
</c:choose>