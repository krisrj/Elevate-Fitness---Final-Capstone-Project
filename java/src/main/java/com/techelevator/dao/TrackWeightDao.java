package com.techelevator.dao;

import com.techelevator.model.FoodIntake;
import com.techelevator.model.TrackWeight;

import java.util.List;

public interface TrackWeightDao {

    // get all weight by id
    List<TrackWeight> getAllWeight(int user_id);

    // create weight
    void createTrackWeight(TrackWeight weight);

    List<TrackWeight> WeightByMonth (int user_id);

    List<TrackWeight> WeightByWeek (int user_id);

    List<TrackWeight> WeightByYear (int user_id);

    //edit weight by id
    boolean editWeightById(TrackWeight trackWeight);

    // delete
    void deleteWeightById(int id);

    TrackWeight getWeightById(int weightId);
}

