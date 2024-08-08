package com.techblog.dao;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.techblog.entities.Post;
import com.techblog.entities.category;
public class PostDao {
Connection con;

public PostDao(Connection con) {
	this.con = con;
}
public ArrayList<category> getAllCategories(){
	ArrayList<category> list =new ArrayList<>();
	
	try {
		String q="select *from catagories";
		Statement st=this.con.createStatement();
		ResultSet set=st.executeQuery(q);
		while(set.next()) {
		int cid=set.getInt("cid");
		String name=set.getString("name");
		String description=set.getString("description");
		category c=new category(cid, name,description);
		list.add(c);
		
		}
	}
	catch(Exception e) {
		e.printStackTrace();
	}
	return list;
}


public boolean savePost(Post p) {
	boolean f=false;
	try {
		String q="insert into post(ptitle, pcontent,pcode, Pic,catid, userid) values(?,?,?,?,?,?)";
		PreparedStatement pstmt=con.prepareStatement(q);
		pstmt.setString(1, p.getpTitle());
		pstmt.setString(2, p.getpContent());
		pstmt.setString(3, p.getpCode());
		pstmt.setString(4, p.getpPic());
		pstmt.setInt(5, p.getCatId());
		pstmt.setInt(6, p.getUserId());
		pstmt.executeUpdate();
		f=true;
	}
	catch(Exception e) {
		e.printStackTrace();
	}
	
	return f;
}

//get all the post
public List<Post>  getAllPosts(){
	List<Post> list=new ArrayList<>();
	//featch all the post
	try {
PreparedStatement psmt=con.prepareStatement("select *from post order by pid desc");
ResultSet rs=psmt.executeQuery();
	while(rs.next()) {
		int pid=rs.getInt("pid");
		String pTitle=rs.getString("ptitle");
		String pContent=rs.getString("pcontent");
		String pCode=rs.getString("pcode");
		String pPic=rs.getString("pic");
		Timestamp date=rs.getTimestamp("pdate");
		int catId=rs.getInt("catid");
		int userId=rs.getInt("userid");
		Post post=new Post(pid, pTitle, pContent, pCode,pPic, date, catId, userId );
		list.add(post);
	}
	
	}
	catch(Exception e) {
		e.printStackTrace();
	}
	
	return list;
}



//get all by catId
public List<Post> getPostByCatId(int catId){
List<Post> list=new ArrayList<>();
	
try {
	PreparedStatement p=con.prepareStatement("select *from post where catId=?");
	p.setInt(1, catId);
	ResultSet rs=p.executeQuery();
	while(rs.next()) {
		int pid=rs.getInt("pid");
		String pTitle=rs.getString("ptitle");
		String pContent=rs.getString("pcontent");
		String pCode=rs.getString("pcode");
		String pPic=rs.getString("pic");
		Timestamp date=rs.getTimestamp("pdate");
		
		int userId=rs.getInt("userid");
		Post post=new Post(pid,pTitle,pContent,pCode,pPic, date, catId, userId );
		list.add(post);
	}
	
	}
	catch(Exception e) {
		e.printStackTrace();
	}
	
	return list;
}



public Post getPostByPostId(int postId) {
	Post post=null;
	String q="select *from post where pid=?";
try {
	PreparedStatement psmt=con.prepareStatement(q);
	psmt.setInt(1, postId);
	ResultSet rs=psmt.executeQuery();
if(rs.next()) {
	
	int pid=rs.getInt("pid");
	String pTitle=rs.getString("ptitle");
	String pContent=rs.getString("pcontent");
	String pCode=rs.getString("pcode");
	String pPic=rs.getString("pic");
	Timestamp date=rs.getTimestamp("pdate");
	int catId=rs.getInt("catid");
	int userId=rs.getInt("userid");
	post=new Post(pid, pTitle, pContent, pCode,pPic, date, catId, userId );
}
	
}
catch(Exception e)
{
	e.printStackTrace();
	}
return post;
}
}
