//
//  Page.swift
//  Blaze
//
//  Created by Paul Wong on 10/13/21.
//

import SwiftUI

class PagerViewModel: ObservableObject {
    
    @Published var lastDrag: CGFloat = 0.0
    @Published var currentDrag: CGFloat = 0.0
    @Published var velocity: CGFloat = 0.0
    @Published var swipeUp: Bool = false
    
    @Binding var currentIndex: Int
    
    init(currentIndex: Binding<Int>) {
        self._currentIndex = currentIndex
    }
}

struct PagerView<Content: View>: View {
    
    let pageCount: Int
    let content: Content

    @Binding var currentIndex: Int
    
    @ObservedObject var viewModel: PagerViewModel
    @GestureState private var translation: CGFloat = 0
    
    init(pageCount: Int, currentIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
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
                        withAnimation(.spring(response: 0.3, dampingFraction: 1)) { viewModel.currentIndex = indexToChangeTo }
                    } else {
                        withAnimation(.spring(response: 0.3, dampingFraction: 1)) { viewModel.lastDrag = 0 }
                    }
                }
            )
        }
    }
}

struct Swipeable<Content: View>: View {
    
    let content: Content
    
    @ObservedObject var viewModel: PagerViewModel
    @GestureState private var translation: CGFloat = 0.0
    
    @State var lastDragPosition: DragGesture.Value?
    @State var state: CGFloat = 0.0
    
    @Binding var popup: Bool
    
    init(currentIndex: Binding<Int>, popup: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._popup = popup
        self.content = content()
        
        viewModel = PagerViewModel(currentIndex: currentIndex)
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
            DragGesture().updating($translation) { value, state, _ in
                state = value.translation.height
                viewModel.lastDrag = value.translation.height
                viewModel.currentDrag = value.translation.height

                if (popup && viewModel.currentDrag < -1) || (!popup && viewModel.currentDrag > 1) {
                    viewModel.lastDrag = 0
                }
                
                if viewModel.lastDrag/(value.predictedEndLocation.y - value.location.y) < 0 {
                    viewModel.swipeUp = false
                } else {
                    viewModel.swipeUp = true
                }
                
                print(viewModel.swipeUp)
                print(viewModel.lastDrag/(value.predictedEndLocation.y - value.location.y))
            }.onEnded { value in
                viewModel.velocity = viewModel.lastDrag/(value.predictedEndLocation.y - value.location.y)
                
                withAnimation(
                    .spring(response:
                                abs(viewModel.velocity) < 0.39 ?
                            viewModel.velocity : 0.39, dampingFraction: 0.79)) {
                            if viewModel.lastDrag < -100.0 {
                                popup = true
                            } else if viewModel.lastDrag > 100.0 {
                                popup = false
                            }
                        }
                withAnimation(.spring(response: 0.3, dampingFraction: 0.9)) { viewModel.lastDrag = 0 }
            }
        )
    }
}
