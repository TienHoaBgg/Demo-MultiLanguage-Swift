//
//  ViewController.swift
//  Demo MultiLanguage
//
//  Created by GEM on 12/15/20.
//

import UIKit

class ViewController: UIViewController {

 
    
    @IBOutlet var txtContent: UILabel!
    @IBOutlet var btnEn: UIButton!
    @IBOutlet var btnVi: UIButton!
    
    var bundle: Bundle = Bundle(){
        didSet{
            localizeString()
        }
    }
    
    func localizeString(){
        txtContent.text = NSLocalizedString("txtContent", bundle: bundle, comment: "")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bundle = LanguageManager.sharedInstance.getCurrentBundle()
    }

    @IBAction func btnEnglishClick(_ sender: Any) {
        LanguageManager.sharedInstance.setLocale(langCode: "en")
                bundle = LanguageManager.sharedInstance.getCurrentBundle()
    }
    
    @IBAction func btnViClick(_ sender: Any) {
        LanguageManager.sharedInstance.setLocale(langCode: "vi")
                bundle = LanguageManager.sharedInstance.getCurrentBundle()
    }
    
    
    
    
}

