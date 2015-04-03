"use strict"

class CMW.Initialize
	constructor: ->
		@plugins()
		@loader()

	plugins: ->
		new zoQ.Init
			Alerts    : true
			Popups    : true
			AjaxEnable: false

		$.hook("panel").sticky()
		return
		
	loader: ->
		new CMW.Common()
		new CMW.Panel()
		new CMW.Settings()
		new CMW.Coming_soon()
		new CMW.Add_work()
		return

$ ->
	new CMW.Initialize()
	return
