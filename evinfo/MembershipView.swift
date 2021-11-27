//
//  MembershipView.swift
//  evinfo
//
//  Created by yhw on 2021/11/26.
//

import SwiftUI

struct MembershipView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            Text("회원가입 및 카드발급")
                .font(.title3)
                .foregroundColor(.green)
            List{
                Section(header:
                    HStack{
                        Text("한국자동차환경협회(환경부)")
                        Link(destination: URL(string: "https://www.ev.or.kr/")!,
                             label: {
                                Image(systemName: "link")
                                    .foregroundColor(.blue)
                        })
                    }
                ){
                    Text("가입: 우측 상단 '회원가입'")
                        .font(.callout)
                    Text("회원카드: '마이페이지 > 회원카드 관리'에서 회원카드 발급 관리")
                        .font(.callout)
                    Text("결제카드: '마이페이지 > 결제카드 관리'에서 결제에 사용할 카드 등록")
                        .font(.callout)
                }

                Section(header:
                    HStack{
                        Text("한국전기차충전서비스(해피차저)")
                        Link(destination: URL(string: "https://www.happecharger.co.kr/")!,
                             label: {
                                Image(systemName: "link")
                                .foregroundColor(.blue)
                        })
                    }
                ){
                    Text("가입: 우측 상단 '회원가입'")
                        .font(.callout)
                    Text("회원카드: '회원서비스 > 멤버십정보'에서 가입 시 발급된 회원카드 확인")
                        .font(.callout)
                    Text("결제카드: '회원서비스 > 결제카드정보'에서 결제에 사용할 카드 등록")
                    .font(.callout)
                }

                Section(header:
                    HStack{
                        Text("한국전력공사(켑코플러그)")
                        Link(destination: URL(string: "https://evc.kepco.co.kr:4445/")!,
                             label: {
                                Image(systemName: "link")
                                .foregroundColor(.blue)
                        })
                    }
                ){
                    Text("가입: 우측 상단 '로그인' → 하단의 '회원가입'")
                        .font(.callout)
                    Text("회원카드: '마이페이지 > 내정보/간편결제관리 > 충전카드'에서 인증용으로 사용할 타사 회원카드 등록")
                        .font(.callout)
                    Text("✳︎ 한전은 자사 회원카드 발급을 실시하지 않음")
                        .font(.callout)
                    Text("결제카드: '마이페이지 > 내정보/간편결제관리 > 결제카드'에서 결제에 사용할 카드 등록")
                        .font(.callout)
                    Text("✳︎ 아파트 한전 충전기는 로밍이 안되므로 충전카드 및 결제카드 등록을 모두 마쳐야 사용 가능")
                        .font(.callout)
                }

                Section(header:
                    HStack{
                        Text("차지비(구 포스코ICT, 현 (주)차지비)")
                        Link(destination: URL(string: "https://www.chargev.co.kr/")!,
                             label: {
                                Image(systemName: "link")
                                    .foregroundColor(.blue)
                        })
                    }
                ){
                    Text("가입: 우측 상단 '회원가입'")
                        .font(.callout)
                    Text("회원카드: 'MY 차지비 > 마이페이지 > 멤버십 카드'에서 가입 시 발급된 회원카드 확인")
                        .font(.callout)
                    Text("결제카드: 'MY 차지비 > 마이페이지 > 결제용 신용카드'에서 결제에 사용할 카드 등록")
                        .font(.callout)
                }

                Section(header:
                    HStack{
                        Text("대영채비")
                        Link(destination: URL(string: "https://www.chaevi.co.kr/")!,
                             label: {
                                Image(systemName: "link")
                                    .foregroundColor(.blue)
                        })
                    }
                ){
                    Text("가입: 우측 상단 '회원가입'")
                        .font(.callout)
                    Text("회원카드: '내정보 > 회원인증'에서 자사 회원카드 발급 또는 인증용으로 사용할 타사 회원카드 등록")
                        .font(.callout)
                    Text("결제카드: '내정보 > 간편결제'에서 결제에 사용할 카드 등록")
                        .font(.callout)
                }

                Section(header:
                    HStack{
                        Text("에버온")
                        Link(destination: URL(string: "https://www.everon.co.kr/")!,
                             label: {
                                Image(systemName: "link")
                                    .foregroundColor(.blue)
                        })
                    }
                ){
                    Text("가입: 우측 상단 '개인회원가입'")
                        .font(.callout)
                    Text("회원카드: '마이페이지 > 회원카드 및 결제카드 관리 > 회원카드 정보'에서 가입 시 발급된 회원카드 확인")
                        .font(.callout)
                    Text("결제카드: '마이페이지 > 회원카드 및 결제카드 관리 > 결제정보'에서 결제에 사용할 카드 등록")
                        .font(.callout)
                }

                Section(header:
                    HStack{
                        Text("지엔텔(지차저)")
                        Link(destination: URL(string: "https://www.gcharger.net/")!,
                             label: {
                                Image(systemName: "link")
                                    .foregroundColor(.blue)
                        })
                    }
                ){
                    Text("가입: 우측 상단 '개인회원가입' 또는 지차저 애플리케이션에서 가입")
                        .font(.callout)
                    Text("회원카드: 어플리케이션 'MENU > (본인이름) > 하단 회원카드 조회/발급'에서 자사 회원카드 발급")
                        .font(.callout)
                    Text("✳︎ 어플리케이션으로 충전기 사용 시 별도 회원카드 불필요")
                        .font(.callout)
                    Text("결제카드: 어플리케이션 'MENU > 결제카드등록'에서 결제에 사용할 카드 등록")
                        .font(.callout)
                }

                Section(header:
                    HStack{
                        Text("에스트래픽(SS차저)")
                        Link(destination: URL(string: "https://sscharger.co.kr/")!,
                             label: {
                                Image(systemName: "link")
                                    .foregroundColor(.blue)
                        })
                    }
                ){
                    Text("가입: 우측 상단 '개인회원가입' 또는 지차저 어플리케이션에서 가입")
                        .font(.callout)
                    Text("회원카드: '마이페이지 > 멤버십 카드 관리'에서 가입 시 발급된 회원카드 확인")
                        .font(.callout)
                    Text("결제카드: '마이페이지 > 개인회원 정보변경 > 신용카드'에서 결제에 사용할 카드 등록")
                        .font(.callout)
                }

                Section(header:
                    HStack{
                        Text("클린일렉스(K차저)")
                        Link(destination: URL(string: "https://kcharger.net/")!,
                             label: {
                                Image(systemName: "link")
                                    .foregroundColor(.blue)
                        })
                    }
                ){
                    Text("가입: 우측 상단 'Join' 또는 K차저 어플리케이션에서 가입")
                        .font(.callout)
                    Text("회원카드: 어플리케이션 우측 상단 아이콘 '마이페이지 > 회원로밍카드등록'에서 인증용으로 쓸 타사 회원카드 등록")
                        .font(.callout)
                    Text("결제카드: 어플리케이션 우측 상단 아이콘 '마이페이지 > 회원로밍카드등록'에서 인증용으로 쓸 타사 회원카드 등록")
                        .font(.callout)
                }
            }
            Spacer()
        }.padding(20)
    }
}

struct MembershipView_Previews: PreviewProvider {
    static var previews: some View {
        MembershipView()
    }
}
