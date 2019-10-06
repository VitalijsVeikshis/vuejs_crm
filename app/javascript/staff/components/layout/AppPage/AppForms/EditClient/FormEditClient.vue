<template lang='pug'>
  q-form(@submit.prevent='updateClient').full-width
    .row.justify-center
      .col.q-gutter-md
        fullnameInput(
          v-bind:inputErrors="errors.fullname"
          v-model='user.fullname'
          @blur='setFullname'
        )
        phoneInput(
          v-bind:inputErrors="errors.phone"
          v-model='user.phone'
          @blur='setPhone'
        )
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
import fullnameInput from './FormInputs/FullnameInput.vue';
import phoneInput from './FormInputs/PhoneInput.vue';
import emailInput from './FormInputs/EmailInput.vue';
import eventBus from '../../../../../utils/EventBus';

export default {
  components: {
    fullnameInput,
    phoneInput,
    emailInput,
  },
  props: {
    id: { type: String, default: '' },
  },
  data() {
    return {
      user: {
        fullname: '',
        phone: '',
        email: '',
      },
      errors: [],
    };
  },
  watch: {
    fullname() {
      this.user.fullname = this.fullname;
    },
    phone() {
      this.user.phone = this.phone;
    },
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
      this.$api.clients
        .edit(this.id)
        .then(
          (response) => {
            this.user = {
              fullname: response.data.data.attributes.fullname,
              phone: response.data.data.attributes.phone,
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
    updateClient() {
      this.$q.loading.show();
      this.$api.clients
        .update(
          this.id,
          { fullname: this.user.fullname, phone: this.user.phone, email: this.user.email },
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
    setFullname(value) {
      this.user.fullname = value;
    },
    setPhone(value) {
      this.user.phone = value;
    },
  },
};
</script>

<style scoped lang="scss">
</style>
