//
//  PokemonDetailViewController.swift
//  DesafioRedFox
//
//  Created by erick pisco on 13/02/19.
//  Copyright © 2019 erick pisco. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    @IBOutlet weak var vwMain: UIView!
    
    @IBOutlet weak var vwLoading: UIView!
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    
    
    @IBOutlet weak var lbNumber: UILabel!
    @IBOutlet weak var imPokemon: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imFront: UIImageView!
    @IBOutlet weak var imBack: UIImageView!
    @IBOutlet weak var imFrontS: UIImageView!
    @IBOutlet weak var imBackS: UIImageView!
   
    @IBOutlet weak var vwHpBar: UIView!
    @IBOutlet weak var vwHp: UIView!
    @IBOutlet weak var lbHp: UILabel!
    
    @IBOutlet weak var vwAttack: UIView!
    @IBOutlet weak var vwAttackBar: UIView!
    @IBOutlet weak var lbAttack: UILabel!
    

    @IBOutlet weak var vwDefenseBar: UIView!
    @IBOutlet weak var vwDefense: UIView!
    @IBOutlet weak var lbDefense: UILabel!
    
    @IBOutlet weak var vwSpAttack: UIView!
    @IBOutlet weak var vwSpAttackBar: UIView!
    @IBOutlet weak var lbSpAttack: UILabel!
    
    @IBOutlet weak var vwSpDefense: UIView!
    @IBOutlet weak var vwSpDefenseBar: UIView!
    @IBOutlet weak var lbSpDefense: UILabel!
    
    @IBOutlet weak var vwSpeed: UIView!
    @IBOutlet weak var vwSpeedBar: UIView!
    @IBOutlet weak var lbSpeed: UILabel!
    
    var pokemon: pokemonData!
    var pokemonInfo: pokemonDetail!
    var viewLoad = true
    let url = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"

    override func viewDidLoad() {
        super.viewDidLoad()
        imageSetting()
        
        if pokemonInfo != nil {
            loadingInfo(id: pokemonInfo.id)
        } else {
            loadingScreen()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationItem.backBarButtonItem?.title = ""
        
        
    }
    
    func loadingScreen() {
        if viewLoad == true {
            viewLoad = false
            loadPokemonDetail()
            view.bringSubviewToFront(vwLoading)
            aiLoading.startAnimating()
            vwLoading.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        } else {
            view.sendSubviewToBack(vwLoading)
            aiLoading.startAnimating()
            vwLoading.backgroundColor = UIColor.clear
            print("entro aqui")
            
        }
        
        
    }

    func loadPokemonDetail() {
        let name = pokemon.name
        PokemonAPI.loadPokemonInfo(name: name, id: 0) { (info) in
            if let info = info {
                self.pokemonInfo = info
                DispatchQueue.main.async {
                    self.loadingInfo(id: self.pokemonInfo.id)
                    self.aiLoading.stopAnimating()
                    self.aiLoading.hidesWhenStopped = true
                    self.loadingScreen()
                    
                }
            }
        }
}
    
    func loadingInfo(id: Int) {
        
        statsBar(width: Int(vwHpBar.frame.size.width) , statsMax: 250, baseHp: pokemonInfo.stats[0].base_stat, baseAtk: pokemonInfo.stats[1].base_stat, baseDef: pokemonInfo.stats[2].base_stat, baseSpAtk: pokemonInfo.stats[3].base_stat, baseSpDef: pokemonInfo.stats[4].base_stat, baseSpeed: pokemonInfo.stats[5].base_stat)
        
        // Image Setting
        let urlFront = URL(string: url + "\(id).png" )
        let urlBack = URL(string: url + "back/" + "\(id).png" )
        let urlFrontS = URL(string: url + "shiny/" + "\(id).png" )
        let urlBackS = URL(string: url + "back/shiny/" + "\(id).png" )
        
        lbNumber.text = "#\(String(pokemonInfo.id))"
        
        // Image Loading
        imPokemon.kf.setImage(with: urlFront)
        imFront.kf.setImage(with: urlFront)
        imBack.kf.setImage(with: urlBack)
        imFrontS.kf.setImage(with: urlFrontS)
        imBackS.kf.setImage(with: urlBackS)
    
        // load stats
        lbName.text = pokemonInfo.name.capitalized
        lbHp.text = String(pokemonInfo.stats[0].base_stat)
        vwHp.layer.cornerRadius = vwHp.frame.size.height/3
        vwHp.layer.borderWidth = 1
        vwHpBar.layer.cornerRadius = vwHpBar.frame.size.height/1.7
        
        lbAttack.text = String(pokemonInfo.stats[1].base_stat)
        vwAttack.layer.cornerRadius = vwAttack.frame.size.height/3
        vwAttack.layer.borderWidth = 1
        vwAttackBar.layer.cornerRadius = vwAttackBar.frame.size.height/1.7
        
        lbDefense.text = String(pokemonInfo.stats[2].base_stat)
        vwDefense.layer.cornerRadius = vwDefense.frame.size.height/3
        vwDefense.layer.borderWidth = 1
        vwDefenseBar.layer.cornerRadius = vwDefenseBar.frame.size.height/1.7
        
        lbSpAttack.text = String(pokemonInfo.stats[3].base_stat)
        vwSpAttack.layer.cornerRadius = vwSpAttack.frame.size.height/3
        vwSpAttack.layer.borderWidth = 1
        vwSpAttackBar.layer.cornerRadius = vwSpAttackBar.frame.size.height/1.7
        
        lbSpDefense.text = String(pokemonInfo.stats[4].base_stat)
        vwSpDefense.layer.cornerRadius = vwSpDefense.frame.size.height/3
        vwSpDefense.layer.borderWidth = 1
        vwSpDefenseBar.layer.cornerRadius = vwSpDefenseBar.frame.size.height/1.7
        
        lbSpeed.text = String(pokemonInfo.stats[5].base_stat)
        vwSpeed.layer.cornerRadius = vwSpeed.frame.size.height/3
        vwSpeed.layer.borderWidth = 1
        vwSpeedBar.layer.cornerRadius = vwSpeedBar.frame.size.height/1.7
        
    }
    
    
    func imageSetting() {
        imPokemon.layer.cornerRadius = imPokemon.frame.size.height/2
        imPokemon.layer.borderWidth = 1
        imFront.layer.cornerRadius = imFront.frame.size.height/2
        imFront.layer.borderWidth = 1
        imBack.layer.cornerRadius = imBack.frame.size.height/2
        imBack.layer.borderWidth = 1
        imFrontS.layer.cornerRadius = imFrontS.frame.size.height/2
        imFrontS.layer.borderWidth = 1
        imBackS.layer.cornerRadius = imBackS.frame.size.height/2
        imBackS.layer.borderWidth = 1
    
    }
    
    func statsBar(width: Int, statsMax: Int, baseHp: Int, baseAtk: Int, baseDef: Int, baseSpAtk: Int, baseSpDef: Int, baseSpeed: Int) {
        
        let hpStats: Int = {
            let stats = Int(baseHp * width/statsMax)
            if(stats >= statsMax){
               return Int(vwHpBar.frame.size.width)
            }else {
                return stats
            }
        }()
        
        let atkStats: Int = {
            let stats = Int(baseAtk * width/statsMax)
            if(stats >= statsMax){
                return Int(vwAttackBar.frame.size.width)
            }else {
                return stats
            }
        }()
        
        let defStats: Int = {
            let stats = Int(baseDef * width/statsMax)
            if(stats >= statsMax){
                return Int(vwDefenseBar.frame.size.width)
            }else {
                return stats
            }
        }()
        
        let spAtkStats: Int = {
            let stats = Int(baseSpAtk * width/statsMax)
            if(stats >= statsMax){
                return Int(vwSpAttackBar.frame.size.width)
            }else {
                return stats
            }
        }()
        
        let spDefStats: Int = {
            let stats = Int(baseSpDef * width/statsMax)
            if(stats >= statsMax){
                return Int(vwSpDefenseBar.frame.size.width)
            }else {
                return stats
            }
        }()
        
        let speedStats: Int = {
            let stats = Int(baseSpeed * width/statsMax)
            if(stats >= statsMax){
                print("speedAlto")
                return Int(vwSpeedBar.frame.size.width)
                
            }else {
                print("speedBaixo")
                return stats
                
            }
        }()
        
            vwHpBar.frame.size.width = CGFloat(hpStats)
            vwAttackBar.frame.size.width = CGFloat(atkStats)
            vwDefenseBar.frame.size.width = CGFloat(defStats)
            vwSpAttackBar.frame.size.width = CGFloat(spAtkStats)
            vwSpDefenseBar.frame.size.width = CGFloat(spDefStats)
            vwSpeedBar.frame.size.width = CGFloat(speedStats)
            
        
        
//        if hpStats != 0 || speedStats != 0 {
//            DispatchQueue.main.async {
//                self.vwHpBar.frame.size.width = CGFloat(hpStats)
//                self.vwAttackBar.frame.size.width = CGFloat(atkStats)
//                self.vwDefenseBar.frame.size.width = CGFloat(defStats)
//                self.vwSpAttackBar.frame.size.width = CGFloat(spAtkStats)
//                self.vwSpDefenseBar.frame.size.width = CGFloat(spDefStats)
//                self.vwSpeedBar.frame.size.width = CGFloat(speedStats)
//
//            }
//
//        }else {
//            print("info faltando")
//        }

        
        
        

        

    }
//    func loadStatsBar(){
//
//    lbHp.frame.size.width =
//    }
}
