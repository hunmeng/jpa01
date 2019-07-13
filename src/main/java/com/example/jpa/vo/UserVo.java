package com.example.jpa.vo;

import com.example.jpa.model.User;
import org.springframework.web.multipart.MultipartFile;

import java.io.Serializable;

public class UserVo extends User implements Serializable {

    private MultipartFile file;

    private String url;

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public MultipartFile getFile() {
        return file;
    }

    public void setFile(MultipartFile file) {
        this.file = file;
    }

    public UserVo(){

    }

}
