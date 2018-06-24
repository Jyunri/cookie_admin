//= require_tree .

$(window).bind("load", function() {
	removeBizuFilter();
	calculateAndSetGoal();
});

$( document ).ajaxComplete( function () {
	removeBizuFilter();
	calculateAndSetGoal();
});

// Remove busca bizu
function removeBizuFilter () {
	bizuFilter = $("input[placeholder='Filtrar']");
	bizuFilter.hide();
}

// Calcula meta de 60%
function calculateAndSetGoal () {
	const $ordersPrice = $('td.orders_price_field');
	if ($ordersPrice.length > 0) {
		var totalCount = 0;
		$ordersPrice.each( function() {
			totalCount += parseFloat($(this).html());
		});

		$footer = $('.total-count');
		$footer.append(' Meta: R$ ' + (totalCount * 0.6).toFixed(2));
	}
}
