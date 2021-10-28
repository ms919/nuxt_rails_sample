<template>
	<div class="tiktok-wrapper">
		<button href="#" @click="play">click</button>
		<blockquote
			class="tiktok-embed"
			cite="https://www.tiktok.com/@kostvjolyx/video/6994978774966095110"
			data-video-id="6994978774966095110"
		>
			<section></section>
		</blockquote>
	</div>
</template>
<script>
export default {
	head() {
		return {
			script: [{ src: "https://www.tiktok.com/embed.js" }],
		};
	},
	methods: {
		play() {
			const tiktok = document.getElementsByClassName("tiktok-embed")[0]
				.firstChild;
			console.log(tiktok);
		},
	},
};
</script>
<style scoped>
.tiktok-wrapper {
	width: 25%;
}
blockquote {
  height: 58vh;
}
@media screen and (max-width: 425px) {
	.tiktok-wrapper {
		width: 90%;
	}
	blockquote {
		width: 100%;
		height: 79vh;
	}
}
</style>
