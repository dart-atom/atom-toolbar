ToolbarElement = require '../lib/toolbar-view'

describe "ToolbarElement", ->
  toolbarElement = null

  class TestItem
    constructor: (@id) ->

  beforeEach ->
    toolbarElement = new ToolbarElement().initialize()

    atom.views.addViewProvider TestItem, (model) ->
      element = document.createElement("item-view")
      element.model = model
      element

  describe "::addLeftTile({item, priority})", ->
    it "appends the view for the given item to its left side", ->
      testItem1 = new TestItem(1)
      testItem2 = new TestItem(2)
      testItem3 = new TestItem(3)

      tile1 = toolbarElement.addLeftTile(item: testItem1, priority: 10)
      tile2 = toolbarElement.addLeftTile(item: testItem2, priority: 30)
      tile3 = toolbarElement.addLeftTile(item: testItem3, priority: 20)

      {leftPanel} = toolbarElement

      expect(leftPanel.children[0].nodeName).toBe("ITEM-VIEW")
      expect(leftPanel.children[1].nodeName).toBe("ITEM-VIEW")
      expect(leftPanel.children[2].nodeName).toBe("ITEM-VIEW")

      expect(leftPanel.children[0].model).toBe(testItem1)
      expect(leftPanel.children[1].model).toBe(testItem3)
      expect(leftPanel.children[2].model).toBe(testItem2)

      expect(toolbarElement.getLeftTiles()).toEqual([tile1, tile3, tile2])
      expect(tile1.getPriority()).toBe(10)
      expect(tile1.getItem()).toBe(testItem1)

    it "allows the view to be removed", ->
      testItem = new TestItem(1)
      tile = toolbarElement.addLeftTile(item: testItem, priority: 10)
      tile.destroy()
      expect(toolbarElement.leftPanel.children.length).toBe(0)

      toolbarElement.addLeftTile(item: testItem, priority: 9)

    describe "when no priority is given", ->
      it "appends the item", ->
        testItem1 = new TestItem(1)
        testItem2 = new TestItem(2)

        toolbarElement.addLeftTile(item: testItem1, priority: 1000)
        toolbarElement.addLeftTile(item: testItem2)

        {leftPanel} = toolbarElement
        expect(leftPanel.children[0].model).toBe(testItem1)
        expect(leftPanel.children[1].model).toBe(testItem2)

  describe "::addRightTile({item, priority})", ->
    it "appends the view for the given item to its left side", ->
      testItem1 = new TestItem(1)
      testItem2 = new TestItem(2)
      testItem3 = new TestItem(3)

      tile1 = toolbarElement.addRightTile(item: testItem1, priority: 10)
      tile2 = toolbarElement.addRightTile(item: testItem2, priority: 30)
      tile3 = toolbarElement.addRightTile(item: testItem3, priority: 20)

      {rightPanel} = toolbarElement

      expect(rightPanel.children[0].nodeName).toBe("ITEM-VIEW")
      expect(rightPanel.children[1].nodeName).toBe("ITEM-VIEW")
      expect(rightPanel.children[2].nodeName).toBe("ITEM-VIEW")

      expect(rightPanel.children[0].model).toBe(testItem2)
      expect(rightPanel.children[1].model).toBe(testItem3)
      expect(rightPanel.children[2].model).toBe(testItem1)

      expect(toolbarElement.getRightTiles()).toEqual([tile2, tile3, tile1])
      expect(tile1.getPriority()).toBe(10)
      expect(tile1.getItem()).toBe(testItem1)

    it "allows the view to be removed", ->
      testItem = new TestItem(1)
      disposable = toolbarElement.addRightTile(item: testItem, priority: 10)
      disposable.destroy()
      expect(toolbarElement.rightPanel.children.length).toBe(0)

      toolbarElement.addRightTile(item: testItem, priority: 11)

    describe "when no priority is given", ->
      it "prepends the item", ->
        testItem1 = new TestItem(1, priority: 1000)
        testItem2 = new TestItem(2)

        toolbarElement.addRightTile(item: testItem1, priority: 1000)
        toolbarElement.addRightTile(item: testItem2)

        {rightPanel} = toolbarElement
        expect(rightPanel.children[0].model).toBe(testItem2)
        expect(rightPanel.children[1].model).toBe(testItem1)
