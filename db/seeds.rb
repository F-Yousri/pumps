# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
Pump.create!([
  {name: "ESP"}
])
Tab.create!([
    {name: "Well Data"},
    {name: "Fluid Characteristics"},
    {name: "Production Parameters"},
    {name: "Staff Experience"},
    {name: "PVT Data at Pump Depth"},
    {name: "Additional Criteria"},
    {name: "Selection Criteria"}
  ])
Property.create!([
  {name: "MD", tab_id: 1, description: "Measured Well depth", choice_type: "text_box", note: "should not exceed 16000 ft or 4800 m.", unit_type: "depth"},
  {name: "TVD", tab_id: 1, description: "Total vertical Depth", choice_type: "text_box", note: "Shouldn't exceed Measured Well Depth", unit_type: "depth"},
  {name: "WL", tab_id: 1, description: "Well Location", choice_type: "list_box", note: "", unit_type: "viscosity"},
  {name: "WD", tab_id: 1, description: "Well Deviation", choice_type: "text_box", note: "Should not exceed 90 deg.", unit_type: "rate_per_pressure"},
  {name: "D_perf", tab_id: 1, description: "Perforation Vertical Depth", choice_type: "text_box", note: "Shouldn't exceed Measured Depth", unit_type: "depth"},
  {name: "DS", tab_id: 1, description: "Dogleg Severity", choice_type: "text_box", note: "Shouldn't exceed 15.", unit_type: "weight"},
  {name: "CSG_ND", tab_id: 1, description: "Casing Nominal Diameter", choice_type: "list_box", note: "", unit_type: "viscosity"},
  {name: "TBG_ND", tab_id: 1, description: "Tubing Nominal Diameter", choice_type: "list_box", note: "Maximum 3.5\" for 5\" casings.", unit_type: "viscosity"},
  {name: "T_bh", tab_id: 1, description: "Bottomhole Temperature", choice_type: "text_box", note: "", unit_type: "viscosity"},
  {name: "T_sc", tab_id: 1, description: "Surface Temperature", choice_type: "text_box", note: "", unit_type: "viscosity"},
  {name: "MD_pump", tab_id: 1, description: "Pump Measured Depth", choice_type: "text_box", note: "Shouldn't exceed Measured Depth", unit_type: "depth"},
  {name: "VD_pump", tab_id: 1, description: "Pump Vertical Depth", choice_type: "text_box", note: "Shouldn't exceed Perforation Depth.", unit_type: "depth"},
  {name: "VD_FL", tab_id: 1, description: "Fluid Level Vertical Depth", choice_type: "text_box", note: "Shouldn't exceed Perforation Depth.", unit_type: "depth"},
  {name: "SG_g", tab_id: 2, description: "Gas Specific Gravity", choice_type: "text_box", note: "", unit_type: nil},
  {name: "GGD", tab_id: 2, description: "Gas Grediant", choice_type: "text_box", note: "", unit_type: nil},
  {name: "SG_w", tab_id: 2, description: "Water Specific Gradient", choice_type: "text_box", note: "", unit_type: nil},
  {name: "API", tab_id: 2, description: "API Gravity", choice_type: "text_box", note: "", unit_type: nil},
  {name: "SG_o", tab_id: 2, description: "Oil Gravity", choice_type: "text_box", note: "", unit_type: nil},
  {name: "AP", tab_id: 2, description: "Abrasives Production", choice_type: "list_box", note: "", unit_type: nil},
  {name: "CP", tab_id: 2, description: "Corrosive Fluid Production", choice_type: "list_box", note: "", unit_type: nil},
  {name: "ArP", tab_id: 2, description: "Aromatics Production", choice_type: "list_box", note: "", unit_type: nil},
  {name: "EP", tab_id: 2, description: "Emulsion Production", choice_type: "radio_box", note: "", unit_type: nil},
  {name: "SP", tab_id: 2, description: "Scale Production", choice_type: "radio_box", note: "", unit_type: nil},
  {name: "PP", tab_id: 2, description: "Parafin Production", choice_type: "radio_box", note: "", unit_type: nil},
  {name: "PR", tab_id: 3, description: "Reservoir Pressure", choice_type: "text_box", note: "", unit_type: "pressure"},
  {name: "WHP", tab_id: 3, description: "Wellhead Pressure", choice_type: "text_box", note: "", unit_type: "pressure"},
  {name: "CHP", tab_id: 3, description: "Casing Head Pressure", choice_type: "text_box", note: "Shouldn't exceed Wellhead Pressure", unit_type: "pressure"},
  {name: "PF_esp", tab_id: 6, description: "ESP PLS Flexibility", choice_type: "text_box", note: "", unit_type: nil},
  {name: "GQ", tab_id: 3, description: "Desired Gross Rate", choice_type: "text_box", note: "Shouldn't exceed 9000", unit_type: nil},
  {name: "J", tab_id: 3, description: "Productivity Index", choice_type: "text_box", note: "", unit_type: "rate_per_pressure"},
  {name: "Q_g", tab_id: 3, description: "Anticipated Gas Rate", choice_type: "text_box", note: "", unit_type: nil},
  {name: "WC", tab_id: 3, description: "Anticipated W.C", choice_type: "text_box", note: "From 0 to 100 %", unit_type: nil},
  {name: "GOR", tab_id: 3, description: "Gas Oil ratio", choice_type: "calculated", note: "", unit_type: nil},
  {name: "GLR", tab_id: 3, description: "Gas Liqued Ratio", choice_type: "calculated", note: "", unit_type: nil},
  {name: "SE_esp", tab_id: 4, description: "ESP", choice_type: "list_box", note: "", unit_type: nil},
  {name: "SE_wspcp", tab_id: 4, description: "ESPCP", choice_type: "list_box", note: "", unit_type: nil},
  {name: "SE_pcp", tab_id: 4, description: "PCP", choice_type: "list_box", note: "", unit_type: nil},
  {name: "SE_srp", tab_id: 4, description: "SRP", choice_type: "list_box", note: "", unit_type: nil},
  {name: "SE_lrp", tab_id: 4, description: "LRP", choice_type: "list_box", note: "", unit_type: nil},
  {name: "AST", tab_id: 4, description: "Available Servicing Type", choice_type: "list_box", note: "", unit_type: nil},
  {name: "EC", tab_id: 4, description: "Electrical Consumption rate", choice_type: "text_box", note: "", unit_type: nil},
  {name: "GC", tab_id: 4, description: "Gas Consumption Rate", choice_type: "text_box", note: "", unit_type: nil},
  {name: "V_ml", tab_id: 4, description: "Main Voltage Line", choice_type: "text_box", note: "", unit_type: nil},
  {name: "meo_o", tab_id: 5, description: "Oil Viscosity", choice_type: "text_box", note: "", unit_type: nil},
  {name: "beta_o", tab_id: 5, description: "Oil volume Factor", choice_type: "text_box", note: "", unit_type: nil},
  {name: "beta_g", tab_id: 5, description: "Gas Volume factor", choice_type: "text_box", note: "", unit_type: nil},
  {name: "R_s", tab_id: 5, description: "Gas Solubility", choice_type: "text_box", note: "", unit_type: nil},
  {name: "Z", tab_id: 5, description: "Gas Compressibility Factor", choice_type: "text_box", note: "", unit_type: nil},
  {name: "meo_w", tab_id: 5, description: "Water Viscosity", choice_type: "text_box", note: "", unit_type: nil},
  {name: "beta_w", tab_id: 5, description: "Water Volume Factor", choice_type: "text_box", note: "", unit_type: nil},
  {name: "PF_espcp", tab_id: 6, description: "ESPCP PLS Flexibility", choice_type: "text_box", note: "", unit_type: nil},
  {name: "PF_pcp", tab_id: 6, description: "PCP PLS Flexibility", choice_type: "text_box", note: "", unit_type: nil},
  {name: "PF_srp", tab_id: 6, description: "SRP PLS Flecibility", choice_type: "text_box", note: "", unit_type: nil},
  {name: "PF_lrp", tab_id: 6, description: "LRP PLS Flexibility", choice_type: "text_box", note: "", unit_type: nil},
  {name: "PR_esp", tab_id: 6, description: "ESP PLS Reliability", choice_type: "text_box", note: "", unit_type: nil},
  {name: "PR_espcp", tab_id: 6, description: "ESPCP PLS Reliability", choice_type: "text_box", note: "", unit_type: nil},
  {name: "PR_pcp", tab_id: 6, description: "PCP PLS Reliability", choice_type: "text_box", note: "", unit_type: nil},
  {name: "PR_srp", tab_id: 6, description: "SRP PLS Reliability", choice_type: "text_box", note: "", unit_type: nil},
  {name: "PR_lrp", tab_id: 6, description: "LRP PLS Reliability", choice_type: "text_box", note: "", unit_type: nil},
  {name: "SE_esp", tab_id: 6, description: "ESP System Efficiency", choice_type: "text_box", note: "", unit_type: nil},
  {name: "SE_espcp", tab_id: 6, description: "ESPCP System Efficiency", choice_type: "text_box", note: "", unit_type: nil},
  {name: "SE_pcp", tab_id: 6, description: "PCP System Efficiency", choice_type: "text_box", note: "", unit_type: nil},
  {name: "SE_srp", tab_id: 6, description: "SRP System Efficiency", choice_type: "text_box", note: "", unit_type: nil},
  {name: "SE_lrp", tab_id: 6, description: "LRP System Efficiency", choice_type: "text_box", note: "", unit_type: nil},
  {name: "W_WL", tab_id: 7, description: "Well Location Weight", choice_type: "text_box", note: "Percentage.", unit_type: nil},
  {name: "W_MD", tab_id: 7, description: "Measured Depth Weight", choice_type: "text_box", note: "Percentage.", unit_type: nil},
  {name: "W_WD", tab_id: 7, description: "Well Deviation Weight", choice_type: "text_box", note: "Percentage.", unit_type: nil},
  {name: "W_CSG_ND", tab_id: 7, description: "Casing Diameter Weight", choice_type: "text_box", note: "Percentage.", unit_type: nil},
  {name: "W_DS", tab_id: 7, description: "Dogleg Severity Weight", choice_type: "text_box", note: "Percentage.", unit_type: nil},
  {name: "W_GQ", tab_id: 7, description: "Desired Gross Rate weight", choice_type: "text_box", note: "Percentage.", unit_type: nil},
  {name: "W_J", tab_id: 7, description: "Productivity Index Weight", choice_type: "text_box", note: "Percentage.", unit_type: nil},
  {name: "W_T_bh", tab_id: 7, description: "Bottomhole Temperature Weight", choice_type: "text_box", note: "Percentage.", unit_type: nil},
  {name: "W_meo_m", tab_id: 7, description: "Fluid Viscosity Weight", choice_type: "text_box", note: "Percentage.", unit_type: nil},
  {name: "W_API", tab_id: 7, description: "Oil gravity Weight", choice_type: "text_box", note: "Percentage.", unit_type: nil},
  {name: "W_AP", tab_id: 7, description: "Abrasives Production Weight", choice_type: "text_box", note: "Percentage.", unit_type: nil},
  {name: "W_CP", tab_id: 7, description: "Corrosive Fluid Production Weight", choice_type: "text_box", note: "Percentage.", unit_type: nil},
  {name: "W_ArP", tab_id: 7, description: "Aromatics Production Weight", choice_type: "text_box", note: "Percentage.", unit_type: nil},
  {name: "W_EP", tab_id: 7, description: "Emulsion Production Weight", choice_type: "text_box", note: "Percentage.", unit_type: nil},
  {name: "W_SP", tab_id: 7, description: "Scale Production Weight", choice_type: "text_box", note: "Percentage.", unit_type: nil},
  {name: "W_PP", tab_id: 7, description: "Parafin Production Weight", choice_type: "text_box", note: "Percentage.", unit_type: nil},
  {name: "W_GLR", tab_id: 7, description: "Gas Liqued Ratio Weight", choice_type: "text_box", note: "Percentage.", unit_type: nil},
  {name: "W_APM", tab_id: 7, description: "Available Prime Mover", choice_type: "text_box", note: "Percentage.", unit_type: nil},
  {name: "W_SE", tab_id: 7, description: "Staff Experience", choice_type: "text_box", note: "Percentage.", unit_type: nil},
  {name: "W_AST", tab_id: 7, description: "Available Servicing Type", choice_type: "text_box", note: "Percentage.", unit_type: nil},
  {name: "W_PF", tab_id: 7, description: "PLS Flexibility", choice_type: "text_box", note: "Percentage.", unit_type: nil},
  {name: "W_PR", tab_id: 7, description: "PLS Reliability", choice_type: "text_box", note: "PLS Reliability", unit_type: nil},
  {name: "W_SE", tab_id: 7, description: "System Efficiency", choice_type: "text_box", note: "Percentage.", unit_type: nil}
])

