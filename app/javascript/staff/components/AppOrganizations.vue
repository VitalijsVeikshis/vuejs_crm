<template lang='pug'>
  #dashboard.q-gutter-md
    formNewOrganization
    tableOrganizations
</template>

<script>
import formNewOrganization from './layout/AppPage/AppForms/NewOrganization/FormNewOrganization.vue';
import tableOrganizations from './layout/AppPage/AppTables/TableOrganizations.vue';

export default {
  components: {
    formNewOrganization,
    tableOrganizations,
  },
  data() {
    return {
    };
  },
};
</script>
