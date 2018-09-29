exports = this
exports.enums = {
    unitDependants: {
        MD: [
            'MD',
            'TVD',
            'MD_pump',
            'VD_pump'
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
        ]
    }


    valueDependants: {
        MD: [
            'TVD',
            'MD_pump'
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