package com.example.jpa.controller;

import com.example.jpa.Service.IUserService;
import com.example.jpa.Service.impl.UserServiceImpl;
import com.example.jpa.model.User;
import com.example.jpa.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.time.Year;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private IUserService userService;

    @PostMapping("/reg")
    public Map reg(UserVo user){
//        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
        return userService.registerUser(user);
    }

    @RequestMapping("/editUser")
    public Map editUser(UserVo user,String opassword,HttpSession session){
        Map map = userService.editUser(user, opassword);
        if (map.get("code").equals(200)) {
            session.setAttribute("user",null);
        }
        return map;
    }

    @RequestMapping("/login")
    public Map login(User user, HttpSession session) throws InterruptedException {
        System.out.println(user);
        Thread.sleep(2000);
        session.setAttribute("user",userService.gerUser(user.getUserName()));
        return userService.loginUser(user);
    }

    @RequestMapping("/getImage")
    public String getImage(User user,HttpServletRequest request){
        String s = userService.imageUrl(user);
//        if (s!=null) {
//            return this.getServerIPPort(request)+s;
//        }
        return s;
    }

    /**
     * 获取服务部署根路径 http:// + ip + port
     *
     * @param request
     * @return
     */
    private String getServerIPPort(HttpServletRequest request) {
        //+ ":" + request.getServerPort()
        return request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+"/";
    }


}
