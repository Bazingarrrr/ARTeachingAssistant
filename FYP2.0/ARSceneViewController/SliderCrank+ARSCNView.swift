//
//  SlideCrank+ARSCNView.swift
//  FYP2.3
//
//  Created by yi 万 on 2020/12/15.
//

import UIKit
import ARKit


extension ARSceneViewController {
    
    func addCrankSlider(driveAngle:Float = 0, followerAngle:Float = -5*pi/6, crankLength:Float = 0.1, followerLength:Float=0.25) {
        
        addLink2D(to: arView, of: crankLength, with: driveAngle)
        addLink2D(to: arView, of: followerLength, lastLength: crankLength, with: followerAngle)
        addSphere(to: arView, at: SCNVector3(0,followerLength/2,0), with: SCNVector4(0,0,1,0), eularAngle: nil, radius: CGFloat(4*self.linkRadius) )
        
    }
    
    func inverseKinematics(driveAngle:Float, crankLength:Float, followerLength:Float) -> Float{
        
        let temp = acos(crankLength*cos(driveAngle)/followerLength)
        let theta2 = pi - driveAngle - temp
        return theta2
    }
    
}
