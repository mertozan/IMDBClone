//
//  ActorDetailsViewModel.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 1.03.2025.
//

class ActorDetailsViewModel {
    private let actor: Actor
    
    init(actor: Actor) {
        self.actor = actor
    }
    
    var name: String {
        return actor.name
    }
    
    var profilePath: String? {
        return actor.profilePath
    }
}
