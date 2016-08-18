{CompositeDisposable} = require 'atom'

class ForceLineEndings
  configDisposable: null
  editorDisposable: null

  config:
    lineEndingType:
      title: 'Default line ending'
      description: 'Line ending to use for all files'
      type: 'string'
      default: 'LF'
      enum: ['LF', 'CRLF']

  activate: ->
    configVar = 'force-line-endings.lineEndingType'
    @configDisposable = atom.config.observe configVar, (val) ->
      @editorDisposable?.dispose()
      @editorDisposable = atom.workspace.observeTextEditors (editor) ->
        cmd = "line-ending-selector:convert-to-#{val}"
        atom.commands.dispatch atom.views.getView(editor), cmd

  deactivate: ->
    @configDisposable?.dispose()
    @editorDisposable?.dispose()

module.exports = new ForceLineEndings
