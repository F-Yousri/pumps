exports = this;
exports.enums = {
    unitDependants: {
        MD : [
            'MD',
            'TVD',
            'MD_pump'
        ]
    }
    valueDependants: {
        MD: [
            'TVD',
            'MD_pump'
        ]
    }

    units: {
        depth: [
            'ft',
            'mt'
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