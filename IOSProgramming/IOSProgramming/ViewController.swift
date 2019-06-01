//
//  ViewController.swift
//  HospitalMap
//
//  Created by KPU_GAME on 22/04/2019.
//  Copyright © 2019 KPU_GAME. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func doneToPickerViewController(segue:UIStoryboardSegue){
        // Done버튼을 누르면 동작하는 unwind메소드
        // 아무 동작도 하지 않지만 이 메소드가 있어야지 hospitaltableviewcontroller 에서 unwind 연결이 가능하다.
    }
    
    // prepare 메소드는 segue 실행될 때 호출되는 메소드
    // id를 segueToTableView로 설정
    // hospitaltableviewcontroller에 url 정보 전달하기 위해서 먼저 UINavigationController를
    // destination으로 설정한 후 hospitalTableViewController 를 선택함
    
    // 그니까 미리 url을 만들어서 전달한다고 prepare메소드에서 segue가 테이블뷰로 갈건지? 지도로 가럭ㄴ지? 이런거
    // 준비하니까 identifier를 살펴봐서 테이블뷰로 가는거면
    // 테이블뷰의 url을 url과 sgg코드를 더해서 넘겨준다.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "segueToTableView" {
            if let navController = segue.destination as? UINavigationController {
                if let hospitalTableViewController = navController.topViewController as? HospitalTableViewController {
                    hospitalTableViewController.url = url + sgguCd
                }
            }
        }
    }
    
    var pickerDataSource = ["광진구", "구로구", "동대문구", "종로구"]
    
    var url : String = "http://apis.data.go.kr/B551182/hospInfoService/getHospBasisList?pageNo=1&numOfRows=10&serviceKey=sea100UMmw23Xycs33F1EQnumONR%2F9ElxBLzkilU9Yr1oT4TrCot8Y2p0jyuJP72x9rG9D8CN5yuEs6AS2sAiw%3D%3D&sidoCd=110000&sgguCd="
    
    var sgguCd : String = "110023" //디폴트 시구코드 = 광진구
    
    // pickerView의 컴포넌트 개수
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
            sgguCd = "110023"
        }
        else if row == 1{
            sgguCd = "110005"
        }
        else if row == 2{
            sgguCd = "110007"
        }
        else {
            sgguCd = "110016"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // pickerView의 데이터소스와 델리게이트를 viewcontroller로 설정
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        
    }


}

