package com.example.jpa.model;

import javax.persistence.*;

@Table(name = "t_user")
@Entity
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)//自增
    private Integer uid;
    @Column(name = "user_name")
    private String userName;
    @Column(name = "user_password")
    private String userPassword;
    @Column(name = "image_url")
    private String imageUrl;

    public User(String userName, String userPassword, String imageUrl) {
        this.userName = userName;
        this.userPassword = userPassword;
        this.imageUrl = imageUrl;
    }

    public User(){}

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    @Override
    public String toString() {
        return "User{" +
                "uid=" + uid +
                ", userName='" + userName + '\'' +
                ", userPassword='" + userPassword + '\'' +
                ", imageUrl='" + imageUrl + '\'' +
                '}';
    }
}
