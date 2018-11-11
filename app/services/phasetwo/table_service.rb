class TableService
    
        @@final_output
        @@table
        attr_accessor :table,:final_output
        def initialize(table,input)
            self.table=table
            self.final_output= self.get_data input
            # final_output = self.get_data final_input
        end


        def get_data input
             self.table.prepare_input input
        end

        def final 
            self.final_output
        end
end