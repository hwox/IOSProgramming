//
//  LocationChoiceViewController.swift
//  TranditionalHouse
//
//  Created by KPU_GAME on 03/06/2019.
//  Copyright © 2019 KPU_GAME. All rights reserved.
//

import UIKit

class LocationChoiceViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

   // var pickerDataSource = ["서울", "인천", "대전", "대구", "광주", "부산", "울산", "세종시", "경기도", "강원도", "충청북도", "충청남도", "경상북도", "경상남도", "전라북도", "전라남도", "제주도"]
   // var pickerDataSource = ["대한제국시대", "일제강점기시대", "조선시대", "고려시대", "신라시대", "백제시대", "고구려시대", "시대미상", "깉]
    var pickerDataSource = ["1", "2", "3", "4", "5"]
    var url : String = "http://api.visitkorea.or.kr/openapi/service/rest/HanokStayInformationService/hanokStayInformationList?serviceKey=uCstxgLSF6idf%2BteFc1Sb8ZX03SfFvl8h6aDFb8CqgB5%2FnR%2FehJ2cH9wgg0iGzH28sD8Aj0IYiTDJ7ZZnEJkGw%3D%3D&numOfRows=90&langType=KOR&MobileOS=ETC&MobileApp=AppTest"
    
    var sidoAreaCode : String = "1" // 디폴트 - 서울시
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func doneToPickerViewController(segue: UIStoryboardSegue){
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
 
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        if row == 0 {
            sidoAreaCode = "1" //서울
        }
        else if row == 1 {
            sidoAreaCode = "2" //인천
        }
        else if row == 2 {
            sidoAreaCode = "3" // 대전
        }
        else if row == 3 {
            sidoAreaCode = "4" // 대구
        }
        else if row == 4 {
            sidoAreaCode = "5" // 광주
        }
        else if row == 5 {
            sidoAreaCode = "6" // 부산
        }
        else if row == 6 {
            sidoAreaCode = "7" // 울산
        }
        else if row == 7 {
            sidoAreaCode = "8" // 세종ㄱ시
        }
        else if row == 8 {
            sidoAreaCode = "31" // 경기도
        }
        else if row == 9 {
            sidoAreaCode = "32" // 강원도
        }
        else if row == 10 {
            sidoAreaCode = "33" // 충청북도
        }
        else if row == 11 {
            sidoAreaCode = "34" // 충청남도
        }
        else if row == 12 {
            sidoAreaCode = "35" // 경상북도
        }
        else if row == 13 {
            sidoAreaCode = "36" // 경상남도
        }
        else if row == 14 {
            sidoAreaCode = "37" // 전라북도
        }
        else if row == 15 {
            sidoAreaCode = "38" // 전라남도
        }
        else if row == 16 {
            sidoAreaCode = "39" // 제주도
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        /*
        if segue.identifier == "segueToLocationDetail" {
            if let navController = segue.destination as? UINavigationController {
                if let houseTableViewController = navController.topViewController as? HouseTableViewController {
                    houseTableViewController.url = url + sidoAreaCode
                }
            }
        }*/
        if segue.identifier == "segueToLocationDetail" {
            if let navController = segue.destination as? UINavigationController {

                if let houseTableViewController = navController.topViewController as? HouseTableViewController {
                    
                    
                    //houseTableViewController.url = url +
                }
            }
        }
    }

}
