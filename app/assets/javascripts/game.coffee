# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
board_size = 4


#VIEW CALLS
window.test_button = () -> random_drop()
window.move_up_call = () -> move_up()

#GAME LOGIC

move_up = () ->
  for cell in $('.filled_cell') when cell_number(cell) > board_size
    cell_up_number = cell_number(cell) - board_size
    if is_empty(cell_up_number)
      $("\##{cell.id}").removeClass('filled_cell')
      $("\##{cell.id}").addClass('empty_cell')

      $("\#cell#{cell_up_number}").addClass('filled_cell')
      $("\#cell#{cell_up_number}").removeClass('empty_cell')

      move_up();




random_drop = () ->
  if $('.empty_cell').length > 0
    random_cell = random_empty_cell()
    $("\##{random_cell.id}").removeClass('empty_cell')
    $("\##{random_cell.id}").addClass('filled_cell')
  else
    lose()

lose = () -> alert('YOU LOSE !')

random_empty_cell = () -> $('.empty_cell')[Math.floor(Math.random() * $('.empty_cell').length)]

is_empty = (cell_number) -> $("\#cell#{cell_number}").hasClass('empty_cell')

initialize = () -> random_drop()

cell_number = (cell) -> parseInt(cell.id.replace('cell',''),10)


# GRAPHIC FUNCTIONS

construct_game = () ->
  for num in [1..(board_size**2)]
    create_cell(num)

    if num%board_size==0
      create_separator()

  initialize();

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
