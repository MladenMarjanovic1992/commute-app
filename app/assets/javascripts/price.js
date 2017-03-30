$(document).ready(function() {
    var slider = $("#the_slider").slider({
        range: true,
        min: 0,
        max: 2000,
        values: [0, 1000],
        slide: function(event, ui) {
            $("#price-from").val(ui.values[0]);
            $("#price-to").val(ui.values[1]);
        }
    });
    $("#price-from").val(slider.slider("values")[0]);
    $("#price-to").val(slider.slider("values")[1]);
});