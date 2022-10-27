<script>
export default {
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
    }
  }
}

function getUser() {
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
}

function createUser() {
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

</script>

<template>
  <div class="profile">
    <h1>Log in:</h1>
  </div>
  <div class="login">
    <span><input v-model="form.name" placeholder="Username" /></span>
    <span><input v-model="form.email" placeholder="Email" /></span>
    <span><button v-on:click="checkUser">Log in</button></span>
  </div>
</template>