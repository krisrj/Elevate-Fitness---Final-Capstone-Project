package com.techelevator.dao;

import com.techelevator.model.FoodIntake;
import com.techelevator.model.Profile;
import com.techelevator.model.TrackWeight;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class JdbcTrackWeightDao implements TrackWeightDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;


    @Override
    public List<TrackWeight> getAllWeight(int user_id) {

        List<TrackWeight> trackWeightList = new ArrayList<>();
        String sql = "SELECT * FROM weight WHERE user_id = ? ORDER BY curr_date DESC";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql,user_id);
        while (results.next()){
            trackWeightList.add(mapRowToWeight(results));
        }
        return trackWeightList;
    }

    @Override
    public void createTrackWeight(TrackWeight trackWeight) {

        String sql = "INSERT INTO weight (user_id, curr_date, curr_weight) " +
                "VALUES (?, ?, ?)";
            jdbcTemplate.update(sql, trackWeight.getUser_id(), trackWeight.getCurr_date(),
                    trackWeight.getCurr_weight());

    }

    @Override
    public List<TrackWeight> WeightByMonth(int user_id) {
        List<TrackWeight> WeightByMonthList = new ArrayList<>();
        String sql = "SELECT * FROM weight WHERE curr_date > (NOW() - interval '30 day') AND user_id = ? " +
                "ORDER BY curr_date ASC";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, user_id);
        while(results.next()) {
            TrackWeight trackWeight = mapRowToWeight(results);
            WeightByMonthList.add(trackWeight);
        }
        return WeightByMonthList;
    }

    @Override
    public List<TrackWeight> WeightByWeek(int user_id) {
        List<TrackWeight> WeightByMonthList = new ArrayList<>();
        String sql = "SELECT * FROM weight WHERE curr_date > (NOW() - interval '7 day') AND user_id = ? " +
                "ORDER BY curr_date ASC";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, user_id);
        while(results.next()) {
            TrackWeight trackWeight = mapRowToWeight(results);
            WeightByMonthList.add(trackWeight);
        }
        return WeightByMonthList;
    }

    @Override
    public List<TrackWeight> WeightByYear(int user_id) {
        List<TrackWeight> WeightByMonthList = new ArrayList<>();
        String sql = "SELECT * FROM weight WHERE curr_date > (NOW() - interval '365 day') AND user_id = ? " +
                "ORDER BY curr_date ASC";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, user_id);
        while(results.next()) {
            TrackWeight trackWeight = mapRowToWeight(results);
            WeightByMonthList.add(trackWeight);
        }
        return WeightByMonthList;
    }

    @Override
    public boolean editWeightById(TrackWeight trackWeight) {
        String sql = "UPDATE weight SET user_id = ?, curr_date = ?, curr_weight = ? " +
               "WHERE weight_id = ?";
        int count = jdbcTemplate.update(sql, trackWeight.getUser_id(), trackWeight.getCurr_date(),
                 trackWeight.getCurr_weight(), trackWeight.getWeight_id());
        return count == 1;
    }

    @Override
    public void deleteWeightById(int id) {
        String sql = "DELETE FROM weight WHERE weight_id = ?";
        jdbcTemplate.update(sql,id);
    }

    @Override
    public TrackWeight getWeightById(int weightId) {
        String sql = "SELECT * FROM weight WHERE weight_id = ?;";
        SqlRowSet resultSet = jdbcTemplate.queryForRowSet(sql, weightId);

        TrackWeight result = null;
        if (resultSet.next()) {
            result = mapRowToWeight(resultSet);
        }
        return result;
    }

    private TrackWeight mapRowToWeight(SqlRowSet results) {
        TrackWeight trackWeight = new TrackWeight();
        trackWeight.setWeight_id(results.getInt("weight_id"));
        trackWeight.setCurr_weight(results.getFloat("curr_weight"));
        trackWeight.setCurr_date(results.getDate("curr_date").toLocalDate());
        trackWeight.setUser_id(results.getInt("user_id"));
        return trackWeight;
    }
}
