<template lang='pug'>
  q-input(
    type='text'
    label='Тип'
    v-model='kind'
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
      kind: '',
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
        this.passKindToDashboard();
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
      return this.kind.length !== 0;
    },
    serverValidation() {
      this.loading = true;
      this.$api.equipments
        .validate(this.$route.params.id, { kind: this.kind })
        .then(
          () => {},
          (errors) => {
            this.errors = errors.response.data.kind;
          },
        )
        .finally(() => {
          this.loading = false;
        });
    },
    passKindToDashboard() {
      this.$emit('blur', this.kind);
    },
  },
};
</script>
