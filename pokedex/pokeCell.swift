//
//  pokeCell.swift
//  pokedex
//
//  Created by Shalom Owolabi on 01/07/2017.
//  Copyright © 2017 SpotPin. All rights reserved.
//

import UIKit

class pokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init? (coder aDecoder: NSCoder ){
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell (_ pokemon: Pokemon){
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
        
    }
    
}
