<template lang='pug'>
  #dashboard.q-gutter-md
    formNewStaff
    tableStaffs
</template>

<script>
import formNewStaff from './layout/AppPage/AppForms/NewStaff/FormNewStaff.vue';
import tableStaffs from './layout/AppPage/AppTables/TableStaffs.vue';

export default {
  components: {
    formNewStaff,
    tableStaffs,
  },
  data() {
    return {
    };
  },
};
</script>
