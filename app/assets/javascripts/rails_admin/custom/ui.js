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
	    var form = '';
	    $.each( args, function( key, value ) {
	    	debugger;
	    	value = JSON.stringify(value).replace(/\"/g, '')
        form += '<input type="hidden" name="'+key+'" value="'+value+'">';
	    });
	    $('<form action="'+location+'" method="POST">'+form+'</form>').appendTo('body').submit();
    }
});

function submitForms() {
	// params = JSON.stringify($("form[action='/print']").serialize());
	params = $("form[action='/print']");

	client_names = {}
	client_rgs = {}
	data = {}
	params.each( function(index) {
		data[index]={};
		data[index]["client_name"] = $(this)[0][0].value;
		data[index]["client_rg"] = $(this)[0][1].value;
	});
	params.each( function(index) {
		client_names[index] = $(this)[0][0].value
		client_rgs[index] = $(this)[0][1].value
	});
	// data = JSON.stringify(params);
	var redirect = '/print';
	$.redirectPost(redirect, data);
	// $.redirectPost(redirect, {batchData: params.replace(/\"/g, '')});
}