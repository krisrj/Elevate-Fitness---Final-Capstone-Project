<template>
  
  <div id="app">
     <div id="mySidenav" class="sidenav">
       <img src="../public/elevate-logo.png" id="logo" >
      
       <router-link tag="button" class="btn" v-bind:to="{ name: 'home' }" v-if="$store.state.token != ''">Home</router-link>&nbsp;&nbsp;
       <router-link tag="button" class="btn" v-bind:to="{ name: 'profile' }" v-if="$store.state.token != ''">Profile</router-link>
      <div class="drop-down">
       <button class="dropbtn" v-on:click="nutritionDropDown" v-if="$store.state.token != ''">Tracker</button>
    
    <div id="myDropdown" v-if="showDropDown">
    <router-link  v-bind:to="{ name: 'water' }" class="water-btn" v-if="$store.state.token != ''">Water</router-link>
    <br>
    <br>
    <router-link  v-bind:to="{ name: 'nutrition' }" class="food-btn" v-if="$store.state.token != ''">Nutrition
    </router-link>
    <br>
    <br>
    <router-link  v-bind:to="{ name: 'weight' }" class="weight-btn" v-if="$store.state.token != ''">Weight
      <br>
      <br>
    </router-link>
    
    </div>
      </div>
       <br>

       <router-link tag="button" class="btn-logout" v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</router-link>&nbsp;&nbsp;
     </div>
    
    <div id="contents">
      <router-view />
    </div>
  </div>

</template>

<script>
export default {
  name: "app",
  data(){
    return {
      showDropDown:false
    }
  },
  methods: {
    nutritionDropDown(){
      this.showDropDown = !this.showDropDown;
      
    }
  }
}
</script>

<style scoped>

#app {
    font-family: 'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif
}
 .btn{
    border-radius: 50%;
    height: 6em;
    width: 6em;
    background-color: transparent;
    top: 0;
    left: 0;
    margin-top: 5px;
    margin-left: 22px;
    margin-bottom: 15px;
    color:ivory
 }
 #logo{
    width: 125px;
    padding-left: 0px;
    padding-bottom: 30px;
 }
 
.dropbtn {
    border-radius: 50%;
    height: 6em;
    width: 6em;
    background-color: transparent;
    top: 0;
    left: 0;
    margin-top: 5px;
    margin-left: 22px; 
    margin-bottom: 5px;
    color:ivory
}

.btn-logout {
    border-radius: 50%;
    height: 6em;
    width: 6em;
    background-color: transparent;
    left: 0;
    margin-top: 0px;
    margin-left: 22px; 
    margin-bottom: 5px;
    color:ivory
}
.water-btn{
    border-radius: 50%;
    height: 6;
    width: 6em;
    background-color: transparent;
    top: 0;
    left: 0;
    margin-top: 5px;
    margin-left: 22px; 
    margin-bottom: 15px;
    color:ivory
 }
 .food-btn{
    border-radius: 50%;
    height: 6em;
    width: 6em;
    background-color: transparent;
    top: 0;
    left: 0;
    margin-top: 5px;
    margin-left: 22px; 
    margin-bottom: 15px;
    color:ivory
 }
 .weight-btn{
    border-radius: 50%;
    height: 6em;
    width: 6em;
    background-color: transparent;
    top: 0;
    left: 0;
    margin-top: 5px;
    margin-left: 22px; 
    margin-bottom: 15px;
    color:ivory
 }
</style>
 


