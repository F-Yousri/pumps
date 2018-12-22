  class PcpTable

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data input  
        @array=Pcp.select('Imperial_H').where(Imperial_Q:  input[:Imperial_Q]).map(&:Imperial_H)
        @array=@array.sort
        @IH_PC=@array.find { |e| e > input[:H_PCP] }
        @e=Pcp.select('eccentricity').where(Imperial_Q:  input[:Imperial_Q]).map(&:eccentricity)
        @d_r=Pcp.select('rotor_minor_diameter').where(Imperial_Q:  input[:Imperial_Q]).map(&:rotor_minor_diameter)
        @hydraulic_torque=Pcp.select('hydraulic_torque').where(Imperial_Q:  input[:Imperial_Q]).map(&:hydraulic_torque)

        @data={
            e: @e[0],
            d_r: @d_r[0],
            IH_PC:@IH_PC,
            hydraulic_torque:@hydraulic_torque[0]
        }
    end 
  end


