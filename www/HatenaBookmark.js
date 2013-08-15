SERVICE_NAME = 'HatenaBookmark'

module.exports = {
  setup: function(config){
      cordova.exec(null, null,SERVICE_NAME, 'setup', [config.consumer, config.secret]);
  },
  authorize: function(options){
      cordova.exec(options.success, options.fail, SERVICE_NAME, 'authorize');
  },
  addBookmark: function(options){
      cordova.exec(options.success, options.fail, SERVICE_NAME, 'addBookmark', [options.url]);
  }
};
