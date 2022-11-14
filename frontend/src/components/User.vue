<script>
import { ref } from 'vue'
export default {
  data() {
    return {
      log: {
        name: '',
        email: '',
        password: '',
        role: ''
      },
      create: {
        name: '',
        email: '',
        password: ''
      },
      token: '',
      id: ''
    }
  },
  methods: {
    getUser() {
      fetch('http://localhost:4000/api/users?email=' + this.log.email , {
        method: 'GET',
        mode: 'cors',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + this.token,
        }
      })
      .then(response => response.json())
      .then(data => {
        console.log(data)
        this.id = data.data.id
        this.log.name = data.data.username
        this.log.role = data.data.role
      })
    },
    checkUser() {
      fetch('http://localhost:4000/api/sessions/new', {
        mode: 'cors',
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          email: this.log.email,
          password: this.log.password,
        })
      })
      .then(response => response.json())
      .then(data => {
        console.log(data.access_token)
        this.token = data.access_token;
        this.getUser()
      })
    },
    createUser() {
      fetch('http://localhost:4000/api/users', {
        mode: 'cors',
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({
          user: {
            username: this.create.name,
            email: this.create.email,
            password: this.create.password,
          }
        })
      })
      .then(response => response.json())
      .then(data => {
        console.log(data)
        this.log.email = this.create.email
        this.log.password = this.create.password
        this.checkUser()
      })
    },
    updateUser() {
      fetch('http://localhost:4000/api/users/' + this.id, {
        mode: 'cors',
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + this.token,
        },
        body: JSON.stringify({
          user: {
            username: this.log.name,
            email: this.log.email,
          }
        })
      })
      .then(response => response.json())
      .then(data => {
        console.log(data)
      })
    },
    deleteUser() {
      fetch('http://localhost:4000/api/users/' + this.id, {
        mode: 'cors',
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + this.token,
        },
      })
      .then(response => response.json())
      .then(data => {
        console.log(data)
      })
      this.token = '';
      this.log.name = ''
      this.log.email = ''
      this.log.password = ''
      this.create.name = ''
      this.create.email = ''
      this.create.password = ''
    }
  }
}
</script>

<template>
  <div class="user" v-if="token == ''">
    <div>
      <h2>Log in</h2><br/>
      <v-form>
        <v-text-field
          v-model="log.email"
          label="Email"
          outlined
          dense
        ></v-text-field>
        <v-text-field
          v-model="log.password"
          label="Password"
          outlined
          type="password"
          dense
        ></v-text-field>
        <v-btn
          class="mr-4"
          variant="outlined"
          v-on:click="checkUser"
        >
          Log in
        </v-btn>
      </v-form>
    </div>
    <div>
      <h2>Create Account</h2><br/>
      <v-form>
        <v-text-field
          v-model="create.name"
          label="Username"
          outlined
          dense
        ></v-text-field>
        <v-text-field
          v-model="create.email"
          label="Email"
          outlined
          dense
        ></v-text-field>
        <v-text-field
          v-model="create.password"
          label="Password"
          type="password"
          outlined
          dense
        ></v-text-field>
        <v-btn
          class="mr-4"
          variant="outlined"
          v-on:click="createUser"
        >
          Create
        </v-btn>
      </v-form>
    </div>
  </div>
  <div class="logged" v-else>
    <br/>
    Welcome {{log.name}}, your role is {{log.role}}.
    <br/>
    <h2>Update or delete your account</h2><br/>
    <v-form>
      <v-text-field
        v-model="log.email"
        label="Email"
        outlined
        dense
      ></v-text-field>
      <v-text-field
        v-model="log.name"
        label="Username"
        outlined
        dense
      ></v-text-field>
      <v-btn
        class="mr-4"
        variant="outlined"
        v-on:click="updateUser"
      >
        Update
      </v-btn>
      <v-btn
        class="mr-4"
        variant="outlined"
        color="error"
        v-on:click="deleteUser"
      >
        Delete
      </v-btn>
    </v-form>
  </div>
</template>

<style scoped>
.profile {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
}

.login {
  display: flex;
  flex-direction: column;
  gap: 5px
}
</style>
