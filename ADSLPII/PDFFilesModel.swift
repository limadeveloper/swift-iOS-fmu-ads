//
//  PDFFilesModel.swift
//  ADSLPII
//
//  Created by John Lima on 21/08/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import Foundation

enum PDFFilesAttributes: String {
    case pdfName = "pdfName"
    case pdfFileName = "pdfFileName"
    case id = "id"
}

enum PDFFileId: Int {
    case MS = 1
    case APS = 2
    case LPII = 3
    case PBD = 4
}

class PDFFilesModel {

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

extension PDFFilesModel {
    
    // MARK: - Data
    func getDatabaseProjectData() -> [PDFFilesModel] {
        return [
            PDFFilesModel(pdfName: "Plano de Ensino", pdfFileName: "PlanoDeEnsino", id: 1),
            PDFFilesModel(pdfName: "Introdução", pdfFileName: "Introducao", id: 2),
            PDFFilesModel(pdfName: "Conceitos", pdfFileName: "Conceitos", id: 3),
            PDFFilesModel(pdfName: "Gestão", pdfFileName: "Gestao", id: 4),
            PDFFilesModel(pdfName: "MER", pdfFileName: "MER", id: 5),
            PDFFilesModel(pdfName: "Modelagem 1", pdfFileName: "Modelagem1", id: 6),
            PDFFilesModel(pdfName: "Modelagem 2", pdfFileName: "Modelagem2", id: 7)
        ]
    }
    
    func getModelingSystemsData() -> [PDFFilesModel] {
        return [
            PDFFilesModel(pdfName: "Apresentação", pdfFileName: "ApresentacaoMS", id: 1),
            PDFFilesModel(pdfName: "Introdução", pdfFileName: "IntroducaoMS", id: 2),
            PDFFilesModel(pdfName: "Casos de Uso", pdfFileName: "CasoDeUso", id: 3)
        ]
    }
    
    // MARK: - Methods
    func getDictionaryFrom(model: PDFFilesModel) -> Dictionary<String,AnyObject>? {
        
        var result = Dictionary<String,AnyObject>()
        
        if let pdfName = model.pdfName {
            result[PDFFilesAttributes.pdfName.rawValue] = pdfName as AnyObject
        }
        if let pdfFileName = model.pdfFileName {
            result[PDFFilesAttributes.pdfFileName.rawValue] = pdfFileName as AnyObject
        }
        if let id = model.id {
            result[PDFFilesAttributes.id.rawValue] = id as AnyObject
        }
        
        if result.isEmpty {
            return nil
        }
        
        return result
    }
    
    func getModelFrom(dictionary: Dictionary<String,AnyObject>) -> PDFFilesModel? {
        
        let result = PDFFilesModel()
        
        if let pdfName = dictionary[PDFFilesAttributes.pdfName.rawValue] as? String {
            result.pdfName = pdfName
        }
        if let pdfFileName = dictionary[PDFFilesAttributes.pdfFileName.rawValue] as? String {
            result.pdfFileName = pdfFileName
        }
        if let id = dictionary[PDFFilesAttributes.id.rawValue] as? Int {
            result.id = id
        }
        
        if result.id == nil {
            return nil
        }
        
        return result
    }
}
