//
//  RightFallAnimation.swift
//  TestsOnTextAnimation
//
//  Created by vlogrFullName on 2021/10/13.
//

import UIKit

public struct RightFallAnimation: VlogrAnimationOutcome {
    
    public func result(translation:inout CGPoint, rotation:inout CGFloat, scale:inout CGFloat, alpha: inout CGFloat, progress:CGFloat, inputVariable:VlogrAnimation.InputVariable) {
        
        // x position
        let normalizedCenter = inputVariable.fixedCenter
        
        let newX = normalizedCenter.x + (progress * 0.15)
        
        // y position
        let newY = normalizedCenter.y + (VlogrAnimationTimingUtil.gravityTiming(from: progress) * 3.0)
        
//        let originalCenter = VlogrAnimationTimingUtil.worldPoint(from: normalizedCenter, worldRect: inputVariable.worldRect)
//        let newCenter = VlogrAnimationTimingUtil.worldPoint(from: CGPoint.init(x: newX, y: newY), worldRect: inputVariable.worldRect)
        
        // rotation
        let piX = (.pi/2.0) * VlogrAnimationTimingUtil.inOutTiming(from: progress)
        
        // scale
        let sc = 1.0
        
        translation = CGPoint.init(x: newX, y: newY)//CGPoint.init(x: newCenter.x - originalCenter.x, y: newCenter.y - originalCenter.y)
        rotation = piX + inputVariable.fixedRotation
        scale = inputVariable.fixedScale
    }
}
