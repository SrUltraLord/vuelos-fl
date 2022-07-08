import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

import '../ui/box_decorations.dart';

class LoadingFlightCard extends StatelessWidget {
  const LoadingFlightCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorations.cardDecoration,
      child: SkeletonItem(
        child: Column(
          children: [
            const _TitleRow(),
            Container(
              height: 16,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: const Divider(
                height: 2,
                color: Colors.black54,
              ),
            ),
            const _CitiesRow(),
          ],
        ),
      ),
    );
  }
}

class _TitleRow extends StatelessWidget {
  const _TitleRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SkeletonLine(
          style: SkeletonLineStyle(
            height: 32,
            width: 100,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
            child: SkeletonLine(
          style: SkeletonLineStyle(
            height: 16,
            width: 32,
            borderRadius: BorderRadius.circular(8),
          ),
        )),
        SkeletonLine(
            style: SkeletonLineStyle(
          height: 24,
          width: 80,
          borderRadius: BorderRadius.circular(4),
        ))
      ],
    );
  }
}

class _CitiesRow extends StatelessWidget {
  const _CitiesRow({
    Key? key,
  }) : super(key: key);

  SkeletonLineStyle dateStyle() {
    return SkeletonLineStyle(
      width: 100,
      height: 16,
      borderRadius: BorderRadius.circular(8),
      alignment: AlignmentDirectional.center,
    );
  }

  SkeletonLineStyle timeStyle() {
    return SkeletonLineStyle(
      width: 50,
      height: 16,
      borderRadius: BorderRadius.circular(8),
      alignment: AlignmentDirectional.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _ColumnItem(),
        Expanded(
            child: Column(
          children: [
            const _AirplaneIcon(),
            SkeletonLine(style: dateStyle()),
            const SizedBox(height: 8),
            SkeletonLine(style: timeStyle()),
          ],
        )),
        const _ColumnItem()
      ],
    );
  }
}

class _AirplaneIcon extends StatelessWidget {
  const _AirplaneIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.center, children: const [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Divider(
          thickness: 2,
          color: Colors.black12,
        ),
      ),
      RotatedBox(
        quarterTurns: 1,
        child: Icon(
          Icons.airplanemode_active_rounded,
          size: 64,
          color: Colors.blueAccent,
        ),
      ),
    ]);
  }
}

class _ColumnItem extends StatelessWidget {
  const _ColumnItem({Key? key}) : super(key: key);

  SkeletonLineStyle titleStyle() {
    return const SkeletonLineStyle(height: 32, width: 64);
  }

  SkeletonLineStyle subtitleStyle() {
    return SkeletonLineStyle(
        height: 16, width: 40, borderRadius: BorderRadius.circular(8));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 8),
        Column(
          children: [
            SkeletonLine(style: titleStyle()),
            const SizedBox(height: 8),
            SkeletonLine(style: subtitleStyle()),
          ],
        ),
      ],
    );
  }
}
