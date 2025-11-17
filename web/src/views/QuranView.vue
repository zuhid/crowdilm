<script setup>
import { ref, reactive, onMounted } from 'vue'
import * as list from "@/services/list.js";

const setting = ref({
  selectedQuran1: "simple",
  selectedQuran2: "en.sahih",
  paging: "page"
});
const lines = ref([]);
const pageNumber = ref(1);

const quranLineIds = ref([]);
const quranlines1 = ref([]);
const quranlines2 = ref([]);

onMounted(async () => {
  var settingStorage = JSON.parse(localStorage.getItem("setting"));
  if (settingStorage) {
    setting.value.selectedQuran1 = settingStorage.quran1;
    setting.value.selectedQuran2 = settingStorage.quran2;
    setting.value.paging = settingStorage.paging;
  }
  lines.value = await list.line();
});

async function displayPage() {
  quranLineIds.value = new Set(lines.value.filter(item => item.page == pageNumber.value).map(x => x.id));

  var allQuranLines1 = await list.quranline(setting.value.selectedQuran1);
  quranlines1.value = allQuranLines1.filter(item => quranLineIds.value.has(item.line_id));

  var allQuranLines2 = await list.quranline(setting.value.selectedQuran2);
  quranlines2.value = allQuranLines2.filter(item => quranLineIds.value.has(item.line_id));

  // if (setting.value.paging === "page") {
  //   quranlines.value = lines.value.filter(item => item.page_number == pageNumber.value);
  // } else if (setting.value.paging === "surah") {
  //   quranlines.value = lines.value.filter(item => item.sura_number == pageNumber.value);
  // } else if (setting.value.paging === "ruku") {
  //   quranlines.value = lines.value.filter(item => item.ruku_number == pageNumber.value);
  // } else if (setting.value.paging === "hizb") {
  //   quranlines.value = lines.value.filter(item => item.hizb_number == pageNumber.value);
  // } else if (setting.value.paging === "juz") {
  //   quranlines.value = lines.value.filter(item => item.juz_number == pageNumber.value);
  // } else if (setting.value.paging === "manzil") {
  //   quranlines.value = lines.value.filter(item => item.manzil_number == pageNumber.value);
  // }
}

</script>
<template>
  <p><input v-model="pageNumber" type="number" min="1" max="604" @change="displayPage" /></p>
  <div id="divQuran">
    <div style="ayah" v-for="item in quranLineIds" :key="item.line_id">
      <span>{{quranlines1.filter(line => line.line_id === item)[0].text}}</span>
      <span>{{quranlines2.filter(line => line.line_id === item)[0].text}}</span>
      <span>{{lines.filter(line => line.id === item)[0].surah}}.{{lines.filter(line => line.id === item)[0].aya}}</span>
    </div>

    <!-- 
    <div style="ayah" v-for="item in quranlines1" :key="item.line_id">
      <span v-html="item.text"></span>
      <span>{{ item.line_id }} .w </span>
    </div>
    <div style="ayah" v-for="item in quranlines2" :key="item.line_id">
      <span v-html="item.text"></span>
      <span>{{ item.line_id }} .s </span>
    </div> -->
  </div>
</template>

<style scoped>
#divQuran {
  background-color: #222222;
}

#divQuran>div {
  display: flex;
  flex-direction: column;
  margin: 5px 0px;
  padding: 5px;
  border-radius: 15px;
  background-color: black;
}
</style>
