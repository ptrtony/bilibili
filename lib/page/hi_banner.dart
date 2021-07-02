import 'package:blibli_app/model/home_model.dart';
import 'package:blibli_app/navigator/hi_navigator.dart';
import 'package:blibli_app/utils/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

class HiBanner extends StatelessWidget {
  final List<BannerMo> bannerList;
  final double bannerHeight;
  final EdgeInsetsGeometry padding;

  const HiBanner(this.bannerList,
      {Key key, this.bannerHeight = 160, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bannerHeight,
      child: _banner(),
    );
  }

  _banner() {
    var right = 5 + (padding?.horizontal ?? 0) / 2;
    return Swiper(
      itemCount: bannerList.length,
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return _image(bannerList[index]);
      },
      //自定义指示器
      pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(right: right, bottom: 10),
          builder: DotSwiperPaginationBuilder(
              color: Colors.white60,
              size: 6,
              activeColor: Colors.white,
              activeSize: 6)),
    );
  }

  _image(BannerMo bannerMo) {
    return InkWell(
      onTap: () {
        showToast(bannerMo.title);
        _handleClick(bannerMo);
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(bannerMo.cover, fit: BoxFit.cover)),
    );
  }

  void _handleClick(BannerMo bannerMo) {
    if (bannerMo.type == "video") {
      HiNavigator.getInstance().onJumpTo(RouteStatus.detail,
          args: {"videoMo": VideoMo(vid: bannerMo.url)});
    }else{
      _launchURL(bannerMo.url);
    }
  }


  void _launchURL(String _url) async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
}
