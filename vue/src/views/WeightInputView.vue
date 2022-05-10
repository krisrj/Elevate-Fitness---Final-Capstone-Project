<template>
      <weight-input v-bind:weightInputID="parseInt($route.params.weightInputID)"/>
</template>

<script>

import WeightInput from '../components/WeightInput.vue';

export default {
    components: {WeightInput }

}
</script>


