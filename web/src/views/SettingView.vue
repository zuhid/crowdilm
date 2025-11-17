<script setup>
import { ref, onMounted } from 'vue'
import * as list from "@/services/list.js";

const selectedQuran1 = ref("simple");
const selectedQuran2 = ref("en.sahih");
const paging = ref("page");
const qurans = ref([]);

onMounted(async () => {
  const setting = JSON.parse(localStorage.getItem("setting"));
  if (setting) {
    selectedQuran1.value = setting.quran1;
    selectedQuran2.value = setting.quran2;
    paging.value = setting.paging;
  }
  qurans.value = await list.quran();
});

const save = () => {
  localStorage.setItem("setting", JSON.stringify({
    quran1: selectedQuran1.value,
    quran2: selectedQuran2.value,
    paging: paging.value
  }));
}

</script>
<template>

  <select v-model="selectedQuran1" @change="save">
    <option v-for="quran in qurans" :key="quran.id" :value="quran.id">{{ quran.language }} : {{ quran.name }}</option>
  </select>
  <br />
  <select v-model="selectedQuran2" @change="save">
    <option v-for="quran in qurans" :key="quran.id" :value="quran.id">{{ quran.language }} : {{ quran.name }}</option>
  </select>
  <br />
  <select v-model="paging" @change="save">
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
