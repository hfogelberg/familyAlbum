$.cloudinary.config
	cloud_name: Meteor.settings.public.cloud_name

Template.addAlbum.rendered = ->
	$('.addAlbumBtn').attr('disabled', 'disabled')
	return

Template.addAlbum.events
	"change input.file_bag": (e) ->
		files = e.currentTarget.files
		$('.addAlbumBtn').attr('disabled', 'disabled')

		Cloudinary.upload files,
			folder: 'familyAlbum'
			(err,res) ->
				console.log "Upload Error: #{err}"
				console.log "Upload Result: #{res}"
				console.log res.public_id
				@image = res.public_id
				$('.addAlbumBtn').removeAttr('disabled')


	'click .addAlbumBtn': (event, template)->
		event.preventDefault

		description = template.find(".description").value

		Meteor.call 'saveAlbumToDb', image, description, (error) ->
		Router.go '/admin'


Template.addAlbum.helpers
	"files": ->
		Cloudinary.collection.find()

	"complete": ->
		@status is "complete"