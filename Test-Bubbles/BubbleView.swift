//
//  BubbleView.swift
//  Test-Bubbles
//
//  Created by Grace Yin on 6/14/15.
//  Copyright (c) 2015 Grace Yin. All rights reserved.
//

import UIKit

class BubbleView: UIView {

    var bubbles = Array<Bubble>();
    
    var shouldPop = false;
    
    var poke = CGPoint();

    
    //Used for relocating bubbles after rotation
    //let nc = NSNotificationCenter.defaultCenter();

    //Used for generating bubbles randomly
    var i: Int;
    var timer: NSTimer!
    
    
//Swift 2
    required init?(coder aDecoder: NSCoder)
//Swift 1.2
//  required init(coder aDecoder: NSCoder)
    {
        i = 0
        
        super.init(coder: aDecoder)
        
        //nc.addObserver(self, selector: "rotated", name:UIDeviceOrientationDidChangeNotification, object:nil);
    }
    
    struct Bubble {
        var center: CGPoint;
        var radius: CGFloat;
        var color = UIColor.cyanColor();
        
        init (c:CGPoint, r:Int)
        {
            center = c;
            radius = CGFloat(r);
            color = UIColor(red: CGFloat(Double(arc4random_uniform(1000))/1000.0), green: CGFloat(Double(arc4random_uniform(1000))/1000.0), blue: CGFloat(Double(arc4random_uniform(1000))/1000.0), alpha: 0.9);
        }
        func contains(point: CGPoint)-> Bool
        {
            let distance = sqrt(pow(point.x - center.x, 2) + pow(point.y - center.y, 2));
            return distance <= radius;
        }
    }
    
    override func drawRect(rect: CGRect) {
        //backgroundColor = UIColor.lightGrayColor();
        
        if shouldPop && !bubbles.isEmpty
        {
            let maxIndex = bubbles.count-1;
            for i in 0...maxIndex
            {
                if bubbles[maxIndex-i].contains(poke)
                {
                    bubbles.removeAtIndex(maxIndex-i);
                    break;
                }
            }
            
            bubbles.reverse();
            shouldPop = false;
        }
        
        for bubble in bubbles
        {
            let b = UIBezierPath(arcCenter: bubble.center, radius: bubble.radius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true);
            bubble.color.set();
            b.fill();
        }
    }
    
    func pop(location: CGPoint)
    {
        poke = location;
        shouldPop = true;
        setNeedsDisplay();
    }
    
    func drawBubble(center: CGPoint)
    {
        let r = Int(arc4random_uniform(100));
        bubbles.append(Bubble(c: center, r: r));
        setNeedsDisplay();
    }
    
    func clear()
    {
        bubbles.removeAll(keepCapacity: true);
        setNeedsDisplay();
    }
    
    func undo()
    {
        if !bubbles.isEmpty
        {
            bubbles.removeLast();
            setNeedsDisplay();
        }
    }

    func generateBubbles()
    {
        //Need to run timer and drawRandomBubble on separate queues.
            //and drawRandomBubble needs to be on the main queue.
        
        timer = NSTimer(timeInterval: 0.1, target: self, selector: "drawRandomBubble", userInfo: nil, repeats: true)
//Swift 2
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0))
//Swift 1.2
//      dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.value), 0))
        {
            NSRunLoop.mainRunLoop().addTimer(self.timer, forMode: NSDefaultRunLoopMode)
            while (self.i < 10) {}
            self.i = 0
            self.timer.invalidate()
        }
    }
    
    func drawRandomBubble()
    {
        let center = CGPointMake(CGFloat(arc4random_uniform(UInt32(self.bounds.width))), CGFloat(arc4random_uniform(UInt32(self.bounds.height))))
        drawBubble(center)
        i++
        
    }

/*
    // for relocating bubbles after rotations
    func rotated()
    {
        for bubble in bubbles
        {
            var x = arc4random_uniform(...)
            var point: CGPoint = CGPointMake(...)
        }
    }
*/
    
}
