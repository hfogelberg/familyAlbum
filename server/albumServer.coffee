Meteor.methods 
	saveAlbumToDb: (image, description) ->
		console.dir 'Save album'

		Albums.insert
			image: image
			description: description

		return

Meteor.startup ->
	Meteor.publish	'getAlbums', ->
		console.dir 'getAlbums'
		Albums.find()