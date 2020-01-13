// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require_tree .
//= require materialize
//= require bxslider



function newCategory() {
  document.getElementById('category-form').style.display = 'block';
}

function newProduct() {
  document.getElementById('product-form').style.display = 'block';
}

function addToCart(id) {
    var data = {
    product_id: id,
    quantity: document.getElementById('product_qty') ? document.getElementById('product_qty').value : 1,
    color: document.getElementById('product_color') ? document.getElementById('product_color').value : "Nill",
    size: document.getElementById('product_size') ? document.getElementById('product_size').value : "Nill",
  }
  $.ajax({
    url: '/add_to_cart',
    data: data,
    type: 'GET',
    success: function() {
      location.reload();
      // $('#cart').load(window.location.href + '#cart');
    }
  });
  M.toast({html: 'Succefully added to Cart'});
}

function removeFromCart(id) {
  $.ajax({
    url: '/removeItem/' + id,
    type: 'GET',
    success: function() {
      location.reload();
    }
  });
  M.toast({html: 'Item removed from Cart'});
}

function plusCartItem(id) {
  $.ajax({
    url: '/addItem/' + id,
    type: 'GET',
    success: function() {
      location.reload();
    }
  });
  M.toast({html: 'Quantity Added'});
}

function minusCartItem(id) {
  $.ajax({
    url: '/minusItem/' + id,
    type: 'GET',
    success: function() {
      location.reload();
    }
  });
  M.toast({html: 'Quantity Decreased'});
}
