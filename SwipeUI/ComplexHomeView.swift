//
//  ComplexHomeView.swift
//  SwipeUI
//
//  Created by Jorge Giannotta on 24/05/21.
//

import SwiftUI

struct ComplexHomeView: View {
    
    @State var firstSpin = "🍑"
    @State var secondSpin = "🍍"
    @State var thirdSpin = "🍒"
    //@State var coins = 25
    @State var result = " "
    @AppStorage("store_coins") var coins = 25
    @State var bet = 0
    let arrayObjects = ["🍑","🍍","🍒","🥭","💵"]
    var hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
    
    var body: some View {
        VStack(alignment: .center, spacing: nil, content: {
            Image("slot")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150, alignment: .center)
            Spacer(minLength: 0)
            
            Group{
                
                Text("Coins: \(coins)")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.bottom, 15)
                HStack(alignment: .center, spacing: 10, content: {
                    Text(firstSpin)

                    Text(secondSpin)
                        
                    Text(thirdSpin)
                        
                })
                .font(.system(size: 80))
                
                Spacer(minLength: 0)
                
                Text("\(result)")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
                
            }
            
            Spacer(minLength: 0)
            
            Group{
                Text("Bet \(bet)")
                    .foregroundColor(.white)
                    .font(.title2)
                HStack(alignment: .center, spacing: 10, content: {
                    Button(action: {
                        if coins >= 1{
                            bet = 1
                            self.hapticImpact.impactOccurred()
                        }
                    }, label: {
                        Capsule()
                            .foregroundColor(Color(UIColor(hexString: "B0B6BB")!))
                            .frame(width: 80, height: 50, alignment: .center)
                            .overlay(
                                Text("1".uppercased())
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            )
                    })
                    Button(action: {
                        if coins >= 5{
                            bet = 5
                            self.hapticImpact.impactOccurred()
                        }
                    }, label: {
                        Capsule()
                            .foregroundColor(Color(UIColor(hexString: "B0B6BB")!))
                            .frame(width: 80, height: 50, alignment: .center)
                            .overlay(
                                Text("5".uppercased())
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            )
                    })
                    Button(action: {
                        if coins >= coins/2{
                            bet = coins/2
                            self.hapticImpact.impactOccurred()
                        }
                    }, label: {
                        Capsule()
                            .foregroundColor(Color(UIColor(hexString: "B0B6BB")!))
                            .frame(width: 80, height: 50, alignment: .center)
                            .overlay(
                                Text("50%".uppercased())
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            )
                    })
                })
                .padding(.vertical)
                
                Button(action: {
                    self.hapticImpact.impactOccurred(intensity: .pi)
                    if coins >= bet && bet > 0 {
                        firstSpin = arrayObjects.randomElement()!
                        secondSpin = arrayObjects.randomElement()!
                        thirdSpin = arrayObjects.randomElement()!
                        coins -= bet
                    }
                    coins = checkWin()
                }, label: {
                    Capsule()
                        .foregroundColor(Color(UIColor(hexString: "F99A00")!))
                        .frame(width: 250, height: 100, alignment: .center)
                        .overlay(
                            Text("Spin".uppercased())
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                        )
                })
                
                Spacer(minLength: 0)
                
                Button(action: {
                    if coins <= 0 {
                    coins += 25
                    }
                }, label: {
                    if coins <= 0 {
                        Capsule()
                            .foregroundColor(Color(UIColor(hexString: "31A343")!))
                            .frame(width: 150, height: 50, alignment: .center)
                            .overlay(
                                Text("More Coins".uppercased())
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                        )
                    } else {
                        Capsule()
                            .foregroundColor(Color(UIColor(hexString: "AF442F")!))
                            .frame(width: 150, height: 50, alignment: .center)
                            .overlay(
                                Text("More Coins".uppercased())
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            )
                    }
                })
            }
            
        })
        .frame(maxWidth: .infinity)
        .background(Color(UIColor(hexString: "#262626")!).edgesIgnoringSafeArea(.all))
        
    }
    func checkWin() -> Int {
        var coin : Int = 0
        if firstSpin == secondSpin && secondSpin == thirdSpin && thirdSpin == "💵" {
            coins += bet * 25
            result = "\(bet * 25) coins win"
            
            coin = coins
        }
        else if firstSpin == secondSpin && secondSpin == thirdSpin {
            coins += bet * 5
            result = "\(bet * 5) coins win"
            coin = coins
        }
        else if firstSpin == secondSpin || secondSpin == thirdSpin{
            coins += bet * 2
            result = "\(bet * 2) coins win"
            coin = coins
        }
        else {
            coin = coins
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            result = " "
        }
        
        return coin
    }
}

struct ComplexHomeView_Previews: PreviewProvider {
    static var previews: some View {
        ComplexHomeView()
    }
}
