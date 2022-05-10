package com.techelevator.controller;

import com.techelevator.dao.FoodIntakeDao;
import com.techelevator.dao.UserDao;
import com.techelevator.model.FoodIntake;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.security.Principal;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;
@CrossOrigin
@RestController
@PreAuthorize("isAuthenticated()")
@RequestMapping("/foodIntake")
public class FoodIntakeController {

    @Autowired
    private FoodIntakeDao foodIntakeDao;

    @Autowired
    private UserDao userDao;

    @GetMapping(path = "/getAll")
    public List<FoodIntake> getAll(Principal principal){
        return foodIntakeDao.getAll(userDao.findIdByUsername(principal.getName()));
    }

    @GetMapping(path = "/get/{id}")
    public FoodIntake getFoodIntakeId(@PathVariable int id){
        return foodIntakeDao.getFoodIntakeById(id);
    }

    @GetMapping(path = "/getByDate/{date}")
    public List<FoodIntake> getByDate(@PathVariable LocalDate date){
        return foodIntakeDao.getByDate(date);
    }

    @GetMapping(path = "/getByMealType/{type}")
    public List<FoodIntake> getByMealType (@PathVariable String type){
        return foodIntakeDao.getByMealType(type);
    }

    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping(path = "")
    public FoodIntake createFoodIntake(@RequestBody FoodIntake foodIntake, Principal principal){
        foodIntake.setUser_id(userDao.findIdByUsername(principal.getName()));
        return foodIntakeDao.createFoodIntake(foodIntake);
    }

    @DeleteMapping(path = "/{id}")
    public void deleteFoodIntakeById(@PathVariable int id){
        foodIntakeDao.deleteFoodIntakeById(id);
    }

    @PutMapping(path = "/edit")
    public FoodIntake editFoodIntake( @RequestBody FoodIntake foodIntake) {
        //foodIntake.setFood_intake_id(id);
        if (foodIntakeDao.editFoodIntakeById(foodIntake)) {
            return foodIntake;
        }else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Food not found to update.");
        }
    }

    @GetMapping(path = "/week")
    public List<FoodIntake> getLastWeek(Principal principal) {
        return foodIntakeDao.getLastWeek(userDao.findIdByUsername(principal.getName()));
    }


}