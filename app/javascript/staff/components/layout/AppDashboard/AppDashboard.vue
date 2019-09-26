<template lang='pug'>
  #dashboard.q-gutter-md
    formNewOrganization
</template>

<script>
import formNewOrganization from './AppForms/NewOrganization/FormNewOrganization.vue';
import eventBus from '../../../utils/EventBus';

export default {
  components: {
    formNewOrganization,
  },
  data() {
    return {
      user: {},
      errors: [],
    };
  },
  methods: {
    createClient() {
      this.$q.loading.show();
      this.$api.clients
        .post({ fullname: this.user.fullname, phone: this.user.phone, email: this.user.email })
        .then(
          () => {
            this.user = {};
            this.errors = [];
            this.handleCreateClient();
          },
          (errors) => {
            this.errors = errors.response.data;
          },
        )
        .finally(
          () => {
            this.$q.loading.hide();
          },
        );
      this.submitted = false;
    },
    setEmail(value) {
      this.user.email = value;
    },
    setFullname(value) {
      this.user.fullname = value;
    },
    setPhone(value) {
      this.user.phone = value;
    },
    handleCreateClient() {
      eventBus.$emit('createClient');
    },
  },
};
</script>
