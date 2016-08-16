//
//  Extensions.swift
//  ADSLPII
//
//  Created by John Lima on 13/08/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

#if os(iOS)
    import UIKit
    typealias SWColor = UIColor
#else
    import Cocoa
    typealias SWColor = NSColor
#endif

extension SWColor {
    
    /**
     Create non-autoreleased color with in the given hex string
     Alpha will be set as 1 by default
     
     :param:   hexString
     :returns: color with the given hex string
     */
    public convenience init?(hexString: String) {
        self.init(hexString: hexString, alpha: 1.0)
    }
    
    
    /**
     Create non-autoreleased color with in the given hex string and alpha
     
     :param:   hexString
     :param:   alpha
     :returns: color with the given hex string and alpha
     */
    public convenience init?(hexString: String, alpha: Float) {
        var hex = hexString
        
        // Check for hash and remove the hash
        if hex.hasPrefix("#") {
            hex = hex.substring(from: hex.index(hex.startIndex, offsetBy: 1))
        }
        
        if (hex.range(of: "(^[0-9A-Fa-f]{6}$)|(^[0-9A-Fa-f]{3}$)", options: .regularExpression) != nil) {
            
            // Deal with 3 character Hex strings
            if hex.characters.count == 3 {
                let redHex   = hex.substring(to: hex.index(hex.startIndex, offsetBy: 1))
                let greenHex = hex.substring(with: hex.index(hex.startIndex, offsetBy: 1)..<hex.index(hex.startIndex, offsetBy: 2))
                let blueHex  = hex.substring(from: hex.index(hex.startIndex, offsetBy: 2))
                
                hex = redHex + redHex + greenHex + greenHex + blueHex + blueHex
            }
            
            let redHex = hex.substring(to: hex.index(hex.startIndex, offsetBy: 2))
            let greenHex = hex.substring(with: hex.index(hex.startIndex, offsetBy: 2)..<hex.index(hex.startIndex, offsetBy: 4))
            let blueHex = hex.substring(with: hex.index(hex.startIndex, offsetBy: 4)..<hex.index(hex.startIndex, offsetBy: 6))
            
            var redInt:   CUnsignedInt = 0
            var greenInt: CUnsignedInt = 0
            var blueInt:  CUnsignedInt = 0
            
            Scanner(string: redHex).scanHexInt32(&redInt)
            Scanner(string: greenHex).scanHexInt32(&greenInt)
            Scanner(string: blueHex).scanHexInt32(&blueInt)
            
            self.init(red: CGFloat(redInt) / 255.0, green: CGFloat(greenInt) / 255.0, blue: CGFloat(blueInt) / 255.0, alpha: CGFloat(alpha))
        }
        else {
            // Note:
            // The swift 1.1 compiler is currently unable to destroy partially initialized classes in all cases,
            // so it disallows formation of a situation where it would have to.  We consider this a bug to be fixed
            // in future releases, not a feature. -- Apple Forum
            self.init()
            return nil
        }
    }
    
    /**
     Create non-autoreleased color with in the given hex value
     Alpha will be set as 1 by default
     
     :param:   hex
     :returns: color with the given hex value
     */
    public convenience init?(hex: Int) {
        self.init(hex: hex, alpha: 1.0)
    }
    
    /**
     Create non-autoreleased color with in the given hex value and alpha
     
     :param:   hex
     :param:   alpha
     :returns: color with the given hex value and alpha
     */
    public convenience init?(hex: Int, alpha: Float) {
        let hexString = NSString(format: "%2X", hex)
        self.init(hexString: hexString as String , alpha: alpha)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return NSString(format:"#%06x", rgb) as String
    }
    
}

extension String {
    
    static func isValidEmail(email: String) -> Bool {
        if email.range(of: "@") != nil {
            if email.range(of: ".com") != nil {
                return true
            }else {
                return false
            }
        }else {
            return false
        }
    }
    
    static func base64Encode(string: String) -> String {
        var result = String()
        let utf8str = string.data(using: String.Encoding.utf8)
        let base64Encoded = utf8str!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        result = base64Encoded
        return result
    }

    static func base64Decode(stringEncoded: String) -> String {
        var result = String()
        let data = NSData(base64Encoded: stringEncoded, options: NSData.Base64DecodingOptions(rawValue: 0)) as! Data
        let base64Decoded = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        result = base64Decoded as! String
        return result
    }
    
    static func currencyCurrentValue(value: NSDecimalNumber) -> String {
        var result = String()
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        result = formatter.string(from: value)!
        return result
    }
    
    static func currencyValueWithCurrencyCode(value: NSDecimalNumber, currencyCode: String) -> String {
        var result = String()
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        result = formatter.string(from: value)!
        return result
    }
    
    static func createTemporallyPassword() -> String {
        var pass = UInt32()
        func createPassword() {
            let password = arc4random() % 999999
            pass = password
            if "\(pass)".characters.count != 6  {
                createPassword()
            }
        }
        createPassword()
        return "\(pass)"
    }
    
}

extension Int {

    static func generateUniqueId(data: [AnyObject]?, key: String?) -> String {
        var result = String()
        func checkingExistedAndGetUniqueNumber(data: [AnyObject]?, key: String?, completion: @escaping (String) -> ()) {
            var unique: Int = 0
            func checking() {
                if data != nil, let data = data as? [Dictionary<String,AnyObject>] {
                    var e = [String]()
                    unique += 1
                    for obj in data {
                        if let key = key {
                            if let value = obj[key] as? String {
                                e.append(value)
                            }
                        }
                    }
                    if e.count < 1 {
                        unique = 1
                        completion(String(unique))
                    }else {
                        if e.contains(String(unique)) {
                            checking()
                        }else {
                            completion(String(unique))
                        }
                    }
                }else {
                    unique = 1
                    completion(String(unique))
                }
            }
            checking()
        }
        checkingExistedAndGetUniqueNumber(data: data, key: key) { (id) -> () in
            result = id
        }
        return result
    }
}

extension Date {
    
    static func stringFromDate(date: Date, calendar: Calendar, dateStyle: DateFormatter.Style) -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = calendar.timeZone
        dateFormatter.dateStyle = dateStyle
        return dateFormatter.string(from: date)
    }
    
    static func stringFromDateWithTime(date: Date, dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let result = DateFormatter.localizedString(from: date, dateStyle: dateStyle, timeStyle: timeStyle)
        return result
    }
    
    static func dateFromDateAndTime(date: Date, dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> Date? {
        let dateFormatter: DateFormatter = DateFormatter()
        var stringFromDate: String = String()
        var dateFromString: Date? = Date()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        stringFromDate = dateFormatter.string(from: date)
        dateFromString = dateFormatter.date(from: stringFromDate)
        return dateFromString
    }
    
    static func dateFromParams(year: Int, month: Int, day: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        (dateComponents as NSDateComponents).timeZone = TimeZone.current
        let userCalendar = Calendar.current
        let someDateTime = userCalendar.date(from: dateComponents)
        return someDateTime
    }
    
    static func dateFromStringDateWithTime(date: String, dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> Date? {
        let formatter: DateFormatter = DateFormatter()
        var dateFromString: Date?
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        dateFromString = formatter.date(from: date)
        return dateFromString
    }
    
}

extension UILabel {
    
    func fullRange() -> NSRange {
        return NSMakeRange(0, (text ?? "").characters.count)
    }
    
    // Range Formatter
    func setTextColor(color: UIColor, range: NSRange?) {
        guard let range = range else { return }
        let text = mutableAttributedString()
        text.addAttribute(NSForegroundColorAttributeName, value: color, range: range)
        attributedText = text
    }
    
    func setFont(font: UIFont, range: NSRange?) {
        guard let range = range else { return }
        let text = mutableAttributedString()
        text.addAttribute(NSFontAttributeName, value: font, range: range)
        attributedText = text
    }
    
    func setTextUnderline(color: UIColor, range: NSRange?) {
        setTextUnderline(color: color, range: range, byWord: false)
    }
    
    func setTextUnderline(color: UIColor, range: NSRange?, byWord: Bool) {
        guard let range = range else { return }
        let text = mutableAttributedString()
        var style = NSUnderlineStyle.styleSingle.rawValue
        if byWord { style = style | NSUnderlineStyle.byWord.rawValue }
        text.addAttribute(NSUnderlineStyleAttributeName, value: NSNumber(value: style), range: range)
        text.addAttribute(NSUnderlineColorAttributeName, value: color, range: range)
        attributedText = text
    }
    
    func setTextWithoutUnderline(range: NSRange?) {
        guard let range = range else { return }
        let text = mutableAttributedString()
        text.removeAttribute(NSUnderlineStyleAttributeName, range: range)
        attributedText = text
    }
    
    // String Formatter
    func rangeOf(string: String) -> NSRange? {
        let range = NSString(string: text ?? "").range(of: string)
        return range.location != NSNotFound ? range : nil
    }
    
    func setTextColor(color: UIColor, string: String) {
        setTextColor(color: color, range: rangeOf(string: string))
    }
    
    func setFont(font: UIFont, string: String) {
        setFont(font: font, range: rangeOf(string: string))
    }
    
    func setTextUnderline(color: UIColor, string: String) {
        setTextUnderline(color: color, range: rangeOf(string: string))
    }
    
    func setTextUnderline(color: UIColor, string: String, byWord: Bool) {
        setTextUnderline(color: color, range: rangeOf(string: string), byWord: byWord)
    }
    
    func setTextWithoutUnderline(string: String) {
        setTextWithoutUnderline(range: rangeOf(string: string))
    }
    
    // After Formatter
    func rangeAfter(string: String) -> NSRange? {
        guard var range = rangeOf(string: string) else { return nil }
        
        range.location = range.location + range.length
        range.length = text!.characters.count - range.location
        return range
    }
    
    func setTextColor(color: UIColor, after: String) {
        setTextColor(color: color, range: rangeAfter(string: after))
    }
    
    func setFont(font: UIFont, after: String) {
        setFont(font: font, range: rangeAfter(string: after))
    }
    
    func setTextUnderline(color: UIColor, after: String) {
        setTextUnderline(color: color, range: rangeAfter(string: after))
    }
    
    func setTextUnderline(color: UIColor, after: String, byWord: Bool) {
        setTextUnderline(color: color, range: rangeAfter(string: after), byWord: byWord)
    }
    
    func setTextWithoutUnderline(after: String) {
        setTextWithoutUnderline(range: rangeAfter(string: after))
    }
    
    // Before Formatter
    func rangeBefore(string: String) -> NSRange? {
        guard var range = rangeOf(string: string) else { return nil }
        
        range.length = range.location
        range.location = 0
        return range
    }
    
    func setTextColor(color: UIColor, before: String) {
        setTextColor(color: color, range: rangeBefore(string: before))
    }
    
    func setFont(font: UIFont, before: String) {
        setFont(font: font, range: rangeBefore(string: before))
    }
    
    func setTextUnderline(color: UIColor, before: String) {
        setTextUnderline(color: color, range: rangeBefore(string: before))
    }
    
    func setTextUnderline(color: UIColor, before: String, byWord: Bool) {
        setTextUnderline(color: color, range: rangeBefore(string: before), byWord: byWord)
    }
    
    func setTextWithoutUnderline(before: String) {
        setTextWithoutUnderline(range: rangeBefore(string: before))
    }
    
    // After & Before Formatter
    func rangeAfter(_ after: String, before: String) -> NSRange? {
        guard let rAfter = rangeAfter(string: after) else { return nil }
        guard let rBefore = rangeBefore(string: before) else { return nil }
        
        if rAfter.location < rBefore.length {
            return NSMakeRange(rAfter.location, rBefore.length - rAfter.location)
        }
        
        return nil
    }
    
    func setTextColor(color: UIColor, after: String, before: String) {
        setTextColor(color: color, range: rangeAfter(after, before: before))
    }
    
    func setFont(font: UIFont, after: String, before: String) {
        setFont(font: font, range: rangeAfter(after, before: before))
    }
    
    func setTextUnderline(color: UIColor, after: String, before: String) {
        setTextUnderline(color: color, range: rangeAfter(after, before: before))
    }
    
    func setTextUnderline(color: UIColor, after: String, before: String, byWord: Bool) {
        setTextUnderline(color: color, range: rangeAfter(after, before: before), byWord: byWord)
    }
    
    func setTextWithoutUnderline(after: String, before: String) {
        setTextWithoutUnderline(range: rangeAfter(after, before: before))
    }
    
    // From Formatter
    func rangeFrom(string: String) -> NSRange? {
        guard var range = rangeOf(string: string) else { return nil }
        
        range.length = text!.characters.count - range.location
        return range
    }
    
    func setTextColor(color: UIColor, from: String) {
        setTextColor(color: color, range: rangeFrom(string: from))
    }
    
    func setFont(font: UIFont, from: String) {
        setFont(font: font, range: rangeFrom(string: from))
    }
    
    func setTextUnderline(color: UIColor, from: String) {
        setTextUnderline(color: color, range: rangeFrom(string: from))
    }
    
    func setTextUnderline(color: UIColor, from: String, byWord: Bool) {
        setTextUnderline(color: color, range: rangeFrom(string: from), byWord: byWord)
    }
    
    func setTextWithoutUnderline(from: String) {
        setTextWithoutUnderline(range: rangeFrom(string: from))
    }
    
    // To Formatter
    func rangeTo(string: String) -> NSRange? {
        guard var range = rangeOf(string: string) else { return nil }
        
        range.length = range.location + range.length
        range.location = 0
        return range
    }
    
    func setTextColor(color: UIColor, to: String) {
        setTextColor(color: color, range: rangeTo(string: to))
    }
    
    func setFont(font: UIFont, to: String) {
        setFont(font: font, range: rangeTo(string: to))
    }
    
    func setTextUnderline(color: UIColor, to: String) {
        setTextUnderline(color: color, range: rangeTo(string: to))
    }
    
    func setTextUnderline(color: UIColor, to: String, byWord: Bool) {
        setTextUnderline(color: color, range: rangeTo(string: to), byWord: byWord)
    }
    
    func setTextWithoutUnderline(to: String) {
        setTextWithoutUnderline(range: rangeTo(string: to))
    }
    
    // From & To Formatter
    func rangeFrom(from: String, to: String) -> NSRange? {
        guard let rFrom = rangeFrom(string: from) else { return nil }
        guard let rTo = rangeTo(string: to) else { return nil }
        
        if rFrom.location < rTo.length {
            return NSMakeRange(rFrom.location, rTo.length - rFrom.location)
        }
        
        return nil
    }
    
    func setTextColor(color: UIColor, from: String, to: String) {
        setTextColor(color: color, range: rangeFrom(from: from, to: to))
    }
    
    func setFont(font: UIFont, from: String, to: String) {
        setFont(font: font, range: rangeFrom(from: from, to: to))
    }
    
    func setTextUnderline(color: UIColor, from: String, to: String) {
        setTextUnderline(color: color, range: rangeFrom(from: from, to: to))
    }
    
    func setTextUnderline(color: UIColor, from: String, to: String, byWord: Bool) {
        setTextUnderline(color: color, range: rangeFrom(from: from, to: to), byWord: byWord)
    }
    
    func setTextWithoutUnderline(from: String, to: String) {
        setTextWithoutUnderline(range: rangeFrom(from: from, to: to))
    }
    
    // Helpers
    private func mutableAttributedString() -> NSMutableAttributedString {
        if attributedText != nil {
            return NSMutableAttributedString(attributedString: attributedText!)
        } else {
            return NSMutableAttributedString(string: text ?? "")
        }
    }
    
}

extension UIStoryboard {
    
    static func startWithViewControllerWithWindow(named: String, window: UIWindow?) {
        let storyboard = UIStoryboard(name: Storyboard.Main.rawValue, bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: named)
        window?.rootViewController = vc
    }
    
    static func startViewController(named: String, target: AnyObject) {
        let storyboard = UIStoryboard(name: Storyboard.Main.rawValue, bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: named)
        target.present(vc, animated: true, completion: nil)
    }
    
}

extension Data {
    
    static func convertAnyObjectToNSData(object: AnyObject) -> Data {
        let data: Data = NSKeyedArchiver.archivedData(withRootObject: object)
        return data
    }
    
    static func convertNSDataToAnyObject(data: Data?) -> Any? {
        if data != nil {
            let object = NSKeyedUnarchiver.unarchiveObject(with: data!)
            return object
        }else {
            return nil
        }
    }
    
}

extension NSError {
    
    @available(*, deprecated, message: "Set code")
    class func FIXME() {}
    
}

extension UIAlertController {

    static func createAlert(title: String?, message: String?, style: UIAlertControllerStyle, actions: [UIAlertAction]?, target: AnyObject, isPopover: Bool, buttonItem: UIBarButtonItem?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        if let actions = actions {
            for action in actions {
                alert.addAction(action)
            }
        }
        
        if isPopover {
            alert.modalPresentationStyle = .popover
            let popover = alert.popoverPresentationController!
            popover.barButtonItem = buttonItem
            popover.sourceRect = CGRect(x: 0, y: 10, width: 0, height: 0)
            popover.backgroundColor = UIColor.white
        }
        
        target.present(alert, animated: true, completion: nil)
    }
    
}

extension UserDefaults {

    static func saveObject(object: AnyObject, key: String) {
        UserDefaults.standard.set(object, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static func saveBoolValue(status: Bool, key: String) {
        UserDefaults.standard.set(status, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static func getObject(forKey: String) -> AnyObject? {
        if let object = UserDefaults.standard.object(forKey: forKey) {
            return object as AnyObject
        }else {
            return nil
        }
    }
    
    static func getBoolValue(forKey: String) -> Bool? {
        return UserDefaults.standard.bool(forKey: forKey)
    }
    
    static func removeObject(forKey: String) {
        UserDefaults.standard.removeObject(forKey: forKey)
        UserDefaults.standard.synchronize()
    }
    
}

extension UIToolbar {
    
    static func createToolbar(textFiels: [AnyObject], doneAction: Selector, color: String, target: AnyObject) {
        
        let toolbar: UIToolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 45)
        
        for field in textFiels {
            if let textField = field as? UITextField {
                textField.inputAccessoryView = toolbar
            }
            if let textView = field as? UITextField {
                textView.inputAccessoryView = toolbar
            }
        }
        
        let done: UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString(ButtonTitle.Ok.rawValue, comment: ""), style: .plain, target: target, action: doneAction)
        let flexibleSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        done.tintColor = UIColor(hexString: color)
        
        let arrayListaBotoes: NSArray = [flexibleSpace, done]
        toolbar.setItems(arrayListaBotoes as? [UIBarButtonItem], animated: true)
    }
    
}

