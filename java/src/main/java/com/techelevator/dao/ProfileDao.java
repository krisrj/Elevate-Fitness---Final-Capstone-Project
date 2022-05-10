package com.techelevator.dao;

import com.techelevator.model.Profile;

public interface ProfileDao {

    Profile addProfile(int userId);

    Profile getProfileById(int profile_id);

    Profile deleteProfile(int profile_id);

    void updateProfile(Profile profile);
}
