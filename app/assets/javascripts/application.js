// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .

$(document).ready(function() {
	console.log('hi');

	$('.checkin').change(function(){
		console.log('asasas');
		var start_date = $('.checkin')[0].value.split('-')

		function addDays(date, days) {
		  var d = new Date(date);
		  	month = '' + (d.getMonth() + 1),
	        day = '' + (d.getDate() + days),
	        year = d.getFullYear();
		         
		    if (month.length < 2) month = '0' + month;
		    if (day.length < 2) day = '0' + day;

		  return [year, month, day].join('-');
		}

		var d = (addDays(start_date, 1))
		$('.checkout').attr('min', d)
	});

}); 



