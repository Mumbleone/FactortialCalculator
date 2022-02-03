//
//  ViewController.swift
//  Factorials
//
//  Created by Adrian Devezin on 5/12/21.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private var numberField: UITextField!
    private var calculateButton: UIButton!
    private let viewModel: ViewModel = ViewModel()
    private var bindings: [AnyCancellable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNumberField()
        createCalculateButton()
        let cancelable = viewModel.$viewState.sink(receiveValue: { viewState in
            switch viewState {
            
            case .initial:
                break
            case let .factorial(answer):
                self.showAnser(answer: answer)
            }
        })
        bindings.append(cancelable)
    }
    
    private func showAnser(answer: Int) {
        let alertController = UIAlertController(title: "Factorial", message:
                                                    String(answer), preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func createNumberField() {
        numberField = UITextField()
        numberField.translatesAutoresizingMaskIntoConstraints = false
        numberField.keyboardType = .numberPad
        numberField.layer.cornerRadius = 8
        numberField.layer.borderColor = UIColor.gray.cgColor
        numberField.layer.borderWidth = 1
        numberField.placeholder = "Enter number to factorial"
        numberField.textColor = UIColor.black
        
        view.addSubview(numberField)
        
        numberField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        numberField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        numberField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    }
    
    private func createCalculateButton() {
        calculateButton = UIButton()
        calculateButton.translatesAutoresizingMaskIntoConstraints = false
        calculateButton.setTitleColor(UIColor.blue, for: .normal)
        calculateButton.setTitle("Calculate", for: .normal)
        calculateButton.addTarget(self, action: #selector(onCalculateClick), for: .touchUpInside)
        
        view.addSubview(calculateButton)
        
        let numberGuide = UILayoutGuide()
        view.addLayoutGuide(numberGuide)
        numberGuide.bottomAnchor.constraint(equalTo: numberField.bottomAnchor).isActive = true
        
        calculateButton.topAnchor.constraint(equalTo: numberGuide.bottomAnchor, constant: 8).isActive = true
        calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc private func onCalculateClick() {
        viewModel.onCalculateClick(numberString: numberField.text)
    }
    
}

