# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(window).load ->
  $('input[data-toggle="theme"]').live "change", (event) ->
    new_theme = $(this).val()
    new_theme_href = "/assets/themes/#{new_theme}/all.css?reload=#{Math.random()}"
    theme_stylesheet = $('head link[href^="/assets/themes/"]')
    theme_stylesheet.attr("href", new_theme_href)


OUT.highlightQuery = () ->
  $("*[data-highlight-query]").each ->
    query = $(this).data("highlight-query")
    if query? && query != ""
      regex = new RegExp("(#{query})", "gi")
      if $(this).html().match regex
        $(this).addClass "highlighted-query"
        $(this).highlight query

$ ->
  OUT.highlightQuery()
