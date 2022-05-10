package com.techelevator.dao;

import com.techelevator.model.FoodIntake;
import com.techelevator.model.Nutrition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Service
public class JdbcNutritionDao implements NutritionDao {

    private JdbcTemplate jdbcTemplate;

    @Autowired
    private UserDao userDao;

    public JdbcNutritionDao(JdbcTemplate jdbcTemplate) {

        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public Nutrition getNutritionByDate(int user_id) {
        Nutrition nutrition = new Nutrition();
        String sql = "Select SUM(calories) as calories, SUM(carbs) as carbs, " +
                "SUM(fats) as fats, SUM(proteins) as proteins " +
                "From foodintake " +
                "Where user_id = ? AND day_of_meal = CURRENT_DATE";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, user_id);
        while(results.next()) {
             nutrition = mapRowToNutrition(results);
        }
        return nutrition;
    }


    @Override
    public List<Nutrition> getLastWeekNutrition() {
        return null;
    }

    private Nutrition mapRowToNutrition(SqlRowSet results) {
        Nutrition nutrition =  new Nutrition();

        nutrition.setCalories(results.getFloat("calories"));
        nutrition.setCarbs(results.getFloat("carbs"));
        nutrition.setFats(results.getFloat("fats"));
        nutrition.setProteins(results.getFloat("proteins"));


        return nutrition;
    }
}
