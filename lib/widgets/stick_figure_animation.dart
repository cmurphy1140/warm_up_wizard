import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/routine_models.dart';

class StickFigureJoint {
  static const String head = 'head';
  static const String neck = 'neck';
  static const String leftShoulder = 'left_shoulder';
  static const String rightShoulder = 'right_shoulder';
  static const String leftElbow = 'left_elbow';
  static const String rightElbow = 'right_elbow';
  static const String torso = 'torso';
  static const String hips = 'hips';
  static const String leftHip = 'left_hip';
  static const String rightHip = 'right_hip';
  static const String leftKnee = 'left_knee';
  static const String rightKnee = 'right_knee';
  static const String leftAnkle = 'left_ankle';
  static const String rightAnkle = 'right_ankle';
}

class StickFigurePose {
  final Map<String, double> jointAngles;
  final String? description;

  const StickFigurePose({
    required this.jointAngles,
    this.description,
  });

  factory StickFigurePose.fromJson(Map<String, dynamic> json) {
    return StickFigurePose(
      jointAngles: Map<String, double>.from(json['jointAngles'] ?? {}),
      description: json['description'],
    );
  }

  static StickFigurePose get neutral => StickFigurePose(
    jointAngles: {
      StickFigureJoint.head: 0,
      StickFigureJoint.neck: 0,
      StickFigureJoint.leftShoulder: 0,
      StickFigureJoint.rightShoulder: 0,
      StickFigureJoint.leftElbow: 0,
      StickFigureJoint.rightElbow: 0,
      StickFigureJoint.torso: 0,
      StickFigureJoint.hips: 0,
      StickFigureJoint.leftHip: 0,
      StickFigureJoint.rightHip: 0,
      StickFigureJoint.leftKnee: 0,
      StickFigureJoint.rightKnee: 0,
      StickFigureJoint.leftAnkle: 0,
      StickFigureJoint.rightAnkle: 0,
    },
    description: "Neutral standing position",
  );

  StickFigurePose interpolate(StickFigurePose other, double t, [String easing = 'ease-in-out']) {
    final easedT = _applyEasing(t, easing);
    
    final interpolatedAngles = <String, double>{};
    
    // Interpolate all joint angles
    for (final joint in StickFigureJointExtension.getAllJoints()) {
      final startAngle = jointAngles[joint] ?? 0.0;
      final endAngle = other.jointAngles[joint] ?? 0.0;
      interpolatedAngles[joint] = _lerpAngle(startAngle, endAngle, easedT);
    }

    return StickFigurePose(
      jointAngles: interpolatedAngles,
      description: "Interpolated pose",
    );
  }

  double _applyEasing(double t, String easing) {
    switch (easing) {
      case 'linear':
        return t;
      case 'ease-in':
        return t * t;
      case 'ease-out':
        return 1 - (1 - t) * (1 - t);
      case 'ease-in-out':
      default:
        return t < 0.5 ? 2 * t * t : 1 - 2 * (1 - t) * (1 - t);
    }
  }

  double _lerpAngle(double start, double end, double t) {
    // Handle angle wrapping for smooth transitions
    double diff = end - start;
    if (diff > 180) {
      diff -= 360;
    } else if (diff < -180) {
      diff += 360;
    }
    return start + diff * t;
  }
}

extension StickFigureJointExtension on StickFigureJoint {
  static List<String> getAllJoints() {
    return [
      StickFigureJoint.head,
      StickFigureJoint.neck,
      StickFigureJoint.leftShoulder,
      StickFigureJoint.rightShoulder,
      StickFigureJoint.leftElbow,
      StickFigureJoint.rightElbow,
      StickFigureJoint.torso,
      StickFigureJoint.hips,
      StickFigureJoint.leftHip,
      StickFigureJoint.rightHip,
      StickFigureJoint.leftKnee,
      StickFigureJoint.rightKnee,
      StickFigureJoint.leftAnkle,
      StickFigureJoint.rightAnkle,
    ];
  }
}

class StickFigureAnimationWidget extends StatefulWidget {
  final String? keyframesJson;
  final double speed;
  final bool isPlaying;
  final double size;
  final Color color;

  const StickFigureAnimationWidget({
    super.key,
    this.keyframesJson,
    this.speed = 1.0,
    this.isPlaying = true,
    this.size = 200.0,
    this.color = Colors.blue,
  });

  @override
  State<StickFigureAnimationWidget> createState() => _StickFigureAnimationWidgetState();
}

class _StickFigureAnimationWidgetState extends State<StickFigureAnimationWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  List<MovePose> _poses = [];

  @override
  void initState() {
    super.initState();
    _setupAnimation();
    _loadKeyframes();
  }

  void _setupAnimation() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );

    if (widget.isPlaying) {
      _controller.repeat();
    }
  }

  void _loadKeyframes() {
    if (widget.keyframesJson != null) {
      try {
        final keyframesData = jsonDecode(widget.keyframesJson!);
        if (keyframesData['poses'] != null) {
          _poses = (keyframesData['poses'] as List)
              .map((poseData) => MovePose.fromJson(poseData))
              .toList();
          
          // Calculate total animation duration
          final totalDuration = _poses.fold(0, (sum, pose) => sum + pose.durationMs);
          _controller.duration = Duration(
            milliseconds: (totalDuration / widget.speed).round(),
          );
          
          if (widget.isPlaying) {
            _controller.repeat();
          }
        }
      } catch (e) {
        // Fallback to default poses if JSON parsing fails
        _poses = _getDefaultPoses();
      }
    } else {
      _poses = _getDefaultPoses();
    }
  }

  List<MovePose> _getDefaultPoses() {
    return [
      MovePose(
        name: 'neutral',
        keyframes: [
          MoveKeyframe(
            id: 'start',
            jointAngles: StickFigurePose.neutral.jointAngles,
            description: 'Standing ready',
          ),
        ],
        durationMs: 1000,
      ),
      MovePose(
        name: 'slight_movement',
        keyframes: [
          MoveKeyframe(
            id: 'move',
            jointAngles: {
              ...StickFigurePose.neutral.jointAngles,
              StickFigureJoint.leftShoulder: 15,
              StickFigureJoint.rightShoulder: -15,
            },
            description: 'Slight arm movement',
          ),
        ],
        durationMs: 1000,
      ),
    ];
  }

  @override
  void didUpdateWidget(StickFigureAnimationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (oldWidget.speed != widget.speed) {
      final totalDuration = _poses.fold(0, (sum, pose) => sum + pose.durationMs);
      _controller.duration = Duration(
        milliseconds: (totalDuration / widget.speed).round(),
      );
    }
    
    if (oldWidget.isPlaying != widget.isPlaying) {
      if (widget.isPlaying) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
    
    if (oldWidget.keyframesJson != widget.keyframesJson) {
      _loadKeyframes();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  StickFigurePose _getCurrentPose() {
    if (_poses.isEmpty) return StickFigurePose.neutral;
    
    final totalDuration = _poses.fold(0, (sum, pose) => sum + pose.durationMs);
    final currentTime = (_animation.value * totalDuration).round();
    
    int elapsedTime = 0;
    for (int i = 0; i < _poses.length; i++) {
      final pose = _poses[i];
      if (currentTime <= elapsedTime + pose.durationMs) {
        final poseProgress = (currentTime - elapsedTime) / pose.durationMs;
        
        if (pose.keyframes.isNotEmpty) {
          // For now, use the first keyframe of each pose
          // In a more sophisticated version, we'd interpolate between keyframes within the pose
          final startPose = StickFigurePose(
            jointAngles: pose.keyframes.first.jointAngles,
          );
          
          // Interpolate with the next pose if available
          if (i < _poses.length - 1 && _poses[i + 1].keyframes.isNotEmpty) {
            final nextPose = StickFigurePose(
              jointAngles: _poses[i + 1].keyframes.first.jointAngles,
            );
            return startPose.interpolate(nextPose, poseProgress, pose.easing);
          } else {
            return startPose;
          }
        }
      }
      elapsedTime += pose.durationMs;
    }
    
    return StickFigurePose.neutral;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final currentPose = _getCurrentPose();
          return CustomPaint(
            painter: StickFigurePainter(
              pose: currentPose,
              color: widget.color,
            ),
            size: Size(widget.size, widget.size),
          );
        },
      ),
    );
  }
}

class StickFigurePainter extends CustomPainter {
  final StickFigurePose pose;
  final Color color;

  StickFigurePainter({
    required this.pose,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final scale = size.width / 200; // Normalize to 200px reference size

    // Define body proportions (relative to size)
    final headRadius = 15 * scale;
    final torsoLength = 60 * scale;
    final armLength = 40 * scale;
    final legLength = 50 * scale;

    // Calculate joint positions based on angles
    final headCenter = Offset(
      center.dx,
      center.dy - torsoLength - headRadius,
    );

    // Draw head
    canvas.drawCircle(headCenter, headRadius, paint);

    // Torso
    final shoulderCenter = Offset(center.dx, center.dy - torsoLength / 2);
    final hipCenter = Offset(center.dx, center.dy + torsoLength / 2);
    
    canvas.drawLine(shoulderCenter, hipCenter, paint);

    // Arms
    _drawLimb(canvas, paint, shoulderCenter, armLength * 0.6, armLength * 0.4,
        pose.jointAngles[StickFigureJoint.leftShoulder] ?? 0,
        pose.jointAngles[StickFigureJoint.leftElbow] ?? 0,
        isLeft: true);
        
    _drawLimb(canvas, paint, shoulderCenter, armLength * 0.6, armLength * 0.4,
        pose.jointAngles[StickFigureJoint.rightShoulder] ?? 0,
        pose.jointAngles[StickFigureJoint.rightElbow] ?? 0,
        isLeft: false);

    // Legs
    _drawLimb(canvas, paint, hipCenter, legLength * 0.6, legLength * 0.4,
        pose.jointAngles[StickFigureJoint.leftHip] ?? 0,
        pose.jointAngles[StickFigureJoint.leftKnee] ?? 0,
        isLeft: true, isLeg: true);
        
    _drawLimb(canvas, paint, hipCenter, legLength * 0.6, legLength * 0.4,
        pose.jointAngles[StickFigureJoint.rightHip] ?? 0,
        pose.jointAngles[StickFigureJoint.rightKnee] ?? 0,
        isLeft: false, isLeg: true);
  }

  void _drawLimb(
    Canvas canvas,
    Paint paint,
    Offset origin,
    double upperLength,
    double lowerLength,
    double upperAngle,
    double lowerAngle,
    {
      required bool isLeft,
      bool isLeg = false,
    }
  ) {
    // Convert angles to radians and adjust for coordinate system
    final upperRad = (upperAngle - 90) * pi / 180;
    final lowerRad = lowerAngle * pi / 180;
    
    // Add side offset for left/right limbs
    final sideOffset = isLeft ? -10.0 : 10.0;
    final startPoint = Offset(origin.dx + sideOffset, origin.dy);
    
    // Calculate joint position (elbow/knee)
    final jointX = startPoint.dx + upperLength * cos(upperRad);
    final jointY = startPoint.dy + upperLength * sin(upperRad);
    final jointPoint = Offset(jointX, jointY);
    
    // Calculate end position (hand/foot)
    final endAngle = upperRad + lowerRad;
    final endX = jointX + lowerLength * cos(endAngle);
    final endY = jointY + lowerLength * sin(endAngle);
    final endPoint = Offset(endX, endY);
    
    // Draw upper limb (arm/thigh)
    canvas.drawLine(startPoint, jointPoint, paint);
    
    // Draw lower limb (forearm/shin)
    canvas.drawLine(jointPoint, endPoint, paint);
    
    // Draw joint circles
    canvas.drawCircle(jointPoint, 2.0, paint);
    canvas.drawCircle(endPoint, 2.0, paint);
  }

  @override
  bool shouldRepaint(StickFigurePainter oldDelegate) {
    return oldDelegate.pose != pose || oldDelegate.color != color;
  }
}