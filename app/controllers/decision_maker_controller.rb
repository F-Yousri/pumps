class DecisionMakerController < ApplicationController
    require "#{Rails.root}/lib/phasetwo/table_generate.rb"
    require "#{Rails.root}/app/services/phasetwo/table_service.rb"
    def techEvalForm        
    end

    def techEval
        @params = DecisionMakerService.make(params)

        @params
    end

    def phasetwo
        table = Tablegenerate.new('mina').get_table
        data = TableService.new(table,50).final
        render html:  data
    end
end
