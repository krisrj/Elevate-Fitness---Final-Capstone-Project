<template id="template">
  <div id="app" >
  <div id="login" class="text-center">
    <form class="form-signin" @submit.prevent="login">

      <h1 class="h3 mb-3 font-weight-normal" >Member Login</h1> 
      <div id="invalid"
        class="alert-danger"
        role="alert"
        v-if="invalidCredentials"
      >Invalid username and password, try again.</div>
      <div
        class="alert-success"
        role="alert"
        v-if="this.$route.query.registration" 
      >Thank you for registering! Please sign in.</div>
      <br>
      <br>
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
      <br>
      <br>
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
      <br>
      <br>
      <br />
      <br />
      <button class="btnStyled" type="submit" id="submit">Sign in</button>
      <br />
      <br />
      <router-link :to="{ name: 'register' }">Need an account?</router-link>
    </form>
  </div>
  </div>
</template>

<script>
import authService from "../services/AuthService";

export default {

  name: "login",
  components: {},
  data() {
    return {
      user: {
        username: "",
        password: ""
      },
      invalidCredentials: false
    };
  },
  
  methods: {
    login() {
      authService
        .login(this.user)
        .then(response => {
          if (response.status == 200) {
            this.$store.commit("SET_AUTH_TOKEN", response.data.token);
            this.$store.commit("SET_USER", response.data.user);
            this.$router.push("/");
          }
        })
        .catch(error => {
          const response = error.response;
          if (response.status === 401) {
            this.invalidCredentials = true;
            this.$route.query.registration = false;
          }
        });
    }
  }
  
}
</script>


<style scoped>

#login {
  display: flex;
  flex-direction: column;
  justify-content: center;

  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  text-align: center;

  /* shadow  */
  background:#e8f7f7;
  box-shadow: 0 20px 15px 0 rgb(0 0 0 / 40%), 0 6px 20px 0 rgb(0 0 0 / 40%);
  width: 500px;
  height: 620px;

}
#submit{
  width: 200px;
 
}

.alert-danger{
  background: rgba(233, 118, 118, 0.774);
  height: 20px;
  align-items: center;
  padding: 5%;
  font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;

}
.alert-success{
  background: rgba(136, 231, 184, 0.774);
  height: 20px;
  align-items: center;
  padding: 5%;
  font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
}

 
</style>