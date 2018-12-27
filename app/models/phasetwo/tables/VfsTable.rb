  class VfsTable

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data input   
      @Availablevfs=Vfd.select('PMM').map(&:PMM)
      @new=@Availablevfs.sort 
      @pmm=@new.find { |e| e > input }
      @pmm
      @vfs=Vfd.select('model').where(PMM: @pmm).map(&:model)
      @vfs[0]
    end 
  end