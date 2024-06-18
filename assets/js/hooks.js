import Plotly from "plotly.js-dist";
let Hooks = {};

Hooks.HistoGram = {
  mounted() {
    console.log("I have been mounted");
    const dataSet = JSON.parse(this.el.dataset.histogramData)

    var trace = {
      x: dataSet,
      type: "histogram",
    };
    var data = [trace];
    Plotly.newPlot(this.el,data);
  },
};

export default Hooks;
