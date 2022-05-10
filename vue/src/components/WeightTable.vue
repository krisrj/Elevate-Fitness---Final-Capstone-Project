<template>
    <div>
      <router-link class="btnStyled" :to="{ name: 'weightInputID', params: {weightInputID: 0}}" id="add-link">Add Current Weight</router-link>
      <table>
        <thead>
          <th>Date</th>
          <th>Weight</th>
          <th>Edit</th>
          <th>Delete</th>
        </thead>
        <tbody>
          <tr v-for="weight in weightArray" v-bind:key="weight.weight_id">
            <td>{{weight.curr_date}}</td>
            <td>{{weight.curr_weight}}</td>
            <td>
              <router-link class="btnStyled" tag="button" :to="{ name: 'weightInputID',
              params: {weightInputID: weight.weight_id} }">Edit</router-link>
            </td>
             <td>
              <button class="btnStyled" v-on:click="deleteWeight(weight.weight_id)">Delete</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
</template>


<script >

import WeightInputService from '@/services/WeightInputService'

export default {

  components: {  },

   data() {
    return{
      weightArray: []
    }
   },

   created(){
    WeightInputService.getAllWeight().then(response => {
      this.weightArray = response.data
    });
   },

  methods: {
    deleteWeight(id) {
      WeightInputService.deleteWeight(parseInt(id)).then(() => {
        this.reloadTable()
      })
    },
    reloadTable() {
      WeightInputService.getAllWeight().then(response => {
        this.weightArray = response.data
      })
    },
   
  }
};
</script>

<style scoped>

</style>
