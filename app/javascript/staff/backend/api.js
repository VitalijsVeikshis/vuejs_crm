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
  destroy: (id) => adapter.delete(`/staff/clients/${id}`),
  update: (client) => adapter.patch('/staff/clients', { client }),
  reset_password: (id) => adapter.patch(`/staff/clients/${id}/reset_password`),
};

const staffs = {
  current: () => adapter.get('/staff/current'),
  create: (staff) => adapter.post('/staff/staffs', { staff }),
  index: () => adapter.get('/staff/staffs'),
  destroy: (id) => adapter.delete(`/staff/staffs/${id}`),
  validate: (staff) => adapter.post('/staff/staffs/validate', { staff }),
  update: (staff) => adapter.patch('/staff/staffs', { staff }),
  reset_password: (id) => adapter.patch(`/staff/staffs/${id}/reset_password`),
};

const organizations = {
  create: (organization) => adapter.post('/staff/organizations', { organization }),
  index: () => adapter.get('/staff/organizations'),
  destroy: (id) => adapter.delete(`/staff/organizations/${id}`),
  validate: (organization) => adapter.post('/staff/organizations/validate', { organization }),
};

const dadataHeaders = {
  headers: {
    contentType: 'application/json',
    accept: 'application/json',
    authorization: 'Token ef0aeb0161b15ac82d2b45dbff5dea6c309b50c9',
  },
};

const dadata = {
  suggestions: (query) => axios.post('https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/party', { query }, dadataHeaders),
};

export default {
  clients,
  staffs,
  organizations,
  dadata,
};
