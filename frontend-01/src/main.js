import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import 'flowbite';
import store from './store';


import './assets/tailwind.css'

const app = createApp(App).use(router).use(store).mount('#app')

// app.mount('#app')
