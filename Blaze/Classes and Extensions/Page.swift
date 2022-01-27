//
//  Page.swift
//  Blaze
//
//  Created by Paul Wong on 10/13/21.
//

import SwiftUI

class PagerViewModel: ObservableObject {
    
    @Published var lastDrag: CGFloat = 0.0
    
    @Binding var currentIndex: Int
    
    init(currentIndex: Binding<Int>) {
        self._currentIndex = currentIndex
    }
}

class SwipeableModel: ObservableObject {
    
    @Published var lastDrag: CGFloat = 0.0
    @Published var currentDrag: CGFloat = 0.0
    @Published var velocity: CGFloat = 0.0
    @Published var accel: CGFloat = 0.0
    @Published var swipeUp: Bool = false
}

struct PagerView<Content: View>: View {

    @ObservedObject var viewModel: PagerViewModel

    @Binding var currentIndex: Int
    @Binding var secondaryShow: Bool
    @Binding var showFireInformation: String
    @Binding var showContacts: Bool
    @Binding var showGlossary: Bool

    let pageCount: Int
    let content: Content

    @GestureState private var translation: CGFloat = 0
    
    init(pageCount: Int, currentIndex: Binding<Int>, secondaryShow: Binding<Bool>, showFireInfomation: Binding<String>, showContacts: Binding<Bool>, showGlossary: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._showFireInformation = showFireInfomation
        self._showContacts = showContacts
        self._showGlossary = showGlossary
        self._currentIndex = currentIndex
        self._secondaryShow = secondaryShow
        self.content = content()
        viewModel = PagerViewModel(currentIndex: currentIndex)
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .top, spacing: -11) {
                content.frame(width: geometry.size.width-11)
            }
            .frame(width: geometry.size.width-11, alignment: .leading)
            .offset(x:
                viewModel.currentIndex == pageCount - 1 ?
                    (-CGFloat(viewModel.currentIndex) * (geometry.size.width - 11*2.5)) + viewModel.lastDrag :
                        (-CGFloat(viewModel.currentIndex) * (geometry.size.width - 22)) + viewModel.lastDrag
            )
            .highPriorityGesture(
                DragGesture().updating($translation) { value, state, _ in
                    state = value.translation.width
                    viewModel.lastDrag = value.translation.width
                }.onEnded { value in
                    let offset = value.predictedEndTranslation.width / geometry.size.width
                    let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
                    let newIndexBound = min(max(Int(newIndex), 0), self.pageCount - 1)
                    let indexToChangeTo = min(max(newIndexBound, currentIndex - 1), currentIndex + 1)
                    if indexToChangeTo != viewModel.currentIndex {
                        showGlossary = false
                        showContacts = false
                        secondaryShow = false

                        withAnimation(.spring(response: 0.3, dampingFraction: 1)) {
                            viewModel.currentIndex = indexToChangeTo
                        }
                    } else {
                        withAnimation(.spring(response: 0.3, dampingFraction: 1)) {
                            viewModel.lastDrag = 0
                        }
                    }
                }
            )
        }
    }
}

struct Swipeable<Content: View>: View {
    
    let content: Content
    
    @ObservedObject var viewModel: SwipeableModel
    @GestureState private var translation: CGFloat = 0.0
    
    @State var lastDragPosition: DragGesture.Value?
    @State var state: CGFloat = 0.0
    @State private var bandingConstant: CGFloat = 7 // End state banding constant
    @State private var hitBox: CGFloat = UIScreen.main.bounds.maxY*0.72 // Area restriction
    
    @Binding var popup: Bool
    
    init(popup: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._popup = popup
        self.content = content()
        
        viewModel = SwipeableModel()
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            
            content
        }
        .offset(
            y: viewModel.lastDrag
        )
        .highPriorityGesture(
            DragGesture(minimumDistance: 30, coordinateSpace: .local)
                .updating($translation) { value, _, _ in
                    withAnimation(.linear(duration: 0.1)) {
                        viewModel.swipeUp = value.predictedEndLocation.y - value.location.y < 0 ? true : false
                        viewModel.lastDrag = min(max(value.translation.height, -hitBox), hitBox)
                        
                        if popup && viewModel.lastDrag < -1 || !popup && viewModel.lastDrag > 1 {
                            viewModel.lastDrag = value.translation.height/8
                        }

                        if value.translation.height > hitBox {
                            viewModel.lastDrag = (viewModel.lastDrag - (hitBox/5)) + (value.translation.height/5)
                        } else if value.translation.height < -hitBox {
                            viewModel.lastDrag = (viewModel.lastDrag + (hitBox/bandingConstant)) + (value.translation.height/bandingConstant)
                        }
                    }
                }
                .onEnded { value in
                    viewModel.accel = abs(viewModel.lastDrag/(value.predictedEndLocation.y - value.location.y))
                    viewModel.velocity = value.predictedEndLocation.y - value.location.y

                    withAnimation(
                        .spring(
                            response: (viewModel.accel < 0.39) && (viewModel.accel > 0.27) ? viewModel.accel : 0.39,
                            dampingFraction: 0.79
                        )) {
                            if (viewModel.velocity < -100.0) || (viewModel.swipeUp && viewModel.velocity < 0.39) {
                                popup = true
                            } else if (viewModel.velocity > 100.0) || (!viewModel.swipeUp && viewModel.velocity > 0.39) {
                                popup = false
                            }
                        }

                    withAnimation(.spring(response: 0.3, dampingFraction: 0.9)) { viewModel.lastDrag = 0 }
                }
        )
    }
}
