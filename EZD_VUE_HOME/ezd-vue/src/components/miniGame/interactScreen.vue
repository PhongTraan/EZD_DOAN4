<template>
  <div class="screen">
    <div
      class="screen__inner"
      :style="{
        width: `${
          ((((920 - 16 * 4) / Math.sqrt(cardsContext.length) - 16) * 3) / 4 +
            16) *
          Math.sqrt(cardsContext.length)
        }px`,
      }"
    >
      <CardFlip
        v-for="(card, index) in cardsContext"
        :key="index"
        :cardsContext="cardsContext"
        :card="{ index, value: card }"
        :imgBackFaceUrl="`images/${card}.png`"
        :ref="`card-${index}`"
        :rules="rules"
        @onFlip="checkRule($event)"
      />
    </div>
  </div>
</template>

<script>
import CardFlip from "@/components/miniGame/card.vue";

export default {
  name: "interactScreen",
  props: {
    cardsContext: {
      type: Array,
      default: function () {
        return [];
      },
    },
  },
  data() {
    return {
      rules: [],
      openedCards: [], // Sử dụng để theo dõi thẻ đã mở
    };
  },
  methods: {
    async checkRule(card) {
      if (this.rules.length === 2) return false;

      // Kiểm tra xem thẻ đã được lật trước đó chưa
      if (this.rules.length === 1 && this.rules[0].index === card.index) {
        return false; // Chọn cùng một thẻ hai lần
      }

      this.rules.push(card);

      if (
        this.rules.length === 2 &&
        this.rules[0].value === this.rules[1].value
      ) {
        this.$refs[`card-${this.rules[0].index}`][0].onEnabledDisabledMode();
        this.$refs[`card-${this.rules[1].index}`][0].onEnabledDisabledMode();
        this.rules = [];

        const disabledElements = document.querySelectorAll(
          ".screen .card.disabled",
        );
        if (
          disabledElements &&
          disabledElements.length === this.cardsContext.length - 2
        )
          setTimeout(() => {
            this.$emit("onFinish");
          }, 920);
      } else if (
        this.rules.length === 2 &&
        this.rules[0].value !== this.rules[1].value
      ) {
        console.log("Wrong");
        await setTimeout(() => {
          this.$refs[`card-${this.rules[0].index}`][0].onFlipBackCard();
          this.$refs[`card-${this.rules[1].index}`][0].onFlipBackCard();

          this.rules = [];
        }, 800);
      } else return false;
    },
  },
  components: {
    CardFlip,
  },
};
</script>
<style lang="css" scoped>
.screen {
  width: 100%;
  height: 860px;

  background-color: #bee0ec;
  color: #f3f3f3;
}

.screen__inner {
  width: calc(424px);
  display: flex;
  flex-wrap: wrap;
  margin: 2rem auto;
}
</style>
