<template lang='pug'>
  q-form(@submit.prevent='createEquipment').full-width
    .row.justify-center
      .col.q-gutter-md
        titleInput(
          v-bind:inputErrors="errors.title"
          v-model='equipment.title'
          @blur='setTitle'
        )
        kindInput(
          v-bind:inputErrors="errors.kind"
          v-model='equipment.kind'
          @blur='setKind'
        )
        snInput(
          v-bind:inputErrors="errors.sn"
          v-model='equipment.sn'
          @blur='setSN'
        )
    .row.justify-center
      q-btn(
        label="Добавить"
        type="submit"
      )
</template>

<script>
import titleInput from './FormInputs/TitleInput.vue';
import kindInput from './FormInputs/KindInput.vue';
import snInput from './FormInputs/SNInput.vue';
import eventBus from '../../../../../utils/EventBus';

export default {
  components: {
    titleInput,
    kindInput,
    snInput,
  },
  data() {
    return {
      id: this.$route.params.id,
      equipment: {
        title: '',
        kind: '',
        sn: '',
      },
      errors: [],
    };
  },
  methods: {
    createEquipment() {
      this.$q.loading.show();
      this.$api.equipments
        .create(
          this.$route.params.id,
          { title: this.equipment.title, kind: this.equipment.kind, sn: this.equipment.sn },
        )
        .then(
          () => {
            this.equipment = {};
            this.errors = [];
            this.handleCreateEquipment();
            this.$router.go(-1);
          },
          (errors) => {
            this.errors = errors.response.data;
          },
        )
        .finally(() => {
          this.$q.loading.hide();
        });
    },
    setTitle(value) {
      this.equipment.title = value;
    },
    setKind(value) {
      this.equipment.kind = value;
    },
    setSN(value) {
      this.equipment.sn = value;
    },
    handleCreateEquipment() {
      eventBus.$emit('createEquipment');
    },
  },
};
</script>
