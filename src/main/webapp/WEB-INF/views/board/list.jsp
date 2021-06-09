<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<%@include file="../includes/header.jsp" %>

<style>
.pagination {
    /* display: flex;
  	justify-content: center; */
}

.searchdiv {
	display: flex;
  	justify-content: center;
}
.logo-image-small
{
background-color: gray;
}


</style>

<form action="/board/list" id="actionForm" method="get">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
	<input type="hidden" name="amount" 	value="${pageMaker.cri.amount }">
	<input type="hidden" name="type" 	value="${pageMaker.cri.type }">
	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
</form>
<div class="row">
	<div class="col-lg-12">
		<h1><a href="/board/list">Thank to</a></h1>
	</div> 
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">Thanks to
                            
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                                <thead>
                                    <tr>
                                        <th style="width:  8%" scope="col">번호</th>
										<th style="width: 42%" scope="col">제목</th>
										<th style="width: 14%" scope="col">작성자</th>
										<th style="width: 15%" scope="col">작성일</th>
										<th style="width: 15%" scope="col">수정일</th>
                                    </tr>
                                </thead>
                                
                                <c:forEach items="${list}" var="board">
                                	<tr>
                                		<td><c:out value="${board.bno}"/></td>
                               			<td><a class="move" href='<c:out value="${board.bno}"/>'>
                               			<c:out value="${board.title}" />
											<b>[<c:out value="${board.replyCnt}"/>]</b>
										</a></td>
                               			
                                		<td><c:out value="${board.writer}"/></td>
                                		<td><fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd"/></td>
                                		<td><fmt:formatDate value="${board.updateDate}" pattern="yyyy-MM-dd"/></td>
                                	</tr>
                                </c:forEach>                     
                            </table>
                            
                            <div class="row">
                            	<div class="searchdiv col-md-4">
                            	
                            		<form action="/board/list" id="searchForm" method="get" >
                            			<select name="type">
                            				<option value=""<c:out value="${pageMaker.cri.type == null? 'selected' : '' }"/>>--</option>                        	
                            				<option value="T"<c:out value="${pageMaker.cri.type eq 'T'? 'selected' : '' }"/>>제목</option>
                            				<option value="C"<c:out value="${pageMaker.cri.type eq 'C'? 'selected' : '' }"/>>내용</option>
                            				<option value="W"<c:out value="${pageMaker.cri.type eq 'W'? 'selected' : '' }"/>>작성자</option>
                            				<option value="TC"<c:out value="${pageMaker.cri.type eq 'TC'? 'selected' : '' }"/>>제목+내용</option>
                            				<option value="TW"<c:out value="${pageMaker.cri.type eq 'TW'? 'selected' : '' }"/>>제목+작성자</option>
                            				<option value="TCW"<c:out value="${pageMaker.cri.type eq 'TCW'? 'selected' : '' }"/>>제목+내용+작성자</option>
                            			</select>
                            			<input type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'/>
                            			<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
                            			<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount}"/>'/>
                            			<!-- 화면이 처리될때 화면상에 pageNum이랑 개수가 보여야 하므로 같이 넘겨준다. -->
                            			<button class="btn btn-default" style="background-color: #57bac9;">찾기</button>
                            		</form>
                            	</div>
                            	
                            	<div class="pagination col-md-6">
	                            	<ul class="pagination">
	                            		
	                            		<c:if test="${pageMaker.prev }">
	                            			<li class="paginate_button previous">
	                            				<a href="${pageMaker.startPage -1 }">이전</a>
	                            			</li>
	                            		</c:if><!--if  -->
	                            		
	                            		<c:forEach var="num" begin="${pageMaker.startPage }"
	                            					end="${pageMaker.endPage }">
	                            			<li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active':'' } ">
	                            				<a href="${num }">${num }</a>
	                            			</li>
	                            		</c:forEach>
	                            		
	                            		<c:if test="${pageMaker.next }">
	                            			<li class="paginate_button next">
	                            				<a href="${pageMaker.endPage +1 }">다음</a>
	                            			</li>
	                            		</c:if>
	                            		
	                            	</ul>
	                            </div>
	                            
	                            <div class="newwrite col-md-2">
	                            	<button id='regBtn' type="button" class="btn btn-primary pull-right" style="background-color: #57bac9;">글 등록</button>
	                            </div>
                            
                            </div>
                            
                            <!-- Modal -->
                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel"></h4>
                                        </div>
                                        <div class="modal-body">
                                            처리가 완료되었습니다.
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
                                        </div>
                                    </div>
                                    <!-- /.modal-content -->
                                </div>
                                <!-- /.modal-dialog -->
                            </div>
                            <!-- /.modal -->
                            
                            
                        </div>
                            <!-- /.table-responsive -->
                     </div>
                     <!-- /.panel-body -->
                 </div>
                 <!-- /.panel -->
             </div>
             <!-- /.col-lg-6 -->
<script type="text/javascript">

$(document).ready(function(){
	
	var result = '<c:out value="${result}"/>';
	
	checkModal(result);
	
	history.replaceState({},null,null);
	
	function checkModal(result) {
		if (result === ''||history.state) {
			return;
		}//if	
		
		if (parseInt(result) > 0) {
			$(".modal-body").html("게시글" + parseInt(result) + "번이 등록되었습니다.")
		}//if
		
		$("#myModal").modal("show");
	}//checkmodal
	
	$("#regBtn").on("click",function(){
		self.location="/board/register";
		
	});
		
	var actionForm = $("#actionForm");
	
	$(".paginate_button a").on("click",function(e){
		e.preventDefault();
		
		console.log('click');
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	$(".move").on("click",function(e) {

		e.preventDefault();
		actionForm.append("<input type='hidden' name='bno' value='"+ $(this).attr("href")+ "'>");
		actionForm.attr("action","/board/get");
		actionForm.submit();

	});
	
	var searchForm = $("#searchForm");
	
	$("#searchForm button").on("click",function(e){
		
		if (!searchForm.find("option:selected").val()) {
			alert("검색 종류를 선택하세요"); 
			return false; 
		}//if
		
		if (!searchForm.find("input[name='keyword']").val()) {
			alert("키워드를 선택하세요");
			return false;
		}//if
		
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		
		searchForm.submit();
		
	})
	 
	
});//


</script>             
         
<%@include file="../includes/footer.jsp" %>