import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/utils/constants/asset_constants.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';

import '../../model/provider_detail_model.dart';

class PortfolioTab extends StatelessWidget {
  final ProviderDetailModel providerDetailModel;

  const PortfolioTab({required this.providerDetailModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.whiteColor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    AssetConstants.icBackgroundImage,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.5),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Image.asset(
                          AssetConstants.icDownload,
                          height: 15,
                          width: 15,
                        ),
                        const Spacer(),
                        Image.asset(
                          AssetConstants.icComment,
                          height: 15,
                          width: 15,
                        ),
                        const Gap(5),
                        Text(
                          "1K",
                          style: TextStyle(
                            fontSize: 14,
                            color: ColorConstants.whiteColor,
                            fontFamily: "PlusJakartaSans",
                          ),
                        ),
                        const Gap(10),
                        Image.asset(
                          AssetConstants.icLike,
                          height: 15,
                          width: 15,
                        ),
                        const Gap(5),
                        Text(
                          "12K",
                          style: TextStyle(
                            fontSize: 14,
                            color: ColorConstants.whiteColor,
                            fontFamily: "PlusJakartaSans",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
