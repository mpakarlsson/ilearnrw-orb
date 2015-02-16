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
			<a class="navbar-brand" href="/">iLearnRW</a>
		</div>
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav">
				<li class="active"><a href="profiles?lang=${pageContext.response.locale}"><spring:message code="navbar.profile" text="default text" /></a></li>
				<li><a href="#about"><spring:message code="navbar.classification" text="default text" /></a></li>
				<li><a href="#contact"><spring:message code="navbar.annotation" text="default text" /></a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<% if((String) request.getSession().getAttribute("username") == null) {%>
				<li><a href="login?lang=${pageContext.response.locale}"><span
						class="glyphicon glyphicon-log-in"></span> <spring:message code="navbar.login" text="default text" /></a></li>
						<% }else {%>
						<li><a href="#"><span class="glyphicon glyphicon-user"></span> <%= (String) request.getSession().getAttribute("username") %></a></li>
				<li><a href="logout"><span class="glyphicon glyphicon-log-out"></span>
						<spring:message code="navbar.logout" text="default text" /></a></li>
				<%} %>

				<li><a href="?lang=en">EN</a></li>
				<li><a href="?lang=el_GR">EL</a></li>

			</ul>
		</div>
		<!--/.navbar-collapse -->
	</div>
</nav>