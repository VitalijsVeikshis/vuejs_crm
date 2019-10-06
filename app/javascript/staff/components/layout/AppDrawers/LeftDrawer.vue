<template lang='pug'>
  q-drawer(
    show-if-above
    :mini="miniState"
    :width="200"
    :breakpoint="500"
    bordered
    content-class="bg-grey-3"
  )
    q-scroll-area.fit
      q-list(padding).text-secondary
        q-item
          q-item-section(v-if='miniState' avatar)
            q-btn(
              dense
              round
              unelevated
              icon="fas fa-caret-right"
              @click="miniState = false"
            )
          q-item-section
            .row.justify-end
              .col-2
                q-btn(
                  dense
                  round
                  unelevated
                  icon="fas fa-caret-left"
                  @click="miniState = true"
                )
        q-item(clickable :to="{ name: 'clients' }")
          q-item-section(avatar)
            q-icon(name='fas fa-user')
          q-item-section
            strong Клиенты
        q-item(clickable :to="{ name: 'organizations' }")
          q-item-section(avatar)
            q-icon(name='fas fa-building')
          q-item-section
            strong Организации
        q-item(clickable :to="{ name: 'staffs' }")
          q-item-section(avatar)
            q-icon(name='fas fa-user-tie')
          q-item-section
            strong Сотрудники
</template>

<script>

export default {
  data() {
    return {
      miniState: false,
    };
  },
  methods: {
    clickMenu(value) {
      this.activeMenu = {};
      this.activeMenu[value.value] = true;
    },
  },
};
</script>
