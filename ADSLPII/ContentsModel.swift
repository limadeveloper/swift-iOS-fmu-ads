//
//  ContentsModel.swift
//  ADSLPII
//
//  Created by John Lima on 21/08/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import Foundation

enum ContentsAttributes: String {
    case Name = "name"
    case WeekId = "weekId"
    case WeekName = "weekName"
    case Id = "id"
}

enum ContentId: Int {
    case MS = 1
    case APS = 2
    case LPII = 3
    case PBD = 4
}

class ContentsModel {
    
    var name: String?
    var weekId: Int?
    var weekName: String?
    var id: Int?
    
    init() {}
    
    init(name: String, weekId: Int, weekName: String, id: Int) {
        self.name = name
        self.weekId = weekId
        self.weekName = weekName
        self.id = id
    }
}

extension ContentsModel {
    
    // MARK: - Data
    func getContents() -> [ContentsModel] {
        return [
            ContentsModel(name: "M. Sistemas", weekId: 2, weekName: "Segunda", id: 1),
            // ContentsModel(name: "A. P. Sistemas", weekId: 3, weekName: "Terça", id: 2),
            ContentsModel(name: "Programação II", weekId: 4, weekName: "Quarta", id: 3),
            ContentsModel(name: "Projeto de BD", weekId: 5, weekName: "Quinta", id: 4)
        ]
    }
    
    // MARK: - Methods
    func getDictionaryFrom(model: ContentsModel) -> Dictionary<String,AnyObject>? {
        
        var result = Dictionary<String,AnyObject>()
        
        if let name = model.name {
            result[ContentsAttributes.Name.rawValue] = name as AnyObject
        }
        if let weekId = model.weekId {
            result[ContentsAttributes.WeekId.rawValue] = weekId as AnyObject
        }
        if let weekName = model.weekName {
            result[ContentsAttributes.WeekName.rawValue] = weekName as AnyObject
        }
        if let id = model.id {
            result[ContentsAttributes.Id.rawValue] = id as AnyObject
        }
        
        if result.isEmpty {
            return nil
        }
        
        return result
    }
    
    func getModelFrom(dictionary: Dictionary<String,AnyObject>) -> ContentsModel? {
        
        let result = ContentsModel()
        
        if let name = dictionary[ContentsAttributes.Name.rawValue] as? String {
            result.name = name
        }
        if let weekId = dictionary[ContentsAttributes.WeekId.rawValue] as? Int {
            result.weekId = weekId
        }
        if let weekName = dictionary[ContentsAttributes.WeekName.rawValue] as? String {
            result.weekName = weekName
        }
        if let id = dictionary[ContentsAttributes.Id.rawValue] as? Int {
            result.id = id
        }
        
        if result.id == nil {
            return nil
        }
        
        return result
    }
    
}
