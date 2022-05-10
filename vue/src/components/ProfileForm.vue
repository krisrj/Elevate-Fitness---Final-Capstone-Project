<template>
  <div>
    <form v-on: submit.prevent>
      <h1>Update Profile</h1>
    <label for="display-name">Display Name: </label>
    <br>
    <input type="text" placeholder="Display Name" v-model="profile.display_name">
    <br>
    <br>
    <label for="photo">Display Photo: </label>
    <br>
    <input type="text" placeholder="Photo URL" v-model="profile.photo">
    <br>
    <br>
    <label for="display-birthday">Birthday: </label>
    <br>
    <input type="date" placeholder="Birthday" v-model="profile.birthday">
    <br>
    <br>
    <label for="age">Age: </label>
    <br>
    <input type="number" id="age" name="age"
       min="18" max="100" v-model="profile.age">
    <br>
    <br>
    <label for="height-feet">Height - feet: </label>
    <br>
    <input type="number" id="height-feet" name="height-feet"
       min="0" max="8" v-model="profile.height_feet">
    <br>
    <br>
    <label for="height-inches">Height - inches: </label>
    <br>
    <input type="number" id="height-inches" name="height-inches"
       min="0" max="11" v-model="profile.height_inches">
    <br>
    <br>
    <label for="weight">Current Weight: </label>
    <br>
    <input type="number" id="weight" name="weight"
       min="100" max="1000" v-model="profile.current_weight">
    <br>
    <br>
    <label for="goal-weight">Goal Weight: </label>
    <br>
    <input type="number" id="goal-weight" name="goal-weight"
       min="100" max="1000" v-model="profile.goal_weight">
    </form>
    <br>
    <button class="btnStyled" type="submit" v-on:click="saveProfile()">Submit</button>
  </div>
</template>

<script>
import profileService from "@/services/ProfileService.js"
export default {
  props: {
    profile_id: {
      type: Number,
      default: 0
    }
  },
    data() {
    return {
      profile: {
         profile_id: "",
         user_id: "",
         display_name: "",
         photo: "",
         birthday: "",
         age:"" ,
         height_feet:"" ,
         height_inches:"" ,
         current_weight:"" ,
         goal_weight: ""
      }
    };
  },

  created() {
    if (this.profile_id != 0) {
      profileService
        .getProfile(this.profile_id)
        .then(response => {
          this.profile = response.data;
        })
    }
  },
  
  methods: {
    saveProfile() {
      console.log(this.profile)
       profileService
        .createProfile(this.profile)
        .then((response) => {
          if (response.status == 200) {
            this.$router.push("/profile");
          }
        })
    }
  }
}
</script>

<style>

</style>