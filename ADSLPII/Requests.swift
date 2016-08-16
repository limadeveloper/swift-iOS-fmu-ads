//
//  Requests.swift
//  ADSLPII
//
//  Created by John Lima on 13/08/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import Foundation

class Requests {

    /**
     * O id deverá ser do tipo string
     */
    class func formateDataFromArray(data: [Dictionary<String,AnyObject>], sectionKey: String, idKey: String) -> (sections: [String]?, rows: Dictionary<String,AnyObject>?) {
        
        var result: (sections: [String]?, rows: Dictionary<String,AnyObject>?) = (nil, nil)
        var rowsForSection = [Dictionary<String,AnyObject>]()
        var sections = [String]()
        var rows = Dictionary<String,AnyObject>()
        var previoursId: Int = -1
        var currentId: Int = -1
        
        if data.count > 0 {
            
            func save() {
                if rowsForSection.count > 0 {
                    for item in rowsForSection {
                        if let dataSectionKey = item[sectionKey] as? String {
                            let key = dataSectionKey
                            if sections.contains(key) {
                                rows.updateValue(rowsForSection as AnyObject, forKey: key)
                                rowsForSection = [Dictionary<String,AnyObject>]()
                                break
                            }
                        }
                    }
                }
            }
            
            for i in 0 ..< data.count {
                
                if let dataSectionKey = data[i][sectionKey] as? String, let dataIdKey = data[i][idKey] as? String {
                    
                    let sectionHeading = dataSectionKey
                    sections.append(sectionHeading)
                    sections = Array(Set(sections))
                    
                    rowsForSection.append(data[i])
                    
                    if currentId != Int(dataIdKey) {
                        currentId = Int(dataIdKey)!
                    }
                    
                    if currentId != previoursId && previoursId != -1 {
                        save()
                    }
                    
                    previoursId = currentId
                }
                
                if i == data.count-1 {
                    save()
                }
            }
            
            result = (sections, rows)
        }
        
        return result
    }
    
}
