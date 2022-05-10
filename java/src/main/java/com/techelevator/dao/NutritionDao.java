package com.techelevator.dao;

import com.techelevator.model.Nutrition;

import java.time.LocalDate;
import java.util.List;

public interface NutritionDao {

    // get Nutrition by the Date
    Nutrition getNutritionByDate(int user_id);


    //get last week
    List<Nutrition> getLastWeekNutrition();
}
