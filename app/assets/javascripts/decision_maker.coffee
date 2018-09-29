# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require enums
#= require Property

$ ->

    #variable used
    inputs = $('input.property')

    #construct properties and fill PropertyFactory
    do ( inputs ) ->
        inputs.each ->
            unitDependants = enums.unitDependants[$(this).prop('name')] or []
            unitDependants = unitDependants.map (property) ->
                "[name=#{property}]"
            
            valueDependants = enums.valueDependants[$(this).prop('name')] or []
            valueDependants = valueDependants.map (property) ->
                "[name=#{property}]"

            #create the property object and fill with data
            PropertyFactory
                .getProperty($(this).prop('name'))
                .setNode($(this))
                .setCategory($(this).closest('[unit]').attr('unit'))
                .setUnitDependants($("#{unitDependants.join(',')}"))
                .setValueDependants($("#{valueDependants.join(',')}"))

    #check weights sum is 100%
    weights = []
    do ( properties = PropertyFactory.properties ) ->
        for name, obj of properties
            if name.includes('W_')
                weights.push(obj.node)
        weights

    weightsValidate = ( propWeights ) ->
        total = propWeights.map( (node) -> parseInt(node.val()) or 0)
                        .reduce((sum, percentage) -> percentage + sum)
        total

    #loop on property objects to create validations
    do ( properties = PropertyFactory.properties ) ->
        
        for name, obj of properties
            obj.unitDependants.prop('type', enums.inputTypes[obj.category]).addClass('col-sm-9')
            .after('<select class="col-sm-3 form-control"></select>')
            
            #append options to select
            options = enums.units[obj.category]
            if options
                for option, index in options
                    obj.unitDependants
                    .siblings('select').append("<option value='#{index + 1}'> #{option} </option>")
            
            #set max of node
            if enums.inputTypes[obj.category] == "number" and enums.max["#{obj.name}"]?
                unit = obj.node.siblings('select').children('option:selected').text().trim()
                max = enums.max[ "#{name}" ][ "#{unit}" ]
                obj.node.prop( 'max', max )
                
            
            #disable unit select in dependants and attach event to leader to instruct their units
            if options and options.length > 1
                obj.unitDependants.not("[name=#{name}]")
                .siblings("select").prop("disabled", "disabled")
            else
                obj.unitDependants.siblings("select").prop("disabled", "disabled")

            obj.node.siblings('select').change (event) ->
                property = $(this).siblings('input')
                unit =  $(this).children('option:selected').text().trim()
                category = property.closest('[unit]').attr('unit')
                
                #set placeholder and max according to unit limit
                max = enums.max["#{property.prop('name')}"]["#{unit}"]
                placeholder = "#{property.prop('name')} max allowable #{category} is #{max} #{unit}"
                property.prop('max', max )
                .prop('placeholder', placeholder)
                PropertyFactory.properties["#{property.prop('name')}"]
                .unitDependants.trigger('change')
                .siblings('select').val($(this).val())
            
            #set max to nodes dependant in value on current node and set error message
            obj.valueDependants.parent()
            .append("<span class=' alert-wrong hidden' role='alert'> Can't Exceed #{name} </span>")
            obj.node.change (event) ->
                property =  PropertyFactory.properties["#{$(this).prop('name')}"]
                property.valueDependants.prop('max', $(this).val()).trigger('change')

    
    #check all inputs value validity on change
    $('.property').change ->
        if $(this).val()
            $(this).siblings('.alert-required').addClass('hidden')
            if +$(this).val() > +$(this).prop('max') or +$(this).val() < +$(this).prop('min')
                $(this).addClass('invalid').removeClass('valid')
                .siblings('.alert-wrong').removeClass('hidden')
            else
                $(this).addClass('valid').removeClass('invalid')
                .siblings('.alert-wrong').addClass('hidden')

    #If a field is empty on submit open its tab and show error msg
    $('#tech-form').submit (event) ->

        $('.property').each ->
            if ! $(this).val()
                event.preventDefault()
                event.stopPropagation()
                $(this).closest('.collapse').collapse('show')
                $(this).removeClass('valid')
                .siblings('.alert-required').removeClass('hidden').focus()
        
        totalWeight = weightsValidate weights
        if totalWeight != 100
            event.preventDefault()
            event.stopPropagation()
            $("[name='Selection Criteria']").children(".alert-wrong").remove()
            $("[name='Selection Criteria']").collapse('show')
            error = "<div class='alert alert-danger alert-wrong'>Weights sum must be 100% currently #{totalWeight}</div>"
            .prepend(error)
            .find('input').addClass('invalid')

        wrong = $('.alert-wrong:not(.hidden)')
        if wrong.length
            event.preventDefault()
            event.stopPropagation()

    $('[unit=percentage').find('input').prop('max', 100)

    $('[name=GQ], [name=Q_g], [name=WC]').change (event) ->
        GQ = parseFloat( $('[name=GQ]').val() ) or 0
        Q_g = parseFloat( $('[name=Q_g]').val() ) or 0
        WC = parseFloat( $('[name=WC]').val() ) or 0
        GOR = 0
        GLR = 0
        dominator =  GQ * (1.0 - WC/100)
        if dominator and Q_g
            GOR = Q_g * 1000 / dominator
        if dominator = GQ
            GLR = Q_g * 1000 / dominator
        $('[name=GOR]').val(GOR)
        $('[name=GLR]').val(GLR)


