//
//  Registry.swift
//  Ice
//
//  Created by Jake Heiser on 9/13/17.
//

import IceKit
import SwiftCLI

class RegistryGroup: CommandGroup {
    let name = "registry"
    let shortDescription = "Manage local package registry"
    let children: [Routable] = [AddEntryCommand(), RemoveEntryCommand(), LookupEntryCommand(), RefreshCommand()]
}

private class AddEntryCommand: Command {
    
    let name = "add"
    let shortDescription = "Add the given entry to your local registry"
    
    let ref = Parameter()
    let shortName = Parameter()

    func execute() throws {
        guard let ref = RepositoryReference(ref.value) else {
            throw IceError(message: "invalid repository reference")
        }
        
        try Ice.registry.add(name: shortName.value, url: ref.url)
    }
    
}

private class RemoveEntryCommand: Command {
    
    let name = "remove"
    let shortDescription = "Remove the given entry from your local registry"
    
    let from = Parameter()
    
    func execute() throws {
        try Ice.registry.remove(from.value)
    }
    
}

private class LookupEntryCommand: Command {
    
    let name = "lookup"
    
    let from = Parameter()
    
    func execute() throws {
        guard let value = Ice.registry.get(from.value) else {
            throw IceError(message: "couldn't find \(from.value)")
        }
        print(value.url)
    }
    
}

private class RefreshCommand: Command {
    
    let name = "refresh"
    
    func execute() throws {
        try Ice.registry.refresh()
    }
    
}
