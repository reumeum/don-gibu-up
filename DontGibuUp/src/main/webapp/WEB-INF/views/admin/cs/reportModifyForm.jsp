<!-- reportReplyModifyForm -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<form:form action="reply" modelAttribute="reportVO">
	<form:hidden path="mem_num" value="${report.mem_num}"/>
	<form:hidden path="report_num" value="${report.report_num}"/>
	<form:radiobutton path="report_status" value="1" id="report_status_1" />
       <label for="report_status_1">승인</label><br>
	<form:radiobutton path="report_status" value="2" id="report_status_2" />
       <label for="report_status_2">반려</label><br>
	<div>
		<form:label path="report_reply">답변</form:label>				
	</div>
	<form:textarea path="report_reply" cols="60" rows="5"/>
	<form:errors path="report_reply" cssClass="form-error"></form:errors>
	<div>
		<form:button>답변 수정</form:button>
	</div>
</form:form>
<script>
$(function() {
	$('#report_reply').val($('#replyContent').text());
	$('#replyContent').hide();
	$('#replyInfo').hide();
});
</script>