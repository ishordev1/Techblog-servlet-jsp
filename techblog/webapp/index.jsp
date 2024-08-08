

<%@page import="java.util.List"%>
<%@page import="com.techblog.entities.category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techblog.dao.PostDao"%>
<%@page import="com.techblog.entities.Post"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*, com.techblog.helper.connectionProvider" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>home page</title>
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

<!-- banner  -->
<div class="container-fluid m-0 p-0">

<div class="jumbotron primary-background text-white banner-background">
<div class="container">
<h3 class="display-3">Welcome to TechBlog</h3>
<p>Welcome to technical blog</p>
<p>This is best plateform to learning and sharing new skill</p>
<button class="btn btn-outline-light btn-lg"><span class="fa fa-user-plus"></span> Start! its Free</button>
<a href="login.jsp" class="btn btn-outline-light btn-lg"><span class="fa fa-user-circle fa-spin"></span> login</a>
</div>
</div>

</div>



<!-- cards -->
<div class="container">
<div class="row mb-2">
<%
    PostDao postd=new PostDao(connectionProvider.getConnection());
    List<Post> list=postd.getAllPosts();
    for(Post p:list){
    %>
<div class="col-md-4 mt-2">
<div class="card">
<img class="card-img-top" src="blog_pics/<%=p.getpPic() %>" alt="card image cap">
<div class="card-body">
	
	<b><%=p.getpTitle() %></b>	
	<!-- <p><%=p.getpContent() %><p> -->
<!--<pre><%=p.getpCode() %></pre> -->	
<div class="card-footer text-center primary-background">
<a href="#" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o">10k</i></a>
<a href="show_blog_page.jsp?post_id=<%=p.getPid() %>" class="btn btn-outline-light btn-sm">Read more</a>
<a href="#" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up">101k</i></a>

</div>
	

	
</div>
</div>
</div>
	
	<%
}
%>
</div>



</div>

</div>




<!-- javascript -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<script src="myjs/myjs.js" type="text/javascript"> </script>

</body>
</html>