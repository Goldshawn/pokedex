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
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexIdLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var currentEvoLbl: UIImageView!
    @IBOutlet weak var nextEvoLbl: UIImageView!
    
    var pokemon: Pokemon!
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLBL.text = pokemon.name
        let img = UIImage(named: "\(pokemon.pokedexId)")
        
        mainImg.image = img
        currentEvoLbl.image = img
        
        pokemon.downloadPokemonDetails {
            
            
            // this would only be done when network calls are complete
        }
        // Do any additional setup after loading the view.
    }
    
    func updateUI()  {
        attackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        pokedexIdLbl.text = "\(pokemon.pokedexId)"
        
    }

    @IBAction func backBtnPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }

}
