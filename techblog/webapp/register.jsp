<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" 
integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link href="css/mystyle.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
.banner-background{
clip-path: polygon(100% 0, 100% 100%, 77% 93%, 50% 98%, 20% 91%, 0 100%, 0 0);
}
</style>
</head>
<body>
<%@include file="navbar.jsp" %>
<main class="primary-background  banner-background " style="padding-bottom : 80px ;">
<div class="container">
<div class="col-md-6 offset-md-3">

<!-- card -->
<div class="card">
<div class="card-header text-center primary-background text-white">
<span class="fa fa-3x fa-user-circle"></span>
<br>
Signup Here
</div>

<div class="card-body">
<form id="reg-form"action="RegisterServlet" method="post">
               
 <div class="form-group">
    <label for="user_name">User Name</label>
    <input type="text"  name="user_name" class="form-control" id="user_name" aria-describedby="emailHelp" placeholder="Enter name">
  </div>

  <div class="form-group">
    <label for="exampleInputEmail1">Email address</label>
    <input name="user_email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
  </div>
  
  
  <div class="form-group">
    <label for="exampleInputPassword1">Password</label>
    <input  name="user_password" type="password" class="form-control" id="password" placeholder="Password">
  </div>
  
  <div class="form-group">
    <label for="gender">Select Gender</label><br>
    <input type="radio" id="gender" value="male" name="user_gender"> male 
     <input type="radio" id="gender" value="female" name="user_gender"> female
  </div>
  
  <div class="form-grounp">
  <textarea name="user_about" rows="5" cols="" placeholder="enter something about yourself" class="form-control"></textarea>
  </div>
  
  <div class="form-check">
    <input name="check" value="checked" type="checkbox" class="form-check-input" id="exampleCheck1">
    <label class="form-check-label" for="exampleCheck1">term & condition</label>
  </div>
  
  <br>
  
  <div class="container text-center" id="loader" style="display:none;">
  <span class="fa fa-refresh fa-4x fa-spin"></span>
  <h4>Please wait....</h4>
  </div>
  <button id="submit-btn" type="submit" class="btn btn-primary">Submit</button>
</form>


</div>
</div>
</div>
</div>
</main>



<!-- javascript -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script src="myjs/myjs.js" type="text/javascript"> </script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
<script>
$(document).ready(function(){
	
console.log("Loaded.........")	

//when form is submit then this function automatic execute
$('#reg-form').on('submit', function(event){
	//form not goes to servlet page so this event preventDefault() function write
	event.preventDefault();
	
	
	//form all data goes to form variable
	let form=new FormData(this);
	
	//after click in submit button    submit btn will hide and loader will show
	$("#submit-btn").hide();
	$("#loader").show();
	
	//send register servlet;
	$.ajax({
		
		url:"RegisterServlet",
		type:'POST',
		data:form,
		//when success then success function execute otherwise error function execute
		success: function(data, textStatus, jqXHR){
			console.log(data)
			//submit btn show and loader will hide
			$("#submit-btn").show();
			$("#loader").hide();
			
			if(data.trim()=='done'){
				
			//sweet alert use
			swal(" Registered successfully..... We are going to redirect to login Page..")
			.then((value) => {
			  window.location="login.jsp"
			});
			
			}
			else{
				swal(data);
				
			}
			
		},
		error:function(jqXHR, textStatus,errorThrown){
			$("#submit-btn").show();
			$("#loader").hide();
			
			
			swal(" Something went wrong....try again latter");
			
		},
		processData:false,
		contentType:false
	});
	
	
})



})
</script>
 
</body>
</html>