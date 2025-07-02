import { createApp } from 'vue';
import Area from '@components/Samples/Area.vue'
import "@css/samples/index.css";

console.log('sample/index');

const app = createApp({});
// サンプルエリア(親コンポーネント)
app.component('sample-area', Area);
app.mount('#app-vue');