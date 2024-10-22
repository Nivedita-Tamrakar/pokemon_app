import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RotatingImageWidget extends StatefulWidget {
  const RotatingImageWidget({super.key, this.imagePath = 'images/pokeball.png'});
  final String imagePath;

  @override
  State<RotatingImageWidget> createState() => _RotatingImageWidgetState();
}

class _RotatingImageWidgetState extends State<RotatingImageWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller; // to initialze it later hence using late
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this,duration: const Duration(seconds: 2))
    ..repeat();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: _controller, 
    builder: (context,child)
    {
      return Transform.rotate(angle: _controller.value * 2 * 3.14, child: Image.asset(widget.imagePath,width: 220,),);
    });
  }
  @override
  void dispose(){
     _controller.dispose();
    super.dispose();
  }
}