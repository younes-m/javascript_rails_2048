# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
BOARD_SIZE = 4
UP = 0
DOWN = 1
LEFT = 2
RIGHT = 3
boardChange = false
won = false


#VIEW CALLS
window.testButton = () -> randomDrop()
window.moveUpCall = () -> move(UP)
window.moveDownCall = () -> move(DOWN)
window.moveLeftCall = () -> move(LEFT)
window.moveRightCall = () -> move(RIGHT)
window.restartCall = () ->
  restart()
  randomDrop()
  updateScore()

#GAME LOGIC

move = (direction) ->
  hasMoved = true
  while hasMoved
    hasMoved=false
    for cell in $('.filledCell') by moveSide(direction) when moveCondition(cell, direction)
      destCellId = moveDestId(cell, direction)
      if isEmpty(destCellId)
        moveCell(cell, cellFromId(destCellId))
        hasMoved=true
        boardChange = true
      else mergeCells(cellSelector(cell), cellIdSelector(destCellId))
  nextTurn() if boardChange

moveSide = (direction) -> if direction==DOWN or direction==RIGHT then -1 else 1

moveCondition = (cell, direction) ->
  switch direction
    when UP then canMove = cellNumber(cell) > BOARD_SIZE
    when DOWN then canMove =  cellNumber(cell) + 4 <= BOARD_SIZE**2
    when LEFT then canMove = cellNumber(cell)%BOARD_SIZE != 1
    when RIGHT then canMove = cellNumber(cell)%BOARD_SIZE != 0

moveDestId = (cell, direction) ->
  switch direction
    when UP then destId = cellNumber(cell) - BOARD_SIZE
    when DOWN then destId = cellNumber(cell) + BOARD_SIZE
    when LEFT then destId = cellNumber(cell) - 1
    when RIGHT then destId = cellNumber(cell) + 1

nextTurn = () ->
  randomDrop()
  if $(".gameCell[data-value='11']").length > 0 and not won
    win()

  for cell in $('.gameCell')
    cellSelector(cell).data('merged',0)

  updateScore()
  boardChange = false

randomDrop = () ->
  if $('.emptyCell').length > 0
    randomCell = randomEmptyCell()
    fillCell(randomCell)


countScore = () ->
  score=0
  for cell in $('.filledCell')
    score+= 2**cellSelector(cell).attr('data-value')
  score

moveCell = (sourceCell, destinationCell) ->
  dataValueDest = cellSelector(sourceCell).attr('data-value')
  fillCell(destinationCell)
  cellSelector(destinationCell).attr('data-value', dataValueDest)
  emptyCell(sourceCell)


mergeCells = (sourceSelector,destinationSelector) ->
  if  sourceSelector.data('merged') == 0 and destinationSelector.data('merged') == 0
    if sourceSelector.attr('data-value') == destinationSelector.attr('data-value')
      emptyCell(sourceSelector[0])
      newDataValue = parseInt(destinationSelector.attr('data-value')) + 1
      destinationSelector.attr('data-value', "#{newDataValue}")
      destinationSelector.data('merged',1)
      boardChange=true

lose = () -> alert('YOU LOSE !')

win = () ->
  won=true
  if not confirm('You win ! Continue playing ?')
    restart()

restart = () ->
  won=false
  for cell in $('.gameCell')
    emptyCell(cell)

randomEmptyCell = () -> $('.emptyCell')[Math.floor(Math.random() * $('.emptyCell').length)]

isEmpty = (cellNumber) -> $("\#cell#{cellNumber}").hasClass('emptyCell')

initialize = () -> randomDrop()


# SELECTORS / GETTERS
cellNumber = (cell) -> parseInt(cell.id.replace('cell',''),10)
cellIdSelector = (num) -> $("\#cell#{num}")
cellSelector = (cell) -> $("\##{cell.id}")
cellFromId = (id) -> $("\#cell#{id}")[0]

# GRAPHIC FUNCTIONS
updateScore = () ->  $('#score').html("Score : #{countScore()}")

fillCell = (cell) ->
  cellSelector(cell).removeClass('emptyCell')
  cellSelector(cell).addClass('filledCell')
  if Math.random() < 0.9 then cellSelector(cell).attr('data-value',1) else cellSelector(cell).attr('data-value',2)

emptyCell = (cell) ->
  cellSelector(cell).removeClass('filledCell')
  cellSelector(cell).addClass('emptyCell')
  cellSelector(cell).attr('data-value',0)

constructGame = () ->
  for num in [1..(BOARD_SIZE**2)]
    createCell(num)

    if num%BOARD_SIZE==0
      create_separator()

  initialize()
  updateScore()


createCell = (num) ->
  #create a container for the cell
  jQuery('<div />',{
    id: "colcontainer#{num}"
    class: "col m-1"
  }).appendTo($('#gameZone'))

  jQuery('<div />',{
    id: "rowcontainer#{num}"
    class: "row"
    }).appendTo($("\#colcontainer#{num}"))

  #create the cell
  jQuery('<div/>',{
    id: "cell#{num}"
    class: "col-12 gameCell emptyCell"

  }).appendTo($("\#rowcontainer#{num}"))

  cellIdSelector(num).attr('data-value',0)
  cellIdSelector(num).data('merged',0)


create_separator = () ->
      jQuery('<div/>',{
        class: "separator col-12"
      }).appendTo($('#gameZone'))

$ ->
  constructGame()
  document.onkeypress = keyDirection

keyDirection = (e) ->
  switch e.key
    when "ArrowUp" then moveUpCall()
    when "ArrowDown" then moveDownCall()
    when "ArrowLeft" then moveLeftCall()
    when "ArrowRight" then moveRightCall()
    when "z" then moveUpCall()
    when "s" then moveDownCall()
    when "q" then moveLeftCall()
    when "d" then moveRightCall()

swipeleft = (e) -> moveLeftCall()
