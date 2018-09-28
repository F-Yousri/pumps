exports = this
exports.PropertyFactory = do -> 
    class @Property
        constructor: (@name) ->
        
        setNode: (@node) ->
            this

        setUnitDependants: (@unitDependants) ->
            this

        setValueDependants: (@valueDependants) ->
            this

        setCategory: (@category) ->
            this
        
        setInputType: (@units) ->
            this

    properties = {}

    makeProperty = (name) ->
        property = new Property(name)
        properties["#{name}"] = property
        property

    getProperty = (name) ->
        properties["#{name}"] or makeProperty(name)



    { getProperty, properties }