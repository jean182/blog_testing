/*
This will trigger the collapse navbar for smaller devices
Notice that turbolinks:load will make function works, without doing a full refresh of the page
*/
$(document).on('turbolinks:load', function () {
  'use strict'

  $('[data-toggle="offcanvas"]').on('click', function () {
    $('.offcanvas-collapse').toggleClass('open')
  })
})