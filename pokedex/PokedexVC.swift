//
//  ViewController.swift
//  pokedex
//
//  Created by Shalom Owolabi on 29/06/2017.
//  Copyright © 2017 SpotPin. All rights reserved.
//

import UIKit
import AVFoundation

class PokedexVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var inSearchMode = false
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        parsePokemonCSV()
        
        initAdudio()
    }
    
    func initAdudio() {
        
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path!)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        }catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    func parsePokemonCSV(){
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows{
                let pokeID = Int(row["id"]!)
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokedexId: pokeID!)
                
                pokemon.append(poke)
            }
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? pokeCell {
            let poke: Pokemon!
            
            if inSearchMode {
                poke = filteredPokemon[indexPath.row]
                cell.configureCell(poke)
            }else {
                poke = pokemon[indexPath.row]
                cell.configureCell(poke)
            }
            
            return cell
        }else {
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var poke: Pokemon
        
        if inSearchMode{
            poke = filteredPokemon[indexPath.row]
        }else {
            poke = pokemon[indexPath.row]
        }
        
        performSegue(withIdentifier: "pokemonDetailVC", sender: poke)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode{
            return filteredPokemon.count
        }else{
        
            return pokemon.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 80, height: 100)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            
            collection.reloadData()
            view.endEditing(true)
            
        }else {
            inSearchMode = true
            
            let lower = searchBar.text?.lowercased()
            
            filteredPokemon = pokemon.filter({$0.name.range(of: lower!) != nil})
            collection.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pokemonDetailVC" {
            if let detailVC = segue.destination as? PokemonDetailVC {
                if let poke = sender as? Pokemon{
                    detailVC.pokemon = poke
                }
            }
        }
    }
    
    @IBAction func musicButtonPressed(_ sender: Any) {
        
        if musicPlayer.isPlaying{
            musicPlayer.pause()
            (sender as! UIButton).alpha = 0.2
        }else{
            musicPlayer.play()
            (sender as! UIButton).alpha = 1.0
        }
    }
}

