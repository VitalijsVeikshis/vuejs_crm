<template lang='pug'>
  #navbar
    a(href="/")#brand-logo
      img(v-bind:src="brandLogo")
      span Vue.js CRM
    ul#nav
      li
        span {{ userEmail }}
      li
        logOutLink
</template>

<script>

import brandLogo from 'images/vue_logo.png';
import logOutLink from './LogOutLink.vue';

export default {
  components: {
    logOutLink,
  },
  props: {
    userEmail: {
      type: String,
      default: '',
    },
  },
  data() {
    return {
      brandLogo,
    };
  },
};
</script>

<style scoped lang="scss">
#navbar {
  background-color: #fff;
  height: 40px;
  padding: 10px 60px;
  position: relative;
  z-index: 20;
}
#brand-logo {
  display: inline-block;
  font-size: 1.5em;
  line-height: 40px;
  color: #273849;
  font-family: Arial;
  font-weight: 500;
}
a {
  text-decoration: none;
}
#brand-logo img {
  vertical-align: middle;
  margin-right: 6px;
  width: 40px;
  height: 40px;
}
#brand-logo span {
  line-height: 40px;
  color: #273849;
  font-family: "Helvetica Neue", Arial, sans-serif;
  font-weight: 500;
}
#nav {
  list-style-type: none;
  margin: 0;
  padding: 0;
  position: absolute;
  right: 30px;
  top: 10px;
  height: 40px;
  line-height: 40px;
}
li {
  display: inline-block;
  position: relative;
  margin: 0 0.6em;
}
li span {
  padding-bottom: 3px;
  white-space: nowrap;
  color: #304455;
  font-family: "Helvetica Neue", Arial, sans-serif;
}
</style>
