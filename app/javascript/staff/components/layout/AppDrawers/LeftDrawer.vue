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
      q-list(padding)
        q-item
          q-item-section(v-if='miniState' avatar)
            q-btn(
              dense
              round
              unelevated
              icon="fas fa-caret-right"
              @click="miniState = false"
            ).secondary
          q-item-section
            .row.justify-end
              .col-2
                q-btn(
                  dense
                  round
                  unelevated
                  icon="fas fa-caret-left"
                  @click="miniState = true"
                ).secondary
        q-item(clickable)
          q-item-section(avatar)
            q-icon(name='fas fa-user' color='secondary')
          q-item-section
            strong.secondary Клиенты
        q-item(clickable)
          q-item-section(avatar)
            q-icon(name='fas fa-building' color='secondary')
          q-item-section
            strong.secondary Организации
        q-item(clickable)
          q-item-section(avatar)
            q-icon(name='fas fa-user-tie' color='secondary')
          q-item-section
            strong.secondary Сотрудники
</template>

<script>

export default {
  data() {
    return {
      miniState: false,
    };
  },
};
</script>

<style scoped lang="scss">
.secondary {
  color: #273849;
}
</style>
