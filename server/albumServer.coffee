Meteor.methods 
	saveAlbumToDb: (image, description) ->
		console.dir 'Save album'

		Albums.insert
			image: image
			description: description

	savePageToDb: (albumId, image, description) ->
		console.dir 'savePage'

		Pages.insert
			albumId: albumId
			image: image
			description: description

Meteor.startup ->
	Meteor.publish	'getAlbums', ->
		console.dir 'getAlbums'
		Albums.find()

	Meteor.publish 'getPages', (limit, albumId) ->
		console.dir 'getPages'
		console.dir albumId
		console.dir 'Pages found: ' + Pages.find({albumId: albumId}, {limit: limit}).count()
		if limit > Pages.find().count()
			limit = 0
		Pages.find({albumId: albumId}, {limit: limit})


