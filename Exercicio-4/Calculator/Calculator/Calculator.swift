import Foundation

struct Calculator {
    
    var partialValue: Int = 0
    var numClicks: Int = 0
    var op: String = ""
        
    enum Operation {
        case sum
        case times
        case divide
        case subtract
    }

    /// Realiza uma operação matemática.
    /// - Parameter operation: Enum com a operação a ser realizada.
    /// - Parameter firstValue: Primeiro valor.
    /// - Parameter secondValue: Segundo valor.
    /// - Returns: Resultado do calculo.
    func perform(operation: Calculator.Operation,
                 firstValue: Int,
                 secondValue: Int) -> Int {
        var result = 0
        
        switch operation{
        case .sum:
            result = firstValue + secondValue
        case .subtract:
            result = firstValue - secondValue
        case .times:
            result = firstValue * secondValue
        case .divide:
            result = firstValue / secondValue
        }
        return result
    }
    
}
