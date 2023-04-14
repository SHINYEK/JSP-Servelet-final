package model;
import java.util.*;
import java.sql.*;

public class UserDAO {
	//회원정보
	public UserVO read(String uid) {
		UserVO vo=new UserVO();
		try {
			String sql="select * from users where uid=?";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setString(1, uid);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				vo.setUid(rs.getString("uid"));
				vo.setUpass(rs.getString("upass"));
				vo.setUname(rs.getString("uname"));
				vo.setAddress(rs.getString("address"));
				vo.setPhone(rs.getString("phone"));
			}
		}catch(Exception e) {
			System.out.println("회원정보:" + e.toString());
		}
		return vo;
	}
}
