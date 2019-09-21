<template lang='pug'>
  .invalid-feedback.d-block
    slot
</template>

<script>
export default {
  props:
  {
    errors: {
      type: Array,
      default: () => [],
    },
  },
};
</script>

<style scoped lang="scss">
</style>
