package com.techblog.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.techblog.dao.PostDao;
import com.techblog.entities.Post;
import com.techblog.entities.User;
import com.techblog.helper.Helper;
import com.techblog.helper.connectionProvider;

@MultipartConfig
public class AddPostServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//String catId=request.getParameter("cid");
	 int catId=Integer.parseInt(request.getParameter("cid"));
		String pTitle=request.getParameter("pTitle");
		String pContent=request.getParameter("pContent");
		String pCode=request.getParameter("pCode");
		Part part=request.getPart("pic");
//		getting user form session
		HttpSession session=request.getSession();
		User user=(User)session.getAttribute("currentUser");
	 

PrintWriter out=response.getWriter();
//out.println("your post title is "+pTitle);
//out.println(part.getSubmittedFileName());
//out.println(ccid);


Post p=new Post(pTitle, pContent, pCode, part.getSubmittedFileName(), null, catId, user.getId() );
PostDao dao=new PostDao(connectionProvider.getConnection());
if(dao.savePost(p)) {
	
	String  path="E://programs//language practies//java/techblog//webapp/blog_pics"+File.separator+p.getpPic();
    Helper.saveFile(part.getInputStream(), path);
    out.print("done");
}
else {
	out.print("not save post");
}
	}

}
