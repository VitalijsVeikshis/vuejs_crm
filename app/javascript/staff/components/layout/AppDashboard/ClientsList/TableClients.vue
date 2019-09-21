<template lang='pug'>
  table.table.mt-5#clients
    thead
      tr
        th(scope='col') Fullname
        th(scope='col') Phone number
        th(scope='col') Email
    tbody
      rowClient(v-for="client in clients" :client="client" :key="client.id")
</template>

<script>
import eventBus from '../../../../utils/EventBus';
import rowClient from './RowClient.vue';

export default {
  components: {
    rowClient,
  },
  data() {
    return {
      clients: this.getClients(),
    };
  },
  mounted() {
    eventBus.$on('createClient', () => {
      this.getClients();
    });
  },
  methods: {
    getClients() {
      this.$api.clients
        .get_index()
        .then(
          (response) => {
            this.clients = response.data.data;
          },
        );
    },
  },
};
</script>

<style scoped lang="scss">
thead {
  background-color: #34495e;
  color: white;
}
label {
  color: #34495e;
}
</style>
