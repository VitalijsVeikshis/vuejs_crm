<template lang='pug'>
  q-input(
    ref='phone'
    type='tel'
    label='Номер телефона'
    placeholder='Только цифры'
    v-model='phone'
    dense
    color='secondary'
    :loading="loading"
    :error="!isValid"
    @blur='validateInputValue'
  )#phone
    template(v-slot:error) {{errors[0] | capitalize}}
</template>

<script>

export default {
  props: {
    inputErrors: {
      type: Array,
      default: () => [],
    },
    value: { type: String, default: '' },
  },
  data() {
    return {
      loading: false,
      phone: '',
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
    value() {
      this.phone = this.value;
    },
  },
  methods: {
    validateInputValue() {
      this.errors = [];
      if (this.frontEndValidation()) {
        this.serverValidation();
        this.passEmailToDashboard();
      }
    },
    frontEndValidation() {
      return this.validateNotEmpty() && this.validateNumbers();
    },
    validateNotEmpty() {
      if (!this.notEmpty()) {
        this.errors.push('Не может быть пустым');
      }
      return this.notEmpty();
    },
    notEmpty() {
      return this.phone.length !== 0;
    },
    validateNumbers() {
      if (!this.onlyNumbers()) {
        this.errors.push('Не является числом');
      }
      return this.onlyNumbers();
    },
    onlyNumbers() {
      return Number.isFinite(Number(this.phone)) && this.notEmpty();
    },
    serverValidation() {
      this.loading = true;
      this.$api.clients
        .validate({ phone: this.phone })
        .then(
          () => {},
          (errors) => {
            this.errors = errors.response.data.phone;
          },
        )
        .finally(() => {
          this.loading = false;
        });
    },
    passEmailToDashboard() {
      this.$emit('blur', this.phone);
    },
  },
};
</script>

<style scoped lang="scss">
label {
  color: #34495e;
}
</style>
