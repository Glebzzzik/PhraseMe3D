//
//  ARScreen.swift
//  PhraseMe3D
//
//  Created by Глеб Голощапов on 11.02.2023.
//

import SwiftUI
import RealityKit
import ARKit
import FocusEntity

struct ARScreen : View {
    
    @State private var isPlacementEnabled = false
    @State private var selectedModel: String?
    @State private var modelComfiredForPlacement: String?
    
    var models = ["tv_retro", "robot_walk_idle"]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer(modelConfirmedForPlacement: self.$modelComfiredForPlacement)
            
            if self.isPlacementEnabled {
                PlacementButtonView(isPlacementEnabled: self.$isPlacementEnabled, selectedModel: self.$selectedModel, modelComfirmedForPlacement: self.$modelComfiredForPlacement)
            } else {
                ModelPickerView(isPlacementEnabled: self.$isPlacementEnabled, selectedModel: self.$selectedModel, models: self.models)
            }
        }
    }
    
    struct ARViewContainer: UIViewRepresentable {
        
        @Binding var modelConfirmedForPlacement: String?
        
        func makeUIView(context: Context) -> ARView {
            
            let arView = CustomARView(frame: .zero)//ARView(frame: .zero)
            
            
            
            return arView
            
        }
        
        func updateUIView(_ uiView: ARView, context: Context) {
            if let modelName = self.modelConfirmedForPlacement {
                print("Debug: adding model to scene")
                
                let fileName = modelName + ".usdz"
//                let modelEntity = try! ModelEntity.loadModel(named: fileName)
                let modelEntity = try! ModelEntity.loadModel(named: "robot_walk_idle")
                
                let anchorEntity = AnchorEntity(plane: .any)
                anchorEntity.addChild(modelEntity)
                
                uiView.scene.addAnchor(anchorEntity)
                
                DispatchQueue.main.async {
                    self.modelConfirmedForPlacement = nil
                }
            }
        }
        
    }
    
    class CustomARView: ARView, FEDelegate {
        let focusSquare = FESquare()
        
        required init(frame frameRect: CGRect) {
            super.init(frame: frameRect)
            
            focusSquare.viewDelegate = self
            focusSquare.delegate = self
            focusSquare.setAutoUpdate(to: true)
            
            self.setupARView()
        }
        
        func setupARView() {
            let config = ARWorldTrackingConfiguration()
            config.planeDetection = [.horizontal, .vertical]
            config.environmentTexturing = .automatic
            
            if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
                config.sceneReconstruction = .mesh
            }
            self.session.run(config)
        }
        
        @MainActor required dynamic init?(coder decoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }


    
    struct ModelPickerView: View {
        
        @Binding var isPlacementEnabled: Bool
        @Binding var selectedModel: String?
        
        var models : [String]
        
        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                ForEach(0 ..< self.models.count) { index in
                    Button(action: {
                        print("Debug: selected model \(self.models[index])")
                        self.selectedModel = self.models[index]
                        self.isPlacementEnabled = true
                    }) {
                        Image(uiImage: UIImage(named: self.models[index])!)
                            .resizable()
                            .frame(height: 80)
                            .aspectRatio(1/1, contentMode: .fit)
                    }.buttonStyle(PlainButtonStyle())
                }
            }
            .padding(20)
            .background(Color.black.opacity(0.5))
        }
        
    }
}

struct PlacementButtonView: View {
    
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: String?
    @Binding var modelComfirmedForPlacement: String?
    
    var body: some View {
        HStack {
            Button(action: {
                print("Debug: Cancel model")
                self.resetPlacementParameters()
            }) {
                Image(systemName: "xmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            }
            
            Button(action: {
                print("Debug: Confirm model")
                self.modelComfirmedForPlacement = self.selectedModel
                self.resetPlacementParameters()
            }) {
                Image(systemName: "checkmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            }
            
        }
    }
    func resetPlacementParameters() {
        self.isPlacementEnabled = false
        self.selectedModel = nil
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ARScreen()
    }
}
#endif
