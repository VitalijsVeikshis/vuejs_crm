<template lang='pug'>
  q-form(@submit.prevent='createOrganization')#newOrganization.full-width
    .row.justify-center
      .col.q-gutter-md
        nameInput(
          v-bind:inputErrors="errors.name"
          v-model='organization.name'
          @blur='setName'
        )
        formOfOwnershipInput(
          v-bind:inputErrors="errors.form_of_ownership"
          v-model='organization.formOfOwnership'
          @blur='setFormOfOwnership'
        )
        innInput(
          v-bind:inputErrors="errors.inn"
          v-bind:formOfOwnership='organization.formOfOwnership'
          v-model='organization.inn'
          @blur='setInn'
        )
        ogrnInput(
          v-bind:inputErrors="errors.ogrn"
          v-model='organization.ogrn'
          @blur='setOgrn'
        )
        .row.justify-center
          q-btn(
            label="Добавить"
            type="submit"
          )#addOrganizationBtn
</template>

<script>
import nameInput from './FormInputs/NameInput.vue';
import formOfOwnershipInput from './FormInputs/FormOfOwnershipInput.vue';
import innInput from './FormInputs/InnInput.vue';
import ogrnInput from './FormInputs/OgrnInput.vue';
import eventBus from '../../../../../utils/EventBus';

const emptyOrganization = {
  name: '',
  formOfOwnership: '',
  inn: '',
  ogrn: '',
};

export default {
  components: {
    nameInput,
    formOfOwnershipInput,
    innInput,
    ogrnInput,
  },
  data() {
    return {
      organization: emptyOrganization,
      errors: [],
    };
  },
  created() {
    eventBus.$on('mouseoverSelected', (suggestion) => {
      this.organization.name = suggestion.name;
      this.organization.formOfOwnership = suggestion.form_of_ownership;
      this.organization.inn = suggestion.inn;
      this.organization.ogrn = suggestion.ogrn;
    });
  },
  methods: {
    createOrganization() {
      this.$q.loading.show();
      this.$api.organizations
        .create(
          {
            name: this.organization.name,
            form_of_ownership: this.organization.formOfOwnership,
            inn: this.organization.inn,
            ogrn: this.organization.ogrn,
          },
        )
        .then(
          () => {
            this.organization = emptyOrganization;
            this.errors = [];
            this.handleCreateOrganization();
          },
          (errors) => {
            this.errors = errors.response.data;
          },
        )
        .finally(() => {
          this.$q.loading.hide();
        });
    },
    setName(value) {
      this.organization.name = value;
    },
    setFormOfOwnership(value) {
      this.organization.formOfOwnership = value;
    },
    setInn(value) {
      this.organization.inn = value;
    },
    setOgrn(value) {
      this.organization.ogrn = value;
    },
    handleCreateOrganization() {
      eventBus.$emit('createOrganization');
    },
  },
};
</script>
