//
//  HomeModel.swift
//  ADSLPII
//
//  Created by John Lima on 13/08/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import Foundation

enum HomeAttributes: String {
    case Title = "title"
    case Subtitle = "subtitle"
    case Date = "date"
    case Id = "id"
    case Index = "index"
}

class HomeModel {
    
    var title: String?
    var subtitle: String?
    var date: String?
    var id: String?
    var index: Int?
    
    init () {
    
    }
    
    init(title: String, subtitle: String, date: String, id: String, index: Int) {
        self.title = title
        self.subtitle = subtitle
        self.date = date
        self.id = id
        self.index = index
    }
}

extension HomeModel {
    
    func getData() -> [HomeModel] {
        return [
            HomeModel(title: "Aula 01", subtitle: "Exercício 01", date: "10/08/2016", id: "010110082016", index: 0),
            HomeModel(title: "Aula 01", subtitle: "Exercício 02", date: "10/08/2016", id: "010210082016", index: 1)
        ]
    }
    
    func convertModelToDictinary(model: HomeModel) -> Dictionary<String,AnyObject>? {
        
        var result = Dictionary<String,AnyObject>()
        
        if let title = model.title {
            result[HomeAttributes.Title.rawValue] = title as AnyObject
        }
        if let subtitle = model.subtitle {
            result[HomeAttributes.Subtitle.rawValue] = subtitle as AnyObject
        }
        if let date = model.date {
            result[HomeAttributes.Date.rawValue] = date as AnyObject
        }
        if let id = model.id {
            result[HomeAttributes.Id.rawValue] = id as AnyObject
        }
        if let index = model.index {
            result[HomeAttributes.Index.rawValue] = index as AnyObject
        }
        
        if model.title == nil || model.title == "" {
            return nil
        }
        
        return result
    }
    
    func convertDictinaryToModel(dictionary: Dictionary<String,AnyObject>) -> HomeModel? {
        
        let result = HomeModel()
        
        if let title = dictionary[HomeAttributes.Title.rawValue] as? String {
            result.title = title
        }
        if let subtitle = dictionary[HomeAttributes.Subtitle.rawValue] as? String {
            result.subtitle = subtitle
        }
        if let date = dictionary[HomeAttributes.Date.rawValue] as? String {
            result.date = date
        }
        if let id = dictionary[HomeAttributes.Id.rawValue] as? String {
            result.id = id
        }
        if let index = dictionary[HomeAttributes.Index.rawValue] as? Int {
            result.index = index
        }
        
        if result.title == nil || result.title == "" {
            return nil
        }
        
        return result
    }
    
    func convertModelArrayToDictionaryArray(array: [HomeModel]?) -> [Dictionary<String,AnyObject>]? {
        
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
    
    func convertDictionaryArrayToModelArray(array: [Dictionary<String,AnyObject>]?) -> [HomeModel]? {
        
        var result = [HomeModel]()
        
        if array != nil, let array = array {
            for item in array {
                if let dictionary = self.convertDictinaryToModel(dictionary: item) {
                    result.append(dictionary)
                }
            }
        }
        
        return result
    }
    
    func formateModelDictionary(item: Dictionary<String,AnyObject>) -> Dictionary<String,[HomeModel]>? {
        
        var result = Dictionary<String,[HomeModel]>()
        
        if item.count > 0 {
            
            let key = item.keys.first!
            let value = item[key] as! [Dictionary<String,AnyObject>]
            
            if let model = self.convertDictionaryArrayToModelArray(array: value) {
                result[key] = model
            }
        }
        
        if result.isEmpty {
            return nil
        }
        
        return result
    }
}
