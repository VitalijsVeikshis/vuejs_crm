<template lang='pug'>
  q-dialog(value @hide='$router.go(-1)')
    q-card.dialog-card
      q-card-section
        formEditStaff(:id='id')
</template>

<script>
import formEditStaff from '../AppPage/AppForms/EditStaff/FormEditStaff.vue';

export default {
  components: {
    formEditStaff,
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
