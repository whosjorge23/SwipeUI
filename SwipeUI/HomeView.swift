//
//  HomeView.swift
//  SwipeUI
//
//  Created by Jorge Giannotta on 21/05/21.
//

import SwiftUI

struct HomeView: View {
    @State var firstSpin = "🍑"
    @State var secondSpin = "🍍"
    @State var thirdSpin = "🍒"
    //@State var coins = 25
    @State var result = " "
    @AppStorage("store_coins") var coins = 25
    let arrayObjects = ["🍑","🍍","🍒","🥭","💵"]
    var hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
    
    var body: some View {
        VStack(alignment: .center, spacing: nil, content: {
            Image("slot")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150, alignment: .center)
            Spacer(minLength: 0)
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
            
            Spacer(minLength: 0)
            
            Button(action: {
                self.hapticImpact.impactOccurred(intensity: .pi)
                if coins > 0 {
                    firstSpin = arrayObjects.randomElement()!
                    secondSpin = arrayObjects.randomElement()!
                    thirdSpin = arrayObjects.randomElement()!
                    coins -= 1
                }
                coins = checkWin()
            }, label: {
                Capsule()
                    .foregroundColor(Color(UIColor(hexString: "D93829")!))
                    .frame(width: 250, height: 100, alignment: .center)
                    .overlay(
                        Text("Spin".uppercased())
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                    )
            })
            Spacer(minLength: 0)
            if coins <= 0 {
                Button(action: {
                    coins += 25
                    self.hapticImpact.impactOccurred()
                }, label: {
                    Capsule()
                        .foregroundColor(Color(UIColor(hexString: "AF442F")!))
                        .frame(width: 150, height: 50, alignment: .center)
                        .overlay(
                            Text("More Coins".uppercased())
                                .foregroundColor(.white)
                                .font(.title3)
                                .fontWeight(.semibold)
                        )
                })
            }
        })
        .frame(maxWidth: .infinity)
        .background(Color(UIColor(hexString: "#262626")!).edgesIgnoringSafeArea(.all))
        
    }
    func checkWin() -> Int {
        var coin : Int = 0
        if firstSpin == secondSpin && secondSpin == thirdSpin && thirdSpin == "💵" {
            coins += 25
            result = "\(25) coins win"
            
            coin = coins
        }
        else if firstSpin == secondSpin && secondSpin == thirdSpin {
            coins += 5
            result = "\(5) coins win"
            coin = coins
        }
        else if firstSpin == secondSpin || secondSpin == thirdSpin{
            coins += 2
            result = "\(2) coins win"
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
