package com.techelevator.controller;

import com.techelevator.dao.ProfileDao;
import com.techelevator.dao.UserDao;
import com.techelevator.model.Profile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;

@CrossOrigin
@PreAuthorize("isAuthenticated()")
@RestController
@RequestMapping("/profile")
public class ProfileController {

    @Autowired
    private ProfileDao profileDao;

    @Autowired
    private UserDao userDao;

    public ProfileController(ProfileDao profileDao) {
        this.profileDao = profileDao;
    }

//    @RequestMapping(path = "", method = RequestMethod.POST)
//    public Profile addProfile( int userId, String username, Principal principal) {
//        data.setUser_id(userDao.findIdByUsername(username));
//        return profileDao.addProfile(userId);
//    }

    @RequestMapping(path = "", method = RequestMethod.GET)
    public Profile getProfileById(Principal principal) {
        System.out.println(principal.getName());
        System.out.println(userDao.findIdByUsername(principal.getName()));
        return profileDao.getProfileById(userDao.findIdByUsername(principal.getName()));
    }

    @PutMapping(path = "/update")
    public void updateProfile(@RequestBody Profile updatedProfile, Principal principal) {
        System.out.println(updatedProfile.getBirthday());
        updatedProfile.setUser_id(userDao.findIdByUsername(principal.getName()));
        profileDao.updateProfile(updatedProfile);
    }
}
