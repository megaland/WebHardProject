/**
 * 
 */

    //Enter Ű Event  
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
			alert("���̵�� 5���� �̻� �Է����ּ���")
			return false;

		} else if (id.length == 0) {
			alert("���̵� �Է��� �ּ���")
			return false;

		} else if (pw.length == 0) {
			alert("��й�ȣ�� �Է��� �ּ���")
			return false;

		} else if (pw.length < 5) {
			alert("��й�ȣ�� 5���� �̻� �Է����ּ���")
			return false;

		} else if (rpw.length < 5) {
			alert("��й�ȣ�� �ٽ��ѹ� �Է����ּ���")
			return false;

		} else if (pw != rpw) {
			alert(" �Է��� 2���� ��й�ȣ�� ��ġ���� �ʽ��ϴ�. ")
			return false;

		} else if (id.indexOf(' ') >= 0) {
			alert(" ID ���̿� ������ ������� �ʽ��ϴ�.")
			return false;

		} else if (pw.indexOf(' ') >= 0) {
			alert(" ��й�ȣ ���̿� ������ ������� �ʽ��ϴ�.")
			return false;

		} else if (rpw.indexOf(' ') >= 0) {
			alert(" ��й�ȣ ���̿� ������ ������� �ʽ��ϴ�.")
			return false;
		}
		
	}
	
	function LoginCheck() {
		var id = document.getElementById('id').value;
		var pw = document.getElementById('pw').value;

		if (id.length == 0) {
			alert("���̵� �Է��� �ּ���")
			return false;
		} else if (id.length < 5) {
			alert("���̵�� 5���� �̻� �Է����ּ���")
			return false;
		} else if (id.indexOf(' ') >= 0) {
			alert(" ID ���̿� ������ ������� �ʽ��ϴ�.")
			return false;
		} else if (pw.length == 0) {
			alert("��й�ȣ�� �Է��� �ּ���")
			return false;
		} else if (pw.length < 5) {
			alert("��й�ȣ�� 5���� �̻� �Է����ּ���")
			return false;
		}  else if (pw.indexOf(' ') >= 0) {
			alert(" ��й�ȣ ���̿� ������ ������� �ʽ��ϴ�.")
			return false;
		}
	}
	
	//�α��� (Ư������) üũ
	function inputCheckSpecial(obj) {
		var strobj = obj;
		re = /[~!@\#$%^&*()_+\\/;:?.,<>]/gi;
		if (re.test(strobj.value)) {
			alert(" Ư�����ڴ� ������� �ʽ��ϴ�.");
			strobj.value = strobj.value.replace(re, "");
		}

	}
	
	function joinOpen(){
		window.open("member_j.jsp", "", "width=500, height=300");
	}
	

	