<template lang='pug'>
  #formOfOwnershipInput
    q-select(
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

const formOfOwnershipOptions = ['ИП', 'ООО', 'КФХ', 'АО', 'ПАО', 'ЗАО'];

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
      formOfOwnership: '',
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
    value() {
      this.formOfOwnership = this.value;
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
      return this.formOfOwnership.length !== 0;
    },
    serverValidation() {
      this.loading = true;
      this.$api.organizations
        .validate({ form_of_ownership: this.formOfOwnership })
        .then(
          () => {},
          (errors) => {
            this.errors = errors.response.data.form_of_ownership;
          },
        )
        .finally(() => {
          this.loading = false;
        });
    },
    passFormOfOwnershipToNewOrganization() {
      this.$emit('blur', this.formOfOwnership);
    },
  },
};
</script>
