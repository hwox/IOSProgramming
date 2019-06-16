//
//  DetailTableViewController.swift
//  TranditionalHouse
//
//  Created by KPU_GAME on 02/06/2019.
//  Copyright © 2019 KPU_GAME. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController, XMLParserDelegate {

    @IBOutlet var detailTableView: UITableView!
    
    var url : String?

    
    var parser = XMLParser()
    
    let postname : [String] = ["가옥 이름", "건축 시기", "체크 인", "체크 아웃", "쉬는 날", "취사 여부", "드라이기", "선풍기",
    "민속 마을", "인터넷 가능 여부", "객실수(숙박가능인원)", "냉장고", "최소 객실요금", "숙박가능 여부", "화장실", "세면도구", "tv","지번주소"]
    var posts : [String] = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
    
    var location = NSMutableArray()
    
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var titleKorean = NSMutableString()
    var House_gener = NSMutableString()
    var checkin_Time = NSMutableString()
    var checkout_Time = NSMutableString()
    var closed = NSMutableString() // 쉬는날
    var cooking = NSMutableString() // 취사 여부
    var dry = NSMutableString() // 드라이기(1-> 보유 , 0-> 미보유)
    var fan = NSMutableString() // 선풍기
    var folkVillage = NSMutableString()// 민속마을
    var internet = NSMutableString() //인터넷
    var numberOfRooms = NSMutableString() // 객실수
    var refrigerator = NSMutableString() // 냉장고
    var roomCharge = NSMutableString() // 최소 객실요금
    var StayOrNot = NSMutableString() // 숙박가능여부
    var toilet = NSMutableString() //화장실
    var wash = NSMutableString() // 세면도구
    var tv = NSMutableString() // tv
    var roadnameAddress = NSMutableString() //도로명주소
    
    var XPos = NSMutableString()
    var YPos = NSMutableString()
    
    
    var housename = ""
    var housename_utf8 = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
        
    }

    
    func beginParsing(){
        posts = []
        parser = XMLParser(contentsOf:(URL(string:url!))!)!
        parser.delegate = self
        parser.parse()
        detailTableView.reloadData()
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI namdspaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "item"){
            elements = NSMutableDictionary()
            elements = [:]
            posts = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]

            titleKorean = NSMutableString()
            titleKorean = ""
            
            House_gener = NSMutableString()
            House_gener = ""
            
            checkin_Time = NSMutableString()
            checkin_Time = ""
                
             checkout_Time = NSMutableString()
            checkout_Time = ""
            
             closed = NSMutableString() // 쉬는날
            closed = "" // 쉬는날
            
             cooking = NSMutableString() // 취사 여부
             cooking = "" // 취사 여부
            
             dry = NSMutableString() // 드라이기(1-> 보유 , 0-> 미보유)
            dry = "" // 드라이기(1-> 보유 , 0-> 미보유)
            
             fan = NSMutableString() // 선풍기
             fan = "" // 선풍기
            
             folkVillage = NSMutableString()// 민속마을
            folkVillage = ""// 민속마을
            
             internet = NSMutableString() //인터넷
             internet = "" //인터넷
            
             numberOfRooms = NSMutableString() // 객실수
            numberOfRooms = "" // 객실수
            
             refrigerator = NSMutableString() // 냉장고
             refrigerator = "" // 냉장고
            
             roomCharge = NSMutableString() // 최소 객실요금
            roomCharge = "" // 최소 객실요금
            
             StayOrNot = NSMutableString() // 숙박가능여부
            StayOrNot = "" // 숙박가능여부
            
             toilet = NSMutableString() //화장실
            toilet = "" //화장실
            
             wash = NSMutableString() // 세면도구
             wash = "" // 세면도구
            
             tv = NSMutableString()// tv
             tv = "" // tv
            
            roadnameAddress = NSMutableString()
            roadnameAddress = ""
            
            XPos = NSMutableString()
            XPos = ""
            YPos = NSMutableString()
            YPos = ""

        }
    }
    func parser(_ parser: XMLParser, foundCharacters string: String){

        if element.isEqual(to: "titleKorean"){
            titleKorean.append(string)
        }
        else if element.isEqual(to: "buildPhases"){
            House_gener.append(string)
        }
        else if element.isEqual(to: "checkinTime") {
            checkin_Time.append(string)
        }
        else if element.isEqual(to: "checkoutTime") {
            checkout_Time.append(string)
        }
        else if element.isEqual(to: "closed") {
            closed.append(string)
        }
        else if element.isEqual(to: "cooking") {
            cooking.append(string)
        }
        else if element.isEqual(to: "dry") {
            dry.append(string)
        }
        else if element.isEqual(to: "fan") {
            fan.append(string)
        }
        else if element.isEqual(to: "folkVillage") {
            folkVillage.append(string)
        }
        else if element.isEqual(to: "internet") {
            internet.append(string)
        }
        else if element.isEqual(to: "numberOfRooms") {
            numberOfRooms.append(string)
        }
        else if element.isEqual(to: "refrigerator") {
             refrigerator.append(string)
        }
        else if element.isEqual(to: "roomCharge") {
            roomCharge.append(string)
        }
        else if element.isEqual(to: "StayOrNot") {
            StayOrNot.append(string)
        }
        else if element.isEqual(to: "toilet") {
            toilet.append(string)
        }
        else if element.isEqual(to: "wash") {
            wash.append(string)
        }
        else if element.isEqual(to: "tv") {
            tv.append(string)
        }
        else if element.isEqual(to: "roadnameAddress") {
            roadnameAddress.append(string)
        }
        
        else if element.isEqual(to: "latitude"){
            XPos.append(string)
        }
        else if element.isEqual(to: "longitude"){
            YPos.append(string)
        }
        
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if(elementName as NSString).isEqual(to: "item") {
            if !titleKorean.isEqual(nil){
                posts[0] = titleKorean as String
                elements.setObject(titleKorean, forKey: "titleKorean" as NSCopying)
            }
            if !House_gener.isEqual(nil){
                posts[1] = House_gener as String
            }
            if !checkin_Time.isEqual(nil){
                posts[2] = checkin_Time as String
            }
            
            if !checkout_Time.isEqual(nil){
                posts[3] = checkout_Time as String
            }
            if !closed.isEqual(nil){
                posts[4] = closed as String
            }
            if !cooking.isEqual(nil){
                posts[5] = cooking as String
            }
            if !dry.isEqual(nil){
                posts[6] = dry as String
            }
            
            if !fan.isEqual(nil){
                posts[7] = fan as String
            }
            if !folkVillage.isEqual(nil){
                posts[8] = folkVillage as String
            }
            if !internet.isEqual(nil){
                posts[9] = internet as String
            }
            if !numberOfRooms.isEqual(nil){
                posts[10] = numberOfRooms as String
            }
            if !refrigerator.isEqual(nil){
                posts[11] = refrigerator as String
            }
            if !roomCharge.isEqual(nil){
                posts[12] = roomCharge as String
            }
            if !StayOrNot.isEqual(nil){
                posts[13] =  StayOrNot as String
            }
            if !toilet.isEqual(nil){
                posts[14] = toilet as String
            }
            if !wash.isEqual(nil){
                posts[15] =  wash as String
            }
            if !wash.isEqual(nil){
                posts[16] = wash as String
            }
            if !roadnameAddress.isEqual(nil){
                posts[17] = roadnameAddress as String
                
                elements.setObject(roadnameAddress, forKey: "roadnameAddress" as NSCopying)

            }
            
            if !XPos.isEqual(nil){
                elements.setObject(XPos, forKey: "latitude" as NSCopying)

            }
            if !YPos.isEqual(nil){
                elements.setObject(YPos, forKey: "longitude" as NSCopying)

                
            }
            location.add(elements)
        }
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return postname.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HouseCell", for: indexPath)

        cell.textLabel?.text = postname[indexPath.row]
        cell.detailTextLabel?.text = posts[indexPath.row]
        // Configure the cell...

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if segue.identifier == "segueToMapView" {
            if let mapViewController = segue.destination as? MapViewController {
                mapViewController.posts = location
            }
        }
 
        
        if segue.identifier == "segueToExplainHouse"{

       

                housename = posts[0] as! NSString as String
                // url에서 한글을 쓸 수 있도록 코딩
               housename_utf8 = housename.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                if let explainHouseViewController = segue.destination as? ExplainHouseViewController {
                    
                    explainHouseViewController.url = "http://api.visitkorea.or.kr/openapi/service/rest/HanokInformationService/hanokInformationList?serviceKey=uCstxgLSF6idf%2BteFc1Sb8ZX03SfFvl8h6aDFb8CqgB5%2FnR%2FehJ2cH9wgg0iGzH28sD8Aj0IYiTDJ7ZZnEJkGw%3D%3D&numOfRows=10&pageNo=1&langType=KOR&MobileOS=ETC&MobileApp=AppTest"  + "&titleKorean=" + housename_utf8
    
                }

            }
        
        
        
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
