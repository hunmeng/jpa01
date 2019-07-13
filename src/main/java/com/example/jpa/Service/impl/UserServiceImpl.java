package com.example.jpa.Service.impl;

import com.example.jpa.Service.IUserService;
import com.example.jpa.model.User;
import com.example.jpa.rep.UserRepository;
import com.example.jpa.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

@Service
public class UserServiceImpl implements IUserService {

    @Autowired
    private UserRepository userRepository;

    @Value("${file.uploadFolder}")
    private String uploadFolder;

    /**
     * 登录。。
     * @param user
     * @return
     */
    @Override
    public Map loginUser(User user) {
        Map map = new HashMap();
        if (userRepository.login(user.getUserName(),user.getUserPassword())>0) {
            map.put("code","200");
            map.put("msg","登录成功");
            return map;
        }
        map.put("code","500");
        map.put("msg","登录失败");
        System.out.println("------------map--------");
        return map;
    }

    /**
     * 注册用户
     * @param userVo
     * @return
     */
    @Override
    public Map registerUser(UserVo userVo) {
        Map map = new HashMap();
        User gerUser = this.gerUser(userVo.getUserName());
        if (gerUser!=null) {
            map.put("code",500);
            map.put("msg","亲，您输入的注册账号已经存在！");
            return map;
        }
        String url = "";
        if(userVo.getFile()!=null){
            url =  this.imgUpload(userVo);
            if (url==null) {
                map.put("code",500);
                map.put("msg","图片上传失败");
                return map;
            }
        }
        User user = new User(userVo.getUserName(),userVo.getUserPassword(),url);
        try {
            userRepository.save(user);
        }catch (Exception e){
            map.put("code",500);
            map.put("msg","注册失败");
            return map;
        }
        map.put("code",200);
        map.put("msg","操作成功");
        return map;
    }

    /**
     * 用户修改，修改图片或修改用户
     * @param user
     * @param opassword 原密码
     * @return
     */
    @Override
    public Map editUser(UserVo user,String opassword) {
        Map map = new HashMap();
        boolean b = this.verificationPassword(user, opassword);
        if (!b) {
            map.put("code",500);
            map.put("msg","原密码错误！");
            return map;
        }
        if (user.getFile()!=null) {     //判断是否进入文件上传
            String url = this.imgUpload(user);
            if (url==null) {
                map.put("code",500);
                map.put("msg","文件上传失败！");
                return map;
            }
            int i = userRepository.editUserAndURL(user.getUserName(), user.getUserPassword(), url);
            if (i>0) {
                map.put("code",200);
                map.put("msg","修改成功");
                return map;
            }
        }else{
            int i = userRepository.editUser(user.getUserName(), user.getUserPassword());
            if (i>0) {
                map.put("code",200);
                map.put("msg","修改成功");
                return map;
            }
        }
        return map;
    }

    /**
     * 拿到用户的图片url
     * @param user
     * @return
     */
    @Override
    public String imageUrl(User user) {
        user = userRepository.nameGetUser(user.getUserName());
        if (user!=null) {
            return user.getImageUrl();
        }
        return null;
    }

    /**
     * 拿到用户
     * @param name
     * @return
     */
    @Override
    public User gerUser(String name) {
        if (name!=null&&name!="") {
            User user = userRepository.nameGetUser(name);
            return user;
        }
        return null;
    }

    @Override
    public int updateSql(User user) {
        return 0;
    }

    /**
     * 验证密码
     * @param user
     * @param opassword
     * @return
     */
    private boolean verificationPassword(User user, String opassword) {
        User u = userRepository.nameGetUser(user.getUserName());
        if (u!=null&&opassword.equals(u.getUserPassword())) {
            return true;
        }
        return false;
    }

    /**
     * 图片上传
     * @param user
     * @return
     */
    public String imgUpload(UserVo user) {
        //随机一个id
        String uuid = UUID.randomUUID().toString().replaceAll("-", "");
        String url = this.uploadFolder+"/"+uuid;
        File file = new File(url);
//        if (file.exists()) {
//            file.mkdir();
//        }
        try {
            user.getFile().transferTo(file);
        } catch (IOException e) {
            url = null;
//            e.printStackTrace();
        }
        return url;
    }

}
