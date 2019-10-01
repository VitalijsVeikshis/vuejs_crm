<template lang='pug'>
  .row.justify-center
    q-table(
      flat
      :data="data"
      :columns="columns"
      @request="onRequest"
      :pagination.sync="pagination"
      :loading="loading"
      loading-label='Loading clients...'
    ).full-width
</template>

<script>
import formNewClient from '../AppForms/NewClient/FormNewClient.vue';
import eventBus from '../../../../utils/EventBus';

export default {
  components: {
    formNewClient,
  },
  data() {
    return {
      loading: false,
      pagination: {
        page: 1,
        rowsPerPage: 15,
      },
      columns: [
        { name: 'fullname', label: 'Полное имя', field: 'fullname' },
        { name: 'phone', label: 'Номер телефона', field: 'phone' },
        { name: 'email', label: 'Электронная почта', field: 'email' },
      ],
      data: [],
    };
  },
  mounted() {
    eventBus.$on('createClient', () => {
      this.onRequest();
    });
    this.onRequest();
  },
  methods: {
    onRequest() {
      this.loading = true;
      this.$api.clients
        .get_index()
        .then((response) => {
          this.parseResponseData(response.data.data);
        })
        .finally(() => {
          this.loading = false;
        });
    },
    parseResponseData(responseData) {
      this.data = [];
      responseData.forEach(
        (record) => {
          this.data.push({
            fullname: record.attributes.fullname,
            phone: record.attributes.phone,
            email: record.attributes.email,
          });
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
