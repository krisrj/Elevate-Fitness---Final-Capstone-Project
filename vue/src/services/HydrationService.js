import axios from 'axios';

export default {
    getAllHydrations(){
        return axios.get("/hydration")
    },

    createHydration(hydration){
        return axios.post("/hydration", hydration)
    },

    getHydrationByWeek() {
        return axios.get(`/hydration/lastWeek`)
    },
    
    getHydrationLastMonth() {
        return axios.get(`/hydration/lastMonth`)
    },

    getHydrationLastYear() {
        return axios.get(`/hydration/lastYear`)
    },

    editHydration(hydration){
        return axios.put(`/hydration/edit`, hydration)
    },

    deleteHydration(id){
        return axios.delete(`hydration/${id}`)
    },

    getHydrationById(id) {
        return axios.get(`/hydration/${id}`)
    },
}
