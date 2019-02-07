  class DriveheadTable 

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data input
        @AvailableTorque=Drivehead.select('max_torque').map(&:max_torque)
        @new=@AvailableTorque.sort 
        @Torque=@new.find { |e| e > input[:T_tot] }
        @num=@new.index(@Torque)
        @AvailableBearing=Drivehead.select('thrust_bearing').map(&:thrust_bearing)
        @new2=@AvailableBearing.sort 
        @TB=@new2.find { |e| e > input[:T_tot] }
        @num2=@new2.index(@TB)
        @AvailableHp=Drivehead.select('hp').map(&:hp)
        @new3=@AvailableHp.sort
        @MHP_Ps=@new3.find { |e| e > input[:MHP_P] }
        @num3=@new3.index(@MHP_Ps)
        @index=[@num,@num2,@num3].max
        @index+1
        @gm=Drivehead.select('gm').where(id: @index+1).map(&:gm)
        @price=Drivehead.select('price').where(gm: @gm).map(&:price)
        @data={
            Torque:@Torque,
            TB:@TB,
            MHP_Ps:@MHP_Ps,
            gm:@gm[0],
            phc:@price[0]
        }

    end 
  end


