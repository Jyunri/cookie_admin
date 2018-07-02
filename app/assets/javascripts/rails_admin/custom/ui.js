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

	    var multiPrintInput = document.createElement('input');
      multiPrintInput.setAttribute('type', 'hidden');
      multiPrintInput.setAttribute('name', 'multiprint');
      multiPrintInput.setAttribute('value', true);
      f.appendChild(multiPrintInput);

	    document.body.appendChild(f);
	    f.submit();
    }
});

function submitForms() {
	params = $('.singlePrint');
	client_names = {};
	client_rgs = {};
	client_cpfs = {};
	client_phones = {};
	client_addresses = {};
	client_neighborhoods = {};
	client_cities = {};
	orders = {};

	params.each( function(index) {
		client_names[index] = $(this)[0][name='client_names'].value;
		client_rgs[index] = $(this)[0][name='client_rgs'].value;
		client_cpfs[index] = $(this)[0][name='client_cpfs'].value;
		client_phones[index] = $(this)[0][name='client_phones'].value;
		client_addresses[index] = $(this)[0][name='client_addresses'].value;
		client_neighborhoods[index] = $(this)[0][name='client_neighborhoods'].value;
		client_cities[index] = $(this)[0][name='client_cities'].value;
		orders[index] = $(this)[0][name='orders'].value;
	});

	var url = '/print'
	$.redirectPost(url, {
		client_names: JSON.stringify(client_names),
		client_rgs: JSON.stringify(client_rgs),
		client_cpfs: JSON.stringify(client_cpfs),
		client_phones: JSON.stringify(client_phones),
		client_addresses: JSON.stringify(client_addresses),
		client_neighborhoods: JSON.stringify(client_neighborhoods),
		client_cities: JSON.stringify(client_cities),
		orders: JSON.stringify(orders)
	});
}