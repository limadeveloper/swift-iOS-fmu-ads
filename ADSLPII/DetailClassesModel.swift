//
//  DetailClassesModel.swift
//  ADSLPII
//
//  Created by John Lima on 13/08/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import Foundation

enum DetailClassesAttributes: String {
    case Name = "name"
    case Title = "title"
    case Subtitle = "subtitle"
    case Date = "date"
    case Id = "id"
    case Index = "index"
    case File = "file"
}

enum DetailClassesModelIds: String { // title + subtitle + date (just int value)
    case First = "010110082016"
    case Second = "010210082016"
    case Third = "020117082016"
}

class DetailClassesModel {
    
    var name: String?
    var title: String?
    var subtitle: String?
    var date: String?
    var id: String?
    var index: Int?
    var file: String?
    
    init () {
    
    }
    
    init(name: String, title: String, subtitle: String, date: String, id: String, index: Int, file: String) {
        self.name = name
        self.title = title
        self.subtitle = subtitle
        self.date = date
        self.id = id
        self.index = index
        self.file = file
    }
}

extension DetailClassesModel {
    
    // MARK: - Data
    func getProgrammingLanguageIIModelData() -> [DetailClassesModel] { // Implementação dos dados
        return [
            DetailClassesModel(name: "Programação II", title: "Aula 01", subtitle: "Exercício 01", date: "10/08/2016", id: DetailClassesModelIds.First.rawValue, index: 1, file: "Exercicio01"),
            DetailClassesModel(name: "Programação II", title: "Aula 01", subtitle: "Exercício 02", date: "10/08/2016", id: DetailClassesModelIds.Second.rawValue, index: 2, file: "Exercicio02"),
            DetailClassesModel(name: "Programação II", title: "Aula 02", subtitle: "Calculadora", date: "17/08/2016", id: DetailClassesModelIds.Third.rawValue, index: 3, file: "Calculadora")
        ]
    }
    
    // MARK: - Methods
    func convertModelToDictinary(model: DetailClassesModel) -> Dictionary<String,AnyObject>? {
        
        var result = Dictionary<String,AnyObject>()
        
        if let name = model.name {
            result[DetailClassesAttributes.Name.rawValue] = name as AnyObject
        }
        if let title = model.title {
            result[DetailClassesAttributes.Title.rawValue] = title as AnyObject
        }
        if let subtitle = model.subtitle {
            result[DetailClassesAttributes.Subtitle.rawValue] = subtitle as AnyObject
        }
        if let date = model.date {
            result[DetailClassesAttributes.Date.rawValue] = date as AnyObject
        }
        if let id = model.id {
            result[DetailClassesAttributes.Id.rawValue] = id as AnyObject
        }
        if let index = model.index {
            result[DetailClassesAttributes.Index.rawValue] = index as AnyObject
        }
        if let file = model.file {
            result[DetailClassesAttributes.File.rawValue] = file as AnyObject
        }
        
        if model.title == nil || model.title == "" {
            return nil
        }
        
        return result
    }
    
    func convertDictinaryToModel(dictionary: Dictionary<String,AnyObject>) -> DetailClassesModel? {
        
        let result = DetailClassesModel()
        
        if let name = dictionary[DetailClassesAttributes.Name.rawValue] as? String {
            result.name = name
        }
        if let title = dictionary[DetailClassesAttributes.Title.rawValue] as? String {
            result.title = title
        }
        if let subtitle = dictionary[DetailClassesAttributes.Subtitle.rawValue] as? String {
            result.subtitle = subtitle
        }
        if let date = dictionary[DetailClassesAttributes.Date.rawValue] as? String {
            result.date = date
        }
        if let id = dictionary[DetailClassesAttributes.Id.rawValue] as? String {
            result.id = id
        }
        if let index = dictionary[DetailClassesAttributes.Index.rawValue] as? Int {
            result.index = index
        }
        if let file = dictionary[DetailClassesAttributes.File.rawValue] as? String {
            result.file = file
        }
        
        if result.title == nil || result.title == "" {
            return nil
        }
        
        return result
    }
    
    func convertModelArrayToDictionaryArray(array: [DetailClassesModel]?) -> [Dictionary<String,AnyObject>]? {
        
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
    
    func convertDictionaryArrayToModelArray(array: [Dictionary<String,AnyObject>]?) -> [DetailClassesModel]? {
        
        var result = [DetailClassesModel]()
        
        if array != nil, let array = array {
            for item in array {
                if let dictionary = self.convertDictinaryToModel(dictionary: item) {
                    result.append(dictionary)
                }
            }
        }
        
        return result
    }
    
    func formateModelDictionary(item: Dictionary<String,AnyObject>) -> Dictionary<String,[DetailClassesModel]>? {
        
        var result = Dictionary<String,[DetailClassesModel]>()
        
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
