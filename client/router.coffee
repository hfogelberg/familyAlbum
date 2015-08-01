Router.configure layoutTemplate: 'layout'
Router.map ->
	@route 'home',
  	path: '/',
    template: 'home'

	@route 'admin'

	@route 'addAlbum'

	@route 'albums',
		path: '/albums',
		template: 'albums'
		waitOn: ->
			@subscribe 'getAlbums'
		data: albums: ->
			Albums.find()

	@route 'pages',
		path: '/pages/:_id',
		template: 'pages'
		onBeforeAction: ->
			Session.set 'albumId', @params._id
			this.next()


	# @route 'addPage