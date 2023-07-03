//
//  OpenedCellViewController.swift
//  rickMorty
//
//  Created by Александр Троицкий on 01.07.2023.
//

import UIKit

/// Добавить на этот экран возможноость изменять данные, а потом вызывать метод делегата при выходе
class OpenedCellViewController: UIViewController {

    var label = UILabel()
    
    var delegate: CharacterDelegate?
    
    func configure(data: Character) {
        label.text = data.name
        delegate?.characterWasChanged(data)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "RickMortyTheme")
        label.frame = CGRect(x: 140, y: 300, width: 300, height: 50)
        view.addSubview(label)
        // Do any additional setup after loading the view.
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
