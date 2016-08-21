//
//  DatabaseProjectModel.swift
//  ADSLPII
//
//  Created by John Lima on 21/08/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import Foundation

enum DatabaseProjectAttributes: String {
    case pdfName = "pdfName"
    case pdfFileName = "pdfFileName"
    case id = "id"
}

class DatabaseProjectModel {

    var pdfName: String?
    var pdfFileName: String?
    var id: Int?
    
    init() {}
    
    init(pdfName: String, pdfFileName: String, id: Int) {
        self.pdfName = pdfName
        self.pdfFileName = pdfFileName
        self.id = id
    }
}

extension DatabaseProjectModel {
    
    // MARK: - Data
    func getData() -> [DatabaseProjectModel] {
        return [
            DatabaseProjectModel(pdfName: "Plano de Ensino", pdfFileName: "PlanoDeEnsino", id: 1),
            DatabaseProjectModel(pdfName: "Introdução", pdfFileName: "Introducao", id: 2),
            DatabaseProjectModel(pdfName: "Conceitos", pdfFileName: "Conceitos", id: 3),
            DatabaseProjectModel(pdfName: "Gestão", pdfFileName: "Gestao", id: 4),
            DatabaseProjectModel(pdfName: "Modelo Entidade Relacionamento", pdfFileName: "MER", id: 5),
            DatabaseProjectModel(pdfName: "Modelagem 1", pdfFileName: "Modelagem1", id: 6),
            DatabaseProjectModel(pdfName: "Modelagem 2", pdfFileName: "Modelagem2", id: 7)
        ]
    }
    
    // MARK: - Methods
    func getDictionaryFrom(model: DatabaseProjectModel) -> Dictionary<String,AnyObject>? {
        
        var result = Dictionary<String,AnyObject>()
        
        if let pdfName = model.pdfName {
            result[DatabaseProjectAttributes.pdfName.rawValue] = pdfName as AnyObject
        }
        if let pdfFileName = model.pdfFileName {
            result[DatabaseProjectAttributes.pdfFileName.rawValue] = pdfFileName as AnyObject
        }
        if let id = model.id {
            result[DatabaseProjectAttributes.id.rawValue] = id as AnyObject
        }
        
        if result.isEmpty {
            return nil
        }
        
        return result
    }
    
    func getModelFrom(dictionary: Dictionary<String,AnyObject>) -> DatabaseProjectModel? {
        
        let result = DatabaseProjectModel()
        
        if let pdfName = dictionary[DatabaseProjectAttributes.pdfName.rawValue] as? String {
            result.pdfName = pdfName
        }
        if let pdfFileName = dictionary[DatabaseProjectAttributes.pdfFileName.rawValue] as? String {
            result.pdfFileName = pdfFileName
        }
        if let id = dictionary[DatabaseProjectAttributes.id.rawValue] as? Int {
            result.id = id
        }
        
        if result.id == nil {
            return nil
        }
        
        return result
    }
}
