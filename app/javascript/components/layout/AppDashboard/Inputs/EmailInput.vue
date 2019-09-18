<template lang='pug'>
  .form-group
    label(for='email' type='email') Email
    input(
      v-model="email"
      v-bind:class="errors && errors.length > 0 ? 'is-invalid' : ''"
      v-on:blur='handleEmail'
    )#email.form-control
    form-error(
      v-if="errors" :errors="errors"
      v-for="(error, index) in errors" :key="index"
    ) {{ error | capitalize }}
</template>

<script>
import FormError from './FormError.vue';
import EventBus from '../event-bus';

export default {
  components: {
    FormError,
  },
  props: {
    inputErrors: {
      type: Array,
      default: () => [],
    },
  },
  data() {
    return {
      email: '',
      errors: this.inputErrors,
    };
  },
  watch: {
    inputErrors() {
      this.errors = this.inputErrors;
    },
  },
  mounted() {
    EventBus.$on('createClient', () => {
      this.email = '';
    });
  },
  methods: {
    validateEmail() {
      this.$api.clients
        .post({ email: this.email })
        .then(
          () => {
            this.errors = [];
          },
          (errors) => {
            this.errors = errors.response.data.email;
          },
        );
    },
    passEmailToDashboard() {
      this.$emit('blur', this.email);
    },
    handleEmail() {
      this.validateEmail();
      this.passEmailToDashboard();
    },
  },
};
</script>

<style scoped lang="scss">
label {
  color: #34495e;
}
</style>
