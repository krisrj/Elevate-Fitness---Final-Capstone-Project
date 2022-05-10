package com.techelevator.model;

import java.time.LocalDate;

public class Nutrition {

    private int user_id;
    private float calories;
    private float carbs;
    private float fats;
    private float proteins;
    private LocalDate day_of_meal;

    public Nutrition() {

    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public float getCalories() {
        return calories;
    }

    public void setCalories(float calories) {
        this.calories = calories;
    }

    public float getCarbs() {
        return carbs;
    }

    public void setCarbs(float carbs) {
        this.carbs = carbs;
    }

    public float getFats() {
        return fats;
    }

    public void setFats(float fats) {
        this.fats = fats;
    }

    public float getProteins() {
        return proteins;
    }

    public void setProteins(float proteins) {
        this.proteins = proteins;
    }

    public LocalDate getDay_of_meal() {
        return day_of_meal;
    }

    public void setDay_of_meal(LocalDate day_of_meal) {
        this.day_of_meal = day_of_meal;
    }
}
