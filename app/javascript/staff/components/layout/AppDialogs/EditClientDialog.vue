<template lang='pug'>
  q-dialog(value @hide='$router.go(-1)')
    q-card.dialog-card
      q-card-section
        formEditClient(:id='id')
</template>

<script>
import formEditClient from '../AppPage/AppForms/EditClient/FormEditClient.vue';

export default {
  components: {
    formEditClient,
  },
  props: {
    id: { type: String, default: '' },
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
