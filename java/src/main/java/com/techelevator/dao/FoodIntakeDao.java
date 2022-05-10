package com.techelevator.dao;

import com.techelevator.model.FoodIntake;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

public interface FoodIntakeDao {

    // get all food intakes
    List<FoodIntake> getAll (int id);

    // get food by date
    List<FoodIntake> getByDate(LocalDate date);

    // get by meal type
    List<FoodIntake> getByMealType(String mealType);

    // create food intake
    FoodIntake createFoodIntake (FoodIntake foodIntake);

    // get food intake id
    FoodIntake getFoodIntakeById(int id);

    //edit food intake by id
    boolean editFoodIntakeById(FoodIntake foodIntake);

    // delete
    void deleteFoodIntakeById(int id);

    //get last week
    List<FoodIntake> getLastWeek(int user_id);


}
