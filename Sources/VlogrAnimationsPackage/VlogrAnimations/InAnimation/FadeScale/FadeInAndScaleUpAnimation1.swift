//
//  File.swift
//
//
//  Created by vlogrFullName on 2021/10/25.
//

import UIKit

public struct FadeInAndScaleUpAnimation1: VlogrAnimationOutcome {
    
    public func result(translation:inout CGPoint, rotation:inout CGFloat, scale:inout CGFloat, alpha: inout CGFloat, progress:CGFloat, inputVariable:VlogrAnimation.InputVariable) {
        
        let sc = VlogrAnimationTimingUtil.inOutTiming(from: progress) * inputVariable.fixedScale
        
        translation = inputVariable.fixedCenter
        rotation = inputVariable.fixedRotation
        scale = sc
        alpha = VlogrAnimationTimingUtil.inOutTiming(from: progress)
    }
}
