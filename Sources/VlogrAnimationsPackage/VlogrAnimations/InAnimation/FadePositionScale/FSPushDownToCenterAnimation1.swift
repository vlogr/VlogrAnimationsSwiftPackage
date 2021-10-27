//
//  File.swift
//
//
//  Created by vlogrFullName on 2021/10/25.
//


import UIKit

public struct FSPushDownToCenterAnimation1: VlogrAnimationOutcome {
    
    public func result(translation:inout CGPoint, rotation:inout CGFloat, scale:inout CGFloat, alpha: inout CGFloat, progress:CGFloat, inputVariable:VlogrAnimation.InputVariable) {
        
        var sc = inputVariable.fixedScale
        
        if progress <= 0.5 {
            sc = inputVariable.fixedScale
        } else {
            sc = (VlogrAnimationTimingUtil.inOutTiming(from: (progress-0.5) * 2)) * inputVariable.fixedScale
        }
        
        // x position
        let normalizedCenter = inputVariable.fixedCenter
        let newX = normalizedCenter.x
        
        // y position
        let newY = -1.0 + normalizedCenter.y + (VlogrAnimationTimingUtil.inOutTiming(from: progress) * 1.0)
        
        translation = CGPoint.init(x: newX, y: newY)
        rotation = inputVariable.fixedRotation
        scale = sc
        alpha = VlogrAnimationTimingUtil.inOutTiming(from: progress)
        
        if progress <= 0.75 {
            alpha = 0
        } else {
            alpha = VlogrAnimationTimingUtil.easeOutCubic(from: (progress-0.75) * 4)
        }
    }
}
