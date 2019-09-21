import Vue from 'vue';
import Client from '../client/client.vue';
import api from '../client/backend/api';
import '../shared/utils/filters';
import 'bootstrap/dist/css/bootstrap.min.css';

Vue.prototype.$api = api;

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: (h) => h(Client),
  }).$mount();
  document.body.appendChild(app.$el);
});
