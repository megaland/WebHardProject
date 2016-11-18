/**
 * 
 */

    //Enter 키 Event  
	function onSearchEnter(event) {   
		if(event.keyCode==13){
			getData("1",$("#field").val(),$("#word").val());
			return false;
		}
	}
	
	
	function IDCheck() { 
		var id = document.getElementById('id').value;
		var pw = document.getElementById('pw').value;
		var rpw = document.getElementById('rpw').value;

		if (id.length < 5) {
			alert("아이디는 5글자 이상 입력해주세요")
			return false;

		} else if (id.length == 0) {
			alert("아이디를 입력해 주세요")
			return false;

		} else if (pw.length == 0) {
			alert("비밀번호를 입력해 주세요")
			return false;

		} else if (pw.length < 5) {
			alert("비밀번호는 5글자 이상 입력해주세요")
			return false;

		} else if (rpw.length < 5) {
			alert("비밀번호를 다시한번 입력해주세요")
			return false;

		} else if (pw != rpw) {
			alert(" 입력한 2개의 비밀번호가 일치하지 않습니다. ")
			return false;

		} else if (id.indexOf(' ') >= 0) {
			alert(" ID 사이에 공백은 허용하지 않습니다.")
			return false;

		} else if (pw.indexOf(' ') >= 0) {
			alert(" 비밀번호 사이에 공백은 허용하지 않습니다.")
			return false;

		} else if (rpw.indexOf(' ') >= 0) {
			alert(" 비밀번호 사이에 공백은 허용하지 않습니다.")
			return false;
		}
		
	}
	
	function LoginCheck() {
		var id = document.getElementById('id').value;
		var pw = document.getElementById('pw').value;

		if (id.length == 0) {
			alert("아이디를 입력해 주세요")
			return false;
		} else if (id.length < 5) {
			alert("아이디는 5글자 이상 입력해주세요")
			return false;
		} else if (id.indexOf(' ') >= 0) {
			alert(" ID 사이에 공백은 허용하지 않습니다.")
			return false;
		} else if (pw.length == 0) {
			alert("비밀번호를 입력해 주세요")
			return false;
		} else if (pw.length < 5) {
			alert("비밀번호는 5글자 이상 입력해주세요")
			return false;
		}  else if (pw.indexOf(' ') >= 0) {
			alert(" 비밀번호 사이에 공백은 허용하지 않습니다.")
			return false;
		}
	}
	
	//로그인 (특수문자) 체크
	function inputCheckSpecial(obj) {
		var strobj = obj;
		re = /[~!@\#$%^&*()_+\\/;:?.,<>]/gi;
		if (re.test(strobj.value)) {
			alert(" 특수문자는 허용하지 않습니다.");
			strobj.value = strobj.value.replace(re, "");
		}

	}
	
	function joinOpen(){
		window.open("member_j.jsp", "", "width=500, height=300");
	}
	

	