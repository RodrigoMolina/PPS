jQuery.fn.ajaxSelect = (options) ->
 if ! $(this).data('select2')
   url = $(this).data('url')
   placeholder = $(this).data('placeholder')
   allow_clear = $(this).data('allow-clear')
   new_button = $(this).data('new-button')


   defaults =
     formatter: (record) ->
       record.full_text || record.name
     result_formatter: (record, container, query, escapeMarkup) ->
       markup = []
       text = settings.format_name(record)
       Select2.util.markMatch(text, query.term, markup, escapeMarkup)
       markup = markup.join("")
       markup = "<div class='select2-main-text'> #{markup} </div>"
       if record.extra
         markup += settings.format_extra(record)

       return markup
     format_name: (record) ->
       record.full_text || record.name
     format_extra: (record) ->
       return "<small class='select2-extra-text'> #{record.extra} </small>"

     allow_clear: true
     selectData: (term, page)->
       query: term
       limit: 10
       page: page

   settings = $.extend(defaults, options)

   if new_button == undefined
    format_no_matches = $.fn.select2.locales['es']['formatNoMatches']
   else
    format_no_matches = () ->
      new_button

   this.select2
     formatNoMatches: format_no_matches
     initSelection: (elm, callback) ->
       data =
         id: $(elm).data "record-id"
         name: $(elm).data "record-text"
       callback(data)
     placeholder: placeholder
     allowClear: allow_clear
     minimumInputLength: 2
     ajax:
       url: url
       dataType: "json"
       quietMillis: 100
       data: (term, page) ->
         settings.selectData(term, page)
       results: (data, page) ->
         more = (page * 10) < data.total
         results: data
         more: more
     formatResult: settings.result_formatter
     formatSelection: settings.formatter



jQuery.fn.normalSelect = (options) ->
 placeholder = $(this).data('placeholder')
 allow_clear = $(this).data('allow-clear')

 defaults =

 settings = $.extend(defaults, options)

 this.select2
   placeholder: placeholder
   allowClear: allow_clear




#------------------------------- Select2 of Country, Province and City, cascade
jQuery.fn.ajaxSelectGeo = (options) ->
 if ! $(this).data('select2')
   url = $(this).data('url')
   kind = $(this).data('kind')   
   placeholder = $(this).data('placeholder')
   allow_clear = $(this).data('allow-clear')
   new_button = $(this).data('new-button')
   div_container = $(this).closest('.select_ajax_geo_container')
   country_select = div_container.find("[data-kind='country']")
   province_select = div_container.find("[data-kind='province']")
   city_select = div_container.find("[data-kind='city']")


   defaults =
     formatter: (record) ->
       record.full_text || record.name
     result_formatter: (record, container, query, escapeMarkup) ->
       markup = []
       text = settings.format_name(record)
       Select2.util.markMatch(text, query.term, markup, escapeMarkup)
       markup = markup.join("")
       markup = "<div class='select2-main-text'> #{markup} </div>"
       if record.extra
         markup += settings.format_extra(record)

       return markup
     format_name: (record) ->
       record.full_text || record.name
     format_extra: (record) ->
       return "<small class='select2-extra-text'> #{record.extra} </small>"

     allow_clear: true
     selectData: (term, page)->
       query: term
       limit: 10
       page: page

   settings = $.extend(defaults, options)

   if new_button == undefined
    format_no_matches = $.fn.select2.locales['es']['formatNoMatches']
   else
    format_no_matches = () ->
      new_button

   this.select2
     formatNoMatches: format_no_matches
     initSelection: (elm, callback) ->
       data =
         id: $(elm).data "record-id"
         name: $(elm).data "record-text"
       callback(data)
     placeholder: placeholder
     allowClear: allow_clear
     minimumInputLength: 1
     ajax:
       url: () ->
        switch kind
         when 'province'
           url + '/' + country_select.val()
         when 'city'
           url + '/' + province_select.val()
         else
           url

       dataType: "json"
       quietMillis: 100
       data: (term, page) ->
         settings.selectData(term, page)
       results: (data, page) ->
         more = (page * 10) < data.total
         results: data
         more: more
     formatResult: settings.result_formatter
     formatSelection: settings.formatter


    switch kind
     when 'country'
       $(this).on "change", ->
         province_select.select2("val", "")
         city_select.select2("val", "")
     when 'province'
       $(this).on "change", ->
         city_select.select2("val", "")