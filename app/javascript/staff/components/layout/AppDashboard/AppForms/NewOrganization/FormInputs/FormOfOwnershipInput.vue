<template lang='pug'>
  #formOfOwnershipInput
    q-select(
      ref='formOfOwnership'
      label='Форма собственности'
      v-model='formOfOwnership'
      :options="options"
      dense
      color='secondary'
      :loading="loading"
      :error="!isValid"
      @blur='validateInputValue'
    )#formOfOwnership
      template(v-slot:error) {{errors[0] | capitalize}}
</template>

<script>
import eventBus from '../../../../../../utils/EventBus';

const formOfOwnershipOptions = [
  { label: 'ИП', value: 'ip' },
  { label: 'ООО', value: 'ooo' },
  { label: 'КФХ', value: 'kfh' },
  { label: 'АО', value: 'ao' },
  { label: 'ПАО', value: 'pao' },
];

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
      formOfOwnership: { value: '' },
      errors: [],
      formOfOwnershipOptions,
      options: formOfOwnershipOptions,
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
      this.formOfOwnership = '';
    });
  },
  methods: {
    validateInputValue() {
      this.errors = [];
      if (this.frontEndValidation()) {
        this.serverValidation();
        this.passFormOfOwnershipToNewOrganization();
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
      return this.formOfOwnership.value.length !== 0;
    },
    serverValidation() {
      this.loading = true;
      this.$api.organizations
        .validate({ form_of_ownership: this.formOfOwnership.value })
        .then(
          () => {},
          (errors) => {
            this.errors = errors.response.data.form_of_ownership;
          },
        )
        .finally(
          () => {
            this.loading = false;
          },
        );
    },
    passFormOfOwnershipToNewOrganization() {
      this.$emit('blur', this.formOfOwnership.value);
    },
  },
};
</script>

<style scoped lang="scss">
label {
  color: #34495e;
}
</style>
