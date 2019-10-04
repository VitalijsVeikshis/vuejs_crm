<template lang='pug'>
  q-input(
    type='text'
    label='Название'
    v-model='title'
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
      title: '',
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
        this.passTitleToDashboard();
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
      return this.title.length !== 0;
    },
    serverValidation() {
      this.loading = true;
      this.$api.equipments
        .validate(this.$route.params.id, { title: this.title })
        .then(
          () => {},
          (errors) => {
            this.errors = errors.response.data.title;
          },
        )
        .finally(() => {
          this.loading = false;
        });
    },
    passTitleToDashboard() {
      this.$emit('blur', this.title);
    },
  },
};
</script>

<style scoped lang="scss">
label {
  color: #34495e;
}
</style>
