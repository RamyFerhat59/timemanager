<script setup>
import User from './components/User.vue'
import WorkingTimes from './components/WorkingTimes.vue'
import { ref } from 'vue'

var items = ref(1)
</script>
<template>
  <div class="main">
    <div class="left">
      <div class="title"><h2>Time Manager</h2></div>
      <v-divider color="grey"></v-divider>
      <div class="list">
        <v-list
          density="compact"
          nav
          bg-color="#0a0a0a"
          active-color="#fff"
        >
          <v-list-item prepend-icon="mdi-view-dashboard" title="Dashboard" value='dash' class="text-white" v-on:click="items = 0" active="" v-if="items == 0"></v-list-item>
          <v-list-item prepend-icon="mdi-user" title="Account" value='acc' class="text-white" v-on:click="items = 1" v-if="items == 0"></v-list-item>
          <v-list-item prepend-icon="mdi-view-dashboard" title="Dashboard" value='dash' class="text-white" v-on:click="items = 0" v-if="items == 1"></v-list-item>
          <v-list-item prepend-icon="mdi-user" title="Account" value='acc' class="text-white" v-on:click="items = 1" active="" v-if="items == 1"></v-list-item>
        </v-list>
      </div>
    </div>
    <div class="right">
      <div class="header">
        <h2>{{ items == 0 ? 'Dashboard' : 'Account' }}</h2>
      </div>
      <div v-if="items == 0">
      </div>
      <div v-else>
        <User/>
      </div>
    </div>
  </div>
</template>
