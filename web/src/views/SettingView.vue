<script setup>
import { ref, onMounted } from 'vue'
import { inject } from 'vue'
import { QuranStore } from "@/store/index.js";

const apiClient = inject('apiClient');
const dbClient = inject('dbClient');
const storageClient = inject('storageClient');

const setting = ref({});
const qurans = ref([]);

onMounted(async () => {
  setting.value = storageClient.getSetting();
  await dbClient.open()
  qurans.value = await new QuranStore(dbClient, apiClient).getAll()
});

const save = () => {
  storageClient.setSetting(setting.value);
}
</script>

<template>
  <select v-model="setting.selectedQuran1" @change="save">
    <option v-for="quran in qurans" :key="quran.id" :value="quran.id">{{ quran.language }} : {{ quran.name }}</option>
  </select>
  <br />
  <select v-model="setting.selectedQuran2" @change="save">
    <option v-for="quran in qurans" :key="quran.id" :value="quran.id">{{ quran.language }} : {{ quran.name }}</option>
  </select>
  <br />
  <select v-model="setting.paging" @change="save">
    <option value="page">Page</option>
    <option value="surah">Surah</option>
    <option value="ruku">Ruku</option>
    <option value="hizb">Hizb</option>
    <option value="juz">Juz</option>
    <option value="manzil">Manzil</option>
  </select>
  <br />
</template>

<style scoped></style>
