package com.techelevator.controller;

import com.techelevator.dao.HydrationDao;
import com.techelevator.dao.UserDao;
import com.techelevator.model.FoodIntake;
import com.techelevator.model.Hydration;
import com.techelevator.model.TrackWeight;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.security.Principal;
import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/hydration")
public class HydrationController {

    @Autowired
    private HydrationDao hydrationDao;

    @Autowired
    private UserDao userDao;

    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping(path = "")
    public void createHydration(@RequestBody Hydration hydration, Principal principal){
        hydration.setUser_id(userDao.findIdByUsername(principal.getName()));
        hydrationDao.createHydration(hydration);
    }

    @GetMapping(path = "")
    public List<Hydration> getAllHydration(Principal principal){
        return hydrationDao.getAllHydration(userDao.findIdByUsername(principal.getName()));
    }

    @GetMapping(path = "/date")
    public List<Hydration> getHydrationByDate(Principal principal) {
        return hydrationDao.getHydrationByDate(userDao.findIdByUsername(principal.getName()));
    }

    @GetMapping(path = "/lastWeek")
    public List<Hydration> getLastWeekHydration(Principal principal) {
        return hydrationDao.getLastWeekHydration(userDao.findIdByUsername(principal.getName()));
    }

    @GetMapping(path = "/lastMonth")
    public List<Hydration> getLastMonthHydration(Principal principal) {
        return hydrationDao.getLastMonthHydration(userDao.findIdByUsername(principal.getName()));
    }

    @GetMapping(path = "/lastYear")
    public List<Hydration> getLastYearHydration(Principal principal) {
        return hydrationDao.getLastYearHydration(userDao.findIdByUsername(principal.getName()));
    }

    @PutMapping(path = "/edit")
    public Hydration editHydration(@RequestBody Hydration hydration) {

        if (hydrationDao.editHydrationById(hydration)) {
            return hydration;
        }else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Water input not found to update.");
        }
    }

    @GetMapping(path = "/{id}")
    public Hydration getHydrationById(@PathVariable int id){
        return hydrationDao.getHydrationById(id);
    }

    @DeleteMapping(path = "/{id}")
    public void deleteWeightById(@PathVariable int id){
        hydrationDao.deleteHydrationById(id);
    }

}
