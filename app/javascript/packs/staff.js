import Vue from 'vue';
import Staff from '../staff/staff.vue';
import api from '../staff/backend/api';
import '../shared/utils/filters';
import 'bootstrap/dist/css/bootstrap.min.css';

Vue.prototype.$api = api;

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: (h) => h(Staff, {
      props: {
        userEmail: document.body.getAttribute('data-user-email'),
      },
    }),
  }).$mount();
  document.body.appendChild(app.$el);
});
