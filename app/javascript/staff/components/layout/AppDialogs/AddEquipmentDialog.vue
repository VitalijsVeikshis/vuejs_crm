<template lang='pug'>
  q-dialog(value @hide='$router.go(-1)')
    q-card.dialog-card
      q-card-section
        formNewEquipment
</template>

<script>
import formNewEquipment from '../AppPage/AppForms/NewEquipment/FormNewEquipment.vue';

export default {
  components: {
    formNewEquipment,
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
