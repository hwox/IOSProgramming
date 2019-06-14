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
    
  
    var url : String = "http://api.visitkorea.or.kr/openapi/service/rest/HanokStayInformationService/hanokStayInformationList?serviceKey=uCstxgLSF6idf%2BteFc1Sb8ZX03SfFvl8h6aDFb8CqgB5%2FnR%2FehJ2cH9wgg0iGzH28sD8Aj0IYiTDJ7ZZnEJkGw%3D%3D&numOfRows=90&pageNo=1&langType=KOR&MobileOS=ETC&MobileApp=AppTest"

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


    var filteredCandies = [Candy]()
    var candies = [Candy]()
    let searchController = UISearchController(searchResultsController: nil)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search House"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        searchController.searchBar.scopeButtonTitles = ["전체", "대한제국시대", "시대미상", "일제강점기", "조선시대"]
        searchController.searchBar.delegate = self

        beginParsing()
        
        for post in posts {
            let titleKorean = (post as AnyObject).value(forKey: "titleKorean") as! NSString as String
            let buildPhases = (post as AnyObject).value(forKey: "buildPhases") as! NSString as String
            
            var building : String?
            
            
           if(buildPhases == "43922|조선시대"){
                building  = "조선시대"
            }
            
            if(buildPhases == "43923|고려시대") {
                building = "기타"
                print("으잉?")
            }
            if(buildPhases == "43924|신라시대") {
                building = "기타"
                print("으잉?")
            }
            if(buildPhases == "43925|백제시대") {
                building = "기타"
                print("으잉?")
            }
            if(buildPhases == "43926|고구려시대") {
                building = "기타"
            print("으잉?")
            }
            if (buildPhases == "43979|시대미상") {
                building = "시대미상"
            }
            if (buildPhases == "43977|대한제국시대") {
                building = "대한제국시대"
            }
            if (buildPhases == "43976|일제강점기시대")
            {
                building = "일제강점기"
            }
            if (buildPhases == "43978|기타")
            {
                building = "기타"
            }
            
          
             candies.append( Candy(category: building!, name: titleKorean))
        }
    }
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    
    func beginParsing(){
        posts = []
        parser = XMLParser(contentsOf:(URL(string:"http://api.visitkorea.or.kr/openapi/service/rest/HanokStayInformationService/hanokStayInformationList?serviceKey=uCstxgLSF6idf%2BteFc1Sb8ZX03SfFvl8h6aDFb8CqgB5%2FnR%2FehJ2cH9wgg0iGzH28sD8Aj0IYiTDJ7ZZnEJkGw%3D%3D&numOfRows=90&pageNo=1&langType=KOR&MobileOS=ETC&MobileApp=AppTest"))!)!
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
                
                let candy: Candy
                if isFiltering() {
                    candy = filteredCandies[indexPath!.row]
                }
                else {
                    candy = candies[indexPath!.row]
                }
                
            
                
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
        
        if isFiltering(){
            return filteredCandies.count
        }
        return candies.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        let candy: Candy
        if isFiltering() {
            candy = filteredCandies[indexPath.row]
        }
        else {
            candy = candies[indexPath.row]
        }

        
        
       // cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "titleKorean") as! NSString as String
        cell.textLabel!.text = candy.name
        //cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "buildPhases") as! NSString as String
        cell.detailTextLabel!.text = candy.category
        if let url = URL(string: (posts.object(at: indexPath.row) as AnyObject).value(forKey: "thumImg") as! NSString as String){
           if let data = try? Data(contentsOf: url){
                cell.imageView?.image = UIImage(data: data)
            }
        }
        //cell.textLabel!.text = candy.name
        //cell.detailTextLabel!.text = candy.category
        return cell
    }
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredCandies = candies.filter({( candy : Candy) -> Bool in
            let doesCategoryMatch = (scope == "All") || (candy.category == scope)
            
            if searchBarIsEmpty() {
                return doesCategoryMatch
            } else {
                return doesCategoryMatch && candy.name.lowercased().contains(searchText.lowercased())
            }
        })
        tableView.reloadData()
    }

}
extension HouseTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        // filterContentForSearchText(searchController.searchBar.text!)
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

extension HouseTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

