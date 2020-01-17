//
//  SlgTableViewController.swift
//  BaseballCalculator
//
//  Created by 桑原　望 on 2019/12/31.
//  Copyright © 2019 Swift-Beginners. All rights reserved.
//

import UIKit

class SlgTableViewController: UITableViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var atBatsText: UITextField!
    @IBOutlet weak var singleText: UITextField!
    @IBOutlet weak var doubleText: UITextField!
    @IBOutlet weak var tripleText: UITextField!
    @IBOutlet weak var homeRunText: UITextField!
    @IBOutlet weak var slgResultText: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    
    let userDefaults = UserDefaults.standard
    @IBAction func calculate(_ sender: Any) {
        view.endEditing(true)
        
        if let atBats = Int(atBatsText.text!),
            let single = Int(singleText.text!),
            let double = Int(doubleText.text!),
            let triple = Int(tripleText.text!),
            let homeRun = Int(homeRunText.text!)
        {
            if atBats <= 0 {
                print("アラート")
                let alertController = UIAlertController(title: "エラー", message: "打数が無効です", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                present(alertController,animated: true, completion: nil)
            } else {
                if single + double + triple + homeRun == 0 {
                    slgResultText.text = ".000"
                } else {
                    //長打率を計算
                    let result = Double((Double(single) + Double(double) * 2 + Double(triple) * 3 + Double(homeRun) * 4) / Double(atBats))
                    let result2a = round(result * 1000)
                    let slg1 = Int(result2a)
                    slgResultText.text = "." + String(format: "%03d" , slg1)
                    //長打率が1を超えた場合
                    if result >= 1.0 {
                        let result2b = round(result * 1000)
                        let slg = result2b / 1000
                        slgResultText.text = String(format: "%.3f" ,slg)  
                    } 
                }
            }
            //保存
            userDefaults.set(Int(atBats), forKey: "atBatsSlg")
            userDefaults.set(Int(single), forKey: "singleSlg")
            userDefaults.set(Int(double), forKey: "doubleSlg")
            userDefaults.set(Int(triple), forKey: "tripleSlg")
            userDefaults.set(Int(homeRun), forKey: "homeRunSlg")
            userDefaults.set(slgResultText.text, forKey: "slg")            
            UserDefaults.standard.synchronize()
        }   
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.atBatsText.delegate = self
        self.singleText.delegate = self
        self.doubleText.delegate = self
        self.tripleText.delegate = self
        self.homeRunText.delegate = self
        
        let resultAtBats = userDefaults.integer(forKey: "atBatsSlg")
        let resultSingle = userDefaults.integer(forKey: "singleSlg")
        let resultDouble = userDefaults.integer(forKey: "doubleSlg")
        let resultTriple = userDefaults.integer(forKey: "tripleSlg")
        let resultHomeRun = userDefaults.integer(forKey: "homeRunSlg")
        let resultSlg = userDefaults.string(forKey: "slg")
        atBatsText.text = "\(resultAtBats)"
        singleText.text = "\(resultSingle)"
        doubleText.text = "\(resultDouble)"
        tripleText.text = "\(resultTriple)"
        homeRunText.text = "\(resultHomeRun)"
        slgResultText.text = resultSlg
        
        //NumberPadに"Done"ボタンを表示
        let toolBar = UIToolbar(frame: CGRect(x:0, y:0, width: 320, height: 40))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolBar.items = [space, doneButton]
        atBatsText.inputAccessoryView = toolBar
        singleText.inputAccessoryView = toolBar
        doubleText.inputAccessoryView = toolBar
        tripleText.inputAccessoryView = toolBar
        homeRunText.inputAccessoryView = toolBar
        self.atBatsText.keyboardType = UIKeyboardType.numberPad
        self.singleText.keyboardType = UIKeyboardType.numberPad  
        self.doubleText.keyboardType = UIKeyboardType.numberPad
        self.tripleText.keyboardType = UIKeyboardType.numberPad
        self.homeRunText.keyboardType = UIKeyboardType.numberPad    
    }
    @objc func doneButtonTapped(sender: UIButton) {
        self.view.endEditing(true) 
    }   
    override func viewWillAppear(_ animated: Bool) {
        let resultAtBats = userDefaults.string(forKey: "atBatsObp")
        atBatsText.text = resultAtBats
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //textFieldの選択範囲を全選択にする
        textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
        
    } 
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0: return 5
        case 1: return 1
        case 2: return 1
        default: return 0
        }
    }
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
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
