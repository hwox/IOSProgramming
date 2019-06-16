//
//  RecommendViewController.swift
//  TranditionalHouse
//
//  Created by KPU_GAME on 17/06/2019.
//  Copyright © 2019 KPU_GAME. All rights reserved.
//

import UIKit

class RecommendViewController: UIViewController, XMLParserDelegate {

    @IBOutlet weak var infoText: UITextView!
    
    var url : String?
    
    @IBOutlet weak var nameText: UILabel!
    var parser = XMLParser()
    
    @IBOutlet weak var tourimage: UIImageView!
    let postname : [String] = [ "이름", "주소"]
    
    var posts : [String] = ["", "", ""]
    
    var elements = NSMutableDictionary()
    var element = NSString()
    
    
    var dbTitle = NSMutableString()
    var address = NSMutableString()
        var thumImg = NSMutableString()
    
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
        infoText.text = address as String
        nameText.text = dbTitle as String
        let imageUrl = URL(string: url!)!
        let imageData = try! Data(contentsOf: imageUrl)
        let image = UIImage(data: imageData)
      //  if let url = URL(string: (posts[2] as! NSString as String)){
      //  if let m_data = try? Data(contentsOf: (URL(string:url!))!){
         //       tourimage.image = UIImage(data: m_data)
       //     }
       // }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI namdspaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){
        
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "item"){
            elements = NSMutableDictionary()
            elements = [:]
            posts = ["", "", ""]
            
            address = NSMutableString()
            address = ""
            
            dbTitle = NSMutableString()
            dbTitle = ""
            
            thumImg = NSMutableString()
            thumImg = ""
            
        }
    }
    func parser(_ parser: XMLParser, foundCharacters string: String){
        
        if element.isEqual(to: "dbTitle"){
            dbTitle.append(string)
        }
        else if element.isEqual(to: "address"){
            address.append(string)
        }
        
        else if element.isEqual(to: "thumImg"){
            thumImg.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if(elementName as NSString).isEqual(to: "item") {
            if !dbTitle.isEqual(nil){
                posts[0] = dbTitle as String
            }
            if !address.isEqual(nil){
                posts[1] = address as String
            }
            if !thumImg.isEqual(nil){
                posts[2] = thumImg as String
                
            }
        }
        
    }

}
