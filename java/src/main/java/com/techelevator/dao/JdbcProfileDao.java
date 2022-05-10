package com.techelevator.dao;

import com.techelevator.model.Profile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

@Service
public class JdbcProfileDao implements ProfileDao{

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public Profile addProfile(int userId) {
        String sql = "INSERT INTO profile (user_id) VALUES (?) RETURNING user_id;";
        Integer id = jdbcTemplate.queryForObject(sql, Integer.class, userId);
        return getProfileById(id);
    }

    @Override
    public Profile getProfileById(int userId) {
        String sql = "SELECT * FROM profile WHERE user_id = ?;";
        SqlRowSet resultSet = jdbcTemplate.queryForRowSet(sql, userId);

        Profile result = null;
        if (resultSet.next()) {
            result = mapRowToProfile(resultSet);
        }
        return result;
    }

    @Override
    public Profile deleteProfile(int profile_id) {
        return null;
    }

    @Override
    public void updateProfile(Profile profile) {
        String sql = "UPDATE profile SET display_name = ?, photo = ?, birthday = ?, age = ?, height_feet = ?," +
                "height_inches = ?, current_weight = ?, goal_weight = ? WHERE user_id = ?;";
        jdbcTemplate.update(sql, profile.getDisplay_name(),profile.getPhoto(),profile.getBirthday(),profile.getAge(),
                profile.getHeight_feet(),profile.getHeight_inches(), profile.getCurrent_weight(), profile.getGoal_weight(),
                profile.getUser_id());

    }


    public Profile deleteProfile(int profile_id, Profile profile) {
        String sql = "DELETE FROM profile" +
        "WHERE profile_id = ?;";
        jdbcTemplate.update(sql, profile.getProfile_id(), profile.getProfile_id());
        return getProfileById(profile_id);
    }



//    public Profile updateProfile(int profile_id, Profile profile) {
//        String sql = "UPDATE profile" +
//        "SET display_name = ?, age= ?, height_feet= ?, height_inches= ?, current_weight= ?, goal_weight= ?" +
//        "WHERE profile_id = ?;";
//        jdbcTemplate.update(sql, profile.getDisplay_name(),profile.getAge(),profile.getHeight_feet(),profile.getHeight_inches(), profile.getCurrent_weight(), profile.getGoal_weight());
//        return getProfileById(profile_id);
//    }

    private Profile mapRowToProfile(SqlRowSet resultSet) {
        Profile profile = new Profile();
        profile.setProfile_id(resultSet.getInt("profile_id"));
        profile.setUser_id(resultSet.getInt("user_id"));
        profile.setDisplay_name(resultSet.getString("display_name"));
        profile.setPhoto(resultSet.getString("photo"));
        profile.setBirthday(resultSet.getDate("birthday"));
        profile.setAge(resultSet.getInt("age"));
        profile.setHeight_feet(resultSet.getInt("height_feet"));
        profile.setHeight_inches(resultSet.getInt("height_inches"));
        profile.setCurrent_weight(resultSet.getInt("current_weight"));
        profile.setGoal_weight(resultSet.getInt("goal_weight"));
        return profile;
    }
}
