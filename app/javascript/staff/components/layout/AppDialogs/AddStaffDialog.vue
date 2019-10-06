<template lang='pug'>
  q-dialog(value @hide='$router.go(-1)')
    q-card.dialog-card
      q-card-section
        formNewStaff
</template>

<script>
import formNewStaff from '../AppPage/AppForms/NewStaff/FormNewStaff.vue';

export default {
  components: {
    formNewStaff,
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
