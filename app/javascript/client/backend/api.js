import axios from 'axios';

const adapter = axios.create({
  baseURL: '/',
});

const clients = {
  current: () => adapter.get('/client/current'),
};

export default {
  clients,
};
