//
//  ViewController.swift
//  RetroCalc2
//
//  Created by Chris Khan on 16/09/2016.
//  Copyright © 2016 Chris Khan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Subtract = "-"
        case Multiply = "*"
        case add = "+"
        case Empty = ""
    }
    
    @IBOutlet weak var outputlbl: UILabel!
    
    var buttonsound: AVAudioPlayer!
    
    var runningnumber = ""
    var leftvalstring = ""
    var rightvalstring = ""
    var currentoperation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundurl = NSURL (fileURLWithPath: path!)
        
        do {
             try buttonsound = AVAudioPlayer(contentsOfURL: soundurl)
        } catch let err as NSError {
            print(err.debugDescription)
        }
       
    }
    
    @IBAction func numberPressed(btn: UIButton!) {
        buttonsound.play()
        runningnumber += "\(btn.tag)"
        outputlbl.text = runningnumber
    }
  
    @IBAction func onclearpressed(sender: AnyObject) {
       processoperation(Operation.Empty)
       leftvalstring = ""
        rightvalstring = ""
        outputlbl.text = "0"
    }
    
    @IBAction func ondividepressed(sender: AnyObject) {
        processoperation(Operation.Divide)
    }
    
    @IBAction func onmultiplypressed(sender: AnyObject) {
         processoperation(Operation.Multiply)
    }
    
    @IBAction func onsubtractpressed(sender: AnyObject) {
         processoperation(Operation.Subtract)
    }
    
    @IBAction func onaddpressed(sender: AnyObject) {
         processoperation(Operation.add)
    }
    
    @IBAction func onequalpressed(sender: AnyObject) {
         processoperation(currentoperation)
    }
    
    func processoperation(op: Operation) {
        playsound()
        
        if currentoperation != Operation.Empty{
            //Run some math
            
            if runningnumber != "" {
                rightvalstring = runningnumber
                runningnumber = ""
            
            if currentoperation == Operation.Multiply {
                result = "\(Double(leftvalstring)! * Double(rightvalstring)!)"
                
            } else if currentoperation == Operation.add {
                result = "\(Double(leftvalstring)! + Double(rightvalstring)!)"
                
            } else if currentoperation == Operation.Subtract {
                result = "\(Double(leftvalstring)! - Double(rightvalstring)!)"
                
            } else if currentoperation == Operation.Divide {
                result = "\(Double(leftvalstring)! / Double(rightvalstring)!)"
                
            }
                
            }
            
            leftvalstring = result
            outputlbl.text = result
            
            currentoperation = op
            
        } else {
            //This is the first time an operator has been pressed 
            leftvalstring = runningnumber
            runningnumber = ""
            currentoperation = op
        }
    }
    
    func playsound() {
        if buttonsound.playing {
            buttonsound.stop()
        }
        buttonsound.play()
    }
}


