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
      template(v-slot:top)
        .q-gutter-md
          q-btn(
            label="Добавить"
            :to="{ name: 'addClient' }"
          )
          q-btn(
            label="Удалить"
            @click="destroy"
            :disable='disableBtn'
          )
          q-btn(
            label="Сбросить пароль"
            no-wrap
            @click="reset"
            :disable='disableBtn'
          )
          q-btn(
            label="Связать с организацией"
            no-wrap
            :disable='disableBtn'
            :to="{ name: 'bindOrganization', params: { selected: selected } }"
          )
      template(v-slot:body-cell-edit="cellProperties")
        q-td(:props="cellProperties")
          q-btn(
              label="Редактировать"
              no-wrap
              :to="{ name: 'editClient', params: { id: cellProperties.row.id.toString() } }"
            )
    router-view
</template>

<script>
import addClientDialog from '../../AppDialogs/AddClientDialog.vue';
import eventBus from '../../../../utils/EventBus';

export default {
  components: {
    addClientDialog,
  },
  data() {
    return {
      disableBtn: true,
      loading: false,
      selected: [],
      visibleColumns: ['fullname', 'phone', 'email', 'edit'],
      pagination: {
        page: 1,
        rowsPerPage: 15,
      },
      columns: [
        { name: 'id', label: 'ID', field: 'id' },
        { name: 'fullname', label: 'Полное имя', field: 'fullname' },
        { name: 'phone', label: 'Номер телефона', field: 'phone' },
        { name: 'email', label: 'Электронная почта', field: 'email' },
        { name: 'edit', label: '', field: 'edit' },
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
    eventBus.$on('dialogHide', () => {
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
    reset() {
      this.$q.loading.show();
      if (this.selected.length > 0) {
        this.selected.forEach(
          (client) => {
            this.$api.clients
              .reset_password(client.id)
              .then(() => {
                this.selected = [];
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
