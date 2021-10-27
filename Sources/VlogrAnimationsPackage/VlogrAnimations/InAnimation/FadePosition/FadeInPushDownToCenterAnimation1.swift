//
//  File.swift
//
//
//  Created by vlogrFullName on 2021/10/25.
//


import UIKit

public struct FadeInPushDownToCenterAnimation1: VlogrAnimationOutcome {
    
    public func result(translation:inout CGPoint, rotation:inout CGFloat, scale:inout CGFloat, alpha: inout CGFloat, progress:CGFloat, inputVariable:VlogrAnimation.InputVariable) {
        
        // x position
        let normalizedCenter = inputVariable.fixedCenter
        let newX = normalizedCenter.x
        
        // y position
        let newY = -1.0 + normalizedCenter.y + (VlogrAnimationTimingUtil.inOutTiming(from: progress) * 1.0)
        
        
        translation = CGPoint.init(x: newX, y: newY)
        rotation = inputVariable.fixedRotation
        scale = inputVariable.fixedScale
        
        if progress <= 0.7 {
            alpha = VlogrAnimationTimingUtil.inOutTiming(from: 0.0)
        } else {
            
            let newProgress = (progress - 0.7) * (1.0/0.3)
            alpha = VlogrAnimationTimingUtil.inOutTiming(from: newProgress)
        }
        
    }
}
