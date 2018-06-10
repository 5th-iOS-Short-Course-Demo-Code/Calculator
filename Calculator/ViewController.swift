//
//  ViewController.swift
//  Calculator
//
//  Created by Chhaileng Peng on 6/2/18.
//  Copyright © 2018 Chhaileng Peng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Outlet
    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    var numberOnScreen: String?
    var numberOnSecondScreen: String?
    var previousSign: String = "+"
    var newCalcuator: Bool? = true
    var previousButton: String = ""
    
    var result: Double = 0
    
    // Action
    // Number button is tapped
    @IBAction func numberTapped(_ sender: UIButton) {
        if previousButton == "+" || previousButton == "-" || previousButton == "×" || previousButton == "÷" || previousButton == "%" {
            newCalcuator = false
        }
        
        if newCalcuator! {
            self.clearScreen()
        }
        
        newCalcuator = false
        
        numberOnScreen = resultLabel.text
        if sender.currentTitle == "." {
            if resultLabel.text!.contains(".") {
                return
            }
            if numberOnScreen == "0" {
                resultLabel.text = numberOnScreen! + sender.currentTitle!
                return
            }
        }
        if numberOnScreen == "0" {
            numberOnScreen = ""
        }
        resultLabel.text = numberOnScreen! + sender.currentTitle!
        
        previousButton = sender.currentTitle!
    }
    
    
    // Operator button is tapped
    @IBAction func operatorTapped(_ sender: UIButton) {
        if (previousButton == "+" || previousButton == "-" || previousButton == "×" || previousButton == "÷" || previousButton == "%") && sender.currentTitle != "=" {
            operationLabel.text = "\(formatNumber(result)) \(sender.currentTitle!) "
            previousButton = sender.currentTitle!
            previousSign = previousButton
            return
        }
        
        if sender.currentTitle! == "=" {
            if operationLabel.text! == "" || previousButton == "="{
                return
            }
        }
        
        numberOnSecondScreen = operationLabel.text!
        
        if sender.currentTitle != "=" {
            if numberOnSecondScreen == "" {
                numberOnSecondScreen = resultLabel.text!
                operationLabel.text = numberOnSecondScreen! + sender.currentTitle!
            } else {
                numberOnSecondScreen = operationLabel.text!
                operationLabel.text = numberOnSecondScreen! + resultLabel.text! + sender.currentTitle!
            }
        } else {
            if numberOnSecondScreen == "" {
                numberOnSecondScreen = resultLabel.text!
                operationLabel.text = numberOnSecondScreen!
            } else {
                numberOnSecondScreen = operationLabel.text!
                operationLabel.text = numberOnSecondScreen! + resultLabel.text!
            }
        }
        
        switch previousSign {
        case "+":
            result += Double(resultLabel.text!)!
        case "-":
            result -= Double(resultLabel.text!)!
        case "×":
            result *= Double(resultLabel.text!)!
        case "÷":
            result /= Double(resultLabel.text!)!
        case "%":
            result = result.truncatingRemainder(dividingBy: Double(resultLabel.text!)!)
        default:
            print("err")
        }
        
        if sender.currentTitle! == "=" {
            operationLabel.text = "\(operationLabel.text!) "
            if formatNumber(result) == "inf" || formatNumber(result) == "nan" {
                resultLabel.text = "Error"
            } else {
                resultLabel.text = formatNumber(result)
            }
            self.resetCalculator()
        } else {
            operationLabel.text = "\(formatNumber(result)) \(sender.currentTitle!) "
            previousSign = sender.currentTitle!
            resultLabel.text = "0"
        }
        
        previousButton = sender.currentTitle!
    }
    
    
    // Other button is tapped
    @IBAction func otherButtonTapped(_ sender: UIButton) {
        if sender.currentTitle == "C" {
            self.clearScreen()
        } else if sender.currentTitle == "+/-" {
            var tempNum = Double(resultLabel.text!)!
            tempNum = -tempNum
            resultLabel.text = self.formatNumber(tempNum)
        }
        
        previousButton = sender.currentTitle!
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func clearScreen() -> Void {
        operationLabel.text = ""
        resultLabel.text = "0"
        result = 0
        previousSign = "+"
        newCalcuator = true
    }
    
    func resetCalculator() -> Void {
        previousSign = "+"
        newCalcuator = true
        result = 0
    }
    
    func formatNumber(_ number: Double) -> String {
        return String(format: "%g", number)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }


}

