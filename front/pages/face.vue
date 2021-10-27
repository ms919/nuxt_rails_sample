<template>
	<div id="app">
		<!-- video の上に canvas をオーバーレイするための div 要素 -->
		<div id="container">
			<!-- カメラ映像を流す video -->
			<video id="video" width="100" height="75" @play="onPlay"></video>
			<!-- 重ねて描画する canvas -->
			<canvas id="canvas" width="100" height="75"></canvas>
		</div>
		<div id="emotion_str"></div>
		<svg>
			<rect class="expression[]" x="30" y="20" height="10" rx="0" ry="0" fill="#ee82ee" stroke="none" fill-opacity="1" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); fill-opacity: 1;"></rect>
      <text x="20" y="20" text-anchor="middle" font-family="IPA Pゴシック" font-size="5px" stroke="none" fill="#888888" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: middle; font-family: IPA Pゴシック; font-size: 5px; font-weight: normal;" font-weight="normal" transform="matrix(1,0,0,1,0,5.5)">
        sad
      </text>
      <rect class="expression[]" x="30" y="40" height="10" rx="0" ry="0" fill="#ee82ee" stroke="none" fill-opacity="1" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); fill-opacity: 1;"></rect>
      <text x="20" y="40" text-anchor="middle" font-family="IPA Pゴシック" font-size="5px" stroke="none" fill="#888888" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: middle; font-family: IPA Pゴシック; font-size: 5px; font-weight: normal;" font-weight="normal" transform="matrix(1,0,0,1,0,5.5)">
         happy
      </text>
		</svg>
	</div>
</template>

<script>
import * as faceapi from "~/assets/js/face-api.min.js";
export default {
	methods: {
		onPlay() {
			const video = document.getElementById("video"); // video 要素を取得
			const canvas = document.getElementById("canvas"); // canvas 要素の取得
			const emotion_str = document.getElementById("emotion_str");
			const ex_arr = document.getElementsByClassName("expression[]");

			setInterval(async () => {
				// ウェブカメラの映像から顔データを取得
				const detections = await faceapi
					.detectAllFaces(video, new faceapi.TinyFaceDetectorOptions())
					.withFaceLandmarks()
					.withFaceExpressions();
				// console.log(detections[0].expressions);
				// 顔データをリサイズ
				const resizedDetections = faceapi.resizeResults(detections, {
					width: video.width,
					height: video.height,
				});

				// キャンバスに描画
				canvas.getContext("2d").clearRect(0, 0, canvas.width, canvas.height);
				// faceapi.draw.drawDetections(canvas, resizedDetections);
				faceapi.draw.drawFaceLandmarks(canvas, resizedDetections);
				// faceapi.draw.drawFaceExpressions(canvas, resizedDetections)
				if (detections[0] !== undefined) {
					const expressions = detections[0].expressions;
					emotion_str.innerHTML = `<p>sad:${expressions.sad}<br/>happy:${expressions.happy}<br/>angry:${expressions.angry}<br/>surprised:${expressions.surprised}<br/>disgusted:${expressions.disgusted}<br/>fearful:${expressions.fearful}</p>`;
					ex_arr[0].width = expressions.sad * 100;
					ex_arr[1].width = expressions.happy * 100;
					console.log(ex_arr[0]);
				}
			}, 100);
		},
	},
	mounted() {
		// 顔モデルをロード
		Promise.all([
			faceapi.nets.tinyFaceDetector.loadFromUri("//weights"),
			faceapi.nets.faceLandmark68Net.loadFromUri("/weights"),
			faceapi.nets.faceExpressionNet.loadFromUri("/weights"),
		]).then(() => {
			// ウェブカメラへアクセス
			navigator.mediaDevices.getUserMedia({ video: true }).then((stream) => {
				video.srcObject = stream;
				video.play();
			});
		});
	},
};
</script>
<style scoped>
/* video 要素の上に canvas 要素をオーバーレイするための CSS */
#app {
	/* コンテナ用の div について */
	display: flex;
}
#container {
	position: relative; /* 座標指定を相対値指定にする */
	margin: 3rem;
}
#video {
	/* カメラ映像を流す video について */
	transform: scaleX(-1); /* 左右反転させる */
	position: absolute;
}
#canvas {
	/* 描画用の canvas について */
	transform: scaleX(-1); /* 左右反転させる */
	position: absolute; /* 座標指定を絶対値指定にして */
	left: 0; /* X座標を0に */
	top: 0; /* Y座標を0に */
	background-color: aqua;
	opacity: 0.5;
}
#emotion_str {
	display: block;
	margin-top: 25rem;
}
svg {
	display: block;
	margin-top: 40rem;
	background-color: blue;
	opacity: 0.5;
}
</style>
