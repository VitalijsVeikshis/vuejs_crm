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
    EventBus.$on('createClient', () => {
      this.fullname = '';
    });
  },
  methods: {
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
      this.validateFullname();
      this.passFullnameToDashboard();
    },
  },
};
</script>

<style scoped lang="scss">
label {
  color: #34495e;
}
</style>
