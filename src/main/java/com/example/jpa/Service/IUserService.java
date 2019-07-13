package com.example.jpa.Service;

import com.example.jpa.model.User;
import com.example.jpa.vo.UserVo;

import java.util.Map;

public interface IUserService {

    Map loginUser(User user);

    Map registerUser(UserVo user);

    Map editUser(UserVo user,String opassword);

    String imageUrl(User user);

    User gerUser(String name);

    int updateSql(User user);
}
