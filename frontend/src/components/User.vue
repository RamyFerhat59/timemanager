<script>
import { ref } from 'vue'
export default {
  setup () {
    return {
      text: ref('')
    }
  },
  data() {
    return {
      form: {
        name: '',
        email: ''
      },
      user: {
        name: '',
        email: ''
      }
    }
  },
  methods: {
    checkUser() {
      fetch('http://localhost:4000/api/users', {
        mode: 'cors',
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
        }
      })
      .then(response => response.json())
      .then(data => {
        console.log(data)
        // if (data.name === null) {
        //   createUser()
        // } else {
        //   getUser()
        // }
      })
    },
    getUser() {
      fetch('http://localhost:4000/api/users', {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
        }
      })
      .then(response => response.json())
      .then(data => {
        this.user.name = data.name
        this.user.email = data.email
      })
    },
    createUser() {
      fetch('http://localhost:4000/api/users', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({
          user: {
            name: this.user.name,
            email: this.user.email
          }
        })
      })
      .then(response => response.json())
      .then(data => {
        this.user.name = data.name
        this.user.email = data.email
      })
    }
  }
}
</script>

<template>
  <div class="profile">
    <h1>Log in:</h1>
  </div>
  <div class="login">
    <span><input v-model="form.name" placeholder="Username" /></span>
    <span><input v-model="form.email" placeholder="Email" /></span>
    <q-input outlined v-model="text" label="Outlined" />
    <span><button v-on:click="checkUser">Log in</button></span>
  </div>
</template>

<style scoped>
.profile {
  display: flex;
  flex-direction: row;
  justify-content: space-between
}

.login {
  display: flex;
  flex-direction: column;
  gap: 5px
}
</style>
