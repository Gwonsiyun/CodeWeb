<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%@ page import="java.util.*" %>
<%
	Member user_ = (Member)session.getAttribute("loginUser");
		
%>
<%
	request.setCharacterEncoding("UTF-8");
	String searchType = request.getParameter("searchType");
	String searchValue = request.getParameter("searchValue");
	
	String bidx= request.getParameter("bidx");
	String type_= request.getParameter("type");
	
	Connection conn	= null;
	PreparedStatement psmt = null;
	ResultSet rs	= null;
	
	PreparedStatement psmtReply = null;
	ResultSet rsReply	= null;
	
	String title_ = "";
	String nickname_ = "";
	String content_ = "";
	int bidx_ = 0;
	int midx_ = 0;
	
	ArrayList<Reply> rList = new ArrayList<>();
	
	try{
		
		conn = DBManager.getConnection();
		
		String sql = " SELECT c.* FROM (SELECT ROWNUM r , b.* FROM (select a.* from board a where type_ = ? and delyn='N' ORDER BY bidx) b ) c WHERE bidx = "+bidx;
		
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,type_);
		rs = psmt.executeQuery();
		
		if(rs.next()){
			title_ = rs.getString("title");
			nickname_ = rs.getString("nickname");
			content_ = rs.getString("content");
			bidx_ = rs.getInt("r");
			midx_ = rs.getInt("midx");
		}
		
		sql = "select * from reply r, member m WHERE r.midx = m.midx AND r.bidx = "+bidx+ "ORDER BY r.RIDX";
		
		psmtReply = conn.prepareStatement(sql);
		
		rsReply = psmtReply.executeQuery();
		
		
		
		
		while(rsReply.next()){
			Reply reply = new Reply();
			reply.setBidx(rsReply.getInt("bidx"));
			reply.setMidx(rsReply.getInt("midx"));
			reply.setRidx(rsReply.getInt("ridx"));
			if(rsReply.getString("delyn").equals("N")){
				reply.setRcontent(rsReply.getString("content"));
			}else{
				reply.setRcontent("삭제된 댓글입니다.");
			}
			reply.setRdate(rsReply.getString("createddate"));
			reply.setNickname(rsReply.getString("nickname"));
			if(rsReply.getString("changeyn").equals("Y") && rsReply.getString("delyn").equals("N")){
				reply.setChangeyn("(수정됨)");
			}else{
				reply.setChangeyn("");
			}
			
			reply.setDelyn(rsReply.getString("delyn"));

			
			rList.add(reply);
		}
		
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null){
			conn.close();		
		}
		if(psmt != null){
			psmt.close();		
		}
		if(rs != null){
			rs.close();		
		}
		if(psmtReply != null) psmtReply.close();
		if(rsReply != null) rsReply.close();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<%@ include file="/header.jsp" %>
	<%@ include file="/route.jsp" %>
	<section>
	
		<article>
			<table border="1" width="70%">
				<tr>
					<th>글제목</th>
					<td colsqan="3"><%=title_ %></td>
				</tr>
				<tr>
					<th>글번호</th>
					<td><%=bidx_ %></td>
					<th>작성자</th>
					<td><%=nickname_ %></td>
				</tr>
				<tr height = "300px">
					<th>내용</th>
					<td colspan="3"><%=content_ %></td>
				</tr>
			</table>
			<button type="button" onclick="location.href='list.jsp?type=<%=type_%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">목록</button>
			<%if(user_!= null && user_.getMidx() == midx_){ %>
			<button type="button" onclick="location.href='modify.jsp?bidx=<%=bidx%>&type=<%=type_%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">수정</button>
			<button type="button" onclick="deleteFn()">삭제</button>
			<%} %>
			
			<div class="replyArea">
				<div class="replyInput">
					<form name="reply">
						<p>
							<label>
								댓글 : <input type="text" size="50" name="rcontent">
							</label>
						</p>
						<p>
							<input onclick="replyFn(this)" type="button" value="등록">
						</p>
					</form>
				</div>
				<div class="replyList">
				<table name=reply>
					<tbody id="reply">
					<%for(Reply r : rList){%>
						<tr>
							<td><%=r.getNickname() %> : </td>
							<td class="recon"><%=r.getRcontent()%></td>
							<td class="changeyn"><%=r.getChangeyn() %></td>
							<% if(user_!=null && user_.getMidx()== r.getMidx() && r!=null && r.getDelyn().equals("N")){%>
							<td>
								<input type="button" onclick='modify(<%=r.getRidx()%>,this)' value="수정">
								<input type="button" onclick='deleteReply(<%=r.getRidx()%>,this)' value="삭제" >
							</td>
							<%} %>
						</tr>
					<%}%>
					</tbody>
				</table>
				</div>
			
				
				
			</div>
			
			
			
		</article>
	</section>
	<%@ include file="/footer.jsp" %>
	<script>//외부로 빼서 사용(보안상의 이유 삭제페이지정보가 넘어가면 안됨)
		function deleteFn(){
			location.href="deleteOk.jsp?bidx=<%=bidx%>";
		}
		function replyFn(obj){
			<%if(user_ != null){%>
				$.ajax({
					url : "<%=request.getContextPath()%>/reply/Insert.jsp",
					type : "post",
					data : $("form[name=reply]").serialize()+"&midx="+<%=user_.getMidx()%>+"&bidx="+<%=bidx%>,
					success : function(data){
						var json = JSON.parse(data.trim());
						var html="";
						html += "<tr>";
						html += "<td>"+json[0].nickname+" : </td>";
						html += "<td class='recon'>"+json[0].rcontent+"<span></span></td>";
						html += "<td></td>";
						html += "<td><input type='button' value='수정' onclick='modify("+json[0].ridx+",this)'> <input type='button' value='삭제' onclick='deleteReply("+json[0].ridx+",this)'></td>";
						html += "</tr>";
						$("tbody#reply").append(html);
						$(obj).parent().prev().find('input').val("");
					}
				});
			<%}else{%>
				alert("로그인후 이용하여 주세요.");
			<%}%>
		}
		function modify(ridx,obj){
			
			
			if($(obj).val()=="수정"){
				$(obj).parent().prev().prev().html("<input type='text' value='"+$(obj).parent().prev().prev().html()+"'>");
				$(obj).val("저장");
				$(obj).next().val("취소");
			}else if($(obj).val()=="저장"){
				$.ajax({
					url : "<%=request.getContextPath()%>/reply/modify.jsp",
					type : "post",
					data : "ridx="+ridx+"&rcontent="+$(obj).parent().prev().prev().find('input').val(),
					success : function(){
						$(obj).parent().prev().prev().html($(obj).parent().prev().prev().find('input').val());
						$(obj).parent().prev().text("(수정됨)");
						$(obj).val("수정");
						$(obj).next().val("삭제");
					}
				});
			}
		}
		function deleteReply(ridx,obj){
			 if($(obj).val()=="삭제"){
				var YN = confirm("정말 삭제하시겠습니까?");
				if(YN){
					$.ajax({
						url : "<%=request.getContextPath()%>/reply/deleteOk.jsp",
						type : "post",
						data : "ridx="+ridx,
						success : function(){
							$(obj).parent().parent().find('.recon').text("삭제된 댓글입니다.");
							$(obj).parent().prev().remove();
							$(obj).parent().remove();
						}
					});
				}
			}else if($(obj).val()=="취소"){
				$(obj).parent().prev().prev().html($(obj).parent().prev().prev().find('input').val());
				$(obj).prev().val("수정");
				$(obj).val("삭제");
			}
		}
		
	</script>
</body>
</html>