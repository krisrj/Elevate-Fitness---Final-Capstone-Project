import axios from 'axios';
//import FoodIntakeService from '../services/FoodIntakeService';

export default {


  getNutritionByDate(){
    return axios.get(`/nutrition/today`)
  },
  getLastWeekNutrition(){
    return axios.get(`/nutrition/week`)
  }
 
}