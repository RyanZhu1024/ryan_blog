# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

parseMarkdown= ->
	# Showdown = require('showdown');
	converter = new Showdown.converter({ extensions: 'github' });
	converter= converter
	content=$('#content').val()
	$('.article1').html(converter.makeHtml(content)) 

getTags= ->
	callback=(response) ->
		for elem in response
			$('.tagTable ul').append("<li class='help-block'><a>#{elem.name}</a></li>")
		$('.tagTable ul li').click ->
			tag=$(this).text()
			hasTags=$('#tags').val().split(' ')
			if hasTags.indexOf(tag)<0
				hasTags.push(tag)
				$('#tags').val(hasTags.join(' '))
			# alert($(this).text())
		$('#tags').unbind 'click'
	$.ajax
		url:'/articles/getTags'
		type:'GET'
		dataType:'json'
		success:callback
		error:(response) ->
			alert('Failed to get tags from server or json pased error')


$ ->
	$('#tags').click ->
		getTags()
	setInterval(parseMarkdown,100) if $('#content').length>0
	$('#post').click ->
		clearInterval(parseMarkdown)






