//
//  LanguageManager.swift
//  Demo MultiLanguage
//
//  Created by GEM on 12/15/20.
//

import UIKit

class LanguageManager: NSObject {
    
    var availableLocales = [Locale]()
    static let sharedInstance = LanguageManager()
    
    override init() {
        let english = Locale()
       _=english.initWithLanguageCode(languageCode: "en", countryCode: "gb", name: "United Kingdom")
        
        let finnish  = Locale()
        _=finnish.initWithLanguageCode(languageCode: "vi", countryCode: "vi", name: "VietNamese")
        self.availableLocales = [english,finnish]
    }
    
    func getCurrentBundle()->Bundle{
        
        let bundlePath = Bundle.main.path(forResource: getSelectedLocale(), ofType: "lproj")
        let bundle = Bundle(path: bundlePath!)
        return bundle!
        
    }
    
    private func getSelectedLocale()->String{
        let lang = NSLocale.preferredLanguages
        let languageComponents: [String : String] = NSLocale.components(fromLocaleIdentifier: lang[0])
        if let languageCode: String = languageComponents[NSLocale.Key.languageCode.rawValue]{
            for locale in availableLocales {
                if(locale.languageCode == languageCode){
                    
                    return locale.languageCode!
                }
            }
        }
        return "en"
    }
    
    func setLocale(langCode:String){
        UserDefaults.standard.set([langCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
}
class Locale: NSObject {
    var name:String?
    var languageCode:String?
    var countryCode:String?
    
    func initWithLanguageCode(languageCode: String,countryCode:String,name: String)->AnyObject{
        self.name = name
        self.languageCode = languageCode
        self.countryCode = countryCode
        return self
    }
}
