package com.example.jpa.controller;

import com.example.jpa.model.Book;
import com.example.jpa.rep.Repository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequestMapping("/book")
@RestController
public class BookController {

    @Autowired
    private Repository repository;

    @RequestMapping("/add")
    public Book add(){
        Book book = new Book();
//        book.setId();
        book.setName("新叫的");
        book.setPrice(16f);
        Book save = repository.save(book);
        return save;
    }
    @RequestMapping("/del")
    public String del(Integer id){
        Book book = new Book();
        book.setId(id);
        try {
            repository.delete(book);
        }catch (Exception e){
            return "no";
        }
        return "ok";
    }
    @RequestMapping("/update")
    public String update(Integer id){
        Book book = new Book();
        book.setId(id);
        try {
//            repository.
        }catch (Exception e){
            return "no";
        }
        return "ok";
    }

    @RequestMapping("/load")
    public String load(Integer id){
        List<Book> book = null;
        try {
            book = repository.findAll();
        }catch (Exception e){
            return "no";
        }
        return String.valueOf(book.size());
    }


}
