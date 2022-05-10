<template>
  <div class="nutrition-container">

    <!-- <input type="button" onClick="document.getElementById('middle').scrollIntoView();" /> -->

   <!-- <button type="button" v-on:click="toggleShowNutrition">Nutrition</button> -->
    <router-link class="btnStyled" :to="{ name: 'food-intake', params: {foodIntakeID: 0}}" id="add-link">Add Food</router-link>
    <div id="tableholder" class="grid-item">
      <table>
        <thead>
          <th>Food Type</th>
          <th>Serving Size</th>
          <th>Number Of Servings</th>
          <th>Meal Type</th>
          <th>Date</th>
          <th>Edit</th>
          <th>Delete</th>
        </thead>
        <tbody>
          <tr v-for="intake in foodIntake" v-bind:key="intake.id">
            <td>{{intake.food_type}}</td>
            <td>{{intake.serving_size}}</td>
            <td>{{intake.number_of_servings}}</td>
            <td>{{intake.meal_type}}</td>
            <td>{{intake.day_of_meal}}</td>
            <td>
              <router-link tag="button"  class="btnStyled" :to="{ name: 'food-intake',
              params: {foodIntakeID: intake.food_intake_id} }">Edit</router-link>
            </td>
            <td>
              <button class="btnStyled" v-on:click="deleteFood(intake.food_intake_id)">Delete</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>


<script >

import foodIntakeService from '../services/FoodIntakeService'

export default {
  
  components: { },

   data() {
    return{
      foodIntake: [],
      }

   },

   created(){
    foodIntakeService.getAllFoodIntakes().then(response => {
      this.foodIntake = response.data
    });
   },

  methods: {
    
     deleteFood(id) {
      foodIntakeService.deleteFoodIntake(parseInt(id)).then(() => {
        this.reloadTable()
      })
    },
    reloadTable() {
      foodIntakeService.getAllFoodIntakes().then(response => {
        this.foodIntake = response.data
      })
    },
    
  }
};
</script>

<style scoped>



</style>

