<script setup>
import { onMounted, inject, ref } from 'vue';
import { RouterLink, RouterView } from 'vue-router'

const apiClient = inject('apiClient');
const dbClient = inject('dbClient');

onMounted(async () => {
  await dbClient.open();
});

</script>

<template>
  <div class="app">
    <header>
      <nav>
        <RouterLink to="/quran">Quran</RouterLink>
        <RouterLink to="/setting">Setting</RouterLink>
      </nav>
    </header>
    <main>
      <RouterView />
    </main>
    <footer>
      <nav>
        <RouterLink to="/quran">Quran</RouterLink>
        <RouterLink to="/setting">Setting</RouterLink>
      </nav>
    </footer>
  </div>

</template>

<style scoped>
.app {
  display: flex;
  flex-direction: column;
  height: 100vh;
}

header,
footer {
  background-color: #111;
  padding: 10px;

  nav>* {
    margin: 0 10px;
  }
}

main {
  flex: 1;
}
</style>
