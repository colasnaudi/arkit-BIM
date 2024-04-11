//
//  ViewController+UIDocumentPickerDelegate.swift
//  ARKitInteraction
//
//  Created by Colas Naudi on 10/04/2024.
//  Copyright © 2024 Apple. All rights reserved.
//
import UIKit
import SceneKit

extension ViewController: UIDocumentPickerDelegate {
    
    // MARK: - Interface Actions
    /// Displays the `VirtualObjectSelectionViewController` from the `addObjectButton` or in response to a tap gesture in the `sceneView`
    @IBAction func showVirtualObjectSelectionViewController() {
        // Assurez-vous que l'ajout d'objets est une action disponible et que nous ne chargeons pas un autre objet (pour éviter les modifications concurrentes de la scène).
        guard !addObjectButton.isHidden && !virtualObjectLoader.isLoading else { return }
        
        statusViewController.cancelScheduledMessage(for: .contentPlacement)
        
        // Créez une instance de UIDocumentPickerViewController
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)
        documentPicker.delegate = self // Assurez-vous que ViewController est conforme à UIDocumentPickerDelegate
        documentPicker.modalPresentationStyle = .formSheet
        
        // Présentez le sélecteur de documents
        present(documentPicker, animated: true, completion: nil)
    }
    
    // Implémentez la méthode documentPicker(_:didPickDocumentsAt:) pour traiter les fichiers sélectionnés par l'utilisateur
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else {
            return
        }
        
        // Create a VirtualObject instance using the selected file URL
        guard let virtualObject = VirtualObject(url: url) else {
            return
        }
        myVirtualObject = virtualObject
        
        // Load the virtual object using the VirtualObjectLoader
        virtualObjectLoader.loadVirtualObject(virtualObject) { [weak self] loadedObject in
            do {
                let scene = try SCNScene(url: url, options: nil)
                self?.sceneView.prepare([scene], completionHandler: { _ in
                    DispatchQueue.main.async {
                        self?.hideObjectLoadingUI()
                        self?.placeVirtualObject(loadedObject)
                    }
                })
            } catch {
                DispatchQueue.main.async {
                    self?.displayErrorMessage(title: "Failed to Load Scene", message: error.localizedDescription)
                }
            }
        }
        displayObjectLoadingUI()
    }
}
