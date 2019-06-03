//
//  HospitalTableViewController.swift
//  HospitalMap
//
//  Created by KPU_GAME on 22/04/2019.
//  Copyright © 2019 KPU_GAME. All rights reserved.
//

import UIKit

class HouseTableViewController: UITableViewController,XMLParserDelegate {

    @IBOutlet var tbData: UITableView!
    // ViewController로 부터 segue를 통해 전달받은 OpenAPI url주소
    
    
    var url : String = "http://api.visitkorea.or.kr/openapi/service/rest/HanokStayInformationService/hanokStayInformationList?serviceKey=uCstxgLSF6idf%2BteFc1Sb8ZX03SfFvl8h6aDFb8CqgB5%2FnR%2FehJ2cH9wgg0iGzH28sD8Aj0IYiTDJ7ZZnEJkGw%3D%3D&numOfRows=130&pageNo=1&langType=KOR&MobileOS=ETC&MobileApp=AppTest"

    //var url : String?
    
    var parser = XMLParser()
    
    var posts = NSMutableArray()
    
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var title1 = NSMutableString()
    var date = NSMutableString()
    
    var addr = NSMutableString()
    
    // 사진
        var imageurl = NSMutableString()
    
    var Housename = ""
    var Housename_utf8 = ""
    
    var XPos = NSMutableString()
    var YPos = NSMutableString()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        beginParsing()
    }
    
    
    func beginParsing(){
        posts = []
        parser = XMLParser(contentsOf:(URL(string:"http://api.visitkorea.or.kr/openapi/service/rest/HanokStayInformationService/hanokStayInformationList?serviceKey=uCstxgLSF6idf%2BteFc1Sb8ZX03SfFvl8h6aDFb8CqgB5%2FnR%2FehJ2cH9wgg0iGzH28sD8Aj0IYiTDJ7ZZnEJkGw%3D%3D&numOfRows=130&pageNo=1&langType=KOR&MobileOS=ETC&MobileApp=AppTest"))!)!
       // parser = XMLParser(contentsOf:(URL(string:url!))!)!
        parser.delegate = self
        parser.parse()
        tbData!.reloadData()
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
            
            XPos = NSMutableString()
            XPos = ""
            YPos = NSMutableString()
            YPos = ""
            
            addr = NSMutableString()
            addr = ""
            
            imageurl = NSMutableString()
            imageurl = ""
        }
    }
    
    
    func parser(_ parser: XMLParser, foundCharacters string: String){
        if element.isEqual(to: "titleKorean"){
            title1.append(string)
        }
        else if element.isEqual(to: "buildPhases") {
            date.append(string)
        }
        else if element.isEqual(to: "latitude"){
            XPos.append(string)
        }
        else if element.isEqual(to: "longitude"){
            YPos.append(string)
        }
        else if element.isEqual(to: "roadnameAddress"){
            addr.append(string)
        }
        
        else if element.isEqual(to: "thumImg"){
            imageurl.append(string)
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
            if !XPos.isEqual(nil){
                elements.setObject(XPos, forKey: "latitude" as NSCopying)
            }
            if !YPos.isEqual(nil){
                elements.setObject(YPos, forKey: "longitude" as NSCopying)
            }
            if !addr.isEqual(nil){
                elements.setObject(addr, forKey: "roadnameAddress" as NSCopying)
            }
            if !imageurl.isEqual(nil){
                elements.setObject(imageurl, forKey: "thumImg" as NSCopying)
            }
            posts.add(elements)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if segue.identifier == "segueToMapView" {
            if let mapViewController = segue.destination as? MapViewController {
                mapViewController.posts = posts
            }
        }
        
        if segue.identifier == "segueToHouse" {
            if let cell = sender as? UITableViewCell {
                
                let indexPath = tableView.indexPath(for: cell)
                Housename = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "titleKorean") as! NSString as String
                // url에서 한글을 쓸 수 있도록 코딩
                
                print(Housename)
                Housename_utf8 = Housename.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                if let detailTableViewController = segue.destination as? DetailTableViewController {

                    detailTableViewController.url = url + "&titleKorean=" + Housename_utf8
                    //DetailTableViewController.url = url! + "&titleKorean=" + Housename_utf8
                   
                }
            }
        }
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "titleKorean") as! NSString as String
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "buildPhases") as! NSString as String
        if let url = URL(string: (posts.object(at: indexPath.row) as AnyObject).value(forKey: "thumImg") as! NSString as String){
            if let data = try? Data(contentsOf: url){
                cell.imageView?.image = UIImage(data: data)
            }
        }
        return cell
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
