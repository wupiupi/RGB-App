//
//  ViewController.swift
//  HomeWork2.3
//
//  Created by Paul Makey on 16.11.23.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet var rgbView: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        rgbView.layer.cornerRadius = 15
    }
    
    // MARK: - IB Actions
    @IBAction func redSliderAction() {
        updateRGBview()
        redValueLabel.text = String(roundValueByHundreds(for: redSlider.value))
    }
    
    @IBAction func greenSliderAction() {
        updateRGBview()
        greenValueLabel.text = String(roundValueByHundreds(for: greenSlider.value))
    }
    
    @IBAction func blueSliderAction() {
        updateRGBview()
        blueValueLabel.text = String(roundValueByHundreds(for: blueSlider.value))
    }
    
    private func updateRGBview() {
        rgbView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func roundValueByHundreds(for value: Float) -> Float {
        (value * 100).rounded() / 100
    }
 }

