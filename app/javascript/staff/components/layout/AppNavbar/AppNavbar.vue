<template lang='pug'>
  q-toolbar(row no-wrap items-center).bg-secondary
    q-btn(stretch flat no-caps type="a" href="/staff")
      q-avatar(square)
        img(v-bind:src="brandLogo")
      q-toolbar-title Vue.js CRM
    q-space
    q-chip(square color='secondary' text-color='white') {{ userEmail }}
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
