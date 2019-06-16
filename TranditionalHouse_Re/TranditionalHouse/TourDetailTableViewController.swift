//
//  TourDetailTableViewController.swift
//  TranditionalHouse
//
//  Created by KPU_GAME on 17/06/2019.
//  Copyright © 2019 KPU_GAME. All rights reserved.
//

import UIKit

class TourDetailTableViewController: UITableViewController, XMLParserDelegate {
    
    
    
    @IBOutlet var detailTableView: UITableView!
    // hospitalTableViewController로 부터 segue를 통해 전달받은 OpenAPI url 주소
    var url : String?
    
    // xml파일을 다운로드 및 파싱하는 오브젝트
    var parser = XMLParser()
    
    // feed 데이터를 저장하는 mutable array : 병원이 1개 이므로 item이 1개
    // 11개 정보를 저장하는 array
    let postsname : [String] = ["관광지이름", "주소", "전화번호", "이용요금", "휴무일", "이용시간","체험안내"]
    
    var posts : [String] = ["","","","","","","",""]
    
    var element = NSString()
    
    var dbTitle = NSMutableString()
    var address = NSMutableString()
    var telephone = NSMutableString()
    var admissionFees = NSMutableString()
    var closed = NSMutableString()
    var operationHours = NSMutableString()
    var experienceProgram = NSMutableString()

    
    var tourname = ""
    var tourname_utf8 = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
    }
    //
    // parser오브젝트 초기화하고 XMLParserDelegate로 설정하고 XML 파싱 시작
    func beginParsing(){
        posts = []
        parser = XMLParser(contentsOf:(URL(string:url!))!)!
        parser.delegate = self
        parser.parse()
        detailTableView!.reloadData()
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI namdspaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){
        
        element = elementName as NSString
        
        if (elementName as NSString).isEqual(to: "item"){
            posts = ["","","","","","",""]
            dbTitle = NSMutableString()
            dbTitle = ""
            address = NSMutableString()
            address = ""
            
            telephone = NSMutableString()
            telephone = ""
            admissionFees = NSMutableString()
            admissionFees = ""
            
            closed = NSMutableString()
            closed = ""
            operationHours = NSMutableString()
            operationHours = ""
            experienceProgram = NSMutableString()
            experienceProgram = ""
            
    
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String){
        if element.isEqual(to: "dbTitle"){
            
            dbTitle.append(string)
        }
        else if element.isEqual(to: "address") {
            address.append(string)
        }
        else if element.isEqual(to: "telephone") {
            telephone.append(string)
        }
        else if element.isEqual(to: "admissionFees") {
            admissionFees.append(string)
        }
        else if element.isEqual(to: "closed") {
            closed.append(string)
        }
        else if element.isEqual(to: "operationHours") {
            operationHours.append(string)
        }
        else if element.isEqual(to: "experienceProgram") {
            experienceProgram.append(string)
        }

        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI : String?, qualifiedName qName: String?){
        if(elementName as NSString).isEqual(to: "item")
        {
            if !dbTitle.isEqual(nil){
                posts[0] = dbTitle as String
            }
            if !address.isEqual(nil){
                posts[1] = address as String
            }
            if !telephone.isEqual(nil){
                posts[2] = telephone as String
            }
            if !admissionFees.isEqual(nil){
                posts[3] = admissionFees as String
            }
            if !closed.isEqual(nil){
                posts[4] = closed as String
            }
            if !operationHours.isEqual(nil){
                posts[5] = operationHours as String
            }
            if !experienceProgram.isEqual(nil){
                posts[6] = experienceProgram as String
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TourCell", for: indexPath)
        cell.textLabel?.text = postsname[indexPath.row]
        cell.detailTextLabel?.text = posts[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if segue.identifier == "segueToTourExplain" {
            
            tourname = posts[0] as! NSString as String
            // url에서 한글을 쓸 수 있도록 코딩
            tourname_utf8 = tourname.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            if let tourExplainViewController = segue.destination as? TourExplainViewController {
                
                tourExplainViewController.url = "http://api.visitkorea.or.kr/openapi/service/rest/SurroundingTourInformationService/tourAttractionInformationList?serviceKey=uCstxgLSF6idf%2BteFc1Sb8ZX03SfFvl8h6aDFb8CqgB5%2FnR%2FehJ2cH9wgg0iGzH28sD8Aj0IYiTDJ7ZZnEJkGw%3D%3D&numOfRows=10&pageNo=1&langType=KOR&MobileOS=ETC&MobileApp=AppTest" + "&dbTitle=" + tourname_utf8
                
            }
            }
            
        }
        
        
        
    }

