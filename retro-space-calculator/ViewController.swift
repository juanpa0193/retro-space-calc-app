//
//  ViewController.swift
//  retro-space-calculator
//
//  Created by JuanPa Villa on 6/1/16.
//  Copyright © 2016 JuanPa Villa. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var buttonSound: AVAudioPlayer!
    
    var runningNumber: String = ""
    var leftValStr: String!
    var rightValStr: String!
    var currentOperation: Operation!
    var result: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            
        try buttonSound = AVAudioPlayer(contentsOfURL: soundURL)
            buttonSound.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        calcDefaultStart()
        
        
    }

    @IBAction func numberPressed(bttn: UIButton!) {
        playSound()
        
        runningNumber += "\(bttn.tag)"
        outputLbl.text = runningNumber
        
        
    }

    @IBAction func divideButtonPressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }

    
    @IBAction func multiplyButtonPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    
    @IBAction func subtractButtonPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    
    @IBAction func equalButtonPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    
    func processOperation(operation: Operation){
        
        playSound()
        
        if currentOperation != Operation.Empty {
            //run some math
            
            // A user selected an operator but then selected another operator without first entering a number
            if runningNumber != "" {
                
                rightValStr = runningNumber
                runningNumber = ""
                
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
                
            }
            
            
            currentOperation = operation
            
            
            
        } else {
            //This is the first time someone presses operator
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
        
    }
    
    
    @IBAction func clearButtonPressed(sender: AnyObject) {
        
        calcDefaultStart()
        
    }
    
    
    func calcDefaultStart() {
        
        leftValStr = ""
        rightValStr = ""
        runningNumber = ""
        result = ""
        
        outputLbl.text = "0"
        
        currentOperation = Operation.Empty
 
    }
    
    
    
    
    
    func playSound() {
        if buttonSound.playing {
            buttonSound.stop()
        }
        
        buttonSound.play()
    }
    
    
    
    
    
    
    
}

