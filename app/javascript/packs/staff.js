import Vue from 'vue';
import Staff from '../staff.vue';

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
