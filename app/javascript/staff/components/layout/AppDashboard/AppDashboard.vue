<template lang='pug'>
  .container#dashboard
    newClientForm
    tableClients
</template>

<script>
import newClientForm from './NewClientForm/NewClientForm.vue';
import tableClients from './ClientsList/TableClients.vue';
import eventBus from '../../../utils/EventBus';

export default {
  components: {
    newClientForm,
    tableClients,
  },
  data() {
    return {
      user: {},
      errors: [],
    };
  },
  methods: {
    createClient() {
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

<style scoped lang="scss">
.btn-primary {
  background-color: #41b883;
  border-color: #41b883;
}
.btn-primary:hover {
  background-color: #3aa575;
  border-color: #3aa575;
}
label {
  color: #34495e;
}
</style>
