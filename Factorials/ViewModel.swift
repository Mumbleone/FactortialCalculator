//
//  ViewModel.swift
//  Factorials
//
//  Created by Student on 5/12/21.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    
    @Published
    var viewState: ViewState = .initial
    
    enum ViewState {
        case initial
        case factorial(Int)
    }
    
    
    func onCalculateClick(numberString: String?) {
        
        guard let factorialString = numberString else {
            return
        }
        
        let castedFactorialInt = Int(factorialString)
        
        guard var int = castedFactorialInt else {
            return
        }
        
        if int == 0 {
            return
        }
        for i in 1..<int {
            int *= i
         }
       
        viewState = .factorial(int)
       
    }
}
