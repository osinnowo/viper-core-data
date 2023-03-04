//
//  Interactor.swift
//  ViperCoreData
//
//  Created by Osinnowo Emmanuel on 04/03/2023.
//

import UIKit
import CoreData

enum NetworkError: Error {
    case unableToFetchUsers
}

protocol AnyInteractor {
    var presenter: AnyPresenter? { get }
    func fetchUserRecord()
}

final class UserInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    var context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func fetchUserRecord() {
        
        self.presenter?.didFetchUserList(with: .success(localEntities()))

        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let response = try JSONDecoder().decode([UserData].self, from: data)
                let users = self?.saveToLocalDatabase(response)
                self?.presenter?.didFetchUserList(with: .success(users ?? []))
            } catch {
                self?.presenter?.didFetchUserList(with: .failure(NetworkError.unableToFetchUsers))
            }
        }
        task.resume()
    }
    
    func saveToLocalDatabase(_ users: [UserData]?) -> [User] {
        clearLocalEntities()
        if let context = context, let users = users {
            for user in users {
                let entity = User(context: context)
                entity.name = user.name
                try? context.save()
            }
        }
        return localEntities()
    }
    
    func localEntities() -> [User] {
        let fetchEntity = User.fetchRequest()
        let entities = try? context?.fetch(fetchEntity)
        return entities ?? []
    }
    
    func clearLocalEntities() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try? context?.execute(deleteRequest)
    }
}
