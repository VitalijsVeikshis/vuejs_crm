<template lang='pug'>
  #dashboard.q-gutter-md
    formNewClient
    tableClients
</template>

<script>
import formNewClient from './layout/AppPage/AppForms/NewClient/FormNewClient.vue';
import tableClients from './layout/AppPage/AppTables/TableClients.vue';

export default {
  components: {
    formNewClient,
    tableClients,
  },
  data() {
    return {
    };
  },
};
</script>
