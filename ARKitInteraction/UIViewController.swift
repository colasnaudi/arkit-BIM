//
//  UIViewController.swift
//  ARKitInteraction
//
//  Created by Colas Naudi on 10/04/2024.
//  Copyright © 2024 Apple. All rights reserved.
//

class ViewController: UIViewController, UIDocumentPickerViewController {

    // Implémentez la méthode documentPicker(_:didPickDocumentsAt:) pour traiter les fichiers sélectionnés par l'utilisateur
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        // Traitez les documents sélectionnés
        for url in urls {
            print("URL du document sélectionné: \(url)")
            // Implémentez votre logique pour manipuler le document sélectionné ici
        }
    }
}
