//
//  MainViewController.swift
//  RGB_App
//
//  Created by Paul Makey on 8.12.23.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func setColor(with view: UIColor)
}

final class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.colorView = view
        settingsVC.delegate = self
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func setColor(with view: UIColor) {
        self.view.backgroundColor = view
    }
}
