requirejs.config
    baseUrl: '/assets/js'
    paths:
        jquery: '../components/jquery/jquery.min'
        scrollto: '../components/jquery.scrollto.min'
        transit: '../components/jquery.transit.min'
        vide: '../components/jquery.vide.min'
        remodal: '../components/remodal/jquery.remodal'
        showgrid: '../components/showgrid/showgrid'
    
###
# Wrapper function for App class
# @param  {Array} dependencies [Dependencies list]
# @param  {Function} init      [Callback function, pass app instance as parameter, optional]
# @return {App}
###
app = (dependencies, init) ->
    require [
        'jquery'
        'helpers'
    ], ->
        new App(dependencies, init)
                
###
# Create new App instance
# If second parameter is not presented, then first parameter becomes init function
# @param  {Array} dependencies [Dependencies list]
# @param  {Function} init      [Callback function, pass app instance as parameter, optional]
###
class App
    constructor: (dependencies, init) ->
        if init
            @require [ '*' ], dependencies, (->
                init this
            ).bind(this)
        else
            init = dependencies
            init this
            
###
# Require scripts for specific pages
# @param  {Array} pages       [Array of page urls]
# @param  {Array} scripts     [Array of dependencies]
# @param  {Function} callback [Callback function]
# @return {void}
###
App::require = (pages, scripts, callback) ->
    if typeof callback == 'undefined'
        callback = ->
    
    # If first parameter is not present
    if typeof scripts == 'function'
        callback = scripts
        scripts = pages
        pages = [ '*' ]
    
    current = trimSlashes(window.location.pathname)
    for i of pages
        path = trimSlashes(pages[i])
        if startsWith(path, current)
            require scripts, callback.bind(this)


###
# Check if string contains * symbol
# @param  {String} string
# @return {String}
###

hasAnyPattern = (string) ->
    string.indexOf('*') != -1

###
# Search string in another string with *
# Or compare strings if no * presented
# @param  {String} search
# @param  {String} string
# @return {Boolean}
###

startsWith = (search, string) ->
    if hasAnyPattern(search)
        reg = new RegExp('^' + search.replace('*', ''))
        reg.test string
    else
        search = trimSlashes(search.replace('*', ''))
        search == string