<template lang='pug'>
  q-input(
    ref='fullname'
    type='text'
    label='Полное имя'
    placeholder='Минимум 5 символов'
    v-model='fullname'
    dense
    color='secondary'
    :loading="loading"
    :error="!isValid"
    @blur='validateInputValue'
  )#fullname
    template(v-slot:error) {{errors[0] | capitalize}}
</template>

<script>
import eventBus from '../../../../../../utils/EventBus';

export default {
  props: {
    inputErrors: {
      type: Array,
      default: () => [],
    },
  },
  data() {
    return {
      loading: false,
      fullname: '',
      errors: [],
    };
  },
  computed: {
    isValid() {
      return this.errors.length === 0;
    },
  },
  watch: {
    inputErrors() {
      this.errors = this.inputErrors;
    },
  },
  mounted() {
    eventBus.$on('createClient', () => {
      this.fullname = '';
    });
  },
  methods: {
    validateInputValue() {
      this.errors = [];
      if (this.frontEndValidation()) {
        this.serverValidation();
        this.passFullnameToDashboard();
      }
    },
    frontEndValidation() {
      return this.validateNotEmpty() && this.validateLength();
    },
    validateNotEmpty() {
      if (!this.notEmpty()) {
        this.errors.push("Can't be blank");
      }
      return this.notEmpty();
    },
    notEmpty() {
      return this.fullname.length !== 0;
    },
    validateLength() {
      if (!this.isValidLength()) {
        this.errors.push('Is too short (minimum is 5 characters)');
      }
      return this.isValidLength();
    },
    isValidLength() {
      return this.fullname.length > 4;
    },
    serverValidation() {
      this.loading = true;
      this.$api.clients
        .validate({ fullname: this.fullname })
        .then(
          () => {},
          (errors) => {
            this.errors = errors.response.data.fullname;
          },
        )
        .finally(() => {
          this.loading = false;
        });
    },
    passFullnameToDashboard() {
      this.$emit('blur', this.fullname);
    },
  },
};
</script>

<style scoped lang="scss">
label {
  color: #34495e;
}
</style>
