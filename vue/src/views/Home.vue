<template>
  <div class="home loading">
    <div id="emptyLeftSpace"></div>
    <div id="weightLineChart" v-if="isLoadingLineGraph">
      <h1 id="graphTitle">Weight</h1>
      <LineChart class="grid-item" :lineGraphData="weightLineGraphData" :lineGraphDates="weightLineGraphDates" :lineGraphGoal="weightLineGraphGoal"/>
      <button type="button" class="btnStyled" v-on:click="weightWeek">Week View</button>
      <button type="button" class="btnStyled" v-on:click="weightMonth">Month View</button>
      <button type="button" class="btnStyled" v-on:click="weightYear">Year View</button>
    </div>
    <div id="hydrationBarChart" v-if="isLoadingBarGraph">
      <h1 id="graphTitle">Hydration</h1>
      <BarChart class="grid-item" :barGraphData="hydrationBarGraphData" :barGraphRecommended="hydrationBarGraphRecommendedData" :barGraphDates="hydrationBarDates"  />
      <button type="button" class="btnStyled" v-on:click="hydrationWeek">Week View</button>
      <button type="button" class="btnStyled" v-on:click="hydrationMonth">Month View</button>
      <button type="button" class="btnStyled" v-on:click="hydrationYear">Year View</button>
    </div>
    <div id="nutritionPieChart" v-if="isLoadingPieChart">
      <h1 id="graphTitle">Nutrition</h1>
      <DoughnutChart class="grid-item" id="nutritionPieChart" :pieGraphData="nutritionPieGraphData" :pieGraphLabels="nutritionLabels" :totalCalories="totalCalories"/>
    </div>
  </div>
</template>

<script>
import LineChart from '../components/Line.vue'
import DoughnutChart from '../components/Doughnut.vue'
import BarChart from '../components/Bar.vue'
import WeightInputService from "@/services/WeightInputService";
import HydrationService from "@/services/HydrationService";
import Nutrition from "@/services/Nutrition";
import ProfileService from "@/services/ProfileService";

export default {
  name: "home",
  components:{
    LineChart,
    DoughnutChart,
    BarChart,
  },

  data() {
    return{
      isLoadingLineGraph: false,
      isLoadingBarGraph: false,
      isLoadingPieChart: false,
      foodIntake: [],

      // this is inputted as prop for the weight line graph
      weightObject: [],
      weightLineGraphData: [],
      weightLineGraphDates: [],
      weightLineGraphGoal: [],
      goalWeight: {},

      // this is inputted as prop for the pie/doughnut
      nutritionObject:[],
      nutritionPieGraphData: [],
      nutritionLabels: [],

      totalCalories: "",
      percentCarbs: "",
      percentProteins: "",
      percentFats: "",

      // this is inputted as prop for hydration bar graph
      hydrationObject:[],
      hydrationBarGraphData: [],
      hydrationBarGraphRecommendedData: [],
      hydrationBarDates: [],
      recommended_hydration: {},
    }
  },
  created(){
    ProfileService.getProfile().then(response => {
      this.recommended_hydration = ((response.data.current_weight * .5) * .8)
      this.goalWeight = response.data.goal_weight
    })
    WeightInputService.getAllWeight().then(() => {
      this.weightWeek()
    });

    HydrationService.getAllHydrations().then(() => {
      this.hydrationWeek()
    })
    Nutrition.getNutritionByDate().then(response => {
      this.nutritionObject = response.data;
      // got the total calories
      this.totalOfCalories(this.nutritionObject.carbs,this.nutritionObject.proteins,this.nutritionObject.fats)
      //get carbs as percent of calories and  push result to array
      this.percentOfCarbs(this.nutritionObject.carbs)
      this.nutritionPieGraphData.push(this.nutritionObject.carbs)
      //get fats as percent of calories and push
      this.percentOfFats(this.nutritionObject.fats);
      this.nutritionPieGraphData.push(this.nutritionObject.fats)
      // get proteins as percent of calories and push
      this.percentOfProteins(this.nutritionObject.proteins);
      this.nutritionPieGraphData.push(this.nutritionObject.proteins)
      // assign the labels in respective order
      this.nutritionLabels.push("Carbs: " + this.percentCarbs + "%")
      this.nutritionLabels.push("Fats: " + this.percentFats + "%")
      this.nutritionLabels.push("Proteins: " + this.percentProteins + "%")
      this.isLoadingPieChart = true;
    })
  },
  methods: {
    totalOfCalories(carbs, proteins, fats) {
        this.totalCalories = (carbs*4 + proteins*4 + fats*9)
     },
    percentOfCarbs(carbs) {
        this.percentCarbs = Math.round((carbs*4 * 100) / this.totalCalories)
    },
    percentOfProteins(proteins) {
      this.percentProteins = Math.round((proteins*4 * 100) / this.totalCalories)
    },
    percentOfFats(fats) {
      this.percentFats = Math.round((fats*9 * 100) / this.totalCalories)
    },

    weightWeek() {
      this.isLoadingLineGraph = false;
      WeightInputService.getWeightLastWeek().then(response => {
        this.weightObject = response.data
        this.weightLineGraphData = []
        this.weightLineGraphDates = []
        this.weightObject.forEach(weight => this.weightLineGraphData.push(weight.curr_weight))
        this.weightObject.forEach(weight => this.weightLineGraphDates.push(weight.curr_date))
        this.weightLineGraphGoal = []
        for (let i = 0; i < this.weightObject.length; i++) {
          this.weightLineGraphGoal.push(this.goalWeight)
        }
        this.isLoadingLineGraph = true;
      })
    },
    weightMonth() {
      this.isLoadingLineGraph = false;
      WeightInputService.getWeightByMonth().then(response => {
        this.weightObject = response.data
        this.weightLineGraphData = []
        this.weightLineGraphDates = []
        this.weightObject.forEach(weight => this.weightLineGraphData.push(weight.curr_weight))
        this.weightObject.forEach(weight => this.weightLineGraphDates.push(weight.curr_date))
        this.weightLineGraphGoal = []
        for (let i = 0; i < this.weightObject.length; i++) {
          this.weightLineGraphGoal.push(this.goalWeight)
        }
        this.isLoadingLineGraph = true;
      })

    },
    weightYear() {
      this.isLoadingLineGraph = false;
      WeightInputService.getWeightLastYear().then(response => {
        this.weightObject = response.data
        this.weightLineGraphData = []
        this.weightLineGraphDates = []
        this.weightObject.forEach(weight => this.weightLineGraphData.push(weight.curr_weight))
        this.weightObject.forEach(weight => this.weightLineGraphDates.push(weight.curr_date))
        this.weightLineGraphGoal = []
        for (let i = 0; i < this.weightObject.length; i++) {
          this.weightLineGraphGoal.push(this.goalWeight)
        }
        this.isLoadingLineGraph = true;
      })
    },

    hydrationWeek() {
       this.isLoadingBarGraph = false
       HydrationService.getHydrationByWeek().then(response => {
        this.hydrationObject = response.data
        this.hydrationBarGraphData = []
        this.hydrationBarGraphRecommendedData = []
        this.hydrationBarDates = []
        this.hydrationObject.forEach(hydration => this.hydrationBarGraphData.push(hydration.amount_drank))
         this.hydrationBarGraphRecommendedData = []
         for (let i = 0; i < this.hydrationBarGraphData.length; i++) {
           this.hydrationBarGraphRecommendedData.push(this.recommended_hydration)
         }
        this.hydrationObject.forEach(hydration => this.hydrationBarGraphRecommendedData.push(hydration.amount_drank))
        this.hydrationObject.forEach(hydration => this.hydrationBarDates.push(hydration.curr_date))
        this.isLoadingBarGraph = true
      })
    },
    hydrationMonth() {
      this.isLoadingBarGraph = false
      HydrationService.getHydrationLastMonth().then(response => {
        this.hydrationObject = response.data
        this.hydrationBarGraphData = []
        this.hydrationBarGraphRecommendedData = []
        this.hydrationBarDates = []
        this.hydrationObject.forEach(hydration => this.hydrationBarGraphData.push(hydration.amount_drank))
        this.hydrationBarGraphRecommendedData = []
        for (let i = 0; i < this.hydrationBarGraphData.length; i++) {
          this.hydrationBarGraphRecommendedData.push(this.recommended_hydration)
        }
        this.hydrationObject.forEach(hydration => this.hydrationBarDates.push(hydration.curr_date))
        this.isLoadingBarGraph = true
      })
    },
    hydrationYear() {
      this.isLoadingBarGraph = false
      HydrationService.getHydrationLastYear().then(response => {
        this.hydrationObject = response.data
        this.hydrationBarGraphData = []
        this.hydrationBarGraphRecommendedData = []
        this.hydrationBarDates = []
        this.hydrationObject.forEach(hydration => this.hydrationBarGraphData.push(hydration.amount_drank))
        this.hydrationBarGraphRecommendedData = []
        for (let i = 0; i < this.hydrationBarGraphData.length; i++) {
          this.hydrationBarGraphRecommendedData.push(this.recommended_hydration)
        }
        this.hydrationObject.forEach(hydration => this.hydrationBarDates.push(hydration.curr_date))
        this.isLoadingBarGraph = true
      })
    },
  }
};
</script>

<style scoped>

.home{
  display: grid;
  grid-template-columns: 130px 30% 30% 30%;
  grid-template-areas: "empty weight weight weight"
                        "empty hydration hydration nutrition";
  padding-top: 20px;
  grid-gap: 10px;
}

.grid-item {
  background-color: rgba(255, 255, 255, .95);
  text-align: center;
  margin-bottom: 20px;
}

#hydrationBarChart{
  grid-area: hydration;
}
#nutritionPieChart{
  grid-area: nutrition;
}

#graphTitle{
  text-align: center;
  padding-top: 10px;
  padding-bottom: 4px;
  

/* title background */
    background-color:rgba(255, 255, 255, .95);
    
    width: 300px;
    margin-top: 5px;
    margin-left: 22px; 
    margin-bottom: 0.6px;
    color:rgba(0, 0, 0, 0.637);
    margin-left: auto;
    margin-right: auto;
    
    
    
}
#weightLineChart{
  grid-area: weight;
}
#emptyLeftSpace{
  grid-area: empty;
}

</style>
