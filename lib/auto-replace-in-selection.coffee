{CompositeDisposable} = require 'atom'

module.exports = AutoReplaceInSelection =
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace',
      'find-and-replace:show': @find_and_replace_shown.bind @

  deactivate: ->
    @subscriptions.dispose()

  find_and_replace_shown: ->
    @fnr ||= atom.packages.loadedPackages['find-and-replace'].mainModule
    if !!@fnr.findModel.getEditor().getSelection().getText() != @fnr.findModel.inCurrentSelection
      @fnr.findView.toggleSelectionOption()
