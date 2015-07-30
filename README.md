# `atom-toolbar` package

Displays a configurable toolbar at the top of the workspace.

## API

This package provides a service that you can use in other Atom packages. To use
it, include `atom-toolbar` in the `consumedServices` section of your `package.json`:

```json
{
  "name": "my-package",
  "consumedServices": {
    "atom-toolbar": {
      "versions": {
        "^1.0.0": "consumeToolbar"
      }
    }
  }
}
```

Then, in your package's main module, call methods on the service:

```coffee
module.exports =
  activate: -> # ...

  consumeToolbar: (toolbar) ->
    @toolbarTile = toolbar.addLeftTile(item: myElement, priority: 100)

  deactivate: ->
    # ...
    @toolbarTile?.destroy()
    @toolbarTile = null
```

The `atom-toolbar` API has four methods:

  * `addLeftTile({ item, priority })` - Add a tile to the left side of the
  toolbar. Lower priority tiles are placed further to the left.
  * `addRightTile({ item, priority })` - Add a tile to the right side of the
  toolbar. Lower priority tiles are placed further to the right.

The `item` parameter to these methods can be a DOM element, a
[jQuery object](http://jquery.com), or a model object for which a view provider
has been registered in the [the view registry](https://atom.io/docs/api/latest/ViewRegistry).

  * `getLeftTiles()` - Retrieve all of the tiles on the left side of the toolbar.
  * `getRightTiles()` - Retrieve all of the tiles on the right side of the toolbar

All of these methods return `Tile` objects, which have the following methods:
  * `getPriority()` - Retrieve the priority that was assigned to the `Tile` when
  it was created.
  * `getItem()` - Retrieve the `Tile`'s item.
  * `destroy()` - Remove the `Tile` from the toolbar.

## Credits and Attributions

This package was forked from Atom's `status-bar` package.
