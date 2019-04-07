import UIKit

class ViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet private weak var digit0Button: UIButton!
    @IBOutlet private weak var digit1Button: UIButton!
    @IBOutlet private weak var digit2Button: UIButton!
    @IBOutlet private weak var digit3Button: UIButton!
    @IBOutlet private weak var digit4Button: UIButton!
    @IBOutlet private weak var digit5Button: UIButton!
    @IBOutlet private weak var digit6Button: UIButton!
    @IBOutlet private weak var digit7Button: UIButton!
    @IBOutlet private weak var digit8Button: UIButton!
    @IBOutlet private weak var digit9Button: UIButton!
    @IBOutlet private weak var cleanButton: UIButton!
    @IBOutlet private weak var sumOpButton: UIButton!
    @IBOutlet private weak var subtractOpButton: UIButton!
    @IBOutlet private weak var timesOpButton: UIButton!
    @IBOutlet private weak var divideOpButton: UIButton!
    @IBOutlet private weak var equalButton: UIButton!
    @IBOutlet private weak var resultLabel: UILabel!
    
    var partial: Int = 0
    var numClicks: Int = 0
    var op: String = ""
    var calc: Calculator.Operation!
    var click_Num: Bool = false
    
    // MARK: - Stored Properties

    private let calculator = Calculator()

    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        registerTouchEvents()
    }

    // MARK: -

    /// Registra o método que será acionado ao tocar em cada um dos eventos.
    private func registerTouchEvents() {
        let digitButtons = [digit0Button, digit9Button, digit8Button,
                            digit7Button, digit6Button, digit5Button,
                            digit4Button, digit3Button, digit2Button,
                            digit1Button]

        let operationButtons = [sumOpButton, subtractOpButton, timesOpButton, divideOpButton]

        digitButtons.forEach { $0?.addTarget(self, action: #selector(digitTap), for: .touchUpInside) }
        operationButtons.forEach { $0?.addTarget(self, action: #selector(operationTap(sender:)), for: .touchUpInside) }
        cleanButton.addTarget(self, action: #selector(clearTap), for: .touchUpInside)
        equalButton.addTarget(self, action: #selector(makeOperation), for: .touchUpInside)
    }

    /// Esse método é responsável por adicionar um dígito na calculadora
    /// - Parameter sender: Referência do botão que está executando a ação
    @objc func digitTap(sender: UIButton) {
        var digit: String?
        switch sender {
        case digit0Button:
            digit =  sender.titleLabel?.text
        case digit1Button:
            digit = sender.titleLabel?.text
        case digit2Button:
            digit = sender.titleLabel?.text
        case digit3Button:
            digit = sender.titleLabel?.text
        case digit4Button:
            digit = sender.titleLabel?.text
        case digit5Button:
            digit = sender.titleLabel?.text
        case digit6Button:
            digit = sender.titleLabel?.text
        case digit7Button:
            digit = sender.titleLabel?.text
        case digit8Button:
            digit = sender.titleLabel?.text
        case digit9Button:
            digit = sender.titleLabel?.text
        case sumOpButton:
            digit = sender.titleLabel?.text
        case subtractOpButton:
            digit = sender.titleLabel?.text
        case timesOpButton:
            digit = sender.titleLabel?.text
        case divideOpButton:
            digit = sender.titleLabel?.text
        case equalButton:
            digit = sender.titleLabel?.text
        case cleanButton:
            digit = sender.titleLabel?.text
            
        default:
            digit = "0"
        }
        if click_Num == true{
            numClicks = Int(digit!)!
        }else{
            partial = Int(digit!)!
        }
        resultLabel.text = digit
    }

    /// Método acionado quando o botão AC é tocado.
    @objc func clearTap() {
        resultLabel.text = "0"
        click_Num = false
        partial = 0
    }

    /// Metódo responsável por escolhe qual a operação será realizada.
    /// - Parameter sender: Referência do botão de operação que foi tocado
    @objc func operationTap(sender: UIButton) {
        click_Num = true
        
        switch sender {
        case sumOpButton:
            calc = Calculator.Operation.sum
        case subtractOpButton:
            calc = Calculator.Operation.subtract
        case timesOpButton:
            calc = Calculator.Operation.times
        case divideOpButton:
            calc = Calculator.Operation.divide
        default:
            break
        }
    }

    /// Método acionado quando o botão = é tocado.
    @objc func makeOperation() {
        var resultado: Int = 0
       
        resultado = calculator.perform(operation: calc, firstValue: partial, secondValue: numClicks)
      
        resultLabel.text = String(resultado)
        partial = resultado
        numClicks = 0
    }
    
    func sum()-> Int{
        return partial + numClicks
    }
    func timesOp()-> Int{
        return partial * numClicks
    }
    func divide()-> Int{
        return partial / numClicks
    }
    func subtract()-> Int{
        return partial - numClicks
    }
}
