<template>
  <div id="weightForm">
    <form @submit.prevent="submitForm" >
      <label for="weight">Weight Update?</label>
      <br>
      <br>
      <input v-model="weight.curr_weight" type="number" 
       min="0" max="1000"/>&nbsp;
       <br>
       <br>
      <input v-model="weight.curr_date" type="date" />&nbsp;
      <br>
      <br>
       <button class="btnStyled" type="submit">Submit</button>
      </form>
  </div>
</template>

<script>
import WeightInputService from "@/services/WeightInputService";
export default {
props: {
  weightInputID: {
    type: Number,
    default: 0
 }
},

  components: {},
  data() {
        return {
            weight: {
              weight_id: "",
              user_id: "",
              curr_date: "",
              curr_weight: ""
            },
        }
    },

  created() {
  if (this.weightInputID != 0) {
    WeightInputService
      .getWeightById(this.weightInputID)
      .then(response => {
        this.weight = response.data;
      })
  }
},
  methods: {
    createWeight() {
      WeightInputService.createWeightInput(this.weight)
      this.weight = {
        weight_id: "",
        user_id: "",
        curr_date: "",
        curr_weight: ""
      }
    },

    submitForm() {

      if (this.weightInputID === 0) {
        WeightInputService
          .createWeightInput(this.weight)
          .then(response => {
            console.log(response.status)
            if (response.status === 201) {
              this.$router.push({name: "weight"});
            }
          })
          .catch(error => {
            this.handleErrorResponse(error, "adding");
          });
      } else {
        WeightInputService
          .editWeight(this.weight)
          .then(response => {
            if (response.status === 200) {
              this.$router.push({name: "weight"});
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
#weightForm {
 position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  text-align: center;

  border-radius: 25px;
  background: #e8f7f7;
  box-shadow: 0 20px 15px 0 rgb(0 0 0 / 40%), 0 6px 20px 0 rgb(0 0 0 / 40%);
  width: 350px;
  height: 200px;
  padding-top: 50px;
  
}
</style>