<template lang='pug'>
  #client
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
  data() {
    return {
      message: 'Hello Client!',
      userEmail: '',
    };
  },
  created() {
    this.getCurrentStaff();
  },
  methods: {
    getCurrentStaff() {
      this.$api.clients
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
