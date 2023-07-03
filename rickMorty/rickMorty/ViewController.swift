//
//  ViewController.swift
//  rickMorty
//
//  Created by Александр Троицкий on 01.07.2023.
//

import UIKit

// Отдельный файл для моделек, посмотри про MVC
struct Character {
    enum Status {
        case alive
        case dead
        case unknown
    }
    
    enum Gender {
        case female
        case male
        case genderless
        case unknown
    }
    
    let id: Int
    let name: String
    let status: Status
    let species: String
    let gender: Gender
    let location: String
    let image: String
}

protocol CharacterDelegate {
    func characterWasChanged(_ character: Character)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var myTableView = UITableView()
    
    let identifier = "MyCell"
    
    var characters = [
        Character(id: 1, name: "Rick", status: Character.Status.alive, species: "Human", gender: Character.Gender.male, location: "Earth", image: "Rick"),
        Character(id: 2, name: "Rick", status: Character.Status.alive, species: "Human", gender: Character.Gender.male, location: "Earth", image: "Rick"),
        Character(id: 3, name: "Rick", status: Character.Status.alive, species: "Human", gender: Character.Gender.male, location: "Earth", image: "Rick"),
        Character(id: 4, name: "Rick", status: Character.Status.alive, species: "Human", gender: Character.Gender.male, location: "Earth", image: "Rick"),
        Character(id: 5, name: "Rick", status: Character.Status.alive, species: "Human", gender: Character.Gender.male, location: "Earth", image: "Rick")
    ] {
        didSet {
            myTableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Table1"
        createTable()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellCharacter = characters[indexPath.row]
        let openCell = OpenedCellViewController()
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

    func createTable() {
        myTableView = UITableView(frame: view.bounds, style: .plain)
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        myTableView.backgroundColor = UIColor(named: "RickMortyTheme")
        myTableView.delegate = self
        myTableView.dataSource = self
        view.addSubview(myTableView)
    }
}

extension ViewController: CharacterDelegate {
    func characterWasChanged(_ character: Character) {
        characters[0] = character
    }
}

