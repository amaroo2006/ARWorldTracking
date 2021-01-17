//
//  ViewController.swift
//  World Tracking
//
//  Created by Ansh Maroo on 7/2/19.
//  Copyright © 2019 Mygen Contac. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true

    }


    @IBAction func add(_ sender: Any) {
        
        let plane = SCNNode(geometry: SCNPlane(width: 0.1, height: 0.1))

        plane.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        
        plane.position = SCNVector3(0, 0, -0.3)
        
        plane.eulerAngles = SCNVector3(0, Float(90.degreesToRadians), 0)
        self.sceneView.scene.rootNode.addChildNode(plane)
        
        let pyramid = SCNNode(geometry: SCNPyramid(width: 0.1, height: 0.1, length: 0.1))
        
        pyramid.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        
        pyramid.position = SCNVector3(0,0,-0.5)
        plane.addChildNode(pyramid)
        
        let doorNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.06))

        doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown

        let boxNode = SCNNode(geometry:SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))

        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.cyan

        let node = SCNNode()

        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)

        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red

        node.position = SCNVector3(0.2, 0.3, -0.7)

        boxNode.position = SCNVector3(0,-0.05,0)

        doorNode.position = SCNVector3(0, -0.02, 0.052)

        self.sceneView.scene.rootNode.addChildNode(node)

        node.addChildNode(boxNode)

        boxNode.addChildNode(doorNode)
    }
    @IBAction func reset(_ sender: Any) {
        
        restartSession()
        
    }
    
    func restartSession() {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node,_)  in
            node.removeFromParentNode()
            
        }
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    func randomNumbers(firstNum : CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}

extension Int {
    
    var degreesToRadians: Double { return Double(self) * .pi/100 }
    
}
