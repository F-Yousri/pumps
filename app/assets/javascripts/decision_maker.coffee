# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require enums
#= require Property

$ ->

    #variable used
    MDInput = {}
    inputs = $('input.property');
    #loop on properties to create their objects
    inputs.each ->
        unitDependants = enums.unitDependants[$(this).prop('name')] or [] ;
        unitDependants = unitDependants.map (property) ->
            "[name=#{property}]"
        
        valueDependants = enums.valueDependants[$(this).prop('name')] or [] ;
        valueDependants = valueDependants.map (property) ->
            "[name=#{property}]"

        PropertyFactory
            .getProperty($(this).prop('name'))
            .setNode($(this))
            .setCategory($(this).closest('[unit]').attr('unit'))
            .setUnitDependants($("#{unitDependants.join(',')}"))
            .setValueDependants($("#{valueDependants.join(',')}"))


    #loop on property objects to create validations
    properties = PropertyFactory.properties
    for name, obj of properties
        obj.valueDependants.parent().append("<span class=' alert-wrong hidden' role='alert'> Can't Exceed #{name} </span>")
        obj.unitDependants.prop('type', enums.inputTypes[obj.category]).addClass('col-sm-9').after('<select class="col-sm-3 form-control"></select>')
        options = enums.units[obj.category]
        #append options to select
        if options 
            for option, index in options
                obj.unitDependants.siblings('select').append("<option value='#{index + 1}'> #{option} </option>")
        #set max if number input and has max
        if enums.inputTypes[obj.category] == "number" and enums.max["#{obj.name}"]?
            max = enums.max[ "#{name}" ][ "#{obj.node.siblings('select').children('option:selected').text().trim() }" ]
            obj.node.prop( 'max', max );
            
            obj.node.siblings('select').change (event)->
                property = $(this).siblings('input')
                max = enums.max["#{property.prop('name')}"]["#{$(this).children('option:selected').text().trim()}"]
                property.prop('max', max ).prop('placeholder', "#{property.prop('name')} max allowable #{obj.category} is #{max}")
                PropertyFactory.properties["#{property.prop('name')}"].unitDependants.trigger('change').siblings('select').val($(this).val())

            obj.node.change (event) ->
                property =  PropertyFactory.properties["#{$(this).prop('name')}"]
                property.valueDependants.prop('max', $(this).val()).trigger('change') 
        #disable unit select in dependants
        obj.unitDependants.not("[name=#{name}]").siblings("select").prop("disabled", "disabled")

    #If a field is empty on submit open its tab and show error msg
    $('#tech-form').submit (event) ->
        $('.property').each ->
            if ! $(this).val()
                event.preventDefault();
                event.stopPropagation();
                $(this).closest('.collapse').collapse('show')
                $(this).siblings('.alert-required').removeClass('hidden').focus()
    
    #check all inputs value validity on change
    $('.property').change ->
        if $(this).val()
            $(this).siblings('.alert-required').addClass('hidden')
            if +$(this).val() > +$(this).prop('max')
                $(this).addClass('invalid').removeClass('valid').siblings('.alert-wrong').removeClass('hidden')
            else
                $(this).addClass('valid').removeClass('invalid').siblings('.alert-wrong').addClass('hidden')


