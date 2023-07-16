//
//  OpenedCellViewController.swift
//  rickMorty
//
//  Created by Александр Троицкий on 01.07.2023.
//

import UIKit

/// Текущий Сharacter
final class CurrentCharacterViewController: UIViewController {
    
    private let networkService = NetworkService()
    
    private var nameLabel = UILabel()
    private var genderLabel = UILabel()
    private var speciecLabel = UILabel()
    private var image = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        genderLabel.frame = CGRect(x: 50, y: 380, width: 300, height: 50)
        nameLabel.frame = CGRect(x: 50, y: 350, width: 300, height: 50)
        speciecLabel.frame = CGRect(x: 50, y: 410, width: 300, height: 50)
        image.frame = CGRect(x: 50, y: 20.0, width: 300.0, height: 300.0)
        image.layer.cornerRadius = 150.0
        image.clipsToBounds = true
        
        view.addSubview(speciecLabel)
        view.addSubview(genderLabel)
        view.addSubview(nameLabel)
        view.addSubview(image)
    }
    
    func configure(data: Character) {
        nameLabel.text = "Name: \(data.name)"
        speciecLabel.text = "Species: \(data.species)"
        genderLabel.text = "Sex: \(data.gender)"
        downloadImage(from: data.image)
    }
    
    private func downloadImage(from url: String) {
        guard let url = URL(string: url) else { return }
        networkService.getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image.image = UIImage(data: data)
            }
        }
    }
}
