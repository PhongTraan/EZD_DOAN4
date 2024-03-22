<template>
    <div class="screen">
      <h1>Poke Memories</h1>
      <p>Select mode to start game</p>
      <router-link to="/login"  v-if="user==null"> <p>Please Login To Play</p></router-link>
      <div class="modes"  v-if="user!=null">
     
        <button @click="onStart(4)">
          <span>2x2</span>
          <span>Easy</span>
        </button>
        <button @click="onStart(16)">
          <span>4x4</span>
          <span>Easy</span>
        </button>
        <button @click="onStart(36)">
          <span>6x6</span>
          <span>Normal</span>
        </button>
       
      </div>
    </div>
  </template>

<script>
import { userInfo } from "@/store";
export default {
name:'mainGame',
emits: ["onStart"],
data(){
  return{
    user:userInfo.value
  }
},

  methods: {

    onStart(totalOfBlocks) {
      this.$emit("onStart", { totalOfBlocks });
    },
  },

 
}
</script>
<style lang="css" scoped>
.screen {
  width: 100%;
  height: 920px;

  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  background-color: #2596be;
  color: #f3f3f3;
}

.screen h1 {
  font-size: 4.5rem;
  text-transform: uppercase;
}

.screen p {
  font-size: 2rem;
  font-family: 'Odibee Sans', sans-serif;
}

.modes {
  display: flex;
  margin-top: 2rem;
}

.modes button {
 
  width: 150px;
  height: 150px;
  background: transparent;
  box-shadow: none;
  border: 1px solid #f3f3f3;
  color: #f3f3f3;
  display: flex;
  flex-direction: column;
  border-radius: 1rem;
  margin: 0 1rem;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: background 0.3s ease-in-out;
}

.modes button:hover {
  background-color: #f3f3f3;
  color: #212121;
}

.modes button span:first-child {
  font-size: 2rem;
}

.modes button span:last-child {
  display: block;
  font-size: 1.25rem;
  margin-top: 0.5rem;
}
</style>

