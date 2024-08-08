

package com.techblog.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.techblog.dao.UserDao;
import com.techblog.entities.User;
import com.techblog.helper.connectionProvider;
import com.techblog.entities.Message;

public class LoginServlet extends HttpServlet {
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException , IOException{
	response.setContentType("text/html");
	PrintWriter out=response.getWriter();
String useremail=request.getParameter("email");
String userpassword=request.getParameter("password");
UserDao dao=new  UserDao(connectionProvider.getConnection());

User u=dao.getUserByEmailAndPassword(useremail, userpassword);


if(u==null) {
	//loging error
	out.println("error fail");
	
	 Message msg=new Message("Invalid Details ! try with another", "error", "alert-danger");
	 HttpSession s=request.getSession();
	 s.setAttribute("msg", msg);
	 
     response.sendRedirect("login.jsp");
}
else {
	//login success
	HttpSession s=request.getSession();
	s.setAttribute("currentUser", u);
	response.sendRedirect("profile.jsp");
	
}

}
	
	
	
}
