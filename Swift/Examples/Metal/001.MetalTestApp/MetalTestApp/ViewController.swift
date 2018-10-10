//
//  ViewController.swift
//  MetalTestApp
//
//  Created by Jared Bruni on 10/8/18.
//  Copyright © 2018 Jared Bruni. All rights reserved.
//

import UIKit
import Metal
import QuartzCore


class ViewController: UIViewController {

    var metal_dev:MTLDevice! = nil
    var vertex_buffer: MTLBuffer! = nil
    var pipe_line_state: MTLRenderPipelineState! = nil
    var metal_layer: CAMetalLayer! = nil
    var command_queue: MTLCommandQueue! = nil
    var timer: CADisplayLink! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        metal_dev = MTLCreateSystemDefaultDevice()
        metal_layer = CAMetalLayer()
        metal_layer.device = metal_dev;
        metal_layer.framebufferOnly = true
        metal_layer.pixelFormat = .bgra8Unorm
        metal_layer.frame = view.layer.frame
        view.layer.addSublayer(metal_layer)
        let vertex_data:[Float] = [
            0.0, 0.5, 0.0,
            -0.5, -0.5, 0.0,
            0.5, -0.5, 0.0
        ]
        let data_size = vertex_data.count * MemoryLayout.size(ofValue: vertex_data[0])
        vertex_buffer = metal_dev.makeBuffer(bytes: vertex_data, length: data_size, options: .storageModeShared)
        let defaultLibrary = metal_dev.makeDefaultLibrary()
        let fragmentProgram = defaultLibrary!.makeFunction(name: "basic_fragment")
        let vertexProgram = defaultLibrary!.makeFunction(name: "basic_vertex")
        let pipe_sd = MTLRenderPipelineDescriptor()
        pipe_sd.vertexFunction = vertexProgram
        pipe_sd.fragmentFunction = fragmentProgram
        pipe_sd.colorAttachments[0].pixelFormat = .bgra8Unorm
        do {
        try
        	pipe_line_state = metal_dev.makeRenderPipelineState(descriptor: pipe_sd)
        }
        catch let error {
            print("Failed to create pipeline state \(error)")
        }
        command_queue = metal_dev.makeCommandQueue()
        timer = CADisplayLink(target:self, selector:#selector(ViewController.game_loop))
        timer.add(to: RunLoop.main, forMode:RunLoopMode.defaultRunLoopMode)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func render() {
        let render_pd = MTLRenderPassDescriptor()
        guard let drawable = metal_layer.nextDrawable() else { return }
        render_pd.colorAttachments[0].texture = drawable.texture
        render_pd.colorAttachments[0].loadAction = .clear
        render_pd.colorAttachments[0].clearColor = MTLClearColor(red: 221.0/255.0, green: 160.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        let command_buf = command_queue.makeCommandBuffer()
        let render_encoder = command_buf?.makeRenderCommandEncoder(descriptor: render_pd)
        render_encoder?.setRenderPipelineState(pipe_line_state)
        render_encoder?.setVertexBuffer(vertex_buffer, offset: 0, index: 0)
        render_encoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3)
        render_encoder?.endEncoding()
        command_buf?.present(drawable);
        command_buf?.commit()
    }
    
    @objc func game_loop() {
        autoreleasepool {
            self.render()
        }
    }

}

