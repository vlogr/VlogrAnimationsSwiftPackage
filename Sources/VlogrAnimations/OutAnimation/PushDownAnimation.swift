//
//  PushDownAnimation.swift
//  VlogrAnimations
//
//  Created by vlogrFullName on 2021/10/13.
//

import UIKit

struct PushDownAnimation: VlogrAnimationOutcome {
    
    func result(translation:inout CGPoint, rotation:inout CGFloat, scale:inout CGFloat, alpha: inout CGFloat, progress:CGFloat, inputVariable:VlogrAnimation.InputVariable) {
        
        // x position
        let normalizedCenter = inputVariable.fixedCenter
        let newX = normalizedCenter.x
        
        // y position
        let newY = normalizedCenter.y + (VlogrAnimationTimingUtil.inOutTiming(from: progress) * 1.0)
        
        let originalCenter = VlogrAnimationTimingUtil.worldPoint(from: inputVariable.fixedCenter, worldRect: inputVariable.worldRect)
        let newCenter = VlogrAnimationTimingUtil.worldPoint(from: CGPoint.init(x: newX, y: newY), worldRect:inputVariable.worldRect)
        
        translation = CGPoint.init(x: newCenter.x - originalCenter.x, y: newCenter.y - originalCenter.y)
        rotation = inputVariable.fixedRotation
        scale = inputVariable.fixedScale
    }
}
