//
//  Artist.swift
//  Chaikovsky
//
//  Created by Алексей on 10/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation

class Artist {

    let name: String
    let description: String
    let imageName: String
    let shortBio: String
    let bio: String = ""

    init() {
        self.name = ""
        self.description = ""
        self.imageName = ""
        self.shortBio = ""
    }

    init(name: String, description: String) {
        self.name = name
        self.description = description
        self.imageName = name
        self.shortBio = ""
    }

    init(imageName: String) {
        switch imageName {
        case "rakhmaninov":
            self.shortBio = """
            Родился 1 апреля 1873 г. в усадьбе Семёнове Новгородской губернии в дворянской семье. В 1882 г. Рахманиновы перебрались в Петербург. В том же году Сергей поступил в консерваторию.

            С осени 1886 г. он стал одним из лучших учеников и получил стипендию имени Н. Г. Рубинштейна. На заключительном экзамене по гармонии П. И. Чайковскому так понравились сочинённые Рахманиновым прелюдии, что он поставил пятёрку, окружённую четырьмя плюсами.
            Наиболее значительное из ранних произведений — одноактная опера «Алеко» на сюжет А. С. Пушкина. Она была закончена в небывало короткий срок — чуть больше двух недель. Экзамен состоялся 7 мая 1892 г.; комиссия поставила Рахманинову высшую оценку, ему была присуждена Большая золотая медаль. Премьера «Алеко» в Большом театре состоялась 27 апреля 1893 г. и имела огромный успех.

            Весной 1899 г. Рахманинов закончил знаменитый Второй концерт для фортепиано с оркестром; в 1904 г. композитору была присуждена за него Глинкинская премия.
            
            В 1902 г. создана кантата «Весна» на стихотворение Н. А. Некрасова «Зелёный шум». За неё композитор также получил Глинкинскую премию в 1906 г.

            Знаменательным событием в истории русской музыки стал приход Рахманинова осенью 1904 г. в Большой театр на пост дирижёра и руководителя русского репертуара. В тот же год композитор завершил свои оперы «Скупой рыцарь» и «Франческа да Римини». После двух сезонов Рахманинов ушёл из театра и поселился сначала в Италии, а затем в Дрездене.
            Здесь была написана симфоническая поэма «Остров мёртвых». В марте 1908 г. Сергей Васильевич вошёл в состав Московской дирекции Русского музыкального общества, а осенью 1909 г., вместе с А. Н. Скрябиным и Н. К. Метнером, — в Совет Российского музыкального издательства.

            В это же время он создал хоровые циклы «Литургия святого Иоанна Златоуста» и «Всенощная».
            Осенью 1915 г. появился «Вокализ», посвящённый певице А. В. Неждановой. Всего Рахманинов написал около 80 романсов.

            В 1917 г. положение в стране обострилось, и композитор, воспользовавшись приглашением на гастроли в Стокгольм, выехал 15 декабря за границу. Он не предполагал, что покидает Россию навсегда. После гастролей по Скандинавии Рахманинов прибыл в Нью-Йорк.
            Летом 1940 г. он закончил своё последнее крупное сочинение — «Симфонические танцы».
            5 февраля 1943 г. состоялся последний концерт великого музыканта.
            Скончался 28 марта 1943 г. в Калифорнии.
            """
            self.name = "Рахманинов С. В."
            self.description = "Русский композитор, пианист, дирижёр"
            self.imageName = imageName
        default:
            self.shortBio = """
            Родился 7 мая 1840 г. в селении при Камско-Воткинском заводе (ныне город Воткинск,
            Удмуртия) в семье горного инженера. В 1850 г. семья переехала в Петербург, и Чайковский поступил в Училище правоведения, которое окончил в 1859 г.

            Он получил чин титулярного советника и место в Министерстве юстиции. Но любовь к музыке оказалась сильнее — в 1862 г. юноша сдал экзамены в только открывшуюся тогда Петербургскую консерваторию. В 1863 г. он оставил службу, а после окончания с серебряной медалью консерватории (1866 г.) был приглашён занять должность профессора в Московской консерватории.

            В 1866 г. Чайковский написал Первую симфонию («Зимние грёзы»), в 1869 г. — оперу «Воевода» и увертюру-фантазию «Ромео и Джульетта», в 1875 г. — знаменитый Первый фортепианный концерт, в 1876 г. — балет «Лебединое озеро».

            В конце 70-х гг. композитор пережил тяжёлый душевный кризис, связанный с неудачной женитьбой, в 1878 г. оставил преподавание. Тем не менее именно в этот год было создано одно из лучших его произведений — опера «Евгений Онегин» на сюжет А. С. Пушкина.
            Настоящей вершиной стала опера «Пиковая дама» (1890 г.), также на сюжет Пушкина. В 1891 г. Чайковский написал свою последнюю оперу «Иоланта». Сочинял он и музыку к балетам: «Спящая красавица», 1889 г.; «Щелкунчик», 1892 г. Взлёт Чайковского – симфониста явлен в его Шестой симфонии (1893 г.).

            Постоянно обращался композитор и к малым формам. Он автор 100 романсов, которые являются жемчужинами вокальной лирики, а также более чем 100 фортепианных пьес (в их числе циклы «Времена года», 1876 г., и «Детский альбом», 1878 г.). Творчество Чайковского было высоко оценено ещё при жизни — в 1885 г. он был избран директором Российского музыкального общества, в 1892 г. стал членом-корреспондентом французской Академии изящных искусств, в 1893 г. — почётным доктором Кембриджского университета.

            Последние годы жизни Пётр Ильич провёл в Клину под Москвой, где в 1892 г. приобрёл дом (с 1894 г. музей композитора).
            Скончался 6 ноября 1893 г. в Петербурге.
            """
            self.name = "Чайковский"
            self.description = "Великий русский композитор"
            self.imageName = imageName
        }
    }

}
