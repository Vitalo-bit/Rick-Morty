//
//  ViewController.swift
//  rickMorty
//
//  Created by Александр Троицкий on 01.07.2023.
//

import UIKit

/// Экран Сharacters
final class CharactersViewController: UIViewController {
    // MARK: - Private Properties
    private let identifier = "characterIdentifier"
    private let networkService = NetworkService()
    private var myTableView = UITableView()
    private var characters = [Character]() {
        didSet {
            myTableView.reloadData()
        }
    }
    
    lazy var dataProvider: RickProvider = {
        let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        let provider = RickProvider(with: managedContext, fetchedResultsControllerDelegate: self)
        return provider
    }()

    
    let char = [RickChar]()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Rick & Morty"
        fetchCharacters()
        createTable()
        
    }
    
    // MARK: - Private Methods
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
            AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
        }
    }
}

/// UITableViewDelegate, UITableViewDataSource
extension CharactersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellCharacter = characters[indexPath.row]
        let openCell = CurrentCharacterViewController()
        openCell.configure(data: cellCharacter)
        navigationController?.present(openCell, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = characters[indexPath.row].name
        return cell
    }
}

