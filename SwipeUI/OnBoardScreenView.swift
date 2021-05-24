//
//  OnBoardScreenView.swift
//  SwipeUI
//
//  Created by Jorge Giannotta on 20/05/21.
//

import SwiftUI
import SwiftHEXColors

struct OnBoardScreenView: View {
    
    @State var maxWidth = UIScreen.main.bounds.width - 100
    @State var offset : CGFloat = 0
    
    var hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
    
    var body: some View {
        ZStack {
            Color(UIColor(hexString: "#262626")!)
             .ignoresSafeArea(.all, edges: .all)
            
            VStack(alignment: .center, spacing: nil, content: {
                
                Spacer(minLength: 0)
                
                Text("SLOT MACHINE")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                Text("Don't waste your time. If you are older than 18 years old swipe and make some real money. 🤑")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .padding(.bottom)
                
                Image("slot")
                
                Spacer(minLength: 0)
                
                // Slider
                
                ZStack{
                    Capsule()
                        .fill(Color.white.opacity(0.1))
                    
                    // Background Progress
                    
                    Text("SWIPE TO SPIN")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.leading, 30)
                    
                    HStack(alignment: .center, spacing: nil, content: {
                        Capsule()
                            .fill(Color(UIColor(hexString: "#D6C394")!))
                            .frame(width: calculateWidth() + 65)
                        Spacer(minLength: 0)
                    })
                    
                    HStack(alignment: .center, spacing: nil, content: {
                        ZStack{
                            Image(systemName: "chevron.right")
                            
                            Image(systemName: "chevron.right")
                                .offset(x: -10)
                        }
                        .foregroundColor(.white)
                        .offset(x: 5)
                        .frame(width: 65, height: 65)
                        .background(Color(UIColor(hexString: "#D6C394")!))
                        .clipShape(Circle())
                        .offset(x: offset)
                        .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnd(value:)))
                        
                        Spacer()
                    })
                }
                .frame(width: maxWidth, height: 65)
                .padding(.bottom)
                
            })
        }
    }
    
    func calculateWidth() -> CGFloat {
        let percent = offset / maxWidth
        
        return percent * maxWidth
    }
    
    func onChanged(value: DragGesture.Value){
        // Updating
        if value.translation.width > 0 && offset <= maxWidth - 65{
            offset = value.translation.width
        }
        
    }
    
    func onEnd(value: DragGesture.Value){
        // Back offset animation
        withAnimation(Animation.easeOut(duration: 0.3)){
            if offset > 180 {
                offset = maxWidth - 65
                
                //Notifying User
                self.hapticImpact.impactOccurred()
                //Delaying for Animation Completion
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    NotificationCenter.default.post(name: NSNotification.Name("Success"), object: nil)
                }
            }else {
                offset = 0
            }
        }
        
    }
}

struct OnBoardScreenView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardScreenView()
    }
}
