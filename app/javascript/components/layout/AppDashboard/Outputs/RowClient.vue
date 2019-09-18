<template lang='pug'>
  tr
    td {{client.fullname}}
    td {{client.phone}}
    td {{client.email}}
</template>

<script>

export default {
  props: {
    client: {
      type: Object,
      default: () => [],
    },
  },
  data() {
    return {
    };
  },
};
</script>

<style scoped lang="scss">
label {
  color: #34495e;
}
</style>
