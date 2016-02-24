{$} = require 'atom-space-pen-views'
{Disposable} = require 'atom'
Tile = require './tile'

class ToolbarView extends HTMLElement
  createdCallback: ->
    @classList.add('toolbar')

    @leftPanel = document.createElement('div')
    @leftPanel.classList.add('tool-bar-left')
    @appendChild(@leftPanel)

    @rightPanel = document.createElement('div')
    @rightPanel.classList.add('tool-bar-right')
    @appendChild(@rightPanel)

    @leftTiles = []
    @rightTiles = []

  initialize: ->
    this

  destroy: ->
    @remove()

  addLeftTile: (options) ->
    newItem = options.item
    if @leftTiles.length
      newPriority = options?.priority ? @leftTiles[@leftTiles.length - 1].priority + 1
    else
      newPriority = options?.priority ? 0
    nextItem = null
    for {priority, item}, index in @leftTiles
      if priority > newPriority
        nextItem = item
        break

    newTile = new Tile(newItem, newPriority, @leftTiles)
    @leftTiles.splice(index, 0, newTile)
    newElement = atom.views.getView(newItem)
    nextElement = atom.views.getView(nextItem)
    @leftPanel.insertBefore(newElement, nextElement)
    newTile

  addRightTile: (options) ->
    newItem = options.item
    if @rightTiles.length
      newPriority = options?.priority ? @rightTiles[0].priority + 1
    else
      newPriority = options?.priority ? 0
    nextItem = null
    for {priority, item}, index in @rightTiles
      if priority < newPriority
        nextItem = item
        break

    newTile = new Tile(newItem, newPriority, @rightTiles)
    @rightTiles.splice(index, 0, newTile)
    newElement = atom.views.getView(newItem)
    nextElement = atom.views.getView(nextItem)
    @rightPanel.insertBefore(newElement, nextElement)
    newTile

  getLeftTiles: ->
    @leftTiles

  getRightTiles: ->
    @rightTiles

  getActiveItem: ->
    atom.workspace.getActivePaneItem()

module.exports = document.registerElement('tool-bar', prototype: ToolbarView.prototype)
