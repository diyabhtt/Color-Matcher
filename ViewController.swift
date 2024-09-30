//
//  ViewController.swift
//  RGB Matcher
//
//  Created by Bhattarai, Diya on 10/18/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var time: UILabel!
    
    @IBOutlet var myColor: UILabel!
    @IBOutlet var matchColor: UILabel!
    
    
    @IBOutlet var rSlider: UISlider!
    
    @IBOutlet var bSlider: UISlider!
    
    @IBOutlet var gSlider: UISlider!
    
    
    @IBOutlet var rLabel: UILabel!
    @IBOutlet var bLabel: UILabel!
    @IBOutlet var gLabel: UILabel!
    
    
    
    var timer = Timer()
    var timeInt = 30
    
    var score = 0
    
    var red : CGFloat = 0.0
    var blue : CGFloat = 0.0
    var green : CGFloat = 0.0
    
    var done = false;
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setup();
        
        
        
        
    }//load

    @IBAction func colorChange(_ sender: UISlider)
    {
       
        myColor.backgroundColor = UIColor(red: CGFloat(rSlider.value), green: CGFloat(gSlider.value), blue: CGFloat(bSlider.value), alpha: 1)
        if (!timer.isValid && !done)
        {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self,selector: #selector(timerFunction), userInfo: nil, repeats:true)
        }
        
        
        
        
    }//action
    
    @objc func timerFunction()
    {
        timeInt = timeInt - 1;
        time.text = "\(timeInt)"
        if(timeInt == 0)
        {
            timer.invalidate()
            done = true;
            calc();
            end();
            
        }
        
        
    }
    
    @objc func end()
    {
        let alert = UIAlertController(title: "Game over!", message: "Score: \(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { action in
            self.setup();
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
                                      
    
    
    @objc func setup()
    {
        myColor.layer.borderWidth = 2;
        myColor.backgroundColor = UIColor.white;
        myColor.layer.borderColor = UIColor.black.cgColor;
        myColor.layer.cornerRadius = 20;
        myColor.clipsToBounds = true;
        
        //Match color
        matchColor.layer.borderWidth = 2;
        matchColor.backgroundColor = UIColor.white;
        matchColor.layer.borderColor = UIColor.black.cgColor;
        matchColor.layer.cornerRadius = 20;
        matchColor.clipsToBounds = true;
        
        red = CGFloat.random(in: 0.0...1.0)
        blue = CGFloat.random(in: 0.0...1.0)
        green = CGFloat.random(in: 0.0...1.0)
        
        print(red)
        print(green)
        print(blue)
        done = false;
        
        //time
        timeInt = 30;
        time.text = "30"
        time.font = UIFont(name: "Gill Sans", size: 18)
        
        timeLabel.font = UIFont(name: "Gill Sans", size: 18)
        matchColor.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        
        
        
        
        
        
    }
    
    func calc()
    {
        var rDiff: CGFloat;
        var gDiff: CGFloat;
        var bDiff: CGFloat;
        
        rDiff = abs(red - CGFloat(rSlider.value))
        bDiff = abs(blue - CGFloat(bSlider.value))
        gDiff = abs(green - CGFloat(gSlider.value))
        
        
        
        var sum : CGFloat = rDiff * rDiff;
        
        var diff : CGFloat;
        
        sum = sum.addingProduct(bDiff, bDiff)
        sum = sum.addingProduct(gDiff, gDiff)
        
        diff = sqrt(sum)
        score =  abs(Int((1-diff) * 100))
        
        
    }
    
    
    
}//class

