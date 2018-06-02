# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
board_size = 4

window.change = () -> $('#test_button').html("coffee function")

construct_game = () ->
  for num in [1..(board_size**2)]
    create_cell(num)

    if num%board_size==0
      create_separator()


create_cell = (num) ->
  jQuery('<div />',{
    id: "colcontainer#{num}"
    class: "col m-1"
  }).appendTo($('#game_zone'))

  jQuery('<div />',{
    id: "rowcontainer#{num}"
    class: "row"
    }).appendTo($("\#colcontainer#{num}"))



  jQuery('<div/>',{
    id: "cell#{num}"
    class: "col-12 game_cell"
  }).appendTo($("\#rowcontainer#{num}"))

  cell_selector = $("\#cel#{num}")

  cell_selector.html(num)
  #cell_selector.css({'border':'thin solid black'})



create_separator = () ->
      jQuery('<div/>',{
        class: "separator col-12"
      }).appendTo($('#game_zone'))



$('document').ready(construct_game)
