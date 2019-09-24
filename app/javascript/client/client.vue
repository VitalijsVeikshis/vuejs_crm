<template lang='pug'>
  #client
    q-layout(view="hHh lpR fFf")
      q-header(elevated)
        app-navbar(v-bind:userEmail="userEmail")
      q-page-container
        q-page.doc-page
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
    this.getCurrentClient();
  },
  methods: {
    getCurrentClient() {
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
.doc-page {
  padding: 16px 46px;
  font-weight: 300;
  max-width: 900px;
  margin-left: auto;
  margin-right: auto;
}
p {
  font-size: 2em;
  text-align: center;
}
</style>
