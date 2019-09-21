<template lang='pug'>
  #staff
    app-navbar(v-bind:userEmail="userEmail")
    .main
      p {{ message }}
      AppDashboard
</template>

<script>
import AppNavbar from './components/layout/AppNavbar/AppNavbar.vue';
import AppDashboard from './components/layout/AppDashboard/AppDashboard.vue';

export default {
  components: {
    AppNavbar,
    AppDashboard,
  },
  data() {
    return {
      message: 'Hello Staff!',
      userEmail: '',
    };
  },
  created() {
    this.getCurrentStaff();
  },
  methods: {
    getCurrentStaff() {
      this.$api.staffs
        .current()
        .then(
          (response) => {
            this.userEmail = response.data.data.attributes.email;
          },
        );
    },
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
