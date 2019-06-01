//
//  DetailHospitalTableViewController.swift
//  HospitalMap
//
//  Created by KPU_GAME on 25/04/2019.
//  Copyright © 2019 KPU_GAME. All rights reserved.
//

import UIKit

class DetailHospitalTableViewController: UITableViewController, XMLParserDelegate {


    @IBOutlet var detailTableView: UITableView!
    
    // hospitalTableViewController로 부터 segue를 통해 전달받은 OpenAPI url 주소
    var url : String?
  
    // xml파일을 다운로드 및 파싱하는 오브젝트
    var parser = XMLParser()
    
    // feed 데이터를 저장하는 mutable array : 병원이 1개 이므로 item이 1개
    // 11개 정보를 저장하는 array
    let postsname : [String] = ["병원명", "주소", "전화번호", "홈페이지", "종별코드명", "개설일자", "의사총수", "전문의 인원수", "일반의 인원수", "레지던트 인원수", "인턴 인원수"]
    
    var posts : [String] = ["","","","","","","","","","",""]
    
    var element = NSString()
    
    var yadmNm = NSMutableString()
    var addr = NSMutableString()
    var telno = NSMutableString()
    var hospUrl = NSMutableString()
    var clCdNm = NSMutableString()
    var estbDd = NSMutableString()
    var drTorCnt = NSMutableString()
    var sdrCnt = NSMutableString()
    var gdrCnt = NSMutableString()
    var resdntCnt = NSMutableString()
    var intnCnt = NSMutableString()

    
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
            posts = ["","","","","","","","","","",""]
            yadmNm = NSMutableString()
            yadmNm = ""
            addr = NSMutableString()
            addr = ""
            
            telno = NSMutableString()
            telno = ""
            hospUrl = NSMutableString()
            hospUrl = ""
            
            clCdNm = NSMutableString()
            clCdNm = ""
            estbDd = NSMutableString()
            estbDd = ""
            drTorCnt = NSMutableString()
            drTorCnt = ""
            sdrCnt = NSMutableString()
            sdrCnt = ""
            
            gdrCnt = NSMutableString()
            gdrCnt = ""
            
            resdntCnt = NSMutableString()
            resdntCnt = ""
            
            intnCnt = NSMutableString()
            intnCnt = ""

        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String){
        if element.isEqual(to: "yadmNm"){
            
            yadmNm.append(string)
        }
        else if element.isEqual(to: "addr") {
            addr.append(string)
        }
        else if element.isEqual(to: "telno") {
            telno.append(string)
        }
        else if element.isEqual(to: "hospUrl") {
                hospUrl.append(string)
        }
        else if element.isEqual(to: "clCdNm") {
            clCdNm.append(string)
        }
        else if element.isEqual(to: "estbDd") {
            estbDd.append(string)
        }
        else if element.isEqual(to: "drTotCnt") {
            drTorCnt.append(string)
        }
        else if element.isEqual(to: "sdrCnt") {
            sdrCnt.append(string)
        }
        else if element.isEqual(to: "gdrCnt") {
            gdrCnt.append(string)
        }
        else if element.isEqual(to: "resdntCnt") {
            resdntCnt.append(string)
        }
        else if element.isEqual(to: "intnCnt") {
            intnCnt.append(string)
        }

    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI : String?, qualifiedName qName: String?){
        if(elementName as NSString).isEqual(to: "item")
        {
            if !yadmNm.isEqual(nil){
                posts[0] = yadmNm as String
            }
            if !addr.isEqual(nil){
                posts[1] = addr as String
            }
            if !telno.isEqual(nil){
                posts[2] = telno as String
            }
            if !hospUrl.isEqual(nil){
                posts[3] = hospUrl as String
            }
            if !clCdNm.isEqual(nil){
                posts[4] = clCdNm as String
            }
            if !estbDd.isEqual(nil){
                posts[5] = estbDd as String
            }
            if !drTorCnt.isEqual(nil){
                posts[6] = drTorCnt as String
            }
            if !sdrCnt.isEqual(nil){
                posts[7] = sdrCnt as String
            }
            if !gdrCnt.isEqual(nil){
                posts[8] = gdrCnt as String
            }
            if !resdntCnt.isEqual(nil){
                posts[9] = resdntCnt as String
            }
            if !intnCnt.isEqual(nil){
                posts[10] = intnCnt as String
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "HospitalCell", for: indexPath)
        print(indexPath)
        cell.textLabel?.text = postsname[indexPath.row]
        cell.detailTextLabel?.text = posts[indexPath.row]
        return cell
    }

}
