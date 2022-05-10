<template>
  <hydration-input v-bind:hydrationID="parseInt($route.params.hydrationID)"/>
</template>

<script>
import HydrationInput from '../components/HydrationInput.vue';
export default{
  components: {
    HydrationInput
  }
}

</script>

<style>

</style>