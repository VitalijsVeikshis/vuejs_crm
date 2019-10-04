<template lang='pug'>
  #name
    q-select(
      label='Название'
      v-model='organization'
      dense
      color='secondary'
      use-input
      hide-selected
      fill-input
      hide-dropdown-icon
      input-debounce="0"
      :loading='loading'
      :error="!isValid"
      :options="options"
      @blur='validateInputValue'
      @filter="filterFn"
      @popup-show='togglePopupShowing'
      @popup-hide='togglePopupShowing'
      v-bind:class='{pb330: popupShowing}'
      emit-value
      map-options
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
      organization: '',
      errors: [],
      options: [],
      suggestions: [],
      popupShowing: false,
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
      this.name = this.value;
    },
  },
  methods: {
    mouseoverSelected(index) {
      eventBus.$emit('mouseoverSelected', this.suggestions[index]);
    },
    togglePopupShowing() {
      this.popupShowing = !this.popupShowing;
    },
    fetchSuggestions() {
      this.loading = true;
      this.$api.organizations
        .index()
        .then((response) => {
          this.suggestions = this.parseSuggestions(response.data.data);
        })
        .finally(
          () => {
            this.loading = false;
          },
        );
    },
    parseSuggestions(suggestions) {
      return suggestions.map(
        (suggestion) => ({
          label: suggestion.attributes.name,
          value: suggestion.attributes.id,
        }),
      );
    },
    filterFn(val, update) {
      setTimeout(
        update(
          () => {
            if (val === '') {
              this.options = [];
            } else {
              this.fetchSuggestions();
              this.options = this.filteredSuggestions(val);

              const emptyOptions = new Array(10 - this.options.length).fill('');
              this.options = [...this.options, ...emptyOptions];
            }
          },
        ), 1500,
      );
    },
    filteredSuggestions(val) {
      const needle = val.toLowerCase();
      return this.suggestions.filter((v) => v.label.toLowerCase().indexOf(needle) > -1);
    },
    validateInputValue() {
      this.errors = [];
      if (this.frontEndValidation()) {
        this.passNameToNewOrganization();
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
      return this.organization.length !== 0;
    },
    passNameToNewOrganization() {
      this.$emit('blur', this.organization);
    },
  },
};
</script>

<style scoped lang="scss">
.pb330 {
  padding-bottom: 330px;
}
</style>
