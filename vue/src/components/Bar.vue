<template>
  <Bar
      :chart-options="chartOptions"
      :chart-data="chartData"
      :chart-id="chartId"
      :dataset-id-key="datasetIdKey"
      :plugins="plugins"
      :css-classes="cssClasses"
      :styles="styles"
      :width="width"
      :height="height"
      :barGraphData="barGraphData"
  />
</template>

<script>
import { Bar } from 'vue-chartjs/legacy'

import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale
} from 'chart.js'
import ProfileService from "@/services/ProfileService";

ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)

export default {
  name: 'BarChart',
  components: {
    Bar
  },
  props: {
    chartId: {
      type: String,
      default: 'bar-chart'
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
    barGraphData: {
      type: Array
    },
    barGraphRecommended: {
      type: Array
    },
    barGraphDates: {
      type: Array
    }
  },
  data() {
    return {
      recommended_hydration: [],
      profile: {},
      chartData: {
        labels: this.barGraphDates,
        datasets: [
          {
            label: 'Current Hydration',
            backgroundColor: '#0ba59d',
            data: this.barGraphData
          },
          {
            label: 'Recommended Hydration',
            backgroundColor: '#00D8FF',
            data: this.barGraphRecommended,
          },
        ]
      },
      chartOptions: {
        responsive: true,
        maintainAspectRatio: false,
      }
    }
  },
  created() {
    ProfileService.getProfile().then(response => {
      for (let i = 0; i < this.barGraphData.length; i++) {
        this.recommended_hydration.push(((response.data.current_weight * .5) * .8))
      }
    })
  }
}
</script>
