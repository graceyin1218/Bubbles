//
//  BubbleView.swift
//  Test-Bubbles
//
//  Created by Grace Yin on 6/14/15.
//  Copyright (c) 2015 Grace Yin. All rights reserved.
//

import UIKit
//import Darwin

class BubbleView: UIView {

    var bubbles = Array<Bubble>();
    
    var shouldPop = false;
    
    var poke = CGPoint();
    
    
    struct Bubble {
        var center: CGPoint;
        var radius: CGFloat;
        var color = UIColor.cyanColor();
        
        init (c:CGPoint, r:Int)
        {
            center = c;
            radius = CGFloat(r);
            color = UIColor(red: CGFloat(Double(arc4random_uniform(1000))/1000.0), green: CGFloat(Double(arc4random_uniform(1000))/1000.0), blue: CGFloat(Double(arc4random_uniform(1000))/1000.0), alpha: 0.5);
        }
        func contains(point: CGPoint)-> Bool
        {
            let distance = sqrt(pow(point.x - center.x, 2) + pow(point.y - center.y, 2));
            return distance <= radius;
        }
    }
    
    override func drawRect(rect: CGRect) {
        //backgroundColor = UIColor.lightGrayColor();
        
        if !shouldPop
        {
            for bubble in bubbles
            {
                let b = UIBezierPath(arcCenter: bubble.center, radius: bubble.radius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true);
                bubble.color.set();
                b.fill();
            }
            return;
        }
        
        shouldPop = false;
    }
    
    func pop(location: CGPoint)
    {
        
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

}