//
//  Constants.swift
//  ADSLPII
//
//  Created by John Lima on 13/08/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import Foundation

enum Colors: String {
    case Default = "#FF0040"
}

enum ButtonTitle: String {
    case Ok = "Ok"
    case Order = "Ordenar"
}

enum StoryboardName: String {
    case ProgrammingLanguageII = "ProgrammingLanguageII"
}

enum NavigationName: String {
    case ProgrammingLanguageII = "Linguagem de Programação II"
}

enum Segue: String {
    case First = "first"
    case Second = "second"
}

enum Message: String {
    case Done = "Pronto"
    case YouSelectedThisNumbers = "Você selecionou os seguintes números:"
    case SelectedNumbers = "Números Selecionados"
    case OrderedNumbers = "Números Ordenados"
    case Result = "Resultado"
    case EnterWithNumber = "Entre com os números"
    case FileNoFound = "Arquivo não encontrado"
    case Error = "Erro"
    case Message = ""
}

enum Title: String {
    case First = "Ordena Valores"
    case Second = "Calcula Média"
    case WebFile = "Arquivo"
}

enum ControllerIdentifier: String {
    case FileWebViewController = "FileWebViewController"
    case ProgrammingLanguageII = "ProgrammingLanguageII"
}

enum KeyData: String {
    case File = "keyFile"
    case Title = "keyTitle"
}
