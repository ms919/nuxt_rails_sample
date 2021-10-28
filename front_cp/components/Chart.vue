<script>
import { HorizontalBar, mixins } from "vue-chartjs";
const { reactiveProp } = mixins;

export default {
	extends: HorizontalBar,
	mixins: [reactiveProp],
	// props: ["options"],
	data() {
		return {
			options: {
				scales: {
					yAxes: [
						{
							ticks: {
								// 目盛り
								min: 0, // 最小値
								// beginAtZero: true でも同じ
								max: 50, // 最大値
								stepSize: 5, // 間隔
							},
						},
					],
				},
			},
		};
	},
	mounted() {
		// this.chartData is created in the mixin.
		// If you want to pass options please create a local options object
		this.renderChart(this.chartData, {options: this.options});
	},
};
</script>
