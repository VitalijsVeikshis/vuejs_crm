<template lang='pug'>
  tr
    td {{client.attributes.fullname}}
    td {{client.attributes.phone}}
    td {{client.attributes.email}}
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
