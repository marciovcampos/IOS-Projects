//
//  ViewController.swift
//  CalculaIdade
//
//  Created by user151742 on 26/03/19.
//  Copyright © 2019 PUC. All rights reserved.

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ageLabel: UITextField!
    
    @IBOutlet weak var birthdateTextField: UILabel!
    
    @IBOutlet weak var birthdateTextErrorField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func actionButtonDidTap(_ sender: Any) {
        do{
            let age = try calculateAge(from: ageLabel.text ?? "", dateFormat: "dd/MM/yyyy")
            birthdateTextField.text = String(age)     + " anos"
            birthdateTextErrorField.text = ""
        } catch AgeError.emptyText {
            birthdateTextErrorField.text = "Data não informada!"
            birthdateTextField.text = "00"
        } catch AgeError.futureBirthday {
            birthdateTextErrorField.text = "Prevendo o futuro?"
            birthdateTextField.text = "00"
        } catch AgeError.invalidDate {
            birthdateTextErrorField.text = "Data inválida!"
            birthdateTextField.text = "00"
        } catch AgeError.invalidFormat {
            birthdateTextErrorField.text = "Formato inválido!"
            birthdateTextField.text = "00"
        } catch AgeError.unknown {
            birthdateTextErrorField.text = "Erro desconhecido!"
            birthdateTextField.text = "00"
        } catch {
            birthdateTextErrorField.text = "Erro inesperado!"
            birthdateTextField.text = "00"
        }
    }
    
    private func calculateAge(from text: String?, dateFormat: String) throws -> Int {
        do {
            
            if text == nil {
                throw AgeError.emptyText
            }
            else{
                
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "pt_BR")
                dateFormatter.dateFormat = dateFormat
                
                if let birthday = dateFormatter.date(from: text!) {
                    
                    let now = Date()
                    guard birthday <= now else { throw AgeError.futureBirthday }
                    
                    if let age = Calendar.current.dateComponents([.year], from: birthday, to: now ).year {
                        return age
                    } else {
                        throw AgeError.invalidDate
                    }
                    
                } else{
                    throw AgeError.invalidFormat
                }
                
            }
            
        } catch {
            throw AgeError.unknown
        }
    }
    
    enum AgeError: Error{
        case emptyText
        case invalidFormat
        case invalidDate
        case futureBirthday
        case unknown
    }
    

    
    
}

