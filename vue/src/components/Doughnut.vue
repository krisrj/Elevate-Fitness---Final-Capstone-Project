<template>
<div>
  <Doughnut id="pieCharObject"
      :chart-options="chartOptions"
      :chart-data="chartData"
      :chart-id="chartId"
      :dataset-id-key="datasetIdKey"
      :plugins="plugins"
      :css-classes="cssClasses"
      :styles="styles"
      :width="width"
      :height="height"
      :pieGraphData="pieGraphData"
  />
  <p class="caloriesText">Total Calories: {{totalCalories}}</p>
  </div>
</template>

<script>
import { Doughnut } from 'vue-chartjs/legacy'
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  ArcElement,
  CategoryScale
} from 'chart.js'

ChartJS.register(Title, Tooltip, Legend, ArcElement, CategoryScale)

export default {
  name: 'DoughnutChart',
  components: {
    Doughnut
  },

  props: {
    chartId: {
      type: String,
      default: 'doughnut-chart'
    },
    datasetIdKey: {
      type: String,
      default: 'label'
    },
    width: {
      type: Number,
      default: 400
    },
    height: {
      type: Number,
      default: 400
    },
    cssClasses: {
      default: '',
      type: String
    },
    styles: {
      type: Object,
      default: () => {}
    },
    plugins: {
      type: Array,
      default: () => []
    },
    pieGraphData:{
      type: Array
    },
    pieGraphLabels:{
      type: Array
    },
    totalCalories:{
      type: Number
    }
  },
  data() {
    return {
      chartData: {
        labels: this.pieGraphLabels,
            //['Proteins', 'Fats', 'Carbs'],
        datasets: [
          {
            backgroundColor: ['#0ba59d', '#00D8FF', 'rgb(98, 182, 140)'],
            data: this.pieGraphData
          }
        ]
      },
      chartOptions: {
        responsive: true,
        maintainAspectRatio: false
      },
    }
  },
}
</script>

