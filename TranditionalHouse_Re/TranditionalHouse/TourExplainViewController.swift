//
//  TourExplainViewController.swift
//  TranditionalHouse
//
//  Created by KPU_GAME on 17/06/2019.
//  Copyright © 2019 KPU_GAME. All rights reserved.
//

import UIKit

class TourExplainViewController: UIViewController, XMLParserDelegate {
    

    @IBOutlet weak var imageTour: UIImageView!
    @IBOutlet weak var coreText: UITextView!
    @IBOutlet weak var introText: UITextView!
    
    @IBOutlet var explainview: UIView!
    
    
    
    var introduction = NSMutableString() // 소개 긴거
    var summary = NSMutableString() // 핵심내용(요약정보)
    var dbTitle = NSMutableString()
    //?
    
    
    var url : String?
    
    var parser = XMLParser()
    
    let postname : [String] = [ "소개", "핵심내용"]
    
    var posts : [String] = ["", ""]
    
    var elements = NSMutableDictionary()
    var element = NSString()
    
    func beginParsing(){
        
        posts = []
        parser = XMLParser(contentsOf:(URL(string:url!))!)!
        parser.delegate = self
        parser.parse()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
        ResetView()
        // Do any additional setup after loading the view.
    }
    
    func ResetView() {
        coreText.text = summary as String
        introText.text = introduction as String
        
        introText.layer.borderWidth = 1.0
        introText.layer.cornerRadius = 10
        
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI namdspaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){
        
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "item"){
            elements = NSMutableDictionary()
            elements = [:]
            posts = ["", ""]
            
            introduction = NSMutableString()
            introduction = ""
            
            summary = NSMutableString()
            summary = ""
            
        }
    }
    func parser(_ parser: XMLParser, foundCharacters string: String){
        
        if element.isEqual(to: "introduction"){
            introduction.append(string)
        }
        else if element.isEqual(to: "summary"){
            summary.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if(elementName as NSString).isEqual(to: "item") {
            if !introduction.isEqual(nil){
                posts[0] = introduction as String
            }
            if !summary.isEqual(nil){
                posts[1] = summary as String
            }
        }
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
