module.exports = {
  '/gettoken': {}
  '/get_jsapi_ticket': {
    token: true
  }
  '/department/list': {
    token: true
  }
  '/department/get': {
    token: true
  }
  '/department/create': {
    method: 'POST'
    token: true
  }
  '/department/update': {
    method: 'POST'
    token: true
  }
  '/department/delete': {
    token: true
  }
  '/user/getUseridByUnionid': {
    token: true
  }
  '/user/get': {
    token: true
  }
  '/user/create': {
    method: 'POST'
    token: true
  }
  '/user/update': {
    method: 'POST'
    token: true
  }
  '/user/delete': {
    token: true
  }
  '/user/batchdelete': {
    method: 'POST'
    token: true
  }
  '/user/simplelist': {
    token: true
  }
  '/user/list': {
    token: true
  }
  '/user/get_admin': {
    token: true
  }
  '/user/getuserinfo': {
    token: true
  }
  '/message/send': {
    method: 'POST'
    token: true
  }
  '/message/list_message_status': {
    method: 'POST'
    token: true
  }

  #sns
  '/sns/gettoken': {}
  '/sns/get_persistent_code': {
    method: 'POST'
    sns_token: true
  }
  '/sns/get_sns_token': {
    method: 'POST'
    sns_token: true
  }
  '/sns/getuserinfo': {}
}