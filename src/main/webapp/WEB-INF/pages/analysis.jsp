<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<jsp:include page="includes/includes.jsp"></jsp:include>

<title>iLearnRW ORB</title>


<!-- Custom styles for this template
    <link href="css/jumbotron.css" rel="stylesheet"> -->
<link
	href=${pageContext.request.contextPath}/resources/libs/css/jumbotron.css
	rel="stylesheet">

</head>

<body>

	<jsp:include page="includes/navbar.jsp"></jsp:include>


	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<br>

				<form name="textForm" action="" method="post">
					<select class="form-control" name="selectedId">
						<c:forEach items="${students}" var="student">
							<option value="${student.getId()}"
								${profileId == student.getId() ? "selected": ""}>
								${student.getUsername()}</option>
						</c:forEach>
					</select> <br>
					<div class="form-group">
						<textarea class="form-control" rows="30" name="inputText">${text}</textarea>
					</div>
					<button type="submit" class="btn btn-default">Submit</button>
				</form>

			</div>
			<div class="col-md-4">
				<br>
				<h4>Generic Metrics</h4>
				<table class="table table-striped" id="resultsTable">
					<thead>
						<tr>
							<th>Property</th>
							<th>Value</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>Number of Words</td>
							<td>${analysisResults.getNumberOfTotalWords() }</td>
						</tr>
						<tr>
							<td>Polysyllabic Words</td>
							<td>${analysisResults.getNumberOfPolysyllabicWords()}</td>
						</tr>
						<tr>
							<td>Number of Sentences</td>
							<td>${analysisResults.getNumberOfSentences() }</td>
						</tr>
						<tr>
							<td>15 or more word Sentences</td>
							<td>${analysisResults.getNumberOfBigSentences() }</td>
						</tr>
						<tr>
							<td>Number of Paragraphs</td>
							<td>${analysisResults.getNumberOfParagraphs() }</td>
						</tr>
						<tr>
							<td>Average Word Length</td>
							<td><fmt:formatNumber type="number" maxFractionDigits="2"
									minFractionDigits="2"
									value="${analysisResults.getAverageWordLength() }" /></td>
						</tr>
						<tr>
							<td>Average Number of Syllables</td>
							<td><fmt:formatNumber type="number" maxFractionDigits="2"
									minFractionDigits="2"
									value="${analysisResults.getAverageSyllablesPerWord() }" /></td>
						</tr>
						<tr>
							<td>Average Words per Sentence</td>
							<td><fmt:formatNumber type="number" maxFractionDigits="2"
									minFractionDigits="2"
									value="${analysisResults.getAverageWordsPerSentence() }" /></td>
						</tr>
						<tr>
							<td>Flesch-Kincaid</td>
							<td><fmt:formatNumber type="number" maxFractionDigits="2"
									minFractionDigits="2"
									value="${analysisResults.getFleschKincaid()}" /></td>
						</tr>
				</table>
				<hr>
				<h4>User Related Metrics</h4>
				<table class="table table-striped" id="resultsTable">
					<thead>
						<tr>
							<th>Property</th>
							<th>Value</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>Text Difficulty</td>
							<td><fmt:formatNumber type="number" maxFractionDigits="2"
									minFractionDigits="2" value="${analysisResults.getTscore()}" /></td>
						</tr>
						<tr>
							<td>Difficult Words</td>
							<td><fmt:formatNumber type="number" maxFractionDigits="2"
									minFractionDigits="2" value="${analysisResults.getDiffWords()}" /></td>
						</tr>
						<tr>
							<td>Very Difficult Words</td>
							<td><fmt:formatNumber type="number" maxFractionDigits="2"
									minFractionDigits="2"
									value="${analysisResults.getVeryDiffWords()}" /></td>
						</tr>
				</table>

			</div>
		</div>




		<div class="container">
			<c:choose>
				<c:when test="${selectedProfile != null}">
					<div class="row">
						<div class="col-md-8">
							<div class="panel-group" id="accordion" role="tablist"
								aria-multiselectable="true">

								<c:forEach begin="0"
									end="${selectedProfile.getUserProblems().getNumerOfRows()-1}"
									var="i">

									<div class="panel panel-default">
										<div class="panel-heading" role="tab"
											id="heading<c:out value="${i}" />">
											<h4 class="panel-title">
												<a data-toggle="collapse" data-parent="#accordion"
													href="#collapse<c:out value="${i}" />"
													aria-expanded="${i == 0}"
													aria-controls="collapse<c:out value="${i}" />">
													${selectedProfile.getUserProblems().getProblemDefinition(i).getUri()}
												</a>
											</h4>
										</div>
										<div id="collapse<c:out value="${i}" />"
											class="panel-collapse collapse" role="tabpanel"
											aria-labelledby="heading<c:out value="${i}" />">
											<div class="panel-body">

												<table class="table table-condensed">
													<c:forEach begin="0"
														end="${selectedProfile.getUserProblems().getRowLength(i)-1}"
														var="j">

														<tr class="success">
															<td
																style="font-size:${65+135*analysisResults.getUserCounters().getValue(i, j) / maxWordsMatched}%">${selectedProfile.getUserProblems().getProblemDescription(i, j).getHumanReadableDescription()}
															</td>
															<td style="min-width: 90px" align="right"><span
																class="badge"
																style="font-size:${65+150*analysisResults.getUserCounters().getValue(i, j) / maxWordsMatched}%">${analysisResults.getUserCounters().getValue(i, j)}</span></td>


														</tr>
													</c:forEach>
												</table>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>

						</div>
					</div>
				</c:when>
			</c:choose>
		</div>





		<hr>

		<footer>
			<p>&copy; iLearnRW 2015</p>
		</footer>
	</div>
	<!-- /container -->


	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster
    <script src="js/jquery-2.1.3.min.js"></script>
    <script src="js/bootstrap.min.js"></script> -->
	<script
		src="${pageContext.request.contextPath}/resources/libs/js/jquery-2.1.3.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/libs/js/bootstrap.min.js"></script>
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug
    <script src="assets/js/ie10-viewport-bug-workaround.js"></script> -->
	<script
		src="${pageContext.request.contextPath}/resources/assets/js/ie10-viewport-bug-workaround.js"></script>


</body>
</html>