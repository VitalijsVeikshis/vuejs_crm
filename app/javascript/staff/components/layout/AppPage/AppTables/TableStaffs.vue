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
      loading-label='Loading staffs...'
      row-key="id"
    ).full-width
    .row.justify-center
      .col
        q-btn(
          label="Удалить"
          @click="destroy"
          :disable='disableBtn'
        )
      .col
        q-btn(
          label="Сбросить пароль"
          no-wrap
          @click="reset"
          :disable='disableBtn'
        )
</template>

<script>
import eventBus from '../../../../utils/EventBus';

export default {
  data() {
    return {
      disableBtn: true,
      loading: false,
      selected: [],
      visibleColumns: ['email'],
      pagination: {
        page: 1,
        rowsPerPage: 15,
      },
      columns: [
        { name: 'id', label: 'ID', field: 'id' },
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
    eventBus.$on('createStaff', () => {
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
    reset() {
      this.$q.loading.show();
      if (this.selected.length > 0) {
        this.selected.forEach(
          (staff) => {
            this.$api.staffs
              .reset_password(staff.id)
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
    destroy() {
      this.$q.loading.show();
      if (this.selected.length > 0) {
        this.selected.forEach(
          (staff) => {
            this.$api.staffs
              .destroy(staff.id)
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
      this.$api.staffs
        .index()
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
            email: record.attributes.email,
          });
        },
      );
    },
  },
};
</script>
