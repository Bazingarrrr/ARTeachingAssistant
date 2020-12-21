//
//  superimposition+ARSCeneVC.swift
//  FYP2.2
//
//  Created by yi 万 on 11/20/20.
//

import ARKit


// Super imposition with existed 2D image
extension ARSceneViewController: ARSCNViewDelegate, ARSessionDelegate {
    
    func superImpositionSetUp(configuration:ARWorldTrackingConfiguration) {

        
            
        arView.delegate = self
        arView.session.delegate = self
        
        
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
            fatalError("Missing expected asset catalog resources.")
        }

        configuration.detectionImages = referenceImages
        
        
    }
    
    // MARK: - ARSCNViewDelegate (Image detection results)
    /// - Tag: ARImageAnchor-Visualizing
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        
        let referenceImage = imageAnchor.referenceImage
        
//        updateQueue.async
        do {
                        
            // Create a plane to visualize the initial position of the detected image.
            let plane = SCNPlane(width: referenceImage.physicalSize.width,
                                 height: referenceImage.physicalSize.height)
            let planeNode = SCNNode(geometry: plane)
            planeNode.opacity = 0.25
            planeNode.name = "QRCode"
            
            
            /*
             `SCNPlane` is vertically oriented in its local coordinate space, but
             `ARImageAnchor` assumes the image is horizontal in its local space, so
             rotate the plane to match.
             */
            planeNode.eulerAngles.x = -.pi / 2
                     
            currentNode_detected = node

            
            /*
             Image anchors are not tracked after initial detection, so create an
             animation that limits the duration for which the plane visualization appears.
             */
            planeNode.runAction(self.imageHighlightAction)

            
            // Add the plane visualization to the scene.
            node.addChildNode(planeNode)
        }
    
    
    }
    
    
}
