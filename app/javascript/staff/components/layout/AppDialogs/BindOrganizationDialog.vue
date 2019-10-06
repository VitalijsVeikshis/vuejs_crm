<template lang='pug'>
  q-dialog(value @hide='$router.go(-1)')
    q-card.dialog-card
      q-card-section
        formBindOrganization(v-model='selected')
</template>

<script>
import formBindOrganization from '../AppPage/AppForms/BindOrganization/FormBindOrganization.vue';

export default {
  components: {
    formBindOrganization,
  },
  props: {
    id: { type: String, default: '' },
    selected: { type: Array, default: () => [] },
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
