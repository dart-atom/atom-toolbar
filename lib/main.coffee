ToolbarView = require './toolbar-view'

module.exports =
  config:
    visible:
      title: 'Show toolbar'
      type: 'boolean'
      default: true
      description: 'Show or hide the toolbar.'

  activate: ->
    @toolbar = new ToolbarView()
    @toolbar.initialize()
    @toolbarPanel = atom.workspace.addTopPanel(item: @toolbar)

    # Have the command toggle the setting.
    atom.commands.add 'atom-workspace', 'toolbar:toggle', =>
      atom.config.set('toolbar.visible', !atom.config.get('toolbar.visible'))

    # Listen to the setting and toggle the view.
    atom.config.observe 'toolbar.visible', (val) =>
      if val
        @toolbarPanel.show()
      else
        @toolbarPanel.hide()

  deactivate: ->
    @toolbarPanel?.destroy()
    @toolbarPanel = null

    @toolbar?.destroy()
    @toolbar = null

  provideToolbar: ->
    addLeftTile: @toolbar.addLeftTile.bind(@toolbar)
    addRightTile: @toolbar.addRightTile.bind(@toolbar)
    getLeftTiles: @toolbar.getLeftTiles.bind(@toolbar)
    getRightTiles: @toolbar.getRightTiles.bind(@toolbar)
