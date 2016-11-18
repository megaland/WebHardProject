<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="../css/write.css" />
<link href="https://maxcdn.bootstrapcdn.com/bootswatch/3.3.7/paper/bootstrap.min.css" rel="stylesheet" integrity="sha384-awusxf8AUojygHf2+joICySzB780jVvQaVCAt1clU3QsyAitLGul28Qxb2r1e5g+" crossorigin="anonymous">
<script src="../js/write.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<title>Insert title here</title>
<style>
	body{
		clear:both;
		margin:0;
	}

</style>
<script>
var ajaxobject =[];
var files = [];
var completed = [];
var beforefiles = [];
var beforecount = 0;
var beforecount2 = 0;
var imgcount = 0;
var imgcount2 = 0;
var imgarray = [];


$(document).ready(function(){
	$("#hideshow").hide();
	$("#dragdiv").on("dragenter dragover", function(event){
		event.preventDefault();
	});
	
	$("#dragdiv").on("drop", function(event){
		event.preventDefault();
		
		if(beforecount == 0){
			$("#dragdiv").html("");
			$("#dragdiv").css("line-height", "1");
			beforecount++;
		}
	
		var tempfiles = event.originalEvent.dataTransfer.files;
		var str = "<table>";
		var currentfileslength = beforefiles.length;
		for (var i = currentfileslength; i < currentfileslength+tempfiles.length; i++) {		
			beforefiles[beforefiles.length] = tempfiles[i - currentfileslength];
			
			var comparestr = beforefiles[i].name.substr(beforefiles[i].name.indexOf(".")+1);
 			if(comparestr == "png" || comparestr == "jpg" || comparestr == "bmp"){
				if(beforecount2 == 0){
					$("#dragimgdiv").html("");
					$("#dragimgdiv").css("line-height", "1");
					beforecount2++;
				}
				imgarray[imgcount] = i;
				imgcount++;
				
		    	var file = beforefiles[i];
		        var reader = new FileReader();
			    reader.onload = (function(theFile){
			    	return function(e){
		                var img_view = ['<img src="', e.target.result,'" id="image', imgarray[imgcount2],'" title="' ,escape(theFile.name), '" style="width:20%; height: 80%;"','"/>'].join('');                
		                $("#dragimgdiv").append(img_view);
		                imgcount2++;
		            };
			    })(file);
			    reader.readAsDataURL(file);
			}
			
	 		str += "<tr onclick='deleterow(this)'><input type='hidden' value='"+i
	 		+"'><td style='width:150px;text-align:left;'>"
	 		+beforefiles[i].name+"</td><td id='filesize"+i+"'>"
	 		+beforefiles[i].size+"</td></tr>";
		}
		str += "</table>";
		$("#dragdiv").append(str);
	});
	
	$("#sendbtn").click(function(){
		var totalpoint = 0;
		var filecount = 0;
		if(beforefiles.length == 0 ){
			alert("파일이 없습니다.");
			return;
		}
		for (var i = 0; i < beforefiles.length; i++) {
			if(beforefiles[i] != null){
				files[filecount] = beforefiles[i];
				totalpoint += beforefiles[i].size/10000000;
				filecount++;
			} 
		}
		if(totalpoint < 10){
			totalpoint = 10;
		}

		var str = "<table>";
		for (var j = 0; j < files.length; j++) {
			str += "<tr><td style='width:70%;'>"+files[j].name+"</td><td style='width:15%' id='filesize"+j+"'>"+files[j].size+"</td><td>"
			+"<progress id='progress"+j+"' max='100' value='0'></progress></td></tr>"
					
		}
		str += "</table>";
		$("#hideshow").html(str);

		$.ajax({
			url : "../board/registerboard",
			type : "post",
			dataType : "text",
			heders : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			data : {"writer": $("#writer").val(), "title": $("#title").val(), "content" : $("#content").val(), "point" : parseInt(totalpoint), "genre" : $("#genre").val()},
			success : function(result){
			
				bno = parseInt(result);
		 		$("#hideshow").show();
				$("#all").css({"background":"rgba(0,0,0,0.8)","z-index":"2","width":"100%" ,"height":$(document).height(),"position":"absolute", "overflow" : "hidden"});
				$("body").css({"display":"block","z-index":"1", "overflow":"hidden"});
				$("#hideshow").css({"top" : $(window).scrollTop()+$(window).height()*1/4, "overflow":"auto", "height" : $(window).height()/2, "background-color": "white"});
				repeatajax(files, 0, bno);
			}
		});
		

	});
	
	$("#all").click(function(){					
		alert("클릭금지");
		/* $("#hideshow").hide();
		$("#all").css({"width":"0","height":"0"});
		$("body").css({"overflow":"auto"}); */
	});
});
function deleterow(obj){
	var objectnum = $(obj).find("input").val()
	var comparestr = beforefiles[objectnum].name.substr(beforefiles[objectnum].name.indexOf(".")+1);
	if(comparestr == "png" || comparestr == "jpg" || comparestr == "bmp"){
		$("#image"+objectnum).remove();
	}
	beforefiles[$(obj).find("input").val()] = null;
	$(obj).remove();
}

function repeatajax(files, count, bno){
	var file = files[count];
	var formData = new FormData();
	formData.append("file", file);
	formData.append("count", count);
	formData.append("bno", bno);
	ajaxobject[count] = $.ajax({
		url : "../board/fileupload",
		type : "post",
		dataType : "text",
		data : formData,
	    xhr: function() {
	        var myXhr = $.ajaxSettings.xhr();
	        if(myXhr.upload){
	            myXhr.upload.addEventListener('progress', function(e){
	                if (e.lengthComputable) {
	                    var s = parseInt((e.loaded / e.total) * 100);
	                    var progressname = "#progress" + count;
	                    var filesize = "#filesize"+count;
	                    $(filesize).text(e.loaded+"/"+e.total);
	                    $(progressname).val(s);
	                    if (s == 100) {
	                        triggerNextFileUpload();
	                    }
	                }
	            }, false);
	        }
	       	return myXhr;
		},
		cache : false,
		processData : false,
		contentType : false,
		success : function(result){
			completed[parseInt(result)] = true;
			var nextcount = parseInt(result)+1;
			if(nextcount < files.length){
				repeatajax(files, nextcount, bno);
			}else {
				alert("업로드 완료");
				window.close();
				window.opener.location.href="../board/mainpage";
			}
		},
		error : function(xhr, status, error){
			alert(error);
		}
	});
}



</script>

</head>
<body>
<div id="all"></div>
<div id="hideshow" style="width:94%;position: absolute;top: 250px;left: 1%;z-index: 3; border-radius:5px; padding:10px; overflow:hidden;"></div>
	<form name="writeform" action="" method="post">
   <table>
   	<tr >
      <td>&nbsp;</td>
      <td align="center">제목</td>
      <td><input type="text" id = "title" name="title" size="55" maxlength="100"></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
    <tr>
          <td>&nbsp;</td>
      <td align="center">장르</td>
      <td>
      		<select id="genre" name="genre">
      			<option>영화</option>
      			<option>음악</option>
      			<option>드라마</option>
      			<option>유틸</option>
      		</select>
      
      </td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
    <tr>
      <td>&nbsp;</td>
      <td align="center">작성자</td>
      <td><input type="hidden" id="writer" name="writer" size="55" maxlength="55" value ="${login }">${login }</td>
      <td>&nbsp;</td>
     </tr>
      <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>

     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
     <tr>
      <td>&nbsp;</td>
      <td align="center">내용</td>
      <td><textarea id="content" name="content" cols="55" rows="13"></textarea></td>
      <td>&nbsp;</td>
     </tr>
     <tr>
      <td>&nbsp;</td>
      <td align="center">파일첨부 </td>
      <td><div id="dragdiv" style="width:100%; height:200px; border:1px solid #dddddd; line-height: 12; text-align: center; overflow:auto">drag & drop</div></td>
      <td>&nbsp;</td>
     </tr>
     <tr>
      <td>&nbsp;</td>
      <td align="center">그림첨부 </td>
      <td><div id="dragimgdiv" style="width:100%; height:200px; border:1px solid #dddddd; line-height: 12; text-align: center; overflow:auto"></div></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
     <tr height="1" bgcolor="#82B5DF"><td colspan="4"></td></tr>
     <tr align="center">
      <td>&nbsp;</td>

      <td colspan="2"><input type=button value="등록" id="sendbtn">
       <input type=button value="취소">
      <td>&nbsp;</td>
     </tr>
    </table>
    </form>
	
</body>
</html>