// MARK: 식단 메뉴
import Foundation


struct MealDay: Equatable, Hashable {
    var dayName: String
}

struct Menu: Equatable, Hashable {
    var menuId: Int
    var date: String
    var lunch: String
    var dinner: String
}

//let menu = [
//    Menu(menuId: 1, date: "2024년 8월 5일", lunch: "쌀밥 맑은미역국 돈육김치찜 사천식가지볶음 마카로니샐러드 배추김치", dinner: "쌀밥 팽이장국 콩나물불고기 허니버터웨지감자 양념깻잎지 배추김치"),
//    Menu(menuId: 2, date: "2024년 8월 6일", lunch: "쌀밥 부대찌개 꼬마돈가스/케찹 찰떡가마보꼬 꼬시래기초무침 배추김치", dinner: "쌀밥 콩나물냉국 언양식불고기/파채 핫도그/케찹 무짠지무침 배추김치"),
//    Menu(menuId: 3, date: "2024년 8월 6일", lunch: "쌀밥 맑은미역국 돈육김치찜 사천식가지볶음 마카로니샐러드 배추김치", dinner: "쌀밥 팽이장국 콩나물불고기 허니버터웨지감자 양념깻잎지 배추김치"),
//    Menu(menuId: 4, date: "2024년 8월 7일", lunch: "쌀밥 맑은미역국 돈육김치찜 사천식가지볶음 마카로니샐러드 배추김치", dinner: "쌀밥 팽이장국 콩나물불고기 허니버터웨지감자 양념깻잎지 배추김치"),
//    Menu(menuId: 5, date: "2024년 8월 8일", lunch: "쌀밥 맑은미역국 돈육김치찜 사천식가지볶음 마카로니샐러드 배추김치", dinner: "쌀밥 팽이장국 콩나물불고기 허니버터웨지감자 양념깻잎지 배추김치"),
//    Menu(menuId: 6, date: "2024년 8월 9일", lunch: "쌀밥 맑은미역국 돈육김치찜 사천식가지볶음 마카로니샐러드 배추김치", dinner: "쌀밥 팽이장국 콩나물불고기 허니버터웨지감자 양념깻잎지 배추김치"),
//    Menu(menuId: 7, date: "2024년 8월 10일", lunch: "쌀밥 맑은미역국 돈육김치찜 사천식가지볶음 마카로니샐러드 배추김치", dinner: "쌀밥 팽이장국 콩나물불고기 허니버터웨지감자 양념깻잎지 배추김치")
//]

