package com.techelevator.dao;

import com.techelevator.model.FoodIntake;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class JdbcFoodIntakeDao implements FoodIntakeDao {

    private JdbcTemplate jdbcTemplate;

    @Autowired
     private UserDao userDao;

     public JdbcFoodIntakeDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<FoodIntake> getAll(int id) {
        List<FoodIntake> foodIntakeList = new ArrayList<>();
        String sql = "SELECT * FROM foodintake WHERE user_id = ? ORDER BY day_of_meal DESC";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, id);
        while(results.next()) {
            FoodIntake foodIntake = mapRowToFoodIntake(results);
            foodIntakeList.add(foodIntake);
        }
        return foodIntakeList;
    }



    @Override
    public List<FoodIntake> getByDate(LocalDate date) {
        List<FoodIntake> foodIntakeList = new ArrayList<>();
        String sql = "SELECT * FROM foodintake WHERE day_of_meal = ?";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, date);
        while(results.next()) {
            FoodIntake foodIntake = mapRowToFoodIntake(results);
            foodIntakeList.add(foodIntake);
        }
        return foodIntakeList;
    }

    @Override
    public List<FoodIntake> getByMealType(String mealType) {
        List<FoodIntake> foodIntakeList = new ArrayList<>();
        String sql = "SELECT * FROM foodintake WHERE meal_type = ? ";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, mealType);
        while(results.next()) {
            FoodIntake foodIntake = mapRowToFoodIntake(results);
            foodIntakeList.add(foodIntake);
        }
        return foodIntakeList;
    }

    @Override
    public FoodIntake createFoodIntake(FoodIntake foodIntake) {
         foodIntake.setProteins(foodIntake.getProteins() * foodIntake.getNumber_of_servings());
         foodIntake.setCarbs(foodIntake.getCarbs() * foodIntake.getNumber_of_servings());
         foodIntake.setFats(foodIntake.getFats() * foodIntake.getNumber_of_servings());
        String sql = "INSERT INTO foodIntake (user_id, food_type, serving_size, number_of_servings, " +
                "calories, carbs, fats, proteins, meal_type, day_of_meal)" +
                "VALUES (?,?,?,?,?,?,?,?,?,?) RETURNING food_intake_id";
        Integer id = jdbcTemplate.queryForObject(sql,Integer.class,foodIntake.getUser_id(),
                foodIntake.getFood_type(),foodIntake.getServing_size(),foodIntake.getNumber_of_servings(),
                foodIntake.getCalories(), foodIntake.getCarbs(), foodIntake.getFats(),
                foodIntake.getProteins(), foodIntake.getMeal_type(),foodIntake.getDay_of_meal());
        return getFoodIntakeById(id);
    }

    @Override
    public FoodIntake getFoodIntakeById(int id){
        String sql = "SELECT * FROM foodintake WHERE food_intake_id = ?";
        SqlRowSet result = jdbcTemplate.queryForRowSet(sql, id);
        if(result.next()){
            return mapRowToFoodIntake(result);
        }
        return null;
    }

    @Override
    public boolean editFoodIntakeById(FoodIntake foodIntake) {
        String sql = "UPDATE foodintake SET user_id = ?, food_type = ?, serving_size = ?, " +
                "number_of_servings = ?, calories = ?, carbs = ?, fats = ?, proteins = ?, meal_type = ?, " +
                "day_of_meal = ? WHERE food_intake_id = ?";
        int count = jdbcTemplate.update(sql, foodIntake.getUser_id(), foodIntake.getFood_type(), foodIntake.getServing_size(),
                foodIntake.getNumber_of_servings(), foodIntake.getCalories(), foodIntake.getCarbs(), foodIntake.getFats(), foodIntake.getProteins(),
                foodIntake.getMeal_type(), foodIntake.getDay_of_meal(), foodIntake.getFood_intake_id());
        return count == 1;
    }

    @Override
    public void deleteFoodIntakeById(int id) {
        String sql = "DELETE FROM foodintake WHERE food_intake_id = ?";
        jdbcTemplate.update(sql,id);
    }

    @Override
    public List<FoodIntake> getLastWeek(int user_id) {
        List<FoodIntake> foodIntakeList = new ArrayList<>();
        String sql = "SELECT * FROM foodIntake WHERE day_of_meal > (NOW() - interval '7 day') " +
                "AND user_id = ? ORDER BY day_of_meal DESC;";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, user_id);
        while(results.next()) {
            FoodIntake foodIntake = mapRowToFoodIntake(results);
            foodIntakeList.add(foodIntake);
        }
        return foodIntakeList;
    }


    private FoodIntake mapRowToFoodIntake(SqlRowSet results) {
        FoodIntake foodIntake =  new FoodIntake();
        foodIntake.setDay_of_meal(results.getDate("day_of_meal").toLocalDate());
        foodIntake.setUser_id(results.getInt("user_id"));
        foodIntake.setFood_intake_id(results.getInt("food_intake_id"));
        foodIntake.setFood_type(results.getString("food_type"));
        foodIntake.setServing_size(results.getFloat("serving_size"));
        foodIntake.setNumber_of_servings(results.getFloat("number_of_servings"));
        foodIntake.setCalories(results.getFloat("calories"));
        foodIntake.setCarbs(results.getFloat("carbs"));
        foodIntake.setFats(results.getFloat("fats"));
        foodIntake.setProteins(results.getFloat("proteins"));
        foodIntake.setMeal_type(results.getString("meal_type"));

        return foodIntake;
    }
}
