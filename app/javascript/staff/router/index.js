import Vue from 'vue';
import VueRouter from 'vue-router';

import appClients from '../components/AppClients.vue';
import appOrganizations from '../components/AppOrganizations.vue';
import appStaffs from '../components/AppStaffs.vue';

Vue.use(VueRouter);

export default new VueRouter({
  mode: 'history',
  hashbangs: false,
  base: '/staff',
  routes: [
    { path: '/clients', component: appClients, name: 'clients' },
    { path: '/organizations', component: appOrganizations, name: 'organizations' },
    { path: '/staffs', component: appStaffs, name: 'staffs' },
  ],
});
