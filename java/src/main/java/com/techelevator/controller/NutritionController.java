package com.techelevator.controller;

import com.techelevator.dao.JdbcUserDao;
import com.techelevator.dao.NutritionDao;
import com.techelevator.dao.UserDao;

import com.techelevator.model.FoodIntake;
import com.techelevator.model.Nutrition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;
import java.time.LocalDate;
import java.util.List;

@CrossOrigin
@RestController
@PreAuthorize("isAuthenticated()")
@RequestMapping("/nutrition")
public class NutritionController {

    @Autowired
    private UserDao userDao;
    @Autowired
    private NutritionDao nutritionDao;

    @GetMapping(path = "/today")
    public Nutrition getNutritionByDate(Principal principal){
        return nutritionDao.getNutritionByDate(userDao.findIdByUsername(principal.getName()));
    }
}
