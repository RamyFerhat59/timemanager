<template>
  <div class="flex flex-col min-h-screen font-Roboto bg-weather-primary">
    <!-- <SiteNavigation /> -->
    <Login />
    <RouterView />
  </div>
</template>

<script setup>
import { RouterView } from "vue-router";
// import SiteNavigation  from "./components/SiteNavigation.vue";
import Login  from "./components/Login.vue";
</script>
<style lang="scss" scoped></style>
