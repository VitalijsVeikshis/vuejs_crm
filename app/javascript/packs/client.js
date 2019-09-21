import Vue from 'vue';
import Client from '../client/client.vue';

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: (h) => h(Client, {
      props: {
        userEmail: document.body.getAttribute('data-user-email'),
      },
    }),
  }).$mount();
  document.body.appendChild(app.$el);
});
