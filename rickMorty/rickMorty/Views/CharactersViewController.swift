//
//  ViewController.swift
//  rickMorty
//
//  Created by Александр Троицкий on 01.07.2023.
//

import UIKit

protocol CharacterDelegate {
    func characterWasChanged(_ character: Character)
}

class CharactersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let identifier = "characterIdentifier"
    private let networkService = NetworkService()
    private var myTableView = UITableView()
    private var characters = [Character]() {
        didSet {
            myTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Rick & Morty"
        fetchCharacters()
        createTable()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellCharacter = characters[indexPath.row]
        let openCell = CurrentCharacterViewController()
        openCell.delegate = self
        openCell.configure(data: cellCharacter)
        navigationController?.present(openCell, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = characters[indexPath.row].name
        return cell
    }

    private func createTable() {
        myTableView = UITableView(frame: view.bounds, style: .plain)
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        myTableView.delegate = self
        myTableView.dataSource = self
        view.addSubview(myTableView)
    }
    
    private func fetchCharacters() {
        networkService.fetchCharacters { result in
            switch result {
            case .success(let success):
                self.characters = success
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            
        }
    }
}

extension CharactersViewController: CharacterDelegate {
    func characterWasChanged(_ character: Character) {
        characters[0] = character
    }
}

