package com.techelevator.model;

import java.time.LocalDate;
import java.util.Date;

public class TrackWeight {

    private int weight_id;
    private int user_id;
    private LocalDate curr_date;
    private float curr_weight;

    public TrackWeight() {

    }

    public int getWeight_id() {
        return weight_id;
    }

    public void setWeight_id(int weight_id) {
        this.weight_id = weight_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public LocalDate getCurr_date() {
        return curr_date;
    }

    public void setCurr_date(LocalDate curr_date) {
        this.curr_date = curr_date;
    }

    public float getCurr_weight() {
        return curr_weight;
    }

    public void setCurr_weight(float curr_weight) {
        this.curr_weight = curr_weight;
    }
}
