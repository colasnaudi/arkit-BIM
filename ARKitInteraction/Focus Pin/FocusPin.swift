//
//  FocusPin.swift
//  ARKitInteraction
//
//  Created by Colas Naudi on 12/04/2024.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation
import ARKit

class FocusPin: SCNNode {
    // MARK: - Properties
    
    var isVisible: Bool = false {
        didSet {
            if isVisible {
                print("Visible")
                unhide()
            } else {
                print("Hide")
                hide()
            }
        }
    }
    
    // MARK: - Initialization
    
    override init() {
        super.init()
        setupPointer()
        opacity = 0.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Appearance
    
    private func setupPointer() {
        // Find the URL for the Pin.obj file in the app's bundle
        guard let pointerURL = Bundle.main.url(forResource: "Pin", withExtension: "obj") else {
            print("Failed to find Pin.obj in the resources folder.")
            return
        }
        
        do {
            // Load the scene from the OBJ file
            let pointerScene = try SCNScene(url: pointerURL, options: nil)
            
            // Find the root node of the loaded scene and get the child node named "Pin"
            guard let pointerNode = pointerScene.rootNode.childNode(withName: "Pin", recursively: true) else {
                print("Failed to find node named 'Pin' in the scene.")
                return
            }
            
            // Add the loaded node to the FocusPin node
            addChildNode(pointerNode)
            
            // Optionally, you can adjust the position, scale, or other properties of the pointerNode here
            
        } catch {
            print("Failed to load the pointer scene: \(error.localizedDescription)")
        }
    }

    
    func hide() {
        guard action(forKey: "hide") == nil else { return }
        runAction(.fadeOut(duration: 0.5), forKey: "hide")
    }
    
    func unhide() {
        guard action(forKey: "unhide") == nil else { return }
        runAction(.fadeIn(duration: 0.5), forKey: "unhide")
    }
}
