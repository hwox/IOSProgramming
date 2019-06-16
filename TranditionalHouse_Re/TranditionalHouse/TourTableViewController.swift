//
//  TourTableViewController.swift
//  TranditionalHouse
//
//  Created by KPU_GAME on 14/06/2019.
//  Copyright © 2019 KPU_GAME. All rights reserved.
//

import UIKit

class TourTableViewController: UITableViewController,XMLParserDelegate  {

    
    @IBOutlet var TbData: UITableView!
    
    var parser = XMLParser()
    
    var posts = NSMutableArray()
    
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var dbTitle = NSMutableString()
    var title2 = NSMutableString()
    
    var sidoAreaCode = NSMutableString()
    var sigunguAreaCode = NSMutableString()
    
    // 대표이미지
    var thumImg = NSMutableString()
    
    var tourname = ""
    var tourname_utf8 = ""
    
    var url : String = "http://api.visitkorea.or.kr/openapi/service/rest/SurroundingTourInformationService/tourAttractionInformationList?serviceKey=uCstxgLSF6idf%2BteFc1Sb8ZX03SfFvl8h6aDFb8CqgB5%2FnR%2FehJ2cH9wgg0iGzH28sD8Aj0IYiTDJ7ZZnEJkGw%3D%3D&numOfRows=10&pageNo=1&langType=KOR&MobileOS=ETC&MobileApp=AppTest"+"&sidoArea="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
        // Do any additional setup after loading the view.
    }
    
    func beginParsing(){
        
        
        posts = []
        parser = XMLParser(contentsOf:(URL(string:url+(sidoAreaCode as String) as String))!)!
        parser.delegate = self
        parser.parse()
        TbData.reloadData()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI namdspaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "item"){
            elements = NSMutableDictionary()
            elements = [:]
            dbTitle = NSMutableString()
            dbTitle = ""
            title2 = NSMutableString()
            title2 = ""
            
            thumImg = NSMutableString()
            thumImg = ""
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String){
        
        if element.isEqual(to: "dbTitle"){
            dbTitle.append(string)
        } else if element.isEqual(to: "title"){
            title2.append(string)
        } else if element.isEqual(to: "thumImg"){
            thumImg.append(string)
        }

    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI namdspaceURI: String?, qualifiedName qName: String?){
        if(elementName as NSString).isEqual(to: "item"){
            if !dbTitle.isEqual(nil) {
                elements.setObject(dbTitle, forKey: "dbTitle" as NSCopying)
            }
            if !title2.isEqual(nil) {
                elements.setObject(title2, forKey: "title" as NSCopying)
            }
            if !thumImg.isEqual(nil){
                elements.setObject(thumImg, forKey: "thumImg" as NSCopying)
                
            }
            posts.add(elements)
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "dbTitle") as! NSString as String
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "title") as! NSString as String
        
        if let url = URL(string: (posts.object(at: indexPath.row) as AnyObject).value(forKey: "thumImg") as! NSString as String){
            if let data = try? Data(contentsOf: url){
                print(data)
                cell.imageView?.image = UIImage(data: data)
            }
        }
        
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if segue.identifier == "segueToRecommend" {
            let randomNo: UInt32 = arc4random_uniform(UInt32(posts.count));
            
           // tourname = posts[Int(randomNo)] as! NSString as String
            tourname = (posts.object(at: Int(randomNo)) as AnyObject).value(forKey: "dbTitle") as! NSString as String
            tourname_utf8 = tourname.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!

            if let recommendViewController = segue.destination as? RecommendViewController {
                
                recommendViewController.url = "http://api.visitkorea.or.kr/openapi/service/rest/SurroundingTourInformationService/tourAttractionInformationList?serviceKey=uCstxgLSF6idf%2BteFc1Sb8ZX03SfFvl8h6aDFb8CqgB5%2FnR%2FehJ2cH9wgg0iGzH28sD8Aj0IYiTDJ7ZZnEJkGw%3D%3D&numOfRows=10&pageNo=1&langType=KOR&MobileOS=ETC&MobileApp=AppTest" + "&dbTitle=" + tourname_utf8
                
            }
        }
        
        if let cell = sender as? UITableViewCell {
        let indexPath = tableView.indexPath(for: cell)
        tourname = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "dbTitle") as! NSString as String
        // url에서 한글을 쓸 수 있도록 코딩
        tourname_utf8 = tourname.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        if segue.identifier == "segueToTourDetail" {
            if let tourDetailTableViewController = segue.destination as? TourDetailTableViewController {
                tourDetailTableViewController.url = "http://api.visitkorea.or.kr/openapi/service/rest/SurroundingTourInformationService/tourAttractionInformationList?serviceKey=uCstxgLSF6idf%2BteFc1Sb8ZX03SfFvl8h6aDFb8CqgB5%2FnR%2FehJ2cH9wgg0iGzH28sD8Aj0IYiTDJ7ZZnEJkGw%3D%3D&numOfRows=10&pageNo=1&langType=KOR&MobileOS=ETC&MobileApp=AppTest" + "&dbTitle=" + tourname_utf8
            }
        }
       
        }
    }
}
