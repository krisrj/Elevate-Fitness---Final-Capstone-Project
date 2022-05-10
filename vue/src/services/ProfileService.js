import axios from "axios";

export default {

    createProfile(profile) {
        return axios.put('/profile/update', profile)
    },
    getProfile(){
        return axios.get(`/profile`)
    },
    editProfile() {
        return axios.put(`/profile/edit`)
    }
}