import Vue from 'vue';
import Staff from '../staff.vue';

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: (h) => h(Staff),
  }).$mount();
  document.body.appendChild(app.$el);
});
