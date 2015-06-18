{CompositeDisposable} = require 'atom'

module.exports = class AutoReplaceInSelection
  @subscriptions: null

  @activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace',
      'find-and-replace:show': @find_and_replace_shown.bind @

  @deactivate: ->
    @subscriptions.dispose()

  @has_selection: ->
    selection = @fnr.findModel.editor.getSelectedBufferRange()
    selection.start.row != selection.end.row or
      selection.start.column != selection.end.column

  @find_and_replace_shown: ->
    @fnr ||= atom.packages.loadedPackages['find-and-replace'].mainModule
    @fnr.findView.toggleSelectionOption() if @has_selection() != @fnr.findModel.inCurrentSelection
