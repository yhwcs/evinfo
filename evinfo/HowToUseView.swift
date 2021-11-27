//
//  HowToUseView.swift
//  evinfo
//
//  Created by yhw on 2021/11/26.
//

import SwiftUI

struct HowToUseView: View {
    var body: some View {
        //ScrollView{
            VStack(alignment: .leading, spacing: 15){
                Text("충전기 이용방법")
                    .font(.title3)
                    .foregroundColor(.green)
                List{
                    Section(header:
                        Text("회원카드")
                    ){
                        Text("전기차 충전기에서 회원인증을 하기 위한 카드")
                    }
                    Section(header:
                        Text("결제카드")
                    ){
                        Text("충전요금을 내기 위한 카드")
                        Text("(일반 신용, 체크 카드)")
                    }
                    Section(header:
                        Text("카드 준비 절차")
                    ){
                        Text("1. 충전 사업자 회원 가입")
                        Text("2. 회원카드 발급\n    또는 기존카드를 인증용으로 등록")
                        Text("3. 결제카드 등록")
                    }
                    Section(header:
                        Text("충전 기본 절차")
                    ){
                        Text("1. 충전 방식 선택")
                        Text("2. 회원/비회원 인증")
                        Text(" • 회원\n   회원카드 터치\n   또는 회원카드 번호 입력")
                        Text(" • 비회원\n   후불 교통카드 기능을 지원하는 결제카드 터치")
                        Text("3. 충전 플러그 꽂음")
                        Text("4. 충전 완료 후 내역 확인")
                        Text("5. 충전 플러그 원위치")
                    }
                }
            }.padding(20)
       // }
    }
}

struct PaymentMethodView_Previews: PreviewProvider {
    static var previews: some View {
        HowToUseView()
    }
}
