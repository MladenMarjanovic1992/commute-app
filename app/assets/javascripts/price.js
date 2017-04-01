$(document).ready(function() {
    var slider = $("#the_slider").slider({
        range: true,
        min: 0,
        max: $("#price-to").val(),
        values: [$("#price-from").val(), $("#price-to").val()],
        slide: function(event, ui) {
            $("#price-from").val(ui.values[0]);
            $("#price-to").val(ui.values[1]);
        }
    });
    $("#price-from").val(slider.slider("values")[0]);
    $("#price-to").val(slider.slider("values")[1]);
});