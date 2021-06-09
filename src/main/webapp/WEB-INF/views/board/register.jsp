<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="../includes/header.jsp" %>


<style>
.uploadResult{
	width:100%;
	background-color: gray;
}

.uploadResult ul{
	display:flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li{
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}

.uploadResult ul li img{
	width: 100px;
}

.uploadResult ul li span{
	color: white;
}

.bigPictureWrapper{
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255,255,255,0.5);
}

.bigPicture{
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img{
	width: 600px;
}
</style>


 <div class="row">
     <div class="col-lg-12">
         <h1>글 등록</h1>
     </div>
     <!-- /.col-lg-12 -->
</div>

<div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
            
                <div class="panel-heading">글 등록</div>
                
                <div class="panel-body">
                    
                    <form action="/board/register" role="form" method="post">
                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }"/>
                    	<div class="form-group">
                    		<label>제목</label> <input class="form-control" name="title">
                    	</div>
                    	
                    	<div class="form-group">
                    		<label>내용</label> <textarea rows="3" class="form-control" name="content"></textarea>
                    	</div>
                    	
                    	<div class="form-group">
                    		<label>작성자</label> <input class="form-control" name="writer" 
                    		value='<sec:authentication property="principal.username"/>' readonly="readonly">
                    	</div>
                    	
                    	<button type="submit" class="btn btn-warning">등록</button>
                    	<button type="reset" class="btn btn-dark">리셋</button>
                    	                    	      	
                    </form>
                    
                </div> <!-- /.table-responsive -->                  
             </div> <!-- /.panel-body -->            
         </div> <!-- /.panel -->       
     </div> <!-- /.col-lg-6 -->
     
     
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
		
			<div class="panel-heading">파일 첨부</div>
			<div class="panel-body">
			
				<div class="uploadDiv">
					<input type="file" name="uploadFile" multiple="multiple">
	
				</div>
				
				<div class="uploadResult">
					<ul>
					</ul>
				</div>
			
			</div><!-- /.panel-body -->   
		</div>          
	</div> <!-- /.panel -->       
</div> <!-- /.col-lg-6 -->

<script type="text/javascript">
$(document).ready(function(e){
    
    var formObj = $("form[role='form']");

    $("button[type='submit']").on("click",function (e){
        
    	e.preventDefault();

        console.log("submit clicked");
        
        var str = "";

        $(".uploadResult ul li").each(function (i, obj) {
            
            var jobj = $(obj);
            
            console.log(jobj);
            
            str +="<input type='hidden' name='attachList["+i+"].fileName'   value='"+jobj.data("filename")+"'>";
            str +="<input type='hidden' name='attachList["+i+"].uuid'       value='"+jobj.data("uuid")+"'>";
            str +="<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
            str +="<input type='hidden' name='attachList["+i+"].fileType'   value='"+jobj.data("type")+"'>";

        });
        formObj.append(str).submit();
        /* formObj.append(str); */
    })
    
    
    

    var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
    var maxSize = 5242880;

    function checkExtension(fileName, fileSize) {
        if (fileSize >= maxSize) {
            alert("파일 사이즈 초과")
            return false;
        }

        if (regex.test(fileName)) {
            alert("해당 종류의 파일은 업로드할 수 없습니다.")
            return false;
        }
        return true;
    }//checkExtension 506

    var csrfHeaderName = "${_csrf.headerName}";
    var csrfTokenValue = "${_csrf.token}";
    
    $("input[type='file']").change(function (e) {
    	
        var formData = new FormData();        
        var inputFile = $("input[name='uploadFile']");        
        var files = inputFile[0].files;

        for (var i = 0; i < files.length; i++) {

            if (!checkExtension(files[i].name, files[i].size)) {
                return false;
            }//if
            formData.append("uploadFile", files[i])

        }//for

        $.ajax({
            url         : '/uploadAjaxAction',
            processData : false,
            contentType : false,
            beforeSend  : function(xhr){
            	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            },
            data        : formData,
            type        : 'POST',
            dataType    : 'json',
            success     : function (result){
                console.log(result)
                showUploadResult(result);
            }
        });//ajax

    });

    function showUploadResult(uploadResultArr){
        if (!uploadResultArr || uploadResultArr.length == 0){return;}

        var uploadUL = $(".uploadResult ul")
        var str = "";

        $(uploadResultArr).each(function (i,obj){
            if (obj.image){

                var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
                str += "<li data-path='"+obj.uploadPath+"'";
                str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'"
                str +" ><div>";
                str += "<span> "+ obj.fileName+"</span>";
                str += "<button type='button' data-file=\'"+fileCallPath+"\' "
                str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
                str += "<img src='/display?fileName="+fileCallPath+"'>";
                str += "</div>";
                str +"</li>";

            }//if
        });
        uploadUL.append(str);
    }

    $(".uploadResult").on("click","button",function (e){
        console.log("delete file");

        var targetFile = $(this).data("file");
        var type = $(this).data("type");

        var targetLi = $(this).closest("li");

        $.ajax({

            url: '/deleteFile',
            data: {fileName: targetFile , type:type},
            beforeSend  : function(xhr){
            	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            },
            dataType: 'text',
            type:   'POST',
            success:function (result){
                alert(result);
                targetLi.remove();
            }
        });//ajax
    });

})
</script>
        
<%@include file="../includes/footer.jsp" %>