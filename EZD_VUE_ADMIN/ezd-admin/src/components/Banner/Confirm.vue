<template>
  <div v-if="visible" class="modal">
    <div class="modal-content">
      <h3>{{ title }}</h3>
      <p>{{ content }}</p>
      <button @click="confirm">Confirm</button>
      <button @click="close">Cancel</button>
    </div>
  </div>
</template>

<script setup>
const props = defineProps({
  visible: Boolean,
  title: String,
  content: String,
});

const emit = defineEmits(['confirm']);

function confirm() {
  emit('confirm');
}

function close() {
  emit('update:visible', false);
}
</script>
