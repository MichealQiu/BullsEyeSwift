//
//  ViewController.swift
//  BullsEye
//
//  Created by MichaelQiu on 16/1/11.
//  Copyright © 2016年 MichaelQiu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        updateLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sliderMoved(slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func showAlert() {
//        var difference: Int
//        if currentValue > targetValue {
//            difference = currentValue - targetValue
//        } else if currentValue < targetValue {
//            difference = targetValue - currentValue
//        } else {
//            difference = 0
//        }
        
//        let difference = (currentValue > targetValue) ? currentValue - targetValue : targetValue - currentValue
        
//        var difference = currentValue - targetValue
//        if difference < 0 {
//            difference = -difference
//        }
        
        let difference = abs(currentValue - targetValue)
        var points = 100 - difference
//        let message = "The value of slider is: \(currentValue)"
//                    + "\nThe target value is: \(targetValue)"
//                    + "\nThe difference is: \(difference)"
        var title: String
        if difference == 0 {
            points += 100
            title = "Prefect!"
        } else if difference < 5 {
            if difference == 1 {
                points += 50
            }
            title = "You almost had it!"
        } else if difference < 10 {
            title = "Pretty Good!"
        } else {
            title = "No even closed..."
        }
        score += points
        let message = "You scored \(points) points"
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { action in
                                                                                                self.startNewRound()
                                                                                                self.updateLabel()
                                                                                                })
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func startOver() {
        startNewGame()
        updateLabel()
    }
    
    func startNewGame() {
        round = 0
        score = 0
        startNewRound()
    }

    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    func updateLabel() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
//        targetLabel.text = "\(targetValue)"
    }
}