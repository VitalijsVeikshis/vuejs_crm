<template lang='pug'>
  .container#dashboard
    form(@submit.prevent='createClient')
      fullnameInput(v-bind:inputErrors="errors.fullname" v-on:blur='setFullname')
      phoneInput(v-bind:inputErrors="errors.phone" v-on:blur='setPhone')
      emailInput(v-bind:inputErrors="errors.email" v-on:blur='setEmail')
      button.btn.btn-primary Save
    tableClients
</template>

<script>
import fullnameInput from './Inputs/FullnameInput.vue';
import phoneInput from './Inputs/PhoneInput.vue';
import emailInput from './Inputs/EmailInput.vue';
import tableClients from './Outputs/TableClients.vue';
import EventBus from './event-bus';

export default {
  components: {
    fullnameInput,
    phoneInput,
    emailInput,
    tableClients,
  },
  data() {
    return {
      fullname: '',
      phone: '',
      email: '',
      errors: [],
    };
  },
  methods: {
    createClient() {
      this.$api.clients
        .post({ fullname: this.fullname, phone: this.phone, email: this.email })
        .then(
          () => {
            this.fullname = '';
            this.phone = '';
            this.email = '';
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
      this.email = value;
    },
    setFullname(value) {
      this.fullname = value;
    },
    setPhone(value) {
      this.phone = value;
    },
    handleCreateClient() {
      EventBus.$emit('createClient');
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
