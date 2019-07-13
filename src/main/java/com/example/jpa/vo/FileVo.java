package com.example.jpa.vo;

import org.springframework.web.multipart.MultipartFile;

import java.io.Serializable;

public class FileVo implements Serializable {

    private MultipartFile file;

    public FileVo(MultipartFile multipartFile) {
        this.file = multipartFile;
    }

    public FileVo(){}

    public MultipartFile getFile() {
        return file;
    }

    public void setFile(MultipartFile file) {
        this.file = file;
    }
}
