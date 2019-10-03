<template lang='pug'>
  q-form(@submit.prevent='createStaff').full-width
    .row.justify-center
      .col.q-gutter-md
        emailInput(
          v-bind:inputErrors="errors.email"
          v-model='user.email'
          @blur='setEmail'
        )
    .row.justify-center
      q-btn(
        label="Добавить"
        type="submit"
      )#addStaffBtn
</template>

<script>
import emailInput from './FormInputs/EmailInput.vue';
import eventBus from '../../../../../utils/EventBus';

export default {
  components: {
    emailInput,
  },
  data() {
    return {
      user: {
        email: '',
      },
      errors: [],
    };
  },
  methods: {
    createStaff() {
      this.$q.loading.show();
      this.$api.staffs
        .create({ email: this.user.email })
        .then(
          () => {
            this.user = {};
            this.errors = [];
            this.handleCreateStaff();
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
    handleCreateStaff() {
      eventBus.$emit('createStaff');
    },
  },
};
</script>

<style scoped lang="scss">
</style>
