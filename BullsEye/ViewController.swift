//
//  ViewController.swift
//  BullsEye
//
//  Created by Jianbo Jia on 1/23/17.
//  Copyright © 2017 Jianbo Jia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentValue: Int = 0
    var targetValue: Int = 0
    var roundValue : Int = 0;
    var scoreValue: Int = 0;
    
    @IBOutlet weak var slider : UISlider!
    @IBOutlet weak var targetLabel : UILabel!
    @IBOutlet weak var roundtLabel : UILabel!
    @IBOutlet weak var scoreLabel : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal.png")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted.png")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft.png")
        let trackLeftResizable =
            trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight.png")
        let trackRightResizable =
            trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        startNewGame()
        updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAlert(){
        
        let difference = abs(currentValue - targetValue)
        let points = 100 - difference
        
        let title: String
        
        let titleList = ["Perfect!", "You almost hat it!", "Pretty good!", "Not even close..."]
       
        if difference == 0{
            title = titleList[0]
        }else if difference <= 5{
            title = titleList[1]
        }else if difference <= 10{
            title = titleList[2]
        }else{
            title = titleList[3]
        }
        
        scoreValue += points
        
        let message = "You scored \(points)"
        
//        let message = "Value of the slider is: \(currentValue)"
//                        + "\n Target value is: \(targetValue)"
//                        + "\n Difference is: \(difference)"
//                        + "\n You scored: \(points)"
//        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: { action in
                                                                            self.startNewRound()
                                                                            self.updateLabels()
                                                                            })
    
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)

    }

    @IBAction func startOver(){
        startNewGame()
        updateLabels()
    }
    @IBAction func sliderMoved(_ slider: UISlider){
        currentValue = lroundf(slider.value)
        print("The value of the slider is now: \(currentValue)")
    }
    
    func startNewRound() {
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        roundValue += 1
    }
    
    func updateLabels(){
        targetLabel.text = String(targetValue)
        roundtLabel.text = String(roundValue)
        scoreLabel.text = String(scoreValue)
    }

    func startNewGame() {
        roundValue = 0
        scoreValue = 0
        startNewRound()
    }
}

