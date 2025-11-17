<template>
  <div class="navbar">
    <svg
      id="btnSetting"
      @click="btnSettingClick"
      viewBox="0 0 512 512"
      width="24"
      height="24"
      fill="silver"
    >
      <path
        d="M487.4 315.7l-42.6-24.6c4.3-23.2 4.3-47 0-70.2l42.6-24.6c4.9-2.8 7.1-8.6 5.5-14-11.1-35.6-30-67.8-54.7-94.6-3.8-4.1-10-5.1-14.8-2.3L380.8 110c-17.9-15.4-38.5-27.3-60.8-35.1V25.8c0-5.6-3.9-10.5-9.4-11.7-36.7-8.2-74.3-7.8-109.2 0-5.5 1.2-9.4 6.1-9.4 11.7V75c-22.2 7.9-42.8 19.8-60.8 35.1L88.7 85.5c-4.9-2.8-11-1.9-14.8 2.3-24.7 26.7-43.6 58.9-54.7 94.6-1.7 5.4.6 11.2 5.5 14L67.3 221c-4.3 23.2-4.3 47 0 70.2l-42.6 24.6c-4.9 2.8-7.1 8.6-5.5 14 11.1 35.6 30 67.8 54.7 94.6 3.8 4.1 10 5.1 14.8 2.3l42.6-24.6c17.9 15.4 38.5 27.3 60.8 35.1v49.2c0 5.6 3.9 10.5 9.4 11.7 36.7 8.2 74.3 7.8 109.2 0 5.5-1.2 9.4-6.1 9.4-11.7v-49.2c22.2-7.9 42.8-19.8 60.8-35.1l42.6 24.6c4.9 2.8 11 1.9 14.8-2.3 24.7-26.7 43.6-58.9 54.7-94.6 1.5-5.5-.7-11.3-5.6-14.1zM256 336c-44.1 0-80-35.9-80-80s35.9-80 80-80 80 35.9 80 80-35.9 80-80 80z"
      ></path>
    </svg>
  </div>
  <div id="divSetting" v-if="display == 'setting'">Settings</div>
  <div id="divQuran" v-if="display == 'quran'">Quran</div>

  <!-- {{ selectedQuran }}
  <select v-model="selectedQuran">
    <option v-for="quran in qurans" :key="quran.id" :value="quran.id">{{ quran.language }} : {{ quran.name }}</option>
  </select>
  <br/>
  {{ selectedSura }}
  <select v-model="selectedSura">
    <option v-for="sura in suras" :key="sura.id" :value="sura.id">{{ sura.id }} : {{ sura.name_english }}</option>
  </select>
  
  <p v-for="(item) in quranlines" :key="item.line_id">
    <span>{{ item.line_id }}</span>
    <span v-html="item.text"></span>
  </p> -->
</template>
<script>
import * as list from "./services/list.js";
export default {
  data() {
    return {
      selectedQuran: "en.sahih",
      selectedSura: "1",
      qurans: [],
      suras: [],
      lines: [],
      quranlines: [],
      display: "quran",
    };
  },

  methods: {
    btnSettingClick() {
      this.display = this.display == "quran" ? "setting" : "quran";
    },
  },

  async mounted() {
    this.qurans = await list.quran();
    this.suras = await list.sura();
    this.lines = await list.line();
    this.quranlines = await list.quranline(this.selectedQuran);
  },
};
</script>
<style>
.navbar {
  background-color: #000000;
  position: -webkit-sticky;
  position: sticky;
  top: 0;
  display: flex;
  flex-direction: row;
  justify-content: center;
  display: flex;
  justify-content: space-between;
  color: white;
}
</style>
