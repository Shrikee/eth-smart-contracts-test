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
import shopsContract from '~/static/Shops.json'
export default {
  data: () => ({
    name: '',
    longitude: '',
    latitude: '',
    createdTime: ''
  }),
  mounted() {
    this.getLocation()
    this.getPermission()
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
      console.log(web3)
      const accounts = await web3.eth.getAccounts()
      console.log(accounts)
      const contract = new web3.eth.Contract(
        shopsContract.abi,
        process.env.CONTRACT_ADDRESS
        // ''
      )
      this.createdTime = new Date().toString()
      await contract.methods
        .createShop(this.name, this.latitude, this.longitude, this.createdTime)
        .send({
          from: accounts[0]
          // ''
        })
    },
    getPermission() {
      window.addEventListener('load', async () => {
        // Modern dapp browsers...
        if (window.ethereum) {
          window.web3 = new Web3(ethereum)
          try {
            // Request account access if needed
            await ethereum.enable()
            // Acccounts now exposed
            web3.eth.sendTransaction({
              /* ... */
            })
          } catch (error) {
            // User denied account access...
          }
        }
        // Legacy dapp browsers...
        else if (window.web3) {
          window.web3 = new Web3(web3.currentProvider)
          // Acccounts always exposed
          web3.eth.sendTransaction({
            /* ... */
          })
        }
        // Non-dapp browsers...
        else {
          console.log(
            'Non-Ethereum browser detected. You should consider trying MetaMask!'
          )
        }
      })
    }
  }
}
</script>
