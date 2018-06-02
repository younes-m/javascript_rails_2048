# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
board_size = 4

window.test_button = () -> random_drop()

#GAME LOGIC
random_drop = () ->
  if $('.empty_cell').length > 0
    random_cell = random_empty_cell()
    console.log(random_cell.id)
    $("\##{random_cell.id}").removeClass('empty_cell')
  else
    lose()

lose = () -> alert('YOU LOSE !')

random_empty_cell = () -> $('.empty_cell')[Math.floor(Math.random() * $('.empty_cell').length)]

# GRAPHIC FUNCTIONS

construct_game = () ->
  for num in [1..(board_size**2)]
    create_cell(num)

    if num%board_size==0
      create_separator()

create_cell = (num) ->
  #create a container for the cell
  jQuery('<div />',{
    id: "colcontainer#{num}"
    class: "col m-1"
  }).appendTo($('#game_zone'))

  jQuery('<div />',{
    id: "rowcontainer#{num}"
    class: "row"
    }).appendTo($("\#colcontainer#{num}"))

  #create the cell
  jQuery('<div/>',{
    id: "cell#{num}"
    class: "col-12 game_cell empty_cell"
  }).appendTo($("\#rowcontainer#{num}"))

  cell_selector = $("\#cel#{num}")

  cell_selector.html(num)

create_separator = () ->
      jQuery('<div/>',{
        class: "separator col-12"
      }).appendTo($('#game_zone'))

$('document').ready(construct_game)
