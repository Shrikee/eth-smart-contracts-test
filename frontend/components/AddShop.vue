<template>
  <v-flex>
    <v-text-field v-model="name" label="Shop name"></v-text-field>
    <v-btn color="success" dark large @click="createShop">Add shop</v-btn>
    <v-flex>Shop name: {{ name }}</v-flex>
    <v-flex>latitude: {{ latitude }}</v-flex>
    <v-flex>longitude: {{ longitude }}</v-flex>
  </v-flex>
</template>

<script>
import Web3 from 'web3'
const shopsContract = require('../../build/contracts/Shops.json')
export default {
  data: () => ({
    name: '',
    longitude: '',
    latitude: '',
    createdTime: ''
  }),
  mounted() {
    this.getLocation()
  },
  methods: {
    getLocation() {
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition((position) => {
          this.latitude = position.coords.latitude.toString()
          this.longitude = position.coords.longitude.toString()
        })
      }
    },
    async createShop() {
      const web3 = new Web3(Web3.givenProvider)
      const contract = new web3.eth.Contract(
        shopsContract.abi,
        process.env.CONTRACT_ADDRESS
        // ''
      )
      this.createdTime = new Date().toString()
      await contract.methods
        .createShop(this.name, this.latitude, this.longitude, this.createdTime)
        .send({
          from: process.env.SENDER_ADDRESS
          // ''
        })
    }
  }
}
</script>
