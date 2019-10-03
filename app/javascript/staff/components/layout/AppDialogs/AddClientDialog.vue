<template lang='pug'>
  q-dialog(value @hide='$router.go(-1)')
    q-card.dialog-card
      q-card-section
        formNewClient
</template>

<script>
import formNewClient from '../AppPage/AppForms/NewClient/FormNewClient.vue';

export default {
  components: {
    formNewClient,
  },
  data() {
    return {
    };
  },
};
</script>

<style lang="scss" scoped>
.dialog-card {
  width: 100%;
  max-width: 600px;
}
</style>
