import Foundation
import CoreData
struct ReviewDataModel {
    
    var title: String
    var review: String
    var data: String
    var scope: Double
    
}

//let oneperson = ReviewDataModel(title: "라이프 사진전 : 더 라스트 프린트", review: "굳", data: "4 MAR 2019", scope: Double(5.0))


//let context = persistentContainer.viewContext
//let entitiy = NSEntityDescription.entity(forEntityName: "Contact", in: context)!
//let review = NSManagedObject(entity: entitiy, insertInto: context)
//review.setValue(oneperson.title, forKey: "title")
//review.setValue(oneperson.data, forKey: "data")
//review.setValue(oneperson.review, forKey: "review")
//review.setValue(oneperson.scope, forKey: "scope")

//if let entitiy = entitiy {
//    let review = NSManagedObject(entity: entitiy, insertInto: context)
//    review.setValue(oneperson.title, forKey: "title")
//    review.setValue(oneperson.data, forKey: "data")
//    review.setValue(oneperson.review, forKey: "review")
//    review.setValue(oneperson.scope, forKey: "scope")
//
//    do {
//
//        try context.save()
//
//    } catch {
//        print(error.localizedDescription)
//    }
//
//
//}

//        setReviewList(title: "라이프 사진전 : 더 라스트 프린트", review: "와 진짜 ! 너무 좋았어요 ㅎㅎ ", data: "4 MAR 2019", scope: Double(5.0))
//        setReviewList(title: "칸딘스키와 함께하는 색채여행", review: "색감이 넘 이뻐요 ", data: "9 MAY 2020", scope: Double(4.5))
//        setReviewList(title: "모네, 르누아르... 샤갈", review: "흠 가지마세요 별루,,", data: "2 JAN 2021", scope: Double(1.0))
//        setReviewList(title: "수퍼네이처 - 부산", review: "쩝스바리~", data: "4 MAR 2019", scope: Double(0.5))
//        setReviewList(title: "카유보트: 향기를 만나다", review: "향기가 납니다", data: "4 MAR 2019", scope: Double(4.0))
//var reviewList:[ReviewDataModel] = [oneperson]

//
//var persistentContainer: NSPersistentContainer = {
//    let container = NSPersistentContainer(name: "ReviewModel"); container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//    if let error = error as NSError? {
//    fatalError("Unresolved error \(error), \(error.userInfo)")
//        
//    }
//        
//    })
//    return container
//    
//}()
//// MARK: - Core Data Saving support
//func saveContext () {
//    let context = persistentContainer.viewContext
//    if context.hasChanges {
//        do {
//            try context.save()
//            
//        } catch { // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        let nserror = error as NSError
//        fatalError("Unresolved error \(nserror), \(nserror.userInfo)") } }
//}
