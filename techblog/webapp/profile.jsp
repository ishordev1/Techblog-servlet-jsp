<%@page import="java.util.ArrayList"%>
<%@page import="com.techblog.dao.PostDao"%>
<%@page import="com.techblog.helper.connectionProvider"%>
<%@page import="com.techblog.entities.category"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page errorPage="error_page.jsp" %>
    <%@page import="com.techblog.entities.User ,com.techblog.entities.Message " %>
    
    <%
    User user=(User)session.getAttribute("currentUser");
    if(user==null)
    {
    	response.sendRedirect("login.jsp");
    }
    

    %>
    
   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>profile</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" 
integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link href="css/mystyle.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.banner-background{
clip-path: polygon(100% 0, 100% 100%, 77% 93%, 50% 98%, 20% 91%, 0 100%, 0 0);
}
body{
background:url(image/bg.jpg);
background-size:cover;
background-attachment:fixed;
}
</style>

</head>
<body>
<!-- nav bar  -->

<nav class="navbar navbar-expand-lg navbar-dark primary-background">
  <a class="navbar-brand" href="index.jsp"><span class="fa fa-asterisk"></span> Tech Blog</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="profile.jsp"><span class="fa fa-home"></span> Mr ishor <span class="sr-only">(current)</span></a>
      </li>
      
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <span class="fa fa-folder-open-o"></span> catagories
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#">programming</a>
          <a class="dropdown-item" href="#">Project</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Python</a>
        </div>
      <li class="nav-item">
        <a class="nav-link" href="#"><span class="fa fa-address-book-o"></span> contact</a>
      </li> 
      
       <li class="nav-item">
        <a class="nav-link" data-toggle="modal" data-target="#add-post-modal" href="#"><span class="fa fa-asterisk"></span>Dopost</a>
      </li>
      
    </ul>
    
    
   <ul class="navbar-nav mr-right">
           <li class="nav-item">
        <a class="nav-link" href="#" data-toggle="modal" data-target="#profilemodal"><span class="fa fa-user-circle"></span> <%= user.getName() %></a>
      </li>
      
      
        <li class="nav-item">
        <a class="nav-link" href="logoutServlet"><span class="fa fa-user-plus"></span> logout</a>
      </li>
   
   </ul>
  </div>
</nav>


<!-- nav bar end -->

<!-- this remove because we are login, so if not login then it help to show error massage  in sign in page-->
<%
Message m=(Message)session.getAttribute("msg");
if(m!=null){

%>

<div class="alert <%= m.getCssClass()%>" role="alert">
<%=m.getContent() %>
</div>
<%
session.removeAttribute("msg");
}
%>




<!--start main body of the page  -->

<main>
 <div class="container">
 <div class="row mt-4">
 <!-- first column -->
 <div class="col-md-4">
 <!-- list of catagories -->
 
 
 
 <div class="list-group">
  <a href="#" onclick="getPosts(0, this)" class=" c-link list-group-item list-group-item-action active">
    All Post
  </a>
    <!-- get all catagories -->
  <%
  PostDao d=new PostDao(connectionProvider.getConnection());
  ArrayList<category> list1=d.getAllCategories();
  for(category cc:list1){
  %>
<a href="#" onclick="getPosts(<%=cc.getCid() %>,this)"  class=" c-link list-group-item list-group-item-action"><%=cc.getName() %></a>
<%
}
%>
  

</div>
 </div>
 
 
 <!-- second column -->
<div class="col-md-8">
<!-- all post -->
<div class="container text-center" id="loader">
<i class="fa fa-refresh fa-4x fa-spin"></i>
<h3 class="mt-2">Loading...</h3>
</div>


<div class="container-fluid" id="post-container">

</div>


</div>
 </div>
 </div>

</main>

<!-- End main body -->





<!-- start modal profile show -->

<div class="modal fade" id="profilemodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header primary-background text-white">
        <h5 class="modal-title" id="exampleModalLabel">Tech Blog</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
       <div class="container text-center">
       <img alt="image not found" src="pics/<%=user.getProfile() %>" class="img-fluid" style="border-radius:50%; max-width:200px;"> 
       <br>
        <h5 class="modal-title mt-3" id="exampleModalLabel"><%=user.getName() %></h5>
        
        <!-- Details... -->
       <div id="profile-details">
        <table class="table">
  <tbody>
    <tr>
      <th scope="row">ID :</th>
      <td><%=user.getId() %></td>
    
    </tr>
    <tr>
      <th scope="row">Email :</th>
      <td><%=user.getEmail() %></td>
    </tr>
    
    <tr>
      <th scope="row">Gender :</th>
      <td><%=user.getGender() %></td>
    </tr>
    
     <tr>
      <th scope="row">About :</th>
      <td><%=user.getAbout() %></td>
    </tr>
    
     <tr>
      <th scope="row">Registered on :</th>
      <td><%=user.getDateTime().toString() %></td>
    </tr>
    
  </tbody>
</table>
       </div>
       
       <!-- profile edit -->
       <div id="profile-edit" style="display:none;">
       <h3 class="mt-2">Please Edit carefully</h3>
       <form action="EditServlet" method="post" enctype="multipart/form-data">
       
       <table class="table">
        <tr>
       <td>ID</td><td><%=user.getId() %> </td>
       </tr>
       
        <tr>
       <td>Name:</td><td><input type="text" name="user_name" value="<%=user.getName() %>" class="form-control"> </td>
       </tr>
       
       
       <tr>
       <td>Email:</td><td><input type="email" name="user_email" value="<%=user.getEmail() %>" class="form-control"> </td>
       </tr>
       
        <tr>
       <td>password:</td><td><input type="password" name="user_password" value="<%=user.getPassword() %>" class="form-control"> </td>
       </tr>
       
        <tr>
       <td>Gender: </td><td><%=user.getGender().toUpperCase() %> </td>
       </tr>
       
       
        <tr>
       <td>About:</td>
       <td>
       <textarea rows="3" name="user_about" class="form-control"> <%=user.getAbout()%> </textarea> 
       </td>
       </tr>
       <tr>
       <td>select new pics:</td><td><input type="file" name="image" class="form-control"> </td>
       </tr>
       
       </table>
       
       <div class="container">
       <button type="submit" class="btn btn-outline-primary">save</button>
       </div>
       
       </form>
       
       </div>
         
       
       </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button id="edit-profile-button" type="button" class="btn btn-primary">Edit</button>
      </div>
    </div>
  </div>
</div>
<!-- end modal -->




<!-- start post modal -->

<!-- Modal -->
<div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Provide the post details</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
    
    <form id="add-post-form" action="AddPostServlet" method="post">
    
    
     <div class="form-group">
    <select class="form-control" name="cid">
    <option selected disabled>--Select catagories--</option>
    <%
    PostDao postd=new PostDao(connectionProvider.getConnection());
    ArrayList<category> list=postd.getAllCategories();
    for(category c:list){
    %>
    <option value="<%=c.getCid() %>"><%=c.getName() %></option>
<%
}
%>
    </select>
    </div>
    
    <div class="form-group">
    <input type="text" placeholder="Enter post Title" class="form-control" name="pTitle">
    </div>
    
      <div class="form-group">
    <textarea placeholder="Enter your contend" name="pContent" class="form-control" style="height:200px;"></textarea>
    </div>
    
         <div class="form-group">
    <textarea placeholder="Enter your program" name="pCode" class="form-control" style="height:200px;"></textarea>
    </div>
    
      <div class="form-group">
      <label>Select your Pics:</label><br>
   <input type="file" name="pic">
    </div>
    
    <div class="container text-center">
    <button type="submit" class="btn btn-outline-primary">post</button>
    </div>
    
    </form>
    
    
      </div>
      
    </div>
  </div>
</div>

<!-- end post modal -->




<!-- javascript -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
<script src="myjs/myjs.js" type="text/javascript"> </script>

<script>
$(document).ready(function(){
	let editStatus=false;
	//to target edit button on his id and when the click on the  button then the function work
	$("#edit-profile-button").click(function(){
//		alert("button clicked")


//when click edit button then edit will show other wise profile show
if(editStatus==false){
	
	// to hide the form when the click on the edit button
	// to target the #profile-details
	$("#profile-details").hide()
	//when hide profile then edit options show
	$("#profile-edit").show();
	editStatus=true;
	//this means edit-profile-button
	$(this).text("Back");
}
else{
	$("#profile-details").show()
	$("#profile-edit").hide();
	editStatus=false;
	$(this).text("Edit");
}

	})
	//end the edit button function
});

</script>


<!-- now add post js -->



<script>
$(document).ready(function(e){
	//alert("this is check....")
$("#add-post-form").on("submit", function(event){
	event.preventDefault();
	console.log("you have clicked on submited...")
	
	let form=new FormData(this);
	
	$.ajax({
		url: "AddPostServlet",
		type: 'POST', 
		data: form,
		success: function (data, textStatus, jqXHR){
			//success
			console.log(data)
			if(data.trim()=='done'){
				swal("Good job!", "save successfully", "success");
			}
			else{
				swal("error", "Something went wrong! try again", "error");
			}
		},
		error: function (jqXHR, textStatus, errorThrown){
			// error	
			swal("error", "Something went wrong! try again", "error");
		},
		processData: false,
		contentType: false
	
	})
})
	
})

</script>

<!-- catagories manage in main body -->
<script>
function getPosts(catId,temp){
	$("#loader").show();
	$("#post-container").hide()
	$(".c-link").removeClass('active')
	<!-- we are puting load_posts function in getPost-->
	<!--function because it execute after page loade here when we call then execute it-->
	$.ajax({
		url:"load_posts.jsp",
		data:{ cid:catId},
		success: function (data,textStatus, jqXHR){
			console.log(data);
			$("#loader").hide();
			$("#post-container").show();
			$('#post-container').html(data);
			$(temp).addClass('active');
		}
	})
}
$(document).ready(function(e){
	<!--we pass zero because it is index 0 -->
	let allPostRef= $('.c-link')[0];
	getPosts(0, allPostRef)
})
</script>

</body>
</html>