<template>
  <div id="register" class="text-center">
    <form class="form-register" @submit.prevent="register">
      <h1 class="h3-mb-3-font-weight-normal">Create Account</h1>
      <br>
      <div class="alert-danger" role="alert" v-if="registrationErrors">
        {{ registrationErrorMsg }}
      </div>
      <label for="username" class="sr-only">Username</label>
      <br>
      <input
        type="text"
        id="username"
        class="form-control"
        placeholder="Username"
        v-model="user.username"
        required
        autofocus
      />
      <br><br>
      <label for="password" class="sr-only">Password</label>
      <br>
      <input
        type="password"
        id="password"
        class="form-control"
        placeholder="Password"
        v-model="user.password"
        required
      />
      <br><br>
      <input
        type="password"
        id="confirmPassword"
        class="form-control"
        placeholder="Confirm Password"
        v-model="user.confirmPassword"
        required
      />
      <br><br><br>
      <button class="btn btn-lg btn-primary btn-block btnStyled" type="submit">
        Create Account
      </button>
      <br><br>
      <router-link :to="{ name: 'login' }">Have an account?</router-link>
    </form>
  </div>
</template>

<script>
import authService from '../services/AuthService';
import profileService from '../services/ProfileService';

export default {
  name: 'register',
  data() {
    return {
      user: {
        username: '',
        password: '',
        confirmPassword: '',
        role: 'user',
      },
      profile: {
         user_id: "",
         display_name: "",
         age:"" ,
         height_feet:"" ,
         height_inches:"" ,
         current_weight:"" ,
         goal_weight: ""
      },
      registrationErrors: false,
      registrationErrorMsg: 'There were problems registering this user.',
    };
  },
  methods: {
    register() {
      if (this.user.password != this.user.confirmPassword) {
        this.registrationErrors = true;
        this.registrationErrorMsg = 'Passwords do not match.';
      } else {
        authService
          .register(this.user)
          .then((response) => {
            if (response.status == 201) {
              this.$router.push({
                path: '/login',
                query: { registration: 'success' },
              });
            }
          })
          .catch((error) => {
            const response = error.response;
            this.registrationErrors = true;
            if (response.status === 400) {
              this.registrationErrorMsg = 'Bad Request: Validation Errors';
            }
          });
      }
    },
    saveProfile() {
       profileService
        .createProfile(this.profile)
    },
    clearErrors() {
      this.registrationErrors = false;
      this.registrationErrorMsg = 'There were problems registering this user.';
    },
  },
};
</script>

<style>
#register {

  display: flex;
  flex-direction:column;
  justify-content: center;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  text-align: center;

  /* shadow  */
  background: #e8f7f7;
  box-shadow: 0 20px 15px 0 rgb(0 0 0 / 40%), 0 6px 20px 0 rgb(0 0 0 / 40%);
  width: 500px;
  height: 500px;
}
.alert-danger{
  background: rgba(233, 118, 118, 0.774);
  height: 30px;
  align-items: center;
  margin-bottom: 8px;
  padding: 0%;
  font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;

}
div.picture1 {
   height:950px; /*height of your image*/
   background-image:url('https://images.pexels.com/photos/1640774/pexels-photo-1640774.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260');
   margin:0; /* If you want no margin */
   padding:0; /*if your want to padding */
  background-repeat: no-repeat;
  background-size:  cover;
  background-position: center;
}
.h3-mb-3-font-weight-normal{
  margin-bottom:40px;
  margin-top:0px
}
</style>
