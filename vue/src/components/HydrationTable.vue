<template>
    <div>
      <router-link class="btnStyled" :to="{ name: 'hydrationID', params: {hydrationID: 0}}" id="add-link">Add Ounces</router-link>
      <table>
        <thead>
          <th>Date</th>
          <th>Ounces</th>
          <th>Edit</th>
          <th>Delete</th>
        </thead>
        <tbody>
          <tr v-for="hydration in hydrationArray" v-bind:key="hydration.hydration_id">
            <td>{{hydration.curr_date}}</td>
            <td>{{hydration.amount_drank}}</td>
            <td>
              <router-link class="btnStyled" tag="button" :to="{ name: 'hydrationID',
              params: {hydrationID: hydration.hydration_id} }">Edit</router-link>
            </td>
             <td>
              <button class="btnStyled" v-on:click="deleteHydration(hydration.hydration_id)">Delete</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
</template>

<script>

import HydrationService from '@/services/HydrationService'

export default {

data() {

    return{
      hydrationArray: []
    }   
},

created(){
    HydrationService.getAllHydrations().then(response => {
      this.hydrationArray = response.data
    });
   },

 methods: {
    deleteHydration(id) {
      HydrationService.deleteHydration(parseInt(id)).then(() => {
        this.reloadTable()
      })
    },
    reloadTable() {
      HydrationService.getAllHydrations().then(response => {
        this.hydrationArray = response.data
      })
    }, 
 }  

}

</script>

<style>



</style>