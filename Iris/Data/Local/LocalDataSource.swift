//
//  LocalDataSource.swift
//  Iris
//
//  Created by Balamurugan on 03/09/25.
//

import CoreData

class PostsLocalDataSource {
    private let context = CoreDataHelper.shared.context
    
    //Save posts to LocalData
    func saveAllPosts(_ posts: [PostsModal],users: [Int: UserModal]) {
        clearPosts()
        for post in posts {
            let cdPost = CDPosts(context: context)
            cdPost.id = Int64(post.id ?? 0)
            cdPost.userId = Int64(post.userId ?? 0)
            cdPost.title = post.title
            cdPost.body = post.body
            if let user = users[post.userId ?? -1] {
                cdPost.user = convertToCdUser(user: user)
            }
        }
        
        CoreDataHelper.shared.save()
    }
    //Fetch post from LocalData
    func loadPosts() -> [PostsModal] {
        let request: NSFetchRequest<CDPosts> = CDPosts.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \CDPosts.id, ascending: true)
        ]
        do {
            let cdPosts = try context.fetch(request)
            
            return cdPosts.map { cdPost in
                let userModel: UserModal? = {
                    if let cdUser = cdPost.user {
                        return UserModal(
                            id: Int(cdUser.id),
                            name: cdUser.name ?? "",
                            username: cdUser.username ?? "",
                            email: cdUser.email ?? "",
                            address:Address(
                                street:cdUser.address?.street,
                                suite:cdUser.address?.street,
                                city:cdUser.address?.street,
                                zipcode:cdUser.address?.street,
                                geo:Geo(
                                    lat: cdUser.address?.geo?.lat, lng: cdUser.address?.geo?.lat
                                )
                                
                            ),
                            phone:cdUser.phone,
                            website:cdUser.website,
                            
                            company:   Company(
                                name: cdUser.company?.name ?? "", catchPhrase: cdUser.company?.catchPhrase ?? "",
                                bs: cdUser.company?.bs ?? "")
                            
                        )
                    }
                    return nil
                }()

                return PostsModal(
                    userId: Int(cdPost.userId),
                    id: Int(cdPost.id),
                    title: cdPost.title ?? "",
                    body: cdPost.body ?? "",
                    user: userModel
                )
            }
        } catch {
            print("Failed to load posts: \(error)")
            return []
        }
    }
    
    //Clear all post in LocalData
    func clearPosts() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CDPosts.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
            CoreDataHelper.shared.save()
        } catch {
            print("Failed to clear posts: \(error)")
        }
    }
    
    //Converting userModal to CdUser
    private func convertToCdUser(user: UserModal) -> CDUsers {
        if let existing = fetchCdUser(byId: user.id ?? -1) {
              return existing
          }
           let cdUser = CDUsers(context: context)
           cdUser.id = Int64(user.id ?? 0)
           cdUser.name = user.name
           cdUser.username = user.username
           cdUser.email = user.email
           cdUser.phone = user.phone
           cdUser.website = user.website
           
           if let company = user.company {
               let cdCompany = CDCompany(context: context)
               cdCompany.name = company.name ?? ""
               cdCompany.catchPhrase = company.catchPhrase ?? ""
               cdCompany.bs = company.bs ?? ""
               cdUser.company = cdCompany
           }
           
           if let address = user.address {
               let cdAddress = CDAddress(context: context)
               cdAddress.street = address.street ?? ""
               cdAddress.suite = address.suite ?? ""
               cdAddress.city = address.city ?? ""
               cdAddress.zipcode = address.zipcode ?? ""
               
               if let geo = address.geo {
                   let cdGeo = CDGeo(context: context)
                   cdGeo.lat = geo.lat ?? ""
                   cdGeo.lng = geo.lng ?? ""
                   cdAddress.geo = cdGeo 
               }
               
               cdUser.address = cdAddress
           }
           
           return cdUser
       }
    //Fetch CdUser from LocalData
    private func fetchCdUser(byId id: Int) -> CDUsers? {
        let request: NSFetchRequest<CDUsers> = CDUsers.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        return try? context.fetch(request).first
    }
}
