Router.configure layoutTemplate: 'layout'
Router.map ->
	@route 'home',
  	path: '/',
    template: 'home'

	@route 'admin'

	@route 'addAlbum'

	@route 'albums',
		path: 'albums',
		template: 'albums'
		waitOn: ->
			@subscribe 'getAlbums'
		data: albums: ->
			Albums.find()