//
//  Calculus.swift
//  ADSLPII
//
//  Created by John Lima on 20/08/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import Foundation

class Calculus {
    
    /**
     * Aula 01 - Exercicio 01
     */
    class func getResultOrderNumbers(numbers: [Int]) -> String {
        
        let messageSelectedNumbers = "\(Message.SelectedNumbers.rawValue): \n\(numbers)"
        
        let orderedNumbers = self.getOrderedNumbersFrom(array: numbers)
        
        print("Order: \(numbers)")
        
        let messageOrderedNumbers = "\(Message.OrderedNumbers.rawValue): \n\(orderedNumbers)"
        let message = "\(messageSelectedNumbers)\n\n\(messageOrderedNumbers)"
        
        return message
    }
    
    /**
     * Aula 01 - Exercicio 02
     */
    class func getResultAverageMinorAndGreaterNumber(numbers: [Int]) -> String {
        
        let messageSelectedNumbers = "\(Message.SelectedNumbers.rawValue): \n\(numbers)"
        
        let orderedNumbers = self.getOrderedNumbersFrom(array: numbers)
        let minorNumber = self.getGreaterOrMinorNumberIn(array: numbers, isGreater: false)
        let greaterNumber = self.getGreaterOrMinorNumberIn(array: numbers, isGreater: true)
        let averageValue = self.getAverageValueFrom(array: numbers)
        
        print("Ordered: \(orderedNumbers)")
        print("Minor: \(minorNumber)")
        print("Greater: \(greaterNumber)")
        print("Average: \(averageValue)")
        
        let messageOrderedNumbers = "\(Message.OrderedNumbers.rawValue): \n\(orderedNumbers)"
        let messageMinorNumber = "\(Message.MinorNumber.rawValue): \(minorNumber)"
        let messageGreaterNumber = "\(Message.GreaterNumber.rawValue): \(greaterNumber)"
        let messageAverageValue = "\(Message.AverageValue.rawValue): \(averageValue)"
        
        let message = "\(messageSelectedNumbers)\n\n\(messageOrderedNumbers)\n\n\(messageMinorNumber)\n\n\(messageGreaterNumber)\n\n\(messageAverageValue)"
        
        return message
    }
    
    /**
     * Aula 02 - Calculadora
     */
    class func getResultCalculatorCalculus(numbers: [Int], operatorValue: String) -> String {
        switch operatorValue {
        case Arrays.operatorArray[0]:
            return "Soma: \(numbers.first!+numbers.last!)"
        case Arrays.operatorArray[1]:
            return "Subtração: \(numbers.first!-numbers.last!)"
        case Arrays.operatorArray[2]:
            return "Multiplicação: \(numbers.first!*numbers.last!)"
        case Arrays.operatorArray[3]:
            return "Divisão: \(numbers.first!/numbers.last!)"
        default:
            return "Nenhum Resultado"
        }
    }
    
    class func getOrderedNumbersFrom(array: [Int]) -> [Int] {
        
        var number = Int()
        var numbers = array
        
        if numbers.count > 0 {
            for i in 0 ..< numbers.count {
                for j in i+1 ..< numbers.count {
                    if numbers[i] > numbers[j] {
                        number = numbers[i]
                        numbers[i] = numbers[j]
                        numbers[j] = number
                    }
                }
            }
        }
        
        number = Int()
        
        return numbers
    }
    
    class func getGreaterOrMinorNumberIn(array: [Int], isGreater: Bool) -> Int {
        
        var result = Int()
        
        if array.count > 0 {
            for item in array {
                if isGreater {
                    if item > result {
                        result = item
                    }
                }else {
                    if item < result || result == 0 {
                        result = item
                    }
                }
            }
        }
        
        return result
    }
    
    class func getAverageValueFrom(array: [Int]) -> Double {
        
        var result = Double()
        
        if array.count > 0 {
            
            var sum = Int()
            
            for item in array {
                sum += item
            }
            
            print("sum: \(sum)")
            print("count: \(array.count)")
            
            result = Double(sum)/Double(array.count)
        }
        
        return result
    }
    
}
