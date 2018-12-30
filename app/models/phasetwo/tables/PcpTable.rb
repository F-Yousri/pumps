  class PcpTable

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data input  
        @array1=Pcp.select('Imperial_Q').map(&:Imperial_Q)
        @array1=@array1.sort
        @Imperial_Q=@array1.find { |e| e > input[:V_min] }
        @array2=Pcp.select('Imperial_H').where(Imperial_Q: @Imperial_Q).map(&:Imperial_H)
        @array2=@array2.sort
        @IH_PC=@array2.find { |e| e > input[:H_PCP] }
        @e=Pcp.select('eccentricity').where(Imperial_Q: @Imperial_Q).map(&:eccentricity)
        @d_r=Pcp.select('rotor_minor_diameter').where(Imperial_Q: @Imperial_Q).map(&:rotor_minor_diameter)
        @hydraulic_torque=Pcp.select('hydraulic_torque').where(Imperial_Q:  @Imperial_Q).map(&:hydraulic_torque)

        @data={
            e: @e[0],
            d_r: @d_r[0],
            IH_PC:@IH_PC,
            hydraulic_torque:@hydraulic_torque[0],
            IQ_PCP: @Imperial_Q
        }
    end 
  end


