<template lang='pug'>
  #staff
    q-layout(view="hHh LpR fFf")
      q-header(elevated)
        app-navbar(v-bind:userEmail="userEmail")
      leftDrawer
      rightDrawer
      q-page-container
        q-page.doc-page
          p {{ message }}
          AppDashboard
</template>

<script>
import AppNavbar from './components/layout/AppNavbar/AppNavbar.vue';
import AppDashboard from './components/layout/AppDashboard/AppDashboard.vue';
import leftDrawer from './components/layout/AppDrawers/LeftDrawer.vue';
import rightDrawer from './components/layout/AppDrawers/RightDrawer.vue';

export default {
  components: {
    AppNavbar,
    AppDashboard,
    leftDrawer,
    rightDrawer,
  },
  data() {
    return {
      message: 'Hello Staff!',
      userEmail: '',
      timer: 0,
    };
  },
  created() {
    this.getCurrentStaff();
  },
  methods: {
    getCurrentStaff() {
      this.$q.loading.show();
      this.$api.staffs
        .current()
        .then(
          (response) => {
            this.userEmail = response.data.data.attributes.email;
          },
        )
        .finally(
          () => {
            this.$q.loading.hide();
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
