<template lang='pug'>
  #staff
    app-navbar(v-bind:userEmail="userEmail")
    .main
      p {{ message }}
</template>

<script>
import AppNavbar from './components/layout/AppNavbar/AppNavbar.vue';

export default {
  components: {
    AppNavbar,
  },
  props: {
    userEmail: {
      type: String,
      default: '',
    },
  },
  data() {
    return {
      message: 'Hello Staff!',
    };
  },
};
</script>

<style scoped lang="scss">
p {
  font-size: 2em;
  text-align: center;
}
.main {
  margin-top: 60px;
}
</style>
