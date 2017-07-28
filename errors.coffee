class DingTalkReturnError extends Error
  constructor: (err_code, err_msg) ->
    @name = 'DingTalkReturnError'
    @message = err_msg
    @code = err_code

  toString: ->
    "#{@name}: [#{@code}] #{@message}"

module.exports = {
  DingTalkReturnError: DingTalkReturnError
}