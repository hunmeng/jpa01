package com.example.jpa.controller;

import com.example.jpa.vo.FileVo;
import com.example.jpa.vo.UserVo;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/upload")
public class UploadController {

    @Value("${file.uploadFolder}")
    private String uploadFolder;

    /**
     * UUID随机的命名
     * 普通上传，多图片上传
     * @param fileVo
     * @return
     */
    @RequestMapping("/randomUplad")
    public Map randomUplad(FileVo fileVo){
        System.out.println("fileVo:"+fileVo.getFile());
        String fileUrl = fileUpload(fileVo,true);
        return this.file(fileUrl);
    }

    /**
     * 上传文件的全名称命名
     * 指定允许上传的文件类型，允许上传的文件后缀，视频
     * @param fileVo
     * @return
     */
    @RequestMapping("/nameUplad")
    public Map nameUplad(FileVo fileVo){
        System.out.println("fileVo:"+fileVo.getFile());
        String fileUrl = fileUpload(fileVo,false);
        return this.file(fileUrl);
    }


    /**
     * 文件上传，随机UUID
     * @param fileVo 上传的实体
     * @param b 判断是用随机的uuid还是文件的名称,默认为UUID
     * @return 上传的URL地址
     */
    public String fileUpload(FileVo fileVo,boolean b) {
        if (fileVo.getFile()==null) {
            return null;
        }
        //随机一个id
        String name = fileVo.getFile().getOriginalFilename();
        if (b) {   //判断是否用什么命名，true为UUID，false为上传文件的全名称
            //获取文件的后缀
            String[] split = name.split("\\.");     //  匹配小数点（.）必须转义，否则split方法无效
            name = UUID.randomUUID().toString().replaceAll("-", "")+"."+split[split.length-1];
        }
        String fileUrl = this.uploadFolder+"/"+name;
        System.out.println("fileUrl:"+fileUrl);
        File file = new File(fileUrl);
        try {
            fileVo.getFile().transferTo(file);
        } catch (IOException e) {
            fileUrl = null;
        }
        return fileUrl;
    }

    @RequestMapping("/fileUploads")
    public Map fileUploads(MultipartFile file[]){


        return this.file(null);
    }

    /**
     * 返回是否上传成功的参数
     * @param url
     * @return
     */
    public Map file(String url){
        Map map = new HashMap();
        if (url==null||url=="") {
            map.put("msg","上传失败");
            map.put("code",500);
            return map;
        }
        map.put("msg","上传成功");
        map.put("code",200);
        map.put("url",url);
        return map;
    }

}
