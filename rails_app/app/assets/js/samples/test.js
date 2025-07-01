import { createApp } from 'vue'
import Message from '../components/Samples/Test.vue'
console.log('samples.test');
const app = createApp({})
app.component('sample-message', Message)
app.mount('#app-vue')