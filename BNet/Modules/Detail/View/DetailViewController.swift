//
//  DetailViewController.swift
//  BNet
//
//  Created by Алексей Черанёв on 19.04.2023.
//

import UIKit

protocol DetailDisplayLogic: AnyObject {
    func set(image: UIImage?, name: String, description: String)
}

final class DetailViewController: UIViewController, DetailDisplayLogic {
    
    var interactor: DetailBuisnessLogic?
    
    @IBOutlet weak var buttonView: UIView?
    @IBOutlet weak var descriptionLabel: UILabel?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var imageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        interactor?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 111/256, green: 181/256, blue: 75/256, alpha: 1)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationController?.navigationBar.tintColor = UIColor.white
        
        
   }
    
    //MARK: - DetailDisplayLogic
    
    func set(image: UIImage?, name: String, description: String) {
        DispatchQueue.main.async {
            self.imageView?.image = image
            self.nameLabel?.text = name
            self.descriptionLabel?.text = description
        }
    }
    
    //MARK: - Private
    
    private func configureUI() {
        buttonView?.layer.borderWidth = 1
        buttonView?.layer.borderColor = UIColor(red: 239/255, green: 239/255, blue: 240/255, alpha: 1).cgColor
        buttonView?.layer.cornerRadius = 8
    }

}
