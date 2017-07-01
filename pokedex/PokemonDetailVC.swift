//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Shalom Owolabi on 01/07/2017.
//  Copyright © 2017 SpotPin. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var nameLBL: UILabel!
    var pokemon: Pokemon!
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLBL.text = pokemon.name
        // Do any additional setup after loading the view.
    }


}
