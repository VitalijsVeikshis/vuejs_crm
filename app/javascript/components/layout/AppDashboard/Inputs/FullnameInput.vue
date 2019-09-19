<template lang='pug'>
  .form-group
    label(for='fullname') Fullname
    input(
      v-model="fullname"
      v-bind:class="errors && errors.length > 0 ? 'is-invalid' : ''"
      v-on:blur='handleFullname'
      placeholder='Minimum 5 characters'
    )#fullname.form-control
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
      fullname: '',
      errors: this.inputErrors,
    };
  },
  watch: {
    inputErrors() {
      this.errors = this.inputErrors;
    },
    submited() {
      if (this.submited === true) this.fullname = '';
    },
  },
  mounted() {
    eventBus.$on('createClient', () => {
      this.fullname = '';
    });
  },
  methods: {
    isValidLength() {
      return this.fullname.length > 4;
    },
    notEmpty() {
      return this.fullname.length > 0;
    },
    frontEndValidation() {
      this.errors = [];

      if (!this.notEmpty()) {
        this.errors.push("Can't be blank");
      }
      if (!this.isValidLength()) {
        this.errors.push('Is too short (minimum is 5 characters)');
      }
      return this.isValidLength() && this.notEmpty();
    },
    validateFullname() {
      this.$api.clients
        .post({ fullname: this.fullname })
        .then(
          () => {
            this.errors = [];
          },
          (errors) => {
            this.errors = errors.response.data.fullname;
          },
        );
    },
    passFullnameToDashboard() {
      this.$emit('blur', this.fullname);
    },
    handleFullname() {
      if (this.frontEndValidation()) {
        this.validateFullname();
        this.passFullnameToDashboard();
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
