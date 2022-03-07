//
//  ViewController.swift
//  doomsDay
//
//  Created by 方仕賢 on 2022/3/5.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var datePicker1: UIDatePicker!
    @IBOutlet weak var datePicker2: UIDatePicker!
    
    @IBOutlet var colorSliders: [UISlider]!
    
    @IBOutlet weak var colorPreview: UIView!
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var changeColorView: UIView!
    
    var timer: Timer?
    let date = Date()
    var dateStrings = [Int](repeating: 0, count: 6)
    var difference = DateComponents()
    var totalSeconds = 0
    
    var blue: Float = 0
    var red: Float = 0
    var green: Float = 0
    
    @IBOutlet var timeLabels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        datePicker2.minimumDate = datePicker1.date
        datePicker1.maximumDate = datePicker2.date
    }
    
    func countDown(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.totalSeconds -= 1
            self.displayInterval()
            if self.totalSeconds == 0 {
                timer.invalidate()
            }
        }
    }
    
    
    func setTotalSeconds() {
        totalSeconds = Int(datePicker2.date.timeIntervalSince(datePicker1.date))
    }
    
    @IBAction func setDate(_ sender: UIDatePicker) {
        datePicker2.minimumDate = datePicker1.date
        datePicker1.maximumDate = datePicker2.date
        
    }
    
    
    @IBAction func setTitleName(_ sender: Any) {
        titleLabel.text = titleTextField.text!
        titleTextField.text = ""
    }
    
    @IBAction func start(_ sender: Any) {
        settingView.isHidden = true
        resetButton.isHidden = false
        
        setTotalSeconds()
        displayInterval()
        countDown()
    }
    
    func displayInterval(){
        timeLabels[0].text = "\((totalSeconds/60/60/24/365))"
        timeLabels[1].text = "\((totalSeconds/60/60/24/30)%12)"
        timeLabels[2].text = "\((totalSeconds/60/60/24)%30)"
        timeLabels[3].text = "\((totalSeconds/60/60)%24)"
        timeLabels[4].text = "\((totalSeconds/60)%60)"
        timeLabels[5].text = "\((totalSeconds)%60)"
    }

    @IBAction func set(_ sender: Any) {
        settingView.isHidden = false
    }
    
    @IBAction func reset(_ sender: Any) {
        let alert = UIAlertController(title: "Reset", message: "Do you want to reset the timer?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            self.timer?.invalidate()
            for i in 0...self.timeLabels.count-1 {
                self.timeLabels[i].text = "0"
            }
            self.resetButton.isHidden = true
            self.startButton.isHidden = false
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func close(_ sender: Any) {
        settingView.isHidden = true
    }
    
    
    @IBAction func changeColor(_ sender: UISlider) {
        
        switch sender {
        case colorSliders[0]:
            red = sender.value
        case colorSliders[1]:
            green = sender.value
        default:
            blue = sender.value
        }
        
        view.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
        colorPreview.backgroundColor = view.backgroundColor
    }
    
    
    @IBAction func controlColorView(_ sender: UIButton) {
        if sender == colorButton {
            changeColorView.isHidden = false
        } else {
            changeColorView.isHidden = true
        }
    }
    

}

