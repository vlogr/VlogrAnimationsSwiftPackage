//
//  File.swift
//  
//
//  Created by vlogrFullName on 2021/10/25.
//

import UIKit

public struct FadeInAnimation2: VlogrAnimationOutcome {
    
    public func result(translation:inout CGPoint, rotation:inout CGFloat, scale:inout CGFloat, alpha: inout CGFloat, progress:CGFloat, inputVariable:VlogrAnimation.InputVariable) {
        
        translation = inputVariable.fixedCenter
        rotation = inputVariable.fixedRotation
        scale = inputVariable.fixedScale
        alpha = VlogrAnimationTimingUtil.easeOutCubic(from: progress)
    }
}

