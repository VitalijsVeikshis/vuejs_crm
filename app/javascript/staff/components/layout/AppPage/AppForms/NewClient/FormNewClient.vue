<template lang='pug'>
  q-form(@submit.prevent='createClient').full-width
    .row.justify-center
      .col.q-gutter-md
        fullnameInput(
          v-bind:inputErrors="errors.fullname"
          v-model='user.fullname'
          @blur='setFullname'
        )
        phoneInput(
          v-bind:inputErrors="errors.phone"
          v-model='user.phone'
          @blur='setPhone'
        )
        emailInput(
          v-bind:inputErrors="errors.email"
          v-model='user.email'
          @blur='setEmail'
        )
    .row.justify-center
      q-btn(
        label="Добавить"
        type="submit"
      )#addClientBtn
</template>

<script>
import fullnameInput from './FormInputs/FullnameInput.vue';
import phoneInput from './FormInputs/PhoneInput.vue';
import emailInput from './FormInputs/EmailInput.vue';
import eventBus from '../../../../../utils/EventBus';

export default {
  components: {
    fullnameInput,
    phoneInput,
    emailInput,
  },
  data() {
    return {
      user: {
        fullname: '',
        phone: '',
        email: '',
      },
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
        .finally(() => {
          this.$q.loading.hide();
        });
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
</style>
