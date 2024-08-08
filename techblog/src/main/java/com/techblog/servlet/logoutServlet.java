package com.techblog.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import com.techblog.entities.Message;


public class logoutServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		
		
		HttpSession s=request.getSession();
		s.removeAttribute("currentUser");
		Message m=new Message("Logout Successfully", "success", "alert-success");
		s.setAttribute("msg", m);
		response.sendRedirect("login.jsp");
		
		
	}
	
}
