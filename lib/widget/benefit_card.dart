import 'package:blibli_app/model/profile_mo.dart';
import 'package:blibli_app/model/profile_mo.dart';
import 'package:blibli_app/utils/view_util.dart';
import 'package:blibli_app/widget/hi_blur.dart';
import 'package:flutter/material.dart';

class BenefitCard extends StatelessWidget {
  final List<BenefitList> benefitList;

  const BenefitCard({Key key, this.benefitList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        children: [_buildText(),
          _buildBenefitCard(context)
        ],
      ),
    );
  }

  _buildText() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Row(
        children: [
          Text(
            "增值服务",
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          hiSpace(width: 10),
          Text(
            "购买后登录慕课网再次点击打开看看",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          )
        ],
      ),
    );
  }

  _buildCard(BuildContext context, BenefitList mo, double width) {
    return InkWell(
      onTap: (){

      },
      child: Padding(padding: EdgeInsets.only(right: 5),
      child: ClipRRect(borderRadius: BorderRadius.circular(5),
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: 60,
        decoration: BoxDecoration(color: Colors.deepPurple),
        child: Stack(
          children: [
            Positioned.fill(child: HiBlur(sigma: 20,)),
            Positioned(child: Center(child: Text(mo.name,style: TextStyle(fontSize: 16,color: Colors.white),),))
          ],
        ),
      ),),),
    );
  }

  // _buildBenefitList(BuildContext context) {
  //   return Container(
  //     height: 60,
  //     child: Row(children: [
  //       ..._buildBenefitCard(context)
  //     ],),
  //   );
  // }


  _buildBenefitCard(BuildContext context){
    var width = (MediaQuery.of(context).size.width -
        20 -
        (benefitList.length - 1) * 5) /
        benefitList.length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...benefitList.map((mo){
         return _buildCard(context, mo, width);
        }).toSet()
      ],
    );
  }
}
