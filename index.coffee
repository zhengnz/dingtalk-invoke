Promise = require 'bluebird'
invoke = require './libs'
_ = require 'lodash'
utils = require 'utility'
url = require 'url'

class Model
  constructor: (@config) ->
    @config = _.assign {
      getToken: ->
        Promise.resolve null
      setToken: (token, expires) ->
        Promise.resolve()
      getSnsToken: ->
        Promise.resolve null
      setSnsToken: (token, expires) ->
        Promise.resolve()
      getJsApiTicket: ->
        Promise.resolve null
      setJsApiTicket: (ticket, expires) ->
        Promise.resolve()
    }, @config

  invoke: (path, params={}) ->
    invoke path, params, @

  getToken: ->
    @config.getToken()
    .then (token) =>
      if token?
        return Promise.resolve token
      @invoke '/gettoken', {corpid: @config.corpid, corpsecret: @config.corpsecret}
      .then (data) =>
        token = data.access_token
        @config.setToken token, (7200 - 100) * 1000
        .then ->
          Promise.resolve token

  getSnsToken: ->
    @config.getSnsToken()
    .then (token) =>
      if token?
        return Promise.resolve token
      @invoke '/sns/gettoken', {appid: @config.appid, appsecret: @config.appsecret}
      .then (data) =>
        token = data.access_token
        @config.setSnsToken token, (7200 - 100) * 1000
        .then ->
          Promise.resolve token

  getJsApiTicket: ->
    @config.getJsApiTicket()
    .then (ticket) =>
      if ticket?
        return Promise.resolve ticket
      @invoke '/get_jsapi_ticket', {type: 'jsapi'}
      .then (data) =>
        ticket = data.ticket
        @config.setJsApiTicket ticket, (7200 - 100) * 1000
        .then ->
          Promise.resolve ticket

  nonce_str: ->
    utils.randomString(32, '1234567890abcdefghijklmnopqrstuvwxyz').toUpperCase()

  getSignature: (originUrl) ->
    origUrlObj =  url.parse originUrl
    delete origUrlObj['hash']
    newUrl = url.format(origUrlObj)

    @getJsApiTicket().then (ticket) =>
      nonceStr = @nonce_str()
      timeStamp = _.now()

      plain = "jsapi_ticket=#{ticket}&noncestr=#{nonceStr}&timestamp=#{timeStamp}&url=#{newUrl}"
      Promise.resolve {
        nonceStr
        timeStamp
        signature: utils.sha1 plain
      }

module.exports = Model