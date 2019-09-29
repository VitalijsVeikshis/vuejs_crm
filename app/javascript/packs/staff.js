import Vue from 'vue';

import iconSet from 'quasar/icon-set/fontawesome-v5';
import '@quasar/extras/fontawesome-v5/fontawesome-v5.css';

import '../shared/assets/styles/quasar.styl';
import 'quasar/dist/quasar.ie.polyfills';

import {
  Quasar,
  QLayout,
  QHeader,
  QDrawer,
  QPageContainer,
  QPage,
  QToolbar,
  QToolbarTitle,
  QAvatar,
  QSpace,
  QBtn,
  QChip,
  QTable,
  QTh,
  QTr,
  QTd,
  QForm,
  QInput,
  QCard,
  QSpinner,
  QSpinnerTail,
  Loading,
  QSelect,
  QList,
  QItem,
  QItemSection,
  QItemLabel,
  QIcon,
  QScrollArea,
} from 'quasar';

import '../shared/utils/filters';
import api from '../staff/backend/api';
import Staff from '../staff/staff.vue';

require('../staff/channels');

Vue.use(Quasar, {
  config: {
    loading: {
      spinner: QSpinnerTail,
    },
  },
  components: {
    QLayout,
    QHeader,
    QDrawer,
    QPageContainer,
    QPage,
    QToolbar,
    QToolbarTitle,
    QAvatar,
    QSpace,
    QBtn,
    QChip,
    QTable,
    QTh,
    QTr,
    QTd,
    QForm,
    QInput,
    QCard,
    QSpinner,
    QSpinnerTail,
    QSelect,
    QList,
    QItem,
    QItemSection,
    QItemLabel,
    QIcon,
    QScrollArea,
  },
  directives: {
  },
  iconSet,
  plugins: {
    Loading,
  },
});

Vue.prototype.$api = api;

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: (h) => h(Staff),
  }).$mount();
  document.body.appendChild(app.$el);
});
