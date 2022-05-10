<template>
  <div class="profile-container">
      <profile-form v-bind:profile_id="parseInt($route.params.profile_id)"/>
  </div>
</template>

<script>
import ProfileForm from '../components/ProfileForm.vue'
export default {
  components: { ProfileForm },
  data() {
    return {
      showPassword : false
    }
  },
  methods:{
    toggleShowPassword(){
      this.showPassword = !this.showPassword;
    }
  }
}
</script>
<style scoped>
.profile-container{
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  text-align: center;

  /* shadow  */
  background: #e8f7f7;
  box-shadow: 0 20px 15px 0 rgb(0 0 0 / 40%), 0 6px 20px 0 rgb(0 0 0 / 40%);
  width: 450px;
  height: 775px;
  border-radius: 25px;
}
</style>
