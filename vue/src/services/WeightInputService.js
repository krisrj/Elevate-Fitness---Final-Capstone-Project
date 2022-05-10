import axios from 'axios';

export default {

  createWeightInput(weightInput){
    return axios.post('/weight', weightInput)
  },

  getAllWeight(){
    return axios.get('/weight')
  },

  getWeightByMonth() {
    return axios.get(`/weight/month`)
  },

  getWeightLastWeek() {
    return axios.get(`/weight/week`)
  },

  getWeightLastYear() {
    return axios.get(`/weight/year`)
  },

  deleteWeight(id){
    return axios.delete(`weight/${id}`)
  },

  editWeight(weight){
    return axios.put(`/weight/edit`, weight)
  },

  getWeightById(id) {
    return axios.get(`/weight/${id}`)
  }
}
