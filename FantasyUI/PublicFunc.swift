//
//  PublicFunc.swift
//  FantasyUI
//
//  Created by 赵翔宇 on 2022/1/5.
//

import Foundation

public func randomString(_ length: Int?) -> String {
    let randomLengthInt = Int.random(in: 1 ... 100)
    let letters = "　党的十三大提出了建设中国特色社会主义的经济、政治、文化三位一体的基本纲领。党的十七大确定了经济建设、政治建设、文化建设、社会建设四位一体的总体布局。党的十八大把生态文明建设提到与经济建设、政治建设、文化建设、社会建设并列的位置，从而把中国特色社会主义事业总体布局发展为“五位一体”并提出了“两个一百年”奋斗目标，即到建党一百年时，全面建成小康社会，到新中国成立一百年时，全面建成社会主义现代化强国。党的十九大将四个全面战略布局写入党章，协调推进全面建成小康社会、全面深化改革、全面依法治国、全面从严治党。这就是现阶段我们党的基本纲领，是贯彻执行党的基本路线的行动纲领和准则。党在各个阶段的基本纲领和最高纲领是辩证统一的关系。党章指出，中国共产党人追求的共产主义最高理想只有在社会主义社会充分发展和高度发达的基础上才能实现。所以，一方面我们要坚定共产主义的信念，另一方面更要脚踏实地地为实现党的基本纲领而不懈努力。"
    if length != nil { return String((0 ..< length!).map { _ in letters.randomElement()! }) }
    else {
        return String((0 ..< randomLengthInt).map { _ in letters.randomElement()! })
    }
}
