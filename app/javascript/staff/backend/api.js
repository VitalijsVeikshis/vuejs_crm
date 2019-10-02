import axios from 'axios';

const metaCsrfToken = document.querySelector('meta[name="csrf-token"]');

axios.defaults.headers.common = {
  'X-Requested-With': 'XMLHttpRequest',
  'X-CSRF-TOKEN': metaCsrfToken ? metaCsrfToken.getAttribute('content') : '',
};

const adapter = axios.create({
  baseURL: '/staff/api/v1',
});

const clients = {
  post: (client) => adapter.post('/clients', { client }),
  get_index: () => adapter.get('/clients'),
  validate: (client) => adapter.post('/clients/validate', { client }),
  destroy: (id) => adapter.delete(`/clients/${id}`),
  update: (client) => adapter.patch('/clients', { client }),
  reset_password: (id) => adapter.patch(`/clients/${id}/reset_password`),
};

const staffs = {
  current: () => adapter.get('/current'),
  create: (staff) => adapter.post('/staffs', { staff }),
  index: () => adapter.get('/staffs'),
  destroy: (id) => adapter.delete(`/staffs/${id}`),
  validate: (staff) => adapter.post('/staffs/validate', { staff }),
  update: (staff) => adapter.patch('/staffs', { staff }),
  reset_password: (id) => adapter.patch(`/staffs/${id}/reset_password`),
};

const organizations = {
  create: (organization) => adapter.post('/organizations', { organization }),
  index: () => adapter.get('/organizations'),
  destroy: (id) => adapter.delete(`/organizations/${id}`),
  validate: (organization) => adapter.post('/organizations/validate', { organization }),
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
