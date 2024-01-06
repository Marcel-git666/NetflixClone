//
//  DataPersistenceManager.swift
//  Netflix Clone
//
//  Created by Marcel Mravec on 05.01.2024.
//

import UIKit
import CoreData

enum DatabaseError: Error {
    case failedToSaveData, failedToLoadData, failedToDeleteData
}

class DataPersistenceManager {
    static let shared = DataPersistenceManager()
    
    func downloadTitleWith(model: Title, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        let item = TitleItem(context: context)
        item.original_name = model.original_name
        item.id = Int64(model.id)
        item.media_type = model.media_type
        item.original_title = model.original_title
        item.overview = model.overview
        item.poster_path = model.poster_path
        item.release_date = model.release_date
        item.vote_average = model.vote_average
        item.vote_count = Int64(model.vote_count)
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToSaveData))
        }
    }
    
    func fetchTitlesFromDatabase(completion: @escaping (Result<[TitleItem], Error>) -> (Void)) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<TitleItem>
        request = TitleItem.fetchRequest()
        
        do {
            let titles = try context.fetch(request)
        
            completion(.success(titles))
            print("Succesfully loaded \(titles.count) items")
        } catch {
            completion(.failure(DatabaseError.failedToLoadData))
        }
        
    }
    
    func deleteTitleWith(model: TitleItem, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        context.delete(model)
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
    }
}
