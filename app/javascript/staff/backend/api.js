import axios from 'axios';

const metaCsrfToken = document.querySelector('meta[name="csrf-token"]');

axios.defaults.headers.common = {
  'X-Requested-With': 'XMLHttpRequest',
  'X-CSRF-TOKEN': metaCsrfToken ? metaCsrfToken.getAttribute('content') : '',
};

const adapter = axios.create({
  baseURL: '/',
});

const clients = {
  post: (client) => adapter.post('/staff/clients', { client }),
  get_index: () => adapter.get('/staff/clients'),
  validate: (client) => adapter.post('/staff/clients/validate', { client }),
};

const staffs = {
  current: () => adapter.get('/staff/current'),
};

const organizations = {
  create: (organization) => adapter.post('/staff/organizations', { organization }),
  index: () => adapter.get('/staff/organizations'),
  destroy: (id) => adapter.delete(`/staff/organizations/${id}`),
  validate: (organization) => adapter.post('/staff/organizations/validate', { organization }),
};

export default {
  clients,
  staffs,
  organizations,
};
