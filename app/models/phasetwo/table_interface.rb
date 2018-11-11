class TableClass < ActiveRecord::Base
    # An "abstract" method
    def prepare_input
      raise NotImplementedError, "Subclasses must define `method1`."
    end

    def get_data
        raise NotImplementedError, "Subclasses must define `method1`."
    end

end
