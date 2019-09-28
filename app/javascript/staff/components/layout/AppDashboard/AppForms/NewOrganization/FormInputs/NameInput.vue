<template lang='pug'>
  #name
    q-select(
      label='Название'
      v-model='name'
      dense
      color='secondary'
      use-input
      hide-selected
      fill-input
      hide-dropdown-icon
      new-value-mode="add"
      input-debounce="0"
      :loading='loading'
      :error="!isValid"
      :options="options"
      @blur='validateInputValue'
      @filter="filterFn"
      @popup-show='togglePopupShowing'
      @popup-hide='togglePopupShowing'
      v-bind:class='{pb330: popupShowing}'
    )
      template(v-slot:option="scope")
        q-item(v-bind="scope.itemProps" v-on="scope.itemEvents" dense)
          q-item-section(@mouseover='mouseoverSelected(scope.index)') {{scope.opt}}
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
      name: '',
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
  mounted() {
    eventBus.$on('createOrganization', () => {
      this.name = '';
    });
  },
  methods: {
    mouseoverSelected(index) {
      eventBus.$emit('mouseoverSelected', this.suggestions[index]);
    },
    togglePopupShowing() {
      this.popupShowing = !this.popupShowing;
    },
    fetchSuggestions(val) {
      this.loading = true;
      this.$api.organizations
        .suggestions({ name: val })
        .then(
          (response) => {
            this.suggestions = response.data;
            this.options = response.data.map((suggestion) => suggestion.name);
          },
        )
        .finally(
          () => {
            this.loading = false;
          },
        );
    },
    filterFn(val, update) {
      setTimeout(
        update(
          () => {
            if (val === '') {
              this.options = [];
            } else {
              this.fetchSuggestions(val);
            }
          },
        ), 1500,
      );
    },
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
        .finally(() => {
          this.loading = false;
        });
    },
    passNameToNewOrganization() {
      this.$emit('blur', this.name);
    },
  },
};
</script>

<style scoped lang="scss">
.pb330 {
  padding-bottom: 330px;
}
</style>
