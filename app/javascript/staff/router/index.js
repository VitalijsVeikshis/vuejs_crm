import Vue from 'vue';
import VueRouter from 'vue-router';

import appClients from '../components/AppClients.vue';
import appOrganizations from '../components/AppOrganizations.vue';

Vue.use(VueRouter);

export default new VueRouter({
  mode: 'history',
  hashbangs: false,
  routes: [
    { path: '/clients', component: appClients, name: 'clients' },
    { path: '/organizations', component: appOrganizations, name: 'organizations' },
  ],
});
