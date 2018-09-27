# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
    #If a field is empty open its tab and show error msg
    $('#tech-form').submit (event) ->
        $('.property').each ->
            if ! $(this).val()
                event.preventDefault();
                $(this).closest('.collapse').collapse('show')
                $(this).siblings('.alert-required').removeClass('hidden').focus()
    
    $('.property').change ->
        if $(this).val()
            $(this).siblings('.alert-required').addClass('hidden')


    # add select field for depth unit on depth properties
    $('[unit=depth').children('input').addClass('col-sm-9').after('<select class="depth-unit col-sm-3 form-control"></select>')
    $depths = $('.depth-unit')
    MDUnit = $('[name=MD').siblings('.depth-unit')[0]
    $depths.append('<option value="1"> ft </option>')
    $depths.append('<option value="2"> mt </option>')
    
    #disable all depth units but MD and apply its value on the rest
    $depths.not(MDUnit).prop('disabled', 'disabled')
    $(MDUnit).change (event) ->
        $depths.val($(MDUnit).val())

    #vertical depth shouldn't exceed measured depth
    $MDInput = $('[name=MD]')
    $TVDInput = $('[name=TVD]')
    $TVDInput.parent().append("<div class='alert alert-danger alert-wrong hidden' role='alert'> Can't Exceed Measured Depth </div>")
    $TVDInput.change (event) ->
        if $TVDInput.val() > $MDInput.val() 
            event.preventDefault();
            $TVDInput.siblings('.alert-wrong').removeClass('hidden')
        else
            $TVDInput.siblings('.alert-wrong').addClass('hidden')




