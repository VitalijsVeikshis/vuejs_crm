<template lang='pug'>
  #ogrn
    q-input(
      type='text'
      label='ОГРН'
      v-model='ogrn'
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
    value: {
      type: String,
      default: '',
    },
  },
  data() {
    return {
      loading: false,
      ogrn: '',
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
      this.ogrn = this.value;
    },
  },
  mounted() {
    eventBus.$on('createOrganization', () => {
      this.ogrn = '';
    });
  },
  methods: {
    validateInputValue() {
      this.errors = [];
      if (this.frontEndValidation()) {
        this.serverValidation();
        this.passOgrnToNewOrganization();
      }
    },
    frontEndValidation() {
      return this.validateNotEmpty() && this.validateOgrnLength();
    },
    validateNotEmpty() {
      if (!this.notEmpty()) {
        this.errors.push('Не может быть пустым');
      }
      return this.notEmpty();
    },
    notEmpty() {
      return this.ogrn.length !== 0;
    },
    validateOgrnLength() {
      if (!this.isValidOgrnLength()) {
        this.errors.push('Неверной длины (может быть длиной ровно 13 символов)');
      }
      return this.isValidOgrnLength();
    },
    isValidOgrnLength() {
      return this.ogrn.length === 13;
    },
    serverValidation() {
      this.loading = true;
      this.$api.organizations
        .validate({ ogrn: this.ogrn })
        .then(
          () => {},
          (errors) => {
            this.errors = errors.response.data.ogrn;
          },
        )
        .finally(() => {
          this.loading = false;
        });
    },
    passOgrnToNewOrganization() {
      this.$emit('blur', this.ogrn);
    },
  },
};
</script>
