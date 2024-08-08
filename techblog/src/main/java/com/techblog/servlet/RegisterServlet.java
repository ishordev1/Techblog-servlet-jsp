package com.techblog.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.techblog.dao.UserDao;
import com.techblog.entities.User;
import com.techblog.helper.connectionProvider;

@MultipartConfig
public class RegisterServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	response.setContentType("text/html");
	PrintWriter out=response.getWriter();
	String check=request.getParameter("check");

	if(check==null) {
		out.println("please accept out term & condition");
	}
	else {
	// checked boxed
		String name=request.getParameter("user_name");
		String email=request.getParameter("user_email");
		String password=request.getParameter("user_password");
		String gender=request.getParameter("user_gender");
		String about=request.getParameter("user_about");

	
		
		// Create User object and set all data to that object
		User user=new User(name, email, password, gender,about);
		
		
		//create user dao object
		UserDao dao=new UserDao(connectionProvider.getConnection());
	if(	dao.saveUser(user)) {
		//save data....
		out.println("done");
	}
	else {
		out.println("error");
	}
	
	}

	
	}

}
