//
//  File 2.swift
//  
//
//  Created by vlogrFullName on 2021/10/25.
//

import UIKit

public struct FadeOutAndScaleDownAnimation1: VlogrAnimationOutcome {
    
    public func result(translation:inout CGPoint, rotation:inout CGFloat, scale:inout CGFloat, alpha: inout CGFloat, progress:CGFloat, inputVariable:VlogrAnimation.InputVariable) {
        
        FadeInAndScaleUpAnimation1.init().result(translation: &translation, rotation: &rotation, scale: &scale, alpha: &alpha, progress: (1.0 - progress), inputVariable: inputVariable)
    }
}
