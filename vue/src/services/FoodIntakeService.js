import axios from 'axios';

export default {

  createFoodIntake(foodIntake){
    return axios.post('/foodIntake', foodIntake)
  },
  getAllFoodIntakes(){
    return axios.get(`/foodIntake/getAll`)
  },
  deleteFoodIntake(id){
    return axios.delete(`foodIntake/${id}`)
  },

  editFoodIntake(foodIntake){
    return axios.put(`/foodIntake/edit`, foodIntake)
  },

  getLastWeek(){
    return axios.get(`/foodIntake/week`)
  },

  getFoodIntakeById(id) {
    return axios.get(`/foodIntake/get/${id}`)
  }

}
