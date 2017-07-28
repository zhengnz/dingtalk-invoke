rp = require 'request-promise'
Promise = require 'bluebird'
errors = require '../errors'
_ = require 'lodash'
config = require './interfaceConfig'

err_filter = (data) ->
  if data.errcode isnt 0
    return Promise.reject new errors.DingTalkReturnError data.errcode, data.errmsg
  delete data.errcode
  delete data.errmsg
  Promise.resolve data

module.exports = (uri, params, model) ->
  if not _.has config, uri
    return Promise.reject new Error '暂未提供该接口的配置'
  c = config[uri]

  method = c.method or 'GET'
  uri = "https://oapi.dingtalk.com#{uri}"

  options = {
    method: method
    uri: uri
    json: true
  }

  (
    do ->
      if c.token
        model.getToken()
      else if c.sns_token
        model.getSnsToken()
      else
        Promise.resolve null
  )
  .then (token) ->
    if method is 'GET'
      if token?
        params.access_token = token
      options.qs = params
    else
      if token?
        options.qs = {
          access_token: token
        }
      options.body = params

    rp options
    .then err_filter