package com.techelevator.controller;



import com.techelevator.dao.TrackWeightDao;
import com.techelevator.dao.UserDao;

import com.techelevator.model.FoodIntake;
import com.techelevator.model.TrackWeight;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.security.Principal;
import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/weight")

public class TrackWeightController {

    @Autowired
    private TrackWeightDao trackWeightDao;

    @Autowired
    private UserDao userDao;

    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping(path = "")
    public void createTrackWeight(@RequestBody TrackWeight trackWeight, Principal principal){
        trackWeight.setUser_id(userDao.findIdByUsername(principal.getName()));
        trackWeightDao.createTrackWeight(trackWeight);
    }

    @GetMapping(path = "")
    public List<TrackWeight> getAllWeight(Principal principal){
        return trackWeightDao.getAllWeight(userDao.findIdByUsername(principal.getName()));
    }

    @GetMapping(path = "/month")
    public List<TrackWeight> WeightByMonth(Principal principal) {
        return trackWeightDao.WeightByMonth(userDao.findIdByUsername(principal.getName()));
    }

    @GetMapping(path = "/week")
    public List<TrackWeight> WeightByWeek(Principal principal) {
        return trackWeightDao.WeightByWeek(userDao.findIdByUsername(principal.getName()));
    }

    @GetMapping(path = "/year")
    public List<TrackWeight> WeightByYear(Principal principal) {
        return trackWeightDao.WeightByYear(userDao.findIdByUsername(principal.getName()));
    }

    @PutMapping(path = "/edit")
    public TrackWeight editWeight( @RequestBody TrackWeight trackWeight) {

        if (trackWeightDao.editWeightById(trackWeight)) {
            return trackWeight;
        }else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Weight not found to update.");
        }
    }

    @GetMapping(path = "/{weightId}")
    public TrackWeight getWeightById (@PathVariable int weightId) {
        return trackWeightDao.getWeightById(weightId);
    }

    @DeleteMapping(path = "/{id}")
    public void deleteWeightById(@PathVariable int id){
        trackWeightDao.deleteWeightById(id);
    }
}


