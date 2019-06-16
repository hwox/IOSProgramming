//
//  AddHouseListTableViewController.swift
//  TranditionalHouse
//
//  Created by KPU_GAME on 17/06/2019.
//  Copyright © 2019 KPU_GAME. All rights reserved.
//

import UIKit

class AddHouseListTableViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    var rating: Int = 0
    var titleKorean : String!
    
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
            rating = 1
        }
        else if row == 1
        {
            rating = 2
        }
        else if row == 2
        {
            rating = 3
        }
        else if row == 3
        {
            rating = 4
        }
        else if row == 4
        {
            rating = 5
        }
        
    }
    

    var like: Like?
    @IBOutlet weak var pickerView: UIPickerView!
    
    var pickerDataSource = ["1점", "2점", "3점", "4점", "5점"]
    
    @IBOutlet weak var memoTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pickerView.delegate = self;
        self.pickerView.dataSource =  self;
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        titleLabel.text = titleKorean

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveLike" {
            like = Like(name: titleKorean, memo: memoTextField.text!, rating: self.rating)
        }
    }

}
