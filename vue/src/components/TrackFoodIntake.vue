<template>
  <div id="food">
    <form @submit.prevent="submitForm">
      <h2>Food Intake Form</h2>
      <label for="food-type">Type of Food</label>
      <br />
      <input type="text" id="food-type" placeholder="Type of Food" v-model="foodIntake.food_type" />
      <br />
      <br />
      <label for="serving-size">Serving Size</label>
      <br />
      <input type="text" id="serving-size" placeholder="Serving Size" v-model="foodIntake.serving_size" />
      <br />
      <br />
      <label for="number-of-servings">Number of Servings</label>
      <br />
      <input
        type="text"
        id="number-of-servings"
        placeholder="Number of Servings"
        v-model="foodIntake.number_of_servings"
      />
      <br />
      <br />
      <!-- <label for="calories">Calories</label>
      <br>
      <input type="text" id="calories" placeholder="Calories" v-model="foodIntake.calories" />
      <br>
      <br> -->
      <label for="carbs">Carbs</label>
      <br>
      <input type="text" id="carbs" placeholder="Carbs" v-model="foodIntake.carbs" />
      <br>
      <br>
      <label for="fats">Fats</label>
      <br>
      <input type="text" id="fats" placeholder="Fats" v-model="foodIntake.fats" />
      <br>
      <br>
      <label for="proteins">Proteins</label>
      <br>
      <input type="text" id="proteins" placeholder="Proteins" v-model="foodIntake.proteins" />
      <br>
      <br>
      <label for="meal-type">Meal Breakfast/Lunch/Dinner/Snack</label>
      <br />
      <select name="meal-type" id="meal-type" v-model="foodIntake.meal_type">
        <option value="breakfast">Breakfast</option>
        <option value="lunch">Lunch</option>
        <option value="dinner">Dinner</option>
        <option value="snack">Snack</option>
      </select>
      <br />
      <br />
      <label>
        Enter the Date:
        <input type="date" name="meal-day" v-model="foodIntake.day_of_meal" />
      </label>
      <br />
      <br />
      <div id="success" v-if="isCreated">You Successfully Added a Food</div>
      <br />
      <button class="btnStyled" type="submit" >Submit</button>
      <br>
    </form>
  </div>
</template>

<script>
import foodIntakeService from '../services/FoodIntakeService'

export default {
  props: {
    foodIntakeID: {
      type: Number,
      default: 0
    }
  },
data() {
  return {
    isCreated: false,
    foodIntake: {
      food_intake_id: "",
      user_id: "",
      food_type: "",
      serving_size: "",
      number_of_servings: "",
      meal_type: "",
      day_of_meal: "",
      calories: "",
      carbs: "",
      fats: "",
      proteins: "",
    },
  }
},

created() {
  if (this.foodIntakeID != 0) {
    foodIntakeService
      .getFoodIntakeById(this.foodIntakeID)
      .then(response => {
        this.foodIntake = response.data;
      })
  }
},

methods: {

  submitForm() {

      if (this.foodIntakeID === 0) {
        // add
        foodIntakeService
          .createFoodIntake(this.foodIntake)
          .then(response => {
            console.log(response.status)
            if (response.status === 200 || response.status === 201) {
            this.isCreated = true,
                this.foodIntake = {
                  food_intake_id: "",
                  user_id: "",
                  food_type: "",
                  serving_size: "",
                  number_of_servings: "",
                  meal_type: "",
                  day_of_meal: "",
                  calories: "",
                  carbs: "",
                  fats: "",
                  proteins: "",
                }
          
            }
          })
          .catch(error => {
            this.handleErrorResponse(error, "adding");
          });
      } else {
        // update
        //newFoodIntake.foodIntakeID = this.foodIntake.foodIntakeID
        foodIntakeService
          .editFoodIntake(this.foodIntake)
          .then(response => {
            if (response.status === 200) {
              this.$router.push(`/nutrition`);
            }
          })
          .catch(error => {
            this.handleErrorResponse(error, "updating");
          });
      }
    },

  //  createFoodIntake() {
  //   foodIntakeService.createFoodIntake(this.foodIntake),
  //   this.foodIntake = {
  //     user_id: "",
  //     food_type: "",
  //     serving_size: "",
  //     number_of_servings: "",
  //     meal_type: "",
  //     day_of_meal: "",
  //     calories: "",
  //     carbs: "",
  //     fats: "",
  //     proteins: "",
  //   }
  // },

  //  editFood(foodIntake) {
  //     foodIntakeService
  //     .editFoodIntake(foodIntake)
  //     .then((response) => {
  //       if (response.status == 200) {
  //         this.$router.push("/")
  //       }
  //     })

  //  },
}
};
</script>

<style>
#meal-type {
  padding: 0.25rem 3rem 0.25rem 3rem;
}

#success {
  background-color: #0ba59d;
  padding: 0.25rem 3rem 0.25rem 3rem;
}

</style>