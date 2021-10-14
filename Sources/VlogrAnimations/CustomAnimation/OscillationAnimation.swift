//
//  OscillationAnimation.swift
//  TestsOnTextAnimation
//
//  Created by vlogrFullName on 2021/10/13.
//

import UIKit

public struct OscillationAnimation: VlogrAnimationOutcome {
    
    public func result(translation:inout CGPoint, rotation:inout CGFloat, scale:inout CGFloat, alpha: inout CGFloat, progress:CGFloat, inputVariable:VlogrAnimation.InputVariable) {
        
        // x position
        let normalizedCenter = inputVariable.fixedCenter
        let newX = normalizedCenter.x + (sin(.pi * 2 * progress) * 0.1)
        
        // y position
        let newY = normalizedCenter.y + (sin(.pi * 4 * progress) * 0.1)
        
        let originalCenter = VlogrAnimationTimingUtil.worldPoint(from: inputVariable.fixedCenter, worldRect: inputVariable.worldRect)
        let newCenter = VlogrAnimationTimingUtil.worldPoint(from: CGPoint.init(x: newX, y: newY), worldRect:inputVariable.worldRect)
        
        // rotation
        let piX = (sin(.pi * 2 * progress) * 0.1) * (.pi/4.0)
        
        // scale
        let sc = 1.0
        
        translation = CGPoint.init(x: newCenter.x - originalCenter.x, y: newCenter.y - originalCenter.y)
        rotation = piX + inputVariable.fixedRotation
        scale = inputVariable.fixedScale
    }
}
