exports = this
exports.enums = {
    unitDependants: {
        MD: [
            'MD',
            'TVD',
            'MD_pump',
            'VD_pump',
            'D_perf',
            'VD_FL'
        ],
        WD: [
            'WD'
        ],
        WGD: [
            'WGD',
            'GGD'
        ],
        PR: [
            'PR'
        ],
        WHP: [
            'WHP'
        ],
        CHP: [
            'CHP'
        ],
        GQ: [
            'GQ'
        ],
        J: [
            'J'
        ],
        Q_g: [
            'Q_g'
        ],
        WC: [
            'WC'
        ],
        GOR: [
            'GOR'
        ],
        GLR: [
            'GLR'
        ],
        DS: [
            'DS'
        ],
        T_sc: [
            'T_bh',
            'T_sc'
        ],
        W_WL: [
            'W_WL',
            'W_MD',
            'W_WD',
            'W_CSG_ND',
            'W_DS',
            'W_GQ',
            'W_J',
            'W_T_bh',
            'W_meo_m',
            'W_PR',
            'W_API',
            'W_AP',
            'W_CP',
            'W_ArP',
            'W_EP',
            'W_SP',
            'W_PP',
            'W_GLR',
            'W_APM',
            'W_SE',
            'W_AST',
            'W_PF',
            'W_ES'
        ],
        ES_espcp: [
            'ES_espcp',
            'ES_pcp',
            'ES_srp',
            'ES_lrp',
            'ES_esp'
        ]
    }


    valueDependants: {
        MD: [
            'TVD',
            'MD_pump'
        ],
        TVD: [
            'D_perf'
        ],
        MD_pump: [
            'VD_pump'
        ],
        D_perf: [
            'VD_FL'
        ]
    }



    units: {
        depth: [
            'ft',
            'mt'
        ],
        angle: [
            '&#176;deg'
        ],
        pressure_rate: [
            'psi/ft'
        ],
        pressure: [
            'psi'
        ],
        volume: [
            'bbl'
        ],
        temperature: [
            '&#176;F',
            '&#176;C'
        ],
        rate_per_pressure: [
            'BPD/psi'
        ],
        gas_rate: [
            'MSCFD'
        ],
        percentage: [
            '%'
        ],
        electricity_price: [
            '$/kW.hr'
        ],
        gas_solubility: [
            'SCF/STB'
        ],
        liquid_volume_factor: [
            'bbl/STB'
        ],
        gas_volume_vactor: [
            'cu.ft/SCF'
        ],
        gas_consumption_rate: [
            '$/MMBT'
        ],
        main_line_voltage: [
            'V'
        ],
        gas_oil_ratio: [
            'SCF/bbl'
        ]
    }

    inputTypes: {
        depth: "number",
    }

    max: {
        MD: {
            ft: "16000",
            mt: "4800"
        }
    }
}