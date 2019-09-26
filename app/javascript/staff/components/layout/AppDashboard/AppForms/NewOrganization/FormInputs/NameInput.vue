<template lang='pug'>
  #name
    q-input(
      ref='name'
      type='text'
      label='Название'
      v-model='name'
      dense
      color='secondary'
      :loading="loading"
      :error="!isValid"
      @blur='validateInputValue'
      id='name3'
    )
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
      name: '',
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
    eventBus.$on('createOrganization', () => {
      this.name = '';
    });
  },
  methods: {
    validateInputValue() {
      this.errors = [];
      if (this.frontEndValidation()) {
        this.serverValidation();
        this.passNameToNewOrganization();
      }
    },
    frontEndValidation() {
      return this.validateNotEmpty();
    },
    validateNotEmpty() {
      if (!this.notEmpty()) {
        this.errors.push("Can't be blank");
      }
      return this.notEmpty();
    },
    notEmpty() {
      return this.name.length !== 0;
    },
    serverValidation() {
      this.loading = true;
      this.$api.organizations
        .validate({ name: this.name })
        .then(
          () => {},
          (errors) => {
            this.errors = errors.response.data.name;
          },
        )
        .finally(
          () => {
            this.loading = false;
          },
        );
    },
    passNameToNewOrganization() {
      this.$emit('blur', this.name);
    },
  },
};
</script>

<style scoped lang="scss">
label {
  color: #34495e;
}
</style>
