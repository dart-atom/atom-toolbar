Grim = require 'grim'
fs = require 'fs-plus'
path = require 'path'
os = require 'os'

describe "Toolbar package", ->
  [editor, toolbarbar, toolbarbarService, workspaceElement] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)

    waitsForPromise ->
      atom.packages.activatePackage('toolbar').then (pack) ->
        toolbarbar = workspaceElement.querySelector("tool-bar")
        toolbarbarService = pack.mainModule.provideToolbar()

  describe "@activate", ->
    it "appends only one toolbar", ->
      expect(workspaceElement.querySelectorAll('tool-bar').length).toBe 1
      atom.workspace.getActivePane().splitRight(copyActiveItem: true)
      expect(workspaceElement.querySelectorAll('tool-bar').length).toBe 1

  describe "@deactivate()", ->
    it "removes the toolbar view", ->
      atom.packages.deactivatePackage("toolbar")
      expect(workspaceElement.querySelector('tool-bar')).toBeNull()

  describe "when toolbar:toggle is triggered", ->
    beforeEach ->
      jasmine.attachToDOM(workspaceElement)
    it "hides or shows the toolbar", ->
      atom.commands.dispatch(workspaceElement, 'toolbar:toggle')
      expect(workspaceElement.querySelector('tool-bar').parentNode).not.toBeVisible()
      atom.commands.dispatch(workspaceElement, 'toolbar:toggle')
      expect(workspaceElement.querySelector('tool-bar').parentNode).toBeVisible()

  describe "the 'toolbar' service", ->
    it "allows tiles to be added, removed, and retrieved", ->
      dummyView = document.createElement("div")
      tile = toolbarbarService.addLeftTile(item: dummyView)
      expect(toolbarbar).toContain(dummyView)
      expect(toolbarbarService.getLeftTiles()).toContain(tile)
      tile.destroy()
      expect(toolbarbar).not.toContain(dummyView)
      expect(toolbarbarService.getLeftTiles()).not.toContain(tile)

      dummyView = document.createElement("div")
      tile = toolbarbarService.addRightTile(item: dummyView)
      expect(toolbarbar).toContain(dummyView)
      expect(toolbarbarService.getRightTiles()).toContain(tile)
      tile.destroy()
      expect(toolbarbar).not.toContain(dummyView)
      expect(toolbarbarService.getRightTiles()).not.toContain(tile)
