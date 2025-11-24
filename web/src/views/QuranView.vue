<script setup>
import { ref, onMounted, computed } from 'vue'
import { inject } from 'vue'
import { SuraStore, QuranLineStore } from '@/store';

const apiClient = inject('apiClient');
const dbClient = inject('dbClient');
const storageClient = inject('storageClient');

const setting = ref({});
const currentPage = ref({});
const quranLines = ref([]);
const suras = ref([]);
const pageMax = ref(604);

onMounted(async () => {
  setting.value = storageClient.getSetting();
  currentPage.value = storageClient.getCurrentPage();
  await dbClient.open()
  quranLines.value = await new QuranLineStore(dbClient, apiClient).getByKey(setting.value.paging, currentPage.value)
  suras.value = await new SuraStore(dbClient, apiClient).getAll();
});

async function displayPage() {
  storageClient.setCurrentPage(currentPage.value);
  quranLines.value = await new QuranLineStore(dbClient, apiClient).getByKey(setting.value.paging, currentPage.value)
}

function currentSura(quranLine) {
  let result = suras.value.find(sura => sura.id == quranLine.surah && quranLine.aya == 1)
  return result == null ? '' : `${result.id} ${result.name_arabic} ${result.name_english}`;
};

function showBismillah(quranLine) {
  let result = suras.value.find(sura => sura.id == quranLine.surah && quranLine.aya == 1)
  return (result != null && result.id != 1 && result.id != 9)
}

const sortedItems = computed(() => {
  // Sort by line
  const sorted = quranLines.value.sort((a, b) => a.line - b.line);

  const grouped = sorted.reduce((acc, item) => {
    if (!acc[item.line]) {
      acc[item.line] = []
    }
    acc[item.line].push(item);
    return acc;
  }, {});
  return grouped;
});



</script>
<template>
  <p><input v-model="currentPage" type="number" min="1" :max="pageMax" @change="displayPage" /></p>
  <div style="ayah" v-for="(items, line) in sortedItems" :key="line">
    <h1>{{ currentSura(items[0]) }}</h1>
    <h3 v-if="showBismillah(items[0])">بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ</h3>
    <div style="ayah" v-for="item in items" :key="item.quran_id">
      <span>{{ item.text }}</span><br />
    </div>
    <span class="ayaNumber">({{ items[0].aya }})</span>
    <br /><br />
  </div>
</template>

<style scoped>
.ayaNumber {
  font-size: medium;
}
</style>
