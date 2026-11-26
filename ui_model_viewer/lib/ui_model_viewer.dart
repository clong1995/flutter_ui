import 'package:material_ui/material_ui.dart';
import 'package:thermion_flutter/thermion_flutter.dart';

class ModelViewer extends StatelessWidget {
  const new({required this.modelPath, super.key});

  final String modelPath;

  @override
  Widget build(BuildContext context) {
    return ViewerWidget(
      // GLB 模型路径
      assetPath: modelPath,

      // 初始摄像机位置
      //initialCameraPosition: Vector3(0, 0, 5),

      // 背景颜色
      //background: Colors.white,

      // 加载过程中的占位界面
      initial: const Center(child: CircularProgressIndicator()),

      // Viewer 初始化完成
      onViewerAvailable: (viewer) async {
        debugPrint('3D Viewer 初始化完成');
      },

      // 模型加载完成
      onAssetLoaded: (viewer, asset) async {
        debugPrint('3D 模型加载完成');
      },
    );
  }
}
