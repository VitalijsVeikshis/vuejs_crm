<template lang='pug'>
  q-form(@submit.prevent='createInteraction')#newOrganization.full-width
    .row.justify-center
      .col.q-gutter-md
        nameInput(
          v-bind:inputErrors="errors.name"
          @blur='setOrganization'
        )
        .row.justify-center
          q-btn(
            label="Связать"
            type="submit"
          )#addOrganizationBtn
</template>

<script>
import nameInput from './FormInputs/NameInput.vue';

export default {
  components: {
    nameInput,
  },
  props: {
    value: { type: Array, default: () => [] },
  },
  data() {
    return {
      interaction: {
        organization: '',
      },
      errors: [],
    };
  },
  methods: {
    createInteraction() {
      this.$q.loading.show();
      this.value.forEach(
        (client) => {
          this.$api.interactions
            .create(
              {
                client_id: client.id,
                organization_id: this.interaction.organization,
              },
            )
            .then(
              () => {
                this.interaction = {
                  organization: '',
                };
                this.errors = [];
                this.$router.push({ name: 'clients' });
              },
              (errors) => {
                this.errors = errors.response.data;
              },
            )
            .finally(() => {
              this.$q.loading.hide();
            });
        },
      );
    },
    setOrganization(value) {
      this.interaction.organization = value;
    },
  },
};
</script>
