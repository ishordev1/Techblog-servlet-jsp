
<%@page import="com.techblog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.techblog.helper.connectionProvider"%>
<%@page import="com.techblog.dao.PostDao"%> 


<div class="row">
<%
PostDao d=new PostDao(connectionProvider.getConnection());
int cid=Integer.parseInt(request.getParameter("cid"));
List<Post> posts=null;
if(cid==0){
posts=d.getAllPosts();
}
else{
	posts=d.getPostByCatId(cid);
}
if(posts.size()==0){
	out.print("<h3 class='display-3 text-center'>No Post in this catagories...</h3>");
	return;
}

for(Post p:posts){
	%>
<div class="col-md-6 mt-2">
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