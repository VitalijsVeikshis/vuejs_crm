import axios from 'axios';

const adapter = axios.create({
  baseURL: '/client/api/v1',
});

const clients = {
  current: () => adapter.get('/current'),
};

export default {
  clients,
};
