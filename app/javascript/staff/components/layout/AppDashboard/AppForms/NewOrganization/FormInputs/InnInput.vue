<template lang='pug'>
  #inn
    q-input(
      type='text'
      label='ИНН'
      v-model='inn'
      dense
      color='secondary'
      :loading="loading"
      :error="!isValid"
      @blur='validateInputValue'
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
    formOfOwnership: {
      type: String,
      default: '',
    },
    value: {
      type: String,
      default: '',
    },
  },
  data() {
    return {
      loading: false,
      inn: '',
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
      this.inn = this.value;
    },
  },
  mounted() {
    eventBus.$on('createOrganization', () => {
      this.inn = '';
    });
  },
  methods: {
    validateInputValue() {
      this.errors = [];
      if (this.frontEndValidation()) {
        this.serverValidation();
        this.passInnToNewOrganization();
      }
    },
    frontEndValidation() {
      return this.validateNotEmpty()
            && (this.validateInnLengthIp() || this.validateInnLengthOther());
    },
    validateNotEmpty() {
      if (!this.notEmpty()) {
        this.errors.push("Can't be blank");
      }
      return this.notEmpty();
    },
    notEmpty() {
      return this.inn.length !== 0;
    },
    validateInnLengthIp() {
      if (!this.isValidInnLengthIp() && this.formOfOwnership === 'ip') {
        this.errors.push('Please use 12 characters');
      }
      return this.isValidInnLengthIp();
    },
    isValidInnLengthIp() {
      return this.inn.length === 12;
    },
    validateInnLengthOther() {
      if (!this.isValidInnLengthOther() && this.formOfOwnership !== 'ip') {
        this.errors.push('Please use 10 characters');
      }
      return this.isValidInnLengthOther();
    },
    isValidInnLengthOther() {
      return this.inn.length === 10;
    },
    serverValidation() {
      this.loading = true;
      const organizationParams = { inn: this.inn };
      if (this.formOfOwnership) {
        Object.assign(organizationParams, { form_of_ownership: this.formOfOwnership });
      }
      this.$api.organizations
        .validate(organizationParams)
        .then(
          () => {},
          (errors) => {
            this.errors = errors.response.data.inn;
          },
        )
        .finally(() => {
          this.loading = false;
        });
    },
    passInnToNewOrganization() {
      this.$emit('blur', this.inn);
    },
  },
};
</script>
