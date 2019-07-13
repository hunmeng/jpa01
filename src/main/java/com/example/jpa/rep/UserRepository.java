package com.example.jpa.rep;

import com.example.jpa.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

public interface UserRepository extends JpaRepository<User,Integer> {


    @Query(value ="SELECT count(c) from User c WHERE c.userName = ?1 AND c.userPassword = ?2")
    Integer login(String name,String password);

    @Query(value ="SELECT c from User c WHERE c.userName = ?1")
    User nameGetUser(String name);

    @Modifying
    @Transactional
    @Query(value ="UPDATE User u set u.userPassword = ?2 WHERE u.userName = ?1")
    int editUser(String name,String password);

    @Modifying
    @Transactional
    @Query(value ="UPDATE User u set u.userPassword = ?2 ,u.imageUrl = ?3 WHERE u.userName = ?1")
    int editUserAndURL(String name,String password,String url);

}
