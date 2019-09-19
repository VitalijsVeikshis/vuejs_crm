<template lang='pug'>
  .form-group
    label(for='fullname') Phone number
    input(
      v-model="phone"
      v-bind:class="errors && errors.length > 0 ? 'is-invalid' : ''"
      v-on:blur='handlePhone'
      placeholder='Only digits'
    )#phone.form-control
    form-error(
      v-if="errors" :errors="errors"
      v-for="(error, index) in errors" :key="index"
    ) {{ error | capitalize }}
</template>

<script>
import FormError from './FormError.vue';
import eventBus from '../EventBus';

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
      phone: '',
      errors: this.inputErrors,
    };
  },
  watch: {
    inputErrors() {
      this.errors = this.inputErrors;
    },
  },
  mounted() {
    eventBus.$on('createClient', () => {
      this.phone = '';
    });
  },
  methods: {
    onlyNumbers() {
      return Number.isFinite(Number(this.phone)) && this.notEmpty();
    },
    notEmpty() {
      return this.phone.length > 0;
    },
    frontEndValidation() {
      this.errors = [];

      if (!this.notEmpty()) {
        this.errors.push("Can't be blank");
      }
      if (!this.onlyNumbers()) {
        this.errors.push('Is not a number');
      }
      return this.onlyNumbers() && this.notEmpty();
    },
    validatePhone() {
      this.$api.clients
        .post({ phone: this.phone })
        .then(
          () => {
            this.errors = [];
          },
          (errors) => {
            this.errors = errors.response.data.phone;
          },
        );
    },
    passPhoneToDashboard() {
      this.$emit('blur', this.phone);
    },
    handlePhone() {
      if (this.frontEndValidation()) {
        this.validatePhone();
        this.passPhoneToDashboard();
      }
    },
  },
};
</script>

<style scoped lang="scss">
label {
  color: #34495e;
}
</style>
