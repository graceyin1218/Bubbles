//
//  ViewController.swift
//  Test-Bubbles
//
//  Created by Grace Yin on 6/14/15.
//  Copyright (c) 2015 Grace Yin. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var bubbleDrawer: BubbleView!
    var shouldPop = false;
    
// Swift 1.2
/*
    override func supportedInterfaceOrientations() -> Int{
        return Int(UIInterfaceOrientationMask.All.rawValue);
    }
*/
    
// Swift 2
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask
    {
        return UIInterfaceOrientationMask.All;
    }

    @IBAction func drawBubble(sender: UITapGestureRecognizer) {
        if shouldPop
        {
            bubbleDrawer.pop(sender.locationInView(bubbleDrawer));
            return;
        }
        bubbleDrawer.drawBubble(sender.locationInView(bubbleDrawer));
        
    }
    
    @IBAction func clear() {
        bubbleDrawer.clear();
    }

    @IBAction func undo() {
        bubbleDrawer.undo();
    }
    
    @IBAction func pop(sender: UISwitch) {
        shouldPop = !shouldPop;
    }
    
    @IBAction func generateBubbles() {
        bubbleDrawer.generateBubbles();
    }

}

