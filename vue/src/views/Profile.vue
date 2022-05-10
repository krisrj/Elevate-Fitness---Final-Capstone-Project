<template>
  <div id="profile">
    <div class="empty"></div>
    <div class="profile-container">
      <br>
      <br>
      <img :src="profile.photo ? profile.photo : defaultPicture" :key="profile.photo" class="profile-photo">
      <br>
      <p>Name: {{profile.display_name}}</p>
      <p>Birthday: {{profile.birthday}}</p>
      <p>Age: {{profile.age}}</p>
      <p>Height: {{profile.height_feet}}', {{profile.height_inches}}"</p>
      <p>Current Weight: {{profile.current_weight}} pounds | (Current BMI: {{bmi.toFixed(1)}})</p>
      <p>Goal Weight: {{profile.goal_weight}} pounds | (Goal BMI: {{bmiGoal.toFixed(1)}})</p>
      <br>
      <button class="btnStyled" @click="$router.push('create-profile')">Update Profile</button>
    </div>
  </div>
</template>

<script >
import ProfileService from '@/services/ProfileService'
import FoodIntakeView from '@/views/FoodIntakeView.vue';


export default {
 
  name: "profile-detail",
  data() {
    FoodIntakeView
    return {
      isLoading: true,
      profile: {
         user_id:"",
         display_name: "",
         photo: "",
         birthday: "",
         age:"" ,
         height_feet:"" ,
         height_inches:"" ,
         current_weight:"" ,
         goal_weight: ""
      },
      bmi: "",
      bmiGoal: "",
      defaultPicture: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
    }
  },
  created() {
    ProfileService.getProfile()
      .then( response => {
        //response responding to http request specifically
        this.profile = response.data;
        this.calculateBMI();
        this.calculateGoalBMI();
      })
  },
  methods: {
      calculateBMI(){
         this.bmi = (this.profile.current_weight / ((this.profile.height_feet * 12 + this.profile.height_inches) * (this.profile.height_feet * 12 + this.profile.height_inches))) * 703
      },
      calculateGoalBMI() {
        this.bmiGoal = (this.profile.goal_weight / ((this.profile.height_feet * 12 + this.profile.height_inches) * (this.profile.height_feet * 12 + this.profile.height_inches))) * 703
      },
  }
};
</script>

<style scoped>

#profile{
  display: grid;
  grid-template-areas: none;
}
.profile-container{

  grid-area: profile;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  text-align: center;

  /* shadow  */
  background: #e8f7f7;
  box-shadow: 0 20px 15px 0 rgb(0 0 0 / 40%), 0 6px 20px 0 rgb(0 0 0 / 40%);
  width: 450px;
  height: 650px;
  border-radius: 25px;
}
img {
  width: 250px;
  height: 250px;
}
</style>
