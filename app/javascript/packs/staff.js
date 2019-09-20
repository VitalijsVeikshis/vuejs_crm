import Vue from 'vue';
import Staff from '../staff.vue';
import api from '../api/api';
import 'bootstrap/dist/css/bootstrap.min.css';

Vue.prototype.$api = api;

document.addEventListener('DOMContentLoaded', () => {
  Vue.filter('capitalize', (value) => {
    if (!value) return '';
    return value.charAt(0).toUpperCase() + value.slice(1);
  });

  const app = new Vue({
    render: (h) => h(Staff, {
      props: {
        userEmail: document.body.getAttribute('data-user-email'),
      },
    }),
  }).$mount();
  document.body.appendChild(app.$el);
});
