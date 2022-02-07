namespace QuantumRNG {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    
    operation GenerateRandomBit() : Result {
        //Allocate a qubit
        use q = Qubit();
        //Put qubit to superposition
        H(q);
        // It now has a 50% chance of being measured 0 or 1.
        // Measure the qubit value.
        return M(q);
    }

    operation SampleRandomNumberInRange(min: Int, max: Int) : Int {
        mutable output = 0;
        if (min >= max) {
            return -1;
        }
        repeat {
            mutable bits = new Result[0];
            for idxBit in 1..BitSizeI(max) {
                set bits += [GenerateRandomBit()];
            }
            set output = ResultArrayAsInt(bits);
        } until (output >= min and output <= max);
        return output;
    }

    @EntryPoint()
    operation SampleRandomNumber() : Int {
        let max = 50;
        let min = 40;
    
        let output = SampleRandomNumberInRange(min, max);
        if(output == -1){
            Message("Min cannot be greater or equal than max.");
        } else {
            Message($"Sampling a random number between {min} and {max}: "); 
        }
        return output;
    }
}

