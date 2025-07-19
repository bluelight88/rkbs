import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../utils/constants/asset_constants.dart';
import '../../../../../utils/constants/color_constants.dart';

class DynamicSlider extends StatefulWidget {
  final List<dynamic> items;
  final String? title;
  final Axis scrollDirection;
  final bool showTileDot;
  final String Function(dynamic item) imageUrlGetter;
  final String Function(dynamic item) primaryTextGetter;
  final String Function(dynamic item) secondaryTextGetter;
  final String Function(dynamic item) badgeText;

  const DynamicSlider({
    super.key,
    required this.items,
    this.title,
    this.showTileDot = true,
    required this.scrollDirection,
    required this.imageUrlGetter,
    required this.primaryTextGetter,
    required this.secondaryTextGetter,
    required this.badgeText,
  });

  @override
  State<DynamicSlider> createState() => _DynamicSliderState();
}

class _DynamicSliderState extends State<DynamicSlider> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final int visibleItemCount = widget.items.length;
    // todo: uncomment when checked with data
    // widget.items.length > 3 ? 3 : widget.items.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: "PlusJakartaSans",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // todo: show all other element of list
                  },
                  child: Opacity(
                    opacity: 0.5,
                    child: Text(
                      "See All",
                      style: TextStyle(
                        color: ColorConstants.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontFamily: "PlusJakartaSans",
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: PageView.builder(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            scrollDirection: widget.scrollDirection,
            itemCount: visibleItemCount,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (context, index) {
              final item = widget.items[index];
              final imageUrl = widget.imageUrlGetter(item);
              final primaryText = widget.primaryTextGetter(item);
              final secondaryText = widget.secondaryTextGetter(item);
              final badgeText = widget.badgeText(item);

              return Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child:
                        imageUrl.startsWith("https")
                            ? Image.network(
                              imageUrl,
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width * 0.80,
                              fit: BoxFit.fill,
                              filterQuality: FilterQuality.medium,
                            )
                            : Image.asset(
                              AssetConstants.icBackgroundImage,
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width * 0.80,
                              fit: BoxFit.cover,
                            ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstants.whiteColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            badgeText,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              fontFamily: "PlusJakartaSans",
                              color: ColorConstants.primaryColor,
                            ),
                          ),
                        ),
                        const Gap(110),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            primaryText,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: "PlusJakartaSans",
                              color: ColorConstants.whiteColor,
                            ),
                          ),
                        ),
                        const Gap(5),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Image.asset(AssetConstants.icLocation),
                              const Gap(10),
                              Text(
                                secondaryText,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "PlusJakartaSans",
                                  color: ColorConstants.whiteColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        if (widget.showTileDot)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.items.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorConstants.primaryColor,
                    width: 1,
                  ),
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _currentIndex == index ? 10 : 6,
                  height: _currentIndex == index ? 10 : 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        _currentIndex == index
                            ? ColorConstants.primaryColor
                            : ColorConstants.whiteColor,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
