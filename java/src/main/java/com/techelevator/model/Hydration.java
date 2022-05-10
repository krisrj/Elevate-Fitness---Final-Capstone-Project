package com.techelevator.model;

import java.time.LocalDate;
import java.util.Date;

public class Hydration {

    private int hydration_id;
    private int user_id;
    private LocalDate curr_date;
    private float amount_drank;

    public Hydration() {

    }
    public int getHydration_id() {
        return hydration_id;
    }

    public void setHydration_id(int hydration_id) {
        this.hydration_id = hydration_id;
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

    public float getAmount_drank() {
        return amount_drank;
    }

    public void setAmount_drank(float amount_drank) {
        this.amount_drank = amount_drank;
    }
}
