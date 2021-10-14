//
//  VlogrAnimation.swift
//  TestsOnTextAnimation
//
//  Created by vlogrFullName on 2021/10/13.
//

import UIKit

public struct VlogrAnimation {
    
    public struct InputVariable {
        // normalized value
        let fixedCenter:CGPoint
        let fixedRotation:CGFloat
        let fixedScale:CGFloat
        let worldRect:CGRect
        
        public init(fixedCenter:CGPoint, fixedRotation:CGFloat, fixedScale:CGFloat, worldRect:CGRect) {
            self.fixedCenter = fixedCenter
            self.fixedRotation = fixedRotation
            self.fixedScale = fixedScale
            self.worldRect = worldRect
        }
    }
    
    public enum AppearanceType: String {
        case InAnimation, OutAnimation, RepeatAnimation
    }
    
    public enum Kind: String, CaseIterable {
        // custom animations
        case RightFall, Oscillation
        
        // in animations
        case PushUpAnimation, ScaleUpAnimation, FadeInAnimation
        
        // out animations
        case PushDownAnimation, ScaleDownAnimation, FadeOutAnimation
    }
    
    public let appearance: AppearanceType
    public let kind: Kind
    
    private let actualAnimation: VlogrAnimationOutcome
    
    public init(kind:Kind) {
        self.kind = kind
        
        switch kind {
        case .RightFall:
            self.actualAnimation = RightFallAnimation.init()
            self.appearance = .OutAnimation
        case .Oscillation:
            self.actualAnimation = OscillationAnimation.init()
            self.appearance = .RepeatAnimation
        case .PushDownAnimation:
            self.actualAnimation = PushDownAnimation.init()
            self.appearance = .OutAnimation
        case .PushUpAnimation:
            self.actualAnimation = PushUpAnimation.init()
            self.appearance = .InAnimation
        case .ScaleUpAnimation:
            self.actualAnimation = ScaleUpAnimation.init()
            self.appearance = .InAnimation
        case .FadeInAnimation:
            self.actualAnimation = FadeInAnimation.init()
            self.appearance = .InAnimation
        case .ScaleDownAnimation:
            self.actualAnimation = ScaleDownAnimation.init()
            self.appearance = .OutAnimation
        case .FadeOutAnimation:
            self.actualAnimation = FadeOutAnimation.init()
            self.appearance = .OutAnimation
        }
    }
    
    // read values from designed animation object
    public func result(translation: inout CGPoint, rotation: inout CGFloat, scale: inout CGFloat, alpha: inout CGFloat, progress: CGFloat, inputVariable: InputVariable) {
        return actualAnimation.result(translation: &translation, rotation: &rotation, scale: &scale, alpha: &alpha, progress: progress, inputVariable: inputVariable)
    }
    
    // MARK: - Convenient functions
    public func resultTransform(progress: CGFloat, inputVariable: InputVariable) -> (CGAffineTransform, CGFloat) {
        var translationPoint = CGPoint.zero
        var rotation: CGFloat = 0
        var scale: CGFloat = 0
        var alpha: CGFloat = 1.0
        
        result(translation: &translationPoint, rotation: &rotation, scale: &scale, alpha: &alpha, progress: progress, inputVariable: inputVariable)
        
        let transform1 = CGAffineTransform.init(rotationAngle: rotation)
        let transform2 = CGAffineTransform.init(translationX: translationPoint.x, y: translationPoint.y)
        let transform3 = CGAffineTransform.init(scaleX: scale, y: scale)
        return (transform1.concatenating(transform2).concatenating(transform3), alpha)
    }

}


// MARK: - Timing Functions
public struct VlogrAnimationTimingUtil {
    public static func inOutTiming(from t:CGFloat) -> CGFloat {
        let sqrt = t * t
        
        return sqrt / (2.0 * (sqrt - t) + 1.0)
    }
    
    public static func gravityTiming(from t:CGFloat) -> CGFloat {
        return t * t
    }
    
    public static func inOutCubicTiming(from t:CGFloat) -> CGFloat {
        return t < 0.5 ? 4 * t * t * t : 1 - pow(-2 * t + 2, 3) / 2;
    }
    
    public static func easeOutCubic(from t:CGFloat) -> CGFloat {
        return 1 - pow(1 - t, 3);
    }
    
    public static func normalizedPoint(from pt:CGPoint, worldRect:CGRect) -> CGPoint {
        let x = pt.x / worldRect.width
        let y = pt.y / worldRect.height
        return CGPoint.init(x: x, y: y)
    }
    
    public static func worldPoint(from pt:CGPoint, worldRect:CGRect) -> CGPoint {
        let x = worldRect.width * pt.x
        let y = worldRect.height * pt.y
        return CGPoint.init(x: x, y: y)
    }
}

public protocol VlogrAnimationOutcome {
    func result(translation:inout CGPoint, rotation:inout CGFloat, scale:inout CGFloat, alpha:inout CGFloat, progress:CGFloat, inputVariable:VlogrAnimation.InputVariable)
}
