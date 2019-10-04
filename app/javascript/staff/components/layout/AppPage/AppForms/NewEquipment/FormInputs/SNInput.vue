<template lang='pug'>
  q-input(
    type='text'
    label='Серийный номер'
    v-model='sn'
    dense
    color='secondary'
    :loading="loading"
    :error="!isValid"
    @blur='validateInputValue'
  )
    template(v-slot:error) {{errors[0] | capitalize}}
</template>

<script>

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
      sn: '',
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
  methods: {
    validateInputValue() {
      this.errors = [];
      if (this.frontEndValidation()) {
        this.serverValidation();
        this.passSNToDashboard();
      }
    },
    frontEndValidation() {
      return this.validateNotEmpty();
    },
    validateNotEmpty() {
      if (!this.notEmpty()) {
        this.errors.push('Не может быть пустым');
      }
      return this.notEmpty();
    },
    notEmpty() {
      return this.sn.length !== 0;
    },
    serverValidation() {
      this.loading = true;
      this.$api.equipments
        .validate(this.$route.params.id, { sn: this.sn })
        .then(
          () => {},
          (errors) => {
            this.errors = errors.response.data.sn;
          },
        )
        .finally(() => {
          this.loading = false;
        });
    },
    passSNToDashboard() {
      this.$emit('blur', this.sn);
    },
  },
};
</script>
