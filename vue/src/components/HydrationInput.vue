<template>
  <div>
    <form @submit.prevent="submitForm" id="water">
      <p>Daily Recommended Water Intake: {{recommended_hydration}} ounces</p>
      <label for="hydration">How Many Ounces Did You Drink?</label>
      <br>
      <br>
      <input v-model="hydration.amount_drank" type="number" id="hydration" name="hydration"
       min="0" max="100" />&nbsp;
      <input v-model="hydration.curr_date" type="date" />&nbsp;
      <br>
      <br>
       <button type="submit" class="btnStyled">Submit</button>
      </form>
  </div>
</template>

<script>
import HydrationService from "@/services/HydrationService";
import ProfileService from "@/services/ProfileService";

export default {
props: {
    hydrationID: {
      type: Number,
      default: 0
    }
  },

  components: {},
  data() {
        return {
            hydration: {
              hydration_id: "",
              user_id: "",
              curr_date: "",
              amount_drank: ""
            },
            current_weight: "",
            recommended_hydration: ""
        }
    },
  created() {
    ProfileService.getProfile()
        .then( response => {
          this.current_weight = response.data.current_weight
          this.getRecommendedHydration(this.current_weight);
        })

   if (this.hydrationID != 0) {
    HydrationService
      .getHydrationById(this.hydrationID)
      .then(response => {
        this.hydration = response.data;
      })
    }
  },

  methods: {
    createHydrationMethod() {
      HydrationService.createHydration(this.hydration)
      this.hydration = {
        hydration_id: "",
        user_id: "",
        curr_date: "",
        amount_drank: ""
      }
    },
    getRecommendedHydration(currentWeight){
      this.recommended_hydration = ((currentWeight * .5) * .8)
    },

    submitForm() {
      if (this.hydrationID === 0) {
        HydrationService
          .createHydration(this.hydration)
          .then(response => {
            console.log(response.status)
            if (response.status === 201) {
              this.$router.push({name: "water"});
            }
          })
          .catch(error => {
            this.handleErrorResponse(error, "adding");
          });
      } else {
        HydrationService
          .editHydration(this.hydration)
          .then(response => {
            if (response.status === 200) {
              this.$router.push({name: "water"});
            }
          })
          .catch(error => {
            this.handleErrorResponse(error, "updating");
          });
      }
    },
  }
}
</script>

<style>
#water{
  position: absolute;
  top: 40%;
  left: 40%;
  text-align: center;

  background: #e8f7f7;
  box-shadow: 0 20px 15px 0 rgb(0 0 0 / 40%), 0 6px 20px 0 rgb(0 0 0 / 40%);
  width: 450px;
  height: 200px;
  border-radius: 25px;

  

}

</style>