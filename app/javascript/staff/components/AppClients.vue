<template lang='pug'>
  #dashboard.q-gutter-md
    tableClients
</template>

<script>
import tableClients from './layout/AppPage/AppTables/TableClients.vue';

export default {
  components: {
    tableClients,
  },
  data() {
    return {
    };
  },
};
</script>
