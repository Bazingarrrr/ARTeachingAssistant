//
//  Interface+ARSceneVC.swift
//  FYP2.2
//
//  Created by yi 万 on 11/20/20.
//

import UIKit


extension ARSceneViewController {
    
    
    func sliderSetUp() {
        
        
        sliderBarLink1.minimumValue = 4 * linkRadius
        sliderBarLink1.maximumValue = 1
        sliderBarLink1.isContinuous = false
        sliderBarLink1.setValue(100 * linkRadius, animated: true)
        
        
        driveAngleVelocity.minimumValue = 16
        driveAngleVelocity.maximumValue = 100
        driveAngleVelocity.isContinuous = false
        driveAngleVelocity.setValue(75, animated: true)
   
    }
    
    
    
    // MARK: - Gesture Recognization Method
    func GestureSetUp() {
    
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnARSCNView))
        arView.addGestureRecognizer(tapGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchOnARSCNView))
        arView.addGestureRecognizer(pinchGesture)
        
    }
    
    
    @objc func tappedOnARSCNView() {
        
        self.generateNewNode()
        
    }
    
    
    // can reset
    @objc func pinchOnARSCNView() {
        
        fourBarInitialAngle![0] += pi/4
        guard fourBarInitialAngle != nil  && fourBarLinkLength != nil else {
            return
        }
        
        removeAllNodes()
        
        currentNode = arView.scene.rootNode
        addFourBarLink(to: arView, ofLength: fourBarLinkLength!, with: fourBarInitialAngle!)
        
    }

    
    
    
}
