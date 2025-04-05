//
//  DrawingViewController.swift
//  Bee
//
//  Created by Artur KNOTHE on 30/08/2023.
//

import UIKit

class DrawingViewController: UIViewController {

    var drawingPoints: [CGPoint] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(panGesture)
    }

    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        let point = gesture.location(in: view)
        
        switch gesture.state {
        case .began:
            drawingPoints = []
        case .changed:
            drawingPoints.append(point)
        case .ended:
            recognizeAndDisplayNumber()
        default:
            break
        }
    }

//    func recognizeAndDisplayNumber() {
//        // TODO: Implement your recognition logic here
//        // Compare drawingPoints with number templates to recognize the written number
//        // Display the recognized number on the screen
//    }
    
    func recognizeAndDisplayNumber() {
        guard !drawingPoints.isEmpty else {
            return
        }
        
        print(drawingPoints)
        
        let numberTemplates: [Int: [CGPoint]] = [
            0: [CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 0), CGPoint(x: 1, y: 1), CGPoint(x: 0, y: 1)],
            1: [CGPoint(x: 0.5, y: 0), CGPoint(x: 0.5, y: 1)],
            // Define templates for other digits
        ]
        
        var bestMatch: (digit: Int, distance: CGFloat) = (-1, .greatestFiniteMagnitude)
        
        for (digit, template) in numberTemplates {
            let distance = calculateDistanceBetweenPoints(template, drawingPoints)
            if distance < bestMatch.distance {
                bestMatch = (digit, distance)
            }
        }
        
        if bestMatch.digit >= 0 {
            displayRecognizedNumber(bestMatch.digit)
        } else {
            displayNoNumberRecognized()
        }
    }

    func calculateDistanceBetweenPoints(_ points1: [CGPoint], _ points2: [CGPoint]) -> CGFloat {
        guard points1.count == points2.count else {
            return .greatestFiniteMagnitude
        }
        
        var totalDistance: CGFloat = 0.0
        for (point1, point2) in zip(points1, points2) {
            let dx = point1.x - point2.x
            let dy = point1.y - point2.y
            let distance = sqrt(dx * dx + dy * dy)
            totalDistance += distance
        }
        
        return totalDistance
    }

    func displayRecognizedNumber(_ digit: Int) {
        // TODO: Display the recognized digit on the screen
        print("Recognized digit: \(digit)")
    }

    func displayNoNumberRecognized() {
        // TODO: Display a message indicating that no digit was recognized
        print("No digit recognized")
    }

}
