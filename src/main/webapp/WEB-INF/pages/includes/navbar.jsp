<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#navbar" aria-expanded="false"
				aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="${pageContext.request.contextPath}/">iLearnRW</a>
		</div>
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav">
				<!-- <li class="active"><a href="${pageContext.request.contextPath}/profiles?lang=${pageContext.response.locale}"><spring:message code="navbar.profile" text="profiles" /></a></li> -->
				<li><a href="${pageContext.request.contextPath}/profiles?lang=${pageContext.response.locale}"><spring:message code="navbar.profile" text="profiles" /></a></li>
				<li><a href="${pageContext.request.contextPath}/analysis?lang=${pageContext.response.locale}"><spring:message code="navbar.analysis" text="analysis" /></a></li>
				<li><a href="${pageContext.request.contextPath}/annotation?lang=${pageContext.response.locale}"><spring:message code="navbar.annotation" text="annotation" /></a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<% if((String) request.getSession().getAttribute("username") == null) {%>
				<li><a href="${pageContext.request.contextPath}/login?lang=${pageContext.response.locale}"><span
						class="glyphicon glyphicon-log-in"></span> <spring:message code="navbar.login" text="default text" /></a></li>
						<% }else {%>
						<li><a href="#"><span class="glyphicon glyphicon-user"></span> <%= (String) request.getSession().getAttribute("username") %></a></li>
				<li><a href="${pageContext.request.contextPath}/logout?lang=${pageContext.response.locale}"><span class="glyphicon glyphicon-log-out"></span>
						<spring:message code="navbar.logout" text="default text" /></a></li>
				<%} %>

				<li><a href="?lang=en"><img border="0" alt="English" src="${pageContext.request.contextPath}/resources/assets/images/uk_flag.png" width="20" height="20"></a></li>
				<li><a href="?lang=el_GR"><img border="0" alt="Greek" src="${pageContext.request.contextPath}/resources/assets/images/gr_flag.png" width="20" height="20"></a></li>

			</ul>
		</div>
		<!--/.navbar-collapse -->
	</div>
</nav>