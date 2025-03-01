//
//  ActorDetailsViewController.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 1.03.2025.
//

import UIKit

class ActorDetailsViewController: UIViewController {
    var viewModel: ActorDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = viewModel.name
        // Diğer UI elemanlarını ayarla
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
