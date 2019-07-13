package com.example.jpa.rep;

import com.example.jpa.JpaApplicationTests;
import com.example.jpa.Service.impl.UserServiceImpl;
import com.example.jpa.model.User;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import static org.junit.Assert.*;

public class UserRepositoryTest extends JpaApplicationTests {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private UserServiceImpl userService;

    private User user;

    @Before
    public void Before(){
        user = new User();
    }

    @Test
    public void login() {
        Integer login = userRepository.login("1321","123");
        System.out.println("login:"+login);

    }

    @Test
    public void eidtUser() {
        int editUser = userRepository.editUser("1321","123");
        System.out.println("editUser:"+editUser);
    }
    @Test
    public void sql() {
        user.setUid(2);
        user.setUserName("qweqweq");
        int editUser = userService.updateSql(user);
        System.out.println("editUser:"+editUser);
    }
}