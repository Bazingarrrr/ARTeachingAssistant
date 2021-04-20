//
//  Add3DObject+ARSCNView.swift
//  FYP2.3
//
//  Created by yi 万 on 2020/12/15.
//

import UIKit
import ARKit

// MARK: - Add 3D Object Methods
extension ARSceneViewController {

func addLine(to sceneView:ARSCNView, at translation:SCNVector3, with orientation:SCNVector4 = SCNVector4(0,0,0,0)) {
    
    let length = translation.y
    let rotationAngle:Float = 0
    
    var Tx:SCNMatrix4?
    var position = translation
    position.y = Float(length/2)
    
    Tx = SCNMatrix4(m11: cos(rotationAngle), m12: sin(rotationAngle), m13: 0.0, m14: 0.0,
                    m21: -sin(rotationAngle), m22: cos(rotationAngle), m23: 0.0, m24: 0.0,
                    m31: 0.0, m32: 0.0, m33: 1.0, m34: 0.0,
                    m41: position.x, m42: position.y, m43: position.z, m44: 1.0)
    
    
    // Create a line object
    let line = SCNCylinder(radius: CGFloat(linkRadius), height: CGFloat(length))
    line.firstMaterial?.diffuse.contents = UIColor.red
    line.name = "node"
    
    // Add the object to the view
    let lineNode = SCNNode()
    lineNode.geometry = line
    currentNode?.addChildNode(lineNode)
    
    // Determine the pose of the object
    lineNode.transform = Tx!
    self.currentNode = lineNode

}

func addSphere(to sceneView:ARSCNView, at translation:SCNVector3, with rotation:SCNVector4 = SCNVector4(0,0,0,0), eularAngle eularRotation:SCNVector3?, radius:CGFloat = -1  ) {

var radius = radius
    
let rotationAngle:Float = rotation.w
if radius == -1 {  radius = CGFloat(2*self.linkRadius) }

// 关于 Z轴 的旋转矩阵
    let Tx = SCNMatrix4(m11: cos(rotationAngle), m12: sin(rotationAngle), m13: 0.0, m14: 0.0,
                        m21: -sin(rotationAngle), m22: cos(rotationAngle), m23: 0.0, m24: 0.0,
                    m31: 0.0, m32: 0.0, m33: 1.0, m34: 0.0,
                    m41: translation.x, m42: translation.y, m43: translation.z, m44: 1.0)

// Set up the object geometry
let sphere = SCNSphere(radius: radius )
sphere.firstMaterial?.diffuse.contents = UIColor.black

// Create and add Node
let sphereNode = SCNNode()
sphereNode.geometry = sphere
sphereNode.name = "node"
currentNode?.addChildNode(sphereNode)


if eularRotation == nil {
    // assign the transformation matrix to the node
    sphereNode.transform = Tx
}
else {
    sphereNode.eulerAngles = eularRotation!
}

// re-new the currentNode
currentNode = sphereNode


}

func addLink2D(to sceneView:ARSCNView, of length:Float, lastLength:Float = 0, with rotation:Float = 0) {
    
    var translation = length
    
    
    // 这个判断是干什么的。
    if (currentNode == self.arView.scene.rootNode) {
        addSphere(to: sceneView, at: SCNVector3(0,0,-0.3), with: SCNVector4(0,0,1,rotation), eularAngle: nil )
    }
    else if (currentNode == self.currentNode_detected) {
        addSphere(to: sceneView, at: SCNVector3(0,0,0), eularAngle: SCNVector3(pi/2, pi/2, 0) )
    }
    else {
        
        translation = Float(lastLength/2)
        addSphere(to: sceneView, at: SCNVector3(0,translation,0), with: SCNVector4(0,0,1,rotation), eularAngle: nil)
    }
    
    translation = length
    addLine(to: sceneView, at:  SCNVector3(0,translation,0))
}

// Joint 是 Rotation
// Link 是 Translation
// 分开来弄，别堆在一起
func addFourBarLink(to sceneView:ARSCNView, ofLength lengthForLink:[Float] = [0.2, 0.2, 0.2, 0.2], with rotation:[Float] = [0, 0, 0, 0] ) {
    
    for i in 1...lengthForLink.count {
        
        if i == 1 {
            addLink2D(to: sceneView, of: lengthForLink[i-1],  with: rotation[i-1])
        }
        else {
            addLink2D(to: sceneView, of: lengthForLink[i-1], lastLength: lengthForLink[i-2],  with: rotation[i-1])
        }
        
    } // end for
    
}

func removeAllNodes() {
    
    let rootNode = arView.scene.rootNode
    
    rootNode.enumerateHierarchy { (node, stop) in
        
        if(node.name == "node") {
            node.removeFromParentNode()
        }
    }
}
    
}

