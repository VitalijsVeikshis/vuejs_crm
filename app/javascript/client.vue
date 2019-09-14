<template lang='pug'>
  #client
    p {{ message }}
</template>

<script>
export default {
  data() {
    return {
      message: 'Hello Client!',
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
