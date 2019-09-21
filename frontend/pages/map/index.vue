<template>
  <div id="map-wrap" style="height: 100vh">
    <no-ssr>
      <l-map :zoom="13" :center="center">
        <l-tile-layer
          url="http://{s}.tile.osm.org/{z}/{x}/{y}.png"
        ></l-tile-layer>
        <l-marker :lat-lng="coordinates">
          <l-popup>{{ coordinates }}</l-popup>
        </l-marker>
      </l-map>
    </no-ssr>
  </div>
</template>
<script>
export default {
  data: () => ({
    center: [49.4333897, 32.083498],
    coordinates: []
  }),
  mounted() {
    this.getParams()
  },
  methods: {
    getParams() {
      this.coordinates.push(this.$route.query.lat)
      this.coordinates.push(this.$route.query.lng)
    }
  }
}
</script>
