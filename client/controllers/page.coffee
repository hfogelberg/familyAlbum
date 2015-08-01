$.cloudinary.config
	cloud_name: Meteor.settings.public.cloud_name

incrementLimit = (inc = ITEMS_INCREMENT) ->
  newLimit = Session.get('limit') + inc
  Session.set 'limit', newLimit
  return

Template.pages.created = ->
  Session.setDefault 'limit', ITEMS_INCREMENT

  Deps.autorun ->
    Meteor.subscribe 'getPages', Session.get('limit'), Session.get('albumId')
    return
  return

Template.pages.helpers pages: ->
	console.log('Getting pages')
	pages = Pages.find({albumId: Session.get('albumId')},{limit: Session.get('limit')})
	console.log pages
	return pages

Template.addPage.rendered = ->
	$('.addpageBtn').attr('disabled', 'disabled')
	return

Template.addPage.events
	"change input.file_bag": (e) ->
		files = e.currentTarget.files
		$('.addPageBtn').attr('disabled', 'disabled')

		Cloudinary.upload files,
			folder: 'familyAlbum'
			(err,res) ->
				console.log "Upload Error: #{err}"
				console.log "Upload Result: #{res}"
				console.log res.public_id
				@image = res.public_id
				$('.addPageBtn').removeAttr('disabled')

	'click .addPageBtn': (event, template)->
		event.preventDefault
		description = template.find(".description").value
		Meteor.call 'savePageToDb', Session.get('albumId'), image, description, (error) ->
		template.find('.description').value = ''
		files.clear()


Template.addPage.helpers
	"files": ->
		Cloudinary.collection.find()

	"complete": ->
		@status is "complete"
