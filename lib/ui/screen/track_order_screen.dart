import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syzee/global/color.dart';
import 'package:syzee/ui/widgets/appbar.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({Key? key, required this.orderNo, required this.status}) : super(key: key);

  final String orderNo;
  final double status;

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Tracking Order',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 24,
              color: Color(0xff009C95),
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'Order No. ${widget.orderNo}',
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 26,
            ),
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: SfSliderTheme(
              data: SfSliderThemeData(
                  activeTrackHeight: 2,
                  inactiveTrackHeight: 2,
                  activeDividerRadius: 6,
                  inactiveDividerRadius: 6,
                  inactiveDividerColor: ThemeColors.mediumGrey,
                  activeDividerColor: ThemeColors.primaryColorLight),
              child: TweenAnimationBuilder(
                curve: Curves.ease,
                duration: const Duration(seconds: 3),
                tween: Tween<double>(
                    begin: 0, end: widget.status == 2 || widget.status == 5 || widget.status == 6 ? 4 : widget.status),
                builder: (_, double value, __) {
                  return SfSlider.vertical(
                    min: 0.0,
                    max: widget.status == 2 || widget.status == 5 || widget.status == 6 ? 4.0 : 3.0,
                    showLabels: true,
                    interval: 1,
                    isInversed: true,
                    showDividers: true,
                    value: value,
                    labelPlacement: LabelPlacement.onTicks,
                    labelFormatterCallback: (dynamic actualValue, String formattedText) {
                      if (actualValue == 0) {
                        return 'Order Placed';
                      } else if (actualValue == 1) {
                        return 'Order Accepted';
                      } else if (actualValue == 2) {
                        return 'Order Processed';
                      } else if (actualValue == 3) {
                        return 'Delivered';
                      } else if (actualValue == 4) {
                        return 'Cancelled';
                      } else {
                        return '';
                      }
                    },
                    onChanged: (dynamic newValue) {},
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
