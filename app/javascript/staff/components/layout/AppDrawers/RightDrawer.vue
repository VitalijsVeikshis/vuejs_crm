<template lang='pug'>
  q-drawer(
    side='right'
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
              icon="fas fa-caret-left"
              @click="miniState = false"
            )
          q-item-section(avatar)
            q-btn(
              dense
              round
              unelevated
              icon="fas fa-caret-right"
              @click="miniState = true"
            )
          q-item-section(side) Сообщения
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
