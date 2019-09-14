<template lang='pug'>
  #staff
    p {{ message }}
</template>

<script>
export default {
  data() {
    return {
      message: 'Hello Staff!',
    };
  },
};
</script>

<style scoped lang="scss">
p {
  font-size: 2em;
  text-align: center;
}
</style>
