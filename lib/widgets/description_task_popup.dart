import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DescriptionTaskPopup extends StatefulWidget {
  final String id;
  final String textTask;
  final DateTime beginTime;
  final DateTime endTime;

  const DescriptionTaskPopup({
    Key? key,
    required this.id,
    required this.textTask,
    required this.beginTime,
    required this.endTime,
  }) : super(key: key);



  @override
  State<DescriptionTaskPopup> createState() => _DescriptionTaskPopupState();
}

class _DescriptionTaskPopupState extends State<DescriptionTaskPopup> {
  late int end;
  late int begin;
  late int current;
  late double percentTime;
  late bool timerAlive;

  @override
  void initState() {
    setState(() {
      timerAlive = true;
      end = widget.endTime.millisecondsSinceEpoch;
      begin = widget.beginTime.millisecondsSinceEpoch;
      current = DateTime.now().millisecondsSinceEpoch;
      percentTime = (current - begin) / (end - begin);
      percentTime = percentTime > 1 || percentTime < 0 ? 1 : percentTime;
    });
    super.initState();
  }

  // String getBase64RandomString(int length) {
  //   return base64UrlEncode(List<int>.generate(10, (_) => Random.secure().nextInt(255)));
  // }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('4'),
      direction: DismissDirection.down,
      // onDismissed: (_) => Navigator.of(context).pop(),
      onDismissed: (_) {
        setState(() {
          timerAlive = false;
        });
        Navigator.of(context).pop();
      },
      child: CupertinoPopupSurface(
        child: Container(
          padding: const EdgeInsetsDirectional.all(20),
          color: const Color(0xFFFFFFFF),
          alignment: Alignment.topCenter,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).copyWith().size.height * 0.7,
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFE8E8E8),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                padding: const EdgeInsets.only(
                  top: 5,
                ),
                margin: const EdgeInsets.only(
                  left: 165,
                  right: 165,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Запись',
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              if (timerAlive) CircularPercentIndicator(
                radius: 100.0,
                animation: true,
                animationDuration: 1200,
                animateFromLastPercent: true,
                lineWidth: 10.0,
                percent: _getPercentForCircleWidget(),
                center: Text(
                  widget.textTask,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: const Color(0xFFE8E8E8),
                progressColor: const Color(0xFF3BB75F),
              ),
              CupertinoButton(
                onPressed: () => Navigator.of(context, rootNavigator: true).pop("Discard"),
                child: const Text(
                  'Назад',
                  style: TextStyle(color: Color(0xFF3BB75F)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _getPercentForCircleWidget() {
    const duration = Duration(milliseconds: 1);
    Timer(duration, () {
      setState(() {
        current = DateTime.now().millisecondsSinceEpoch;
        percentTime = (current - begin) / (end - begin);
        percentTime = percentTime > 1 || percentTime < 0 ? 1 : percentTime;
      });
    });
    return percentTime;
  }
}
