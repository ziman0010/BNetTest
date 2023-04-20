//
//  SearchViewController.swift
//  BNet
//
//  Created by Алексей Черанёв on 19.04.2023.
//

import UIKit

protocol SearchDisplayLogic: AnyObject {
    func set(viewObject: [Item])
    func clear()
    func showError(title: String, message: String)
}

final class SearchViewController: UIViewController,
                                  SearchDisplayLogic,
                                  UICollectionViewDelegate,
                                  UICollectionViewDataSource,
                                  UICollectionViewDelegateFlowLayout,
                                  UISearchBarDelegate {
    
    var interactor: SearchBuisnessLogic?
    
    @IBOutlet weak var loader: UIActivityIndicatorView?
    @IBOutlet weak var searchBar: UISearchBar?
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewObject: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        interactor?.viewDidLoad()
        collectionView.contentInset = UIEdgeInsets.init(top: 24, left: 16, bottom: 0, right: 16)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 111/256, green: 181/256, blue: 75/256, alpha: 1)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
   }
    
    //MARK: - SearchDisplayLogic
    
    func set(viewObject: [Item]) {
        self.viewObject = viewObject
        DispatchQueue.main.async {
            self.stopLoader()
            self.collectionView.reloadData()
            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    func clear() {
        self.viewObject = []
        
        DispatchQueue.main.async {
            self.stopLoader()
            self.collectionView.reloadData()
            
        }
    }
    
    func showError(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alertController, animated: true)
        stopLoader()
    }
    
    //MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            return
        }
        dismissKeyboard()
        startLoader()
        interactor?.search(query: query)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            interactor?.viewDidLoad()
        }
    }
    
    //MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let controller = DetailInitializer.controller(item: viewObject[indexPath.row])
        dismissKeyboard()
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    //MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewObject.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.reuseId, for: indexPath) as? SearchCell else {
            return UICollectionViewCell()
        }
        cell.set(viewObject: viewObject[indexPath.row])
        
        return cell
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = trunc((collectionView.frame.size.width - 47) / 2.0)
        
        return CGSize(width: size, height: 296)
    }
    
    //MARK: - Private
    
    private func configureSearchBar() {
        searchBar?.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        collectionView.keyboardDismissMode = .onDrag
        
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func startLoader() {
        loader?.startAnimating()
        loader?.isHidden = false
        view.isUserInteractionEnabled = false
    }
    
    private func stopLoader() {
        loader?.stopAnimating()
        loader?.isHidden = true
        view.isUserInteractionEnabled = true
    }
}
