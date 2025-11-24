import './assets/main.css'
import { createApp } from 'vue'
import App from '@/App.vue'
import router from '@/router'
import { apiClient, dbClient, storageClient } from '@/lib'

const app = createApp(App)

app.use(router)
app.provide('apiClient', apiClient)
app.provide('dbClient', dbClient)
app.provide('storageClient', storageClient)
app.mount('#app')
