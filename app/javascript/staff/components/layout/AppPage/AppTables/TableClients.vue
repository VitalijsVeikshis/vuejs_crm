<template lang='pug'>
  .row.justify-center
    q-table(
      flat
      :data="data"
      :columns="columns"
      :visible-columns='visibleColumns'
      :selected.sync="selected"
      selection="multiple"
      @request="onRequest"
      :pagination.sync="pagination"
      :loading="loading"
      loading-label='Loading clients...'
      row-key="id"
    ).full-width
    .row.justify-center
      q-btn(
        label="Удалить"
        @click="destroy"
        :disable='disableBtn'
      )
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
      disableBtn: true,
      loading: false,
      selected: [],
      visibleColumns: ['fullname', 'phone', 'email'],
      pagination: {
        page: 1,
        rowsPerPage: 15,
      },
      columns: [
        { name: 'id', label: 'ID', field: 'id' },
        { name: 'fullname', label: 'Полное имя', field: 'fullname' },
        { name: 'phone', label: 'Номер телефона', field: 'phone' },
        { name: 'email', label: 'Электронная почта', field: 'email' },
      ],
      data: [],
    };
  },
  watch: {
    selected() {
      this.disableDestroyBtn();
    },
  },
  mounted() {
    eventBus.$on('createClient', () => {
      this.onRequest();
    });
    this.onRequest();
  },
  methods: {
    disableDestroyBtn() {
      if (this.selected.length === 0) {
        this.disableBtn = true;
      } else {
        this.disableBtn = false;
      }
    },
    destroy() {
      this.$q.loading.show();
      if (this.selected.length > 0) {
        this.selected.forEach(
          (client) => {
            this.$api.clients
              .destroy(client.id)
              .then(() => {
                this.selected = [];
                this.onRequest();
              })
              .finally(() => {
                this.$q.loading.hide();
              });
          },
        );
      }
    },
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
            id: record.attributes.id,
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
