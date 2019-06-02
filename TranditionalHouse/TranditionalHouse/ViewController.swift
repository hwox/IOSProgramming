//
//  ViewController.swift
//  XMLParsingDemo
//
//  Created by KPU_GAME on 18/04/2019.
//  Copyright © 2019 KPU_GAME. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    @IBAction func doneToPickerViewController(segue: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
/*
    @IBOutlet weak var TbData: UITableView!
    
    var parser = XMLParser()
    
    var posts = NSMutableArray()
    
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var title1 = NSMutableString()
    var date = NSMutableString()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
        // Do any additional setup after loading the view.
    }
    
    func beginParsing(){
        posts = []
        parser = XMLParser(contentsOf: (URL(string:"http://api.visitkorea.or.kr/openapi/service/rest/HanokStayInformationService/hanokStayInformationList?serviceKey=uCstxgLSF6idf%2BteFc1Sb8ZX03SfFvl8h6aDFb8CqgB5%2FnR%2FehJ2cH9wgg0iGzH28sD8Aj0IYiTDJ7ZZnEJkGw%3D%3D&numOfRows=10&pageNo=1&langType=KOR&MobileOS=ETC&MobileApp=AppTest"))!)!
        parser.delegate = self
        parser.parse()
        TbData!.reloadData()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI namdspaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "item"){
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
            date = NSMutableString()
            date = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String){
        if element.isEqual(to: "titleKorean"){
            title1.append(string)
        }
        else if element.isEqual(to: "buildPhases") {
            date.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        if(elementName as NSString).isEqual(to: "item"){
            if !title1.isEqual(nil) {
                elements.setObject(title1, forKey: "titleKorean" as NSCopying)
            }
            if !date.isEqual(nil) {
                elements.setObject(date, forKey: "buildPhases" as NSCopying)
            }
            
            posts.add(elements)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "titleKorean") as! NSString as String
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "buildPhases") as! NSString as String
        return cell
    }
    
*/
}

