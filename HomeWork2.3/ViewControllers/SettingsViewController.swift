//
//  ViewController.swift
//  HomeWork2.3
//
//  Created by Paul Makey on 16.11.23.
//

import UIKit

final class SettingsViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet var rgbView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!

    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        rgbView.layer.cornerRadius = 15
    }
    
    // MARK: - IB Actions
    @IBAction func sliderValueHasChanged(_ sender: UISlider) {
        updateRGBview()
        
        switch sender {
        case redSlider:
            redLabel.text = roundString(for: sender.value)
        case greenSlider:
            greenLabel.text = roundString(for: sender.value)
        default:
            blueLabel.text = roundString(for: sender.value)
        }
    }
    
 }

// MARK: - Private Methods
private extension SettingsViewController {
    
    func roundString(for value: Float) -> String {
        String(format: "%.2f", value)
    }
    
    func updateRGBview() {
        rgbView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
}
