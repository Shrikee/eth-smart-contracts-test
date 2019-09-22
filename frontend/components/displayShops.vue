<template>
  <v-container fluid>
    <v-row>
      <v-col
        v-for="shop in shops"
        :key="shop.name"
        cols="12"
        sm="6"
        md="4"
        lg="3"
      >
        <v-card>
          <v-card-title class="subheading font-weight-bold">{{
            shop[1]
          }}</v-card-title>

          <v-divider></v-divider>

          <v-list dense>
            <v-list-item>
              <v-list-item-content>Created time:</v-list-item-content>
              <v-list-item-content class="align-end">{{
                shop.createdTime
              }}</v-list-item-content>
            </v-list-item>
            <v-list-item>
              <v-list-item-content>Latitude:</v-list-item-content>
              <v-list-item-content class="align-end">{{
                shop.lat
              }}</v-list-item-content>
            </v-list-item>
            <v-list-item>
              <v-list-item-content>Longitude:</v-list-item-content>
              <v-list-item-content class="align-end">{{
                shop.long
              }}</v-list-item-content>
            </v-list-item>
          </v-list>
          <v-card-actions>
            <v-btn
              color="success"
              :href="'/map?' + 'lat=' + shop.lat + '&' + 'lng=' + shop.long"
              >Details {{ shop.name }}</v-btn
            >
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import Web3 from 'web3'
import shopsContract from '../../build/contracts/Shops.json'
const web3 = new Web3(Web3.givenProvider)
const contract = new web3.eth.Contract(
  shopsContract.abi,
  process.env.CONTRACT_ADDRESS
)
export default {
  data: () => ({
    index: '_',
    item: null,
    shops: []
  }),
  created() {
    this.getIndexAndPopulateShops()
  },
  methods: {
    getIndexAndPopulateShops() {
      contract.methods
        .shopCount()
        .call()
        .then((res) => {
          this.index = res
          this.getShops()
        })
    },

    async getShops() {
      for (let i = 1; i <= this.index; i++) {
        await contract.methods
          .shopsMapping(i)
          .call()
          .then((res) => {
            this.shops.push(res)
          })
      }
    }
  }
}
</script>
