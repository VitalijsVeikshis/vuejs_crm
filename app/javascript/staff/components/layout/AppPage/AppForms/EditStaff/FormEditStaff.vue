<template lang='pug'>
  q-form(@submit.prevent='updateStaff').full-width
    .row.justify-center
      .col.q-gutter-md
        emailInput(
          v-bind:inputErrors="errors.email"
          v-model='user.email'
          @blur='setEmail'
        )
    .row.justify-center
      q-btn(
        label="Обновить"
        type="submit"
      )#addClientBtn
</template>

<script>
import emailInput from './FormInputs/EmailInput.vue';
import eventBus from '../../../../../utils/EventBus';

export default {
  components: {
    emailInput,
  },
  props: {
    id: { type: String, default: '' },
  },
  data() {
    return {
      user: {
        email: '',
      },
      errors: [],
    };
  },
  watch: {
    email() {
      this.user.email = this.email;
    },
  },
  created() {
    this.onRequest();
  },
  methods: {
    onRequest() {
      this.$q.loading.show();
      this.$api.staffs
        .edit(this.id)
        .then(
          (response) => {
            this.user = {
              email: response.data.data.attributes.email,
            };
          },
          (errors) => {
            this.errors = errors.response.data;
          },
        )
        .finally(() => {
          this.$q.loading.hide();
        });
    },
    updateStaff() {
      this.$q.loading.show();
      this.$api.staffs
        .update(
          this.id,
          { email: this.user.email },
        )
        .then(
          () => {
            this.user = {};
            this.errors = [];
            eventBus.$emit('dialogHide');
            this.$router.go(-1);
          },
          (errors) => {
            this.errors = errors.response.data;
          },
        )
        .finally(() => {
          this.$q.loading.hide();
        });
    },
    setEmail(value) {
      this.user.email = value;
    },
  },
};
</script>

<style scoped lang="scss">
</style>
