//
//  ProgrammingLanguageIIModel.swift
//  ADSLPII
//
//  Created by John Lima on 13/08/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import Foundation

enum ProgrammingLanguageIIAttributes: String {
    case Title = "title"
    case Subtitle = "subtitle"
    case Date = "date"
    case Id = "id"
    case Index = "index"
    case File = "file"
    case PdfName = "PdfName"
    case PdfFileName = "PdfFileName"
}

enum ProgrammingLanguageIIModelIds: String { // title + subtitle + date (just int value)
    case First = "010110082016"
    case Second = "010210082016"
    case Third = "020117082016"
}

class ProgrammingLanguageIIModel {
    
    var title: String?
    var subtitle: String?
    var date: String?
    var id: String?
    var index: Int?
    var file: String?
    
    // PDF Files
    var pdfName: String?
    var pdfFileName: String?
    
    init () {
    
    }
    
    init(title: String, subtitle: String, date: String, id: String, index: Int, file: String) {
        self.title = title
        self.subtitle = subtitle
        self.date = date
        self.id = id
        self.index = index
        self.file = file
    }
    
    init(pdfName: String, pdfFileName: String) {
        self.pdfName = pdfName
        self.pdfFileName = pdfFileName
    }
}

extension ProgrammingLanguageIIModel {
    
    // MARK: - Data
    func getData() -> [ProgrammingLanguageIIModel] { // Implementação dos dados
        return [
            ProgrammingLanguageIIModel(title: "Aula 01", subtitle: "Exercício 01", date: "10/08/2016", id: ProgrammingLanguageIIModelIds.First.rawValue, index: 1, file: "Exercicio01"),
            ProgrammingLanguageIIModel(title: "Aula 01", subtitle: "Exercício 02", date: "10/08/2016", id: ProgrammingLanguageIIModelIds.Second.rawValue, index: 2, file: "Exercicio02"),
            ProgrammingLanguageIIModel(title: "Aula 02", subtitle: "Calculadora", date: "17/08/2016", id: ProgrammingLanguageIIModelIds.Third.rawValue, index: 3, file: "Calculadora")
        ]
    }
    
    func getPdfDataFiles() -> [ProgrammingLanguageIIModel]? {
        return nil
    }
    
    // MARK: - Methods
    func convertModelToDictinary(model: ProgrammingLanguageIIModel) -> Dictionary<String,AnyObject>? {
        
        var result = Dictionary<String,AnyObject>()
        
        if let title = model.title {
            result[ProgrammingLanguageIIAttributes.Title.rawValue] = title as AnyObject
        }
        if let subtitle = model.subtitle {
            result[ProgrammingLanguageIIAttributes.Subtitle.rawValue] = subtitle as AnyObject
        }
        if let date = model.date {
            result[ProgrammingLanguageIIAttributes.Date.rawValue] = date as AnyObject
        }
        if let id = model.id {
            result[ProgrammingLanguageIIAttributes.Id.rawValue] = id as AnyObject
        }
        if let index = model.index {
            result[ProgrammingLanguageIIAttributes.Index.rawValue] = index as AnyObject
        }
        if let file = model.file {
            result[ProgrammingLanguageIIAttributes.File.rawValue] = file as AnyObject
        }
        if let pdfName = model.pdfName {
            result[ProgrammingLanguageIIAttributes.PdfName.rawValue] = pdfName as AnyObject
        }
        if let pdfFileName = model.pdfFileName {
            result[ProgrammingLanguageIIAttributes.PdfFileName.rawValue] = pdfFileName as AnyObject
        }
        
        if model.title == nil || model.title == "" {
            return nil
        }
        
        return result
    }
    
    func convertDictinaryToModel(dictionary: Dictionary<String,AnyObject>) -> ProgrammingLanguageIIModel? {
        
        let result = ProgrammingLanguageIIModel()
        
        if let title = dictionary[ProgrammingLanguageIIAttributes.Title.rawValue] as? String {
            result.title = title
        }
        if let subtitle = dictionary[ProgrammingLanguageIIAttributes.Subtitle.rawValue] as? String {
            result.subtitle = subtitle
        }
        if let date = dictionary[ProgrammingLanguageIIAttributes.Date.rawValue] as? String {
            result.date = date
        }
        if let id = dictionary[ProgrammingLanguageIIAttributes.Id.rawValue] as? String {
            result.id = id
        }
        if let index = dictionary[ProgrammingLanguageIIAttributes.Index.rawValue] as? Int {
            result.index = index
        }
        if let file = dictionary[ProgrammingLanguageIIAttributes.File.rawValue] as? String {
            result.file = file
        }
        if let pdfName = dictionary[ProgrammingLanguageIIAttributes.PdfName.rawValue] as? String {
            result.pdfName = pdfName
        }
        if let pdfFileName = dictionary[ProgrammingLanguageIIAttributes.PdfFileName.rawValue] as? String {
            result.pdfFileName = pdfFileName
        }
        
        if result.title == nil || result.title == "" {
            return nil
        }
        
        return result
    }
    
    func convertModelArrayToDictionaryArray(array: [ProgrammingLanguageIIModel]?) -> [Dictionary<String,AnyObject>]? {
        
        var result = [Dictionary<String,AnyObject>]()
        
        if array != nil, let array = array {
            for item in array {
                if let dictionary = self.convertModelToDictinary(model: item) {
                    result.append(dictionary)
                }
            }
        }
        
        return result
    }
    
    func convertDictionaryArrayToModelArray(array: [Dictionary<String,AnyObject>]?) -> [ProgrammingLanguageIIModel]? {
        
        var result = [ProgrammingLanguageIIModel]()
        
        if array != nil, let array = array {
            for item in array {
                if let dictionary = self.convertDictinaryToModel(dictionary: item) {
                    result.append(dictionary)
                }
            }
        }
        
        return result
    }
    
    func formateModelDictionary(item: Dictionary<String,AnyObject>) -> Dictionary<String,[ProgrammingLanguageIIModel]>? {
        
        var result = Dictionary<String,[ProgrammingLanguageIIModel]>()
        
        if item.count > 0 {
            let keys = item.keys.sorted()
            for key in keys {
                if
                    let value = item[key] as? [Dictionary<String,AnyObject>],
                    let model = self.convertDictionaryArrayToModelArray(array: value) {
                    result[key] = model
                }
            }
        }
        
        if result.isEmpty {
            return nil
        }
        
        return result
    }
}
