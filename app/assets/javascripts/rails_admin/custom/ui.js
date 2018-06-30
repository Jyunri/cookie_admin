//= require_tree .

var $ordersPrice = $('td.orders_price_field');
var $footer = $('.total-count');

$(window).bind("load", function() {
	removeBizuFilter();
	customActionForFichas();
});

$( document ).ajaxComplete( function () {
	removeBizuFilter();
	customActionForFichas();
});

// Remove busca bizu
function removeBizuFilter () {
	bizuFilter = $("input[placeholder='Filtrar']");
	bizuFilter.hide();
}

// Adiciona informacao ao rodape de fichas
function customActionForFichas () {
	$ordersPrice = $('td.orders_price_field');
	$footer = $('.total-count');
	if ($ordersPrice.length > 0) {
		calculateAndSetGoal();
		setPrintAll();
	}
}

// Calcula meta de 60%
function calculateAndSetGoal () {
	var totalCount = 0;
	$ordersPrice.each( function() {
		totalCount += parseFloat($(this).html());
	});

	$footer.append(' Meta: R$ ' + (totalCount * 0.6).toFixed(2));
}

function setPrintAll() {
	$footer.append("<br><br><input type='button' value='Imprimir tudo!' onclick='submitForms()' />");
}

// jquery extend function
$.extend(
{
    redirectPost: function(location, args)
    {
	    var f = document.createElement('form');
			f.setAttribute('method', 'post');
			f.setAttribute('action', location);
			f.target='_blank';

	    var inputs = '';
	    $.each( args, function(key, value) {
        var input = document.createElement('input');
        input.setAttribute('type', 'hidden');
        input.setAttribute('name', key);
        input.setAttribute('value', value);
        f.appendChild(input);
	    });

	    document.body.appendChild(f);
	    f.submit();
    }
});

function submitForms() {
	params = $("form[action='/print']");
	client_names = {}
	client_rgs = {}

	params.each( function(index) {
		client_names[index] = $(this)[0][0].value
		client_rgs[index] = $(this)[0][1].value
	});

	var url = '/print'
	$.redirectPost(url, {
		client_names: JSON.stringify(client_names),
		client_rgs: JSON.stringify(client_rgs)
	});
}