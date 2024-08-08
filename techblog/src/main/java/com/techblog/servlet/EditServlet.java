package com.techblog.servlet;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.techblog.dao.UserDao;
import com.techblog.entities.Message;
import com.techblog.entities.User;
import com.techblog.helper.Helper;
import com.techblog.helper.connectionProvider;

@MultipartConfig
public class EditServlet extends HttpServlet {
public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
	PrintWriter out=res.getWriter();
	String userName=req.getParameter("user_name");
	String userEmail=req.getParameter("user_email");
	String userPassword=req.getParameter("user_password");
	String userAbout=req.getParameter("user_about");
	Part part=req.getPart("image");
	
	String imgName=part.getSubmittedFileName();
	
	//get the user from the session...
	HttpSession s=req.getSession();
	User user=(User)s.getAttribute("currentUser");
	
	user.setEmail(userEmail);
    user.setName(userName);
	user.setAbout(userAbout);
	user.setPassword(userPassword);
	
	String oldPic=user.getProfile();
	user.setProfile(imgName);
	
	
	//update into databasses......
	
	UserDao userDao=new UserDao(connectionProvider.getConnection());
	boolean ans=userDao.updateUser(user);
	
	if(ans) {
	// 	out.println("updated to db");
	
	//String path=req.getRealPath("/")+"pics"+File.separator+user.getProfile();   //it will send data in temp folder so not user this but use on server
				String  path="E://programs//language practies//java/techblog//webapp/pics"+File.separator+user.getProfile();
				
//				Delete old pic
				String  oldPicPath="E://programs//language practies//java/techblog//webapp/pics"+File.separator+oldPic;
				if(!oldPic.equals("default.png")) {
		       Helper.deleteFile(oldPicPath);
		}
	
		if(Helper.saveFile(part.getInputStream(), path)) {
		out.println("profile updated......");
		 Message msg=new Message("profile details updated......", "success", "alert-success");
		 s.setAttribute("msg", msg);
		}
		else {
		
				out.println("not update");
				 Message msg=new Message("Something went wrong...", "error", "alert-denger");
				 s.setAttribute("msg", msg);
		}
	}

	else {
		out.println("not update");
		 Message msg=new Message("Something went wrong...", "error", "alert-denger");
		 s.setAttribute("msg", msg);
	}

	res.sendRedirect("profile.jsp");
	
}

}
