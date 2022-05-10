package com.techelevator.dao;

import com.techelevator.model.FoodIntake;
import com.techelevator.model.Hydration;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@Service
public class JdbcHydrationDao implements HydrationDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;


    @Override
    public List<Hydration> getAllHydration(int user_id) {
        List<Hydration> hydrationList = new ArrayList<>();
        String sql = "SELECT * FROM hydration WHERE user_id = ? ORDER BY curr_date DESC";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql,user_id);
        while (results.next()){
            hydrationList.add(mapRowToHydration(results));
        }
        return hydrationList;
    }

    @Override
    public Hydration getHydrationById(int id) {
        String sql = "Select * From hydration Where hydration_id = ?";
        SqlRowSet result = jdbcTemplate.queryForRowSet(sql, id);
        if(result.next()){
            return mapRowToHydration(result);
        }
        else {
            return null;
        }
    }

    @Override
    public List<Hydration> getHydrationByDate(int user_id) {
        List<Hydration> hydrationList = new ArrayList<>();
        String sql = "Select SUM (amount_drank) AS amount_drank, curr_date " +
                "From hydration " +
                "Where user_id = ? " +
                "Group By curr_date " +
                "Order By curr_date ASC";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, user_id);
        while (results.next()) {
            hydrationList.add(mapRowToHydrationSum(results));
        }
        return hydrationList;
    }

    @Override
    @ResponseStatus(HttpStatus.CREATED)
    public void createHydration(Hydration hydrationToCreate) {
        String sql = "INSERT INTO hydration (user_id, curr_date, amount_drank)" +
                " VALUES (?,?,?)";
        jdbcTemplate.update(sql, hydrationToCreate.getUser_id(),
                hydrationToCreate.getCurr_date(), hydrationToCreate.getAmount_drank());
    }

    @Override
    public List<Hydration> getLastWeekHydration(int user_id) {
        List<Hydration> hydrationList = new ArrayList<>();
        String sql = "SELECT SUM (amount_drank) AS amount_drank, curr_date FROM hydration " +
                "WHERE curr_date > (NOW() - interval '7 day') AND user_id = ? " +
                "GROUP BY curr_date " +
                "ORDER BY curr_date ASC;";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, user_id);
        while (results.next()) {
            Hydration hydration = mapRowToHydrationSum(results);
            hydrationList.add(hydration);
        }
        return hydrationList;
    }

    @Override
    public List<Hydration> getLastMonthHydration(int user_id) {
        List<Hydration> hydrationList = new ArrayList<>();
        String sql = "SELECT SUM (amount_drank) AS amount_drank, curr_date " +
                "FROM hydration WHERE curr_date > (NOW() - interval '30 day') AND user_id = ? " +
                "GROUP BY curr_date " +
                "ORDER BY curr_date ASC;";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, user_id);
        while (results.next()) {
            Hydration hydration = mapRowToHydrationSum(results);
            hydrationList.add(hydration);
        }
        return hydrationList;
    }


    @Override
    public List<Hydration> getLastYearHydration(int user_id) {
        List<Hydration> hydrationList = new ArrayList<>();
        String sql = "SELECT SUM (amount_drank) AS amount_drank, curr_date " +
                "FROM hydration WHERE curr_date > (NOW() - interval '365 day') AND user_id = ? " +
                "GROUP BY curr_date " +
                "ORDER BY curr_date ASC;";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, user_id);
        while (results.next()) {
            Hydration hydration = mapRowToHydrationSum(results);
            hydrationList.add(hydration);
        }
        return hydrationList;
    }

    @Override
    @ResponseStatus(HttpStatus.CREATED)
    public boolean editHydrationById(Hydration hydration) {
        String sql = "UPDATE hydration SET user_id = ?, curr_date = ?, amount_drank = ? " +
                "WHERE hydration_id = ?";
        int count = jdbcTemplate.update(sql, hydration.getUser_id(), hydration.getCurr_date(),
                hydration.getAmount_drank(), hydration.getHydration_id());
        return count == 1;
    }

    @Override
    public void deleteHydrationById(int id) {
        String sql = "DELETE FROM hydration WHERE hydration_id = ?";
        jdbcTemplate.update(sql,id);
    }

    private Hydration mapRowToHydration(SqlRowSet results) {
        Hydration hydration = new Hydration();
        hydration.setHydration_id(results.getInt("hydration_id"));
        hydration.setAmount_drank(results.getFloat("amount_drank"));
        hydration.setCurr_date(results.getDate("curr_date").toLocalDate());
        hydration.setUser_id(results.getInt("user_id"));
        return hydration;
    }
    private Hydration mapRowToHydrationSum(SqlRowSet results) {
        Hydration hydration = new Hydration();
        hydration.setAmount_drank(results.getFloat("amount_drank"));
        hydration.setCurr_date(results.getDate("curr_date").toLocalDate());

        return hydration;
    }
}
