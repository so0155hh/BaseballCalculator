//
//  OpsTableViewController.swift
//  BaseballCalculator
//
//  Created by 桑原　望 on 2020/01/01.
//  Copyright © 2020 Swift-Beginners. All rights reserved.
//

import UIKit

class OpsTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var atBatsText: UITextField!
    @IBOutlet weak var singleText: UITextField!
    @IBOutlet weak var doubleText: UITextField!
    @IBOutlet weak var tripleText: UITextField!
    @IBOutlet weak var homeRunText: UITextField!
    @IBOutlet weak var fourBallsText: UITextField!
    @IBOutlet weak var deadBallsText: UITextField!
    @IBOutlet weak var sacFlyText: UITextField!
    @IBOutlet weak var opsText: UITextField!
    @IBOutlet weak var commentLabel: UILabel!
    
    let userDefaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        let resultAtBatsObp = userDefaults.string(forKey: "atBatsObp")
        atBatsText.text = resultAtBatsObp
       // atBatsText.text = resultAtBatsSlg
        let resultSingle = userDefaults.string(forKey: "singleSlg")
        singleText.text = resultSingle
        let resultDouble = userDefaults.string(forKey: "doubleSlg")
        doubleText.text = resultDouble
        let resultTriple = userDefaults.string(forKey: "tripleSlg")
        tripleText.text = resultTriple
        let resultHomeRun = userDefaults.string(forKey: "homeRunSlg")
        homeRunText.text = resultHomeRun
        let resultFourBalls = userDefaults.string(forKey: "fourBalls")
        fourBallsText.text = resultFourBalls
        let resultDeadBalls = userDefaults.string(forKey: "deadBalls")
        deadBallsText.text = resultDeadBalls
        let resultSacFly = userDefaults.string(forKey: "sacFly")
        sacFlyText.text = resultSacFly
    }
    
    @IBAction func calculate(_ sender: Any) {
        if let atBats = Int(atBatsText.text!),
            let single = Int(singleText.text!),
            let double = Int(doubleText.text!),
            let triple = Int(tripleText.text!),
            let homeRun = Int(homeRunText.text!),
            let fourBalls = Int(fourBallsText.text!),
            let deadBalls = Int(deadBallsText.text!),
            let sacFly = Int(sacFlyText.text!) {
            
            if atBats <= 0 {
                //打数が0以下のためアラートを表示
                print("アラート！")
                let alertController = UIAlertController(title: "エラー", message: "打数が無効です", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                present(alertController, animated: true, completion: nil)  
            } else {     
            //出塁率を求める
            let obpNumerator = single + double + triple + homeRun + fourBalls + deadBalls
            let obpDenominator = atBats + fourBalls + deadBalls + sacFly
            let obp = Double(obpNumerator) / Double(obpDenominator)
            
            //長打率を求める
            let totalBases = single + double * 2 + triple * 3 + homeRun * 4
            let slg = Double(totalBases) / Double(atBats)
            let opsResult = obp + slg
            let opsResult2 = round(opsResult * 1000)
            let ops = Int(opsResult2)
            opsText.text = "." + String(format: "%03d", ops)
            
            //opsが1.000を超えた場合
            if opsResult >= 1.0 {
                let result2b = round(opsResult * 1000)
                let ops2 = result2b / 1000
                opsText.text = String(format: "%.3f" ,ops2) 
                commentLabel.text = "スター選手！！"
            } else if opsResult < 0.700 {
                commentLabel.text = "" 
            } else if opsResult >= 0.700 , opsResult < 0.767 {
                commentLabel.text = "準レギュラー"
            } else if opsResult >= 0.767 , opsResult < 0.834 {
                commentLabel.text = "レギュラー"
            } else if opsResult >= 0.834 , opsResult < 0.900 {
                commentLabel.text = "強打者"
            } else if opsResult >= 0.900 , opsResult < 1.0 {
                commentLabel.text = "チームの中心"
            }
            userDefaults.set(opsText.text, forKey: "ops")
            userDefaults.synchronize()
        }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.atBatsText.delegate = self
        self.singleText.delegate = self
        self.doubleText.delegate = self
        self.tripleText.delegate = self
        self.homeRunText.delegate = self
        self.fourBallsText.delegate = self
        self.deadBallsText.delegate = self
        self.sacFlyText.delegate = self
        
        let resultOps = userDefaults.string(forKey: "ops")
        opsText.text = resultOps
        
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
        fourBallsText.inputAccessoryView = toolBar
        deadBallsText.inputAccessoryView = toolBar
        sacFlyText.inputAccessoryView = toolBar
        self.atBatsText.keyboardType = UIKeyboardType.numberPad
        self.singleText.keyboardType = UIKeyboardType.numberPad  
        self.doubleText.keyboardType = UIKeyboardType.numberPad
        self.tripleText.keyboardType = UIKeyboardType.numberPad
        self.homeRunText.keyboardType = UIKeyboardType.numberPad  
        self.fourBallsText.keyboardType = UIKeyboardType.numberPad
        self.deadBallsText.keyboardType = UIKeyboardType.numberPad
        self.sacFlyText.keyboardType = UIKeyboardType.numberPad
    }
    @objc func doneButtonTapped(sender: UIButton) {
        self.view.endEditing(true) 
    }           
     func textFieldDidBeginEditing(_ textField: UITextField) {
          //textFieldの選択範囲を全選択にする
           textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
       }     
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0: return 8
        case 1: return 1
        case 2: return 1
        case 3: return 1
        case 4: return 1
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
