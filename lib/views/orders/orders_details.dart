import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../consts/consts.dart';
import 'components/order_placed_details.dart';
import 'components/order_status.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;

  const OrdersDetails({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1,
        title: "Order details"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(
                  color: redColor,
                  icon: Icons.done,
                  title: "Placed",
                  showOnce: data["order_placed"]),

              orderStatus(
                  color: Colors.blue,
                  icon: Icons.thumb_up,
                  title: "Confirmed",
                  showOnce:data["order_confirmed"]),
              orderStatus(
                  color: Colors.yellow,
                  icon: Icons.car_crash,
                  title: "On Delivery",
                  showOnce:data["order_on_delivery"]),
              orderStatus(
                  color: Colors.purple,
                  icon: Icons.done_all_rounded,
                  title: "Delivered",
                  showOnce:data["order_delivered"]),
              const Divider(),
              10.heightBox,
             Column(
               children: [
                 orderPlacedDetails(
                     title1: "Order Code",
                     title2: "Sipping Method",
                     d1: "${data["order_code"]}",
                     d2: "${data["shopping_method"]}"),
                 orderPlacedDetails(
                   title1: "Order Date",
                   title2: "Payment Method",
                   d1: intl.DateFormat()
                       .add_yMd()
                       .format((data["order_date"].toDate())),
                   d2: "${data["payment_method"]}",),
                 orderPlacedDetails(
                   title1: "Payment Status",
                   title2: "Delivery Status",
                   d1: "Unpaid",
                   d2:"Order Placed",),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 8),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           "Shipping Address".text.fontFamily(semibold).make(),
                           "${data["order_by_name"]}".text.make(),
                           "${data["order_by_email"]}".text.make(),
                           "${data["order_by_address"]}".text.make(),
                           "${data["order_by_city"]}".text.make(),
                           "${data["order_by_state"]}".text.make(),
                           "${data["order_by_phone"]}".text.make(),
                           "${data["order_by_postalcode"]}".text.make(),

                         ],
                       ),
                       SizedBox(
                         width: 130,
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             "Total Amount".text.fontFamily(semibold).make(),
                             "${data["total_amount"]}".text.color(redColor).fontFamily(bold).make(),
                           ],
                         ),
                       ),

                     ],
                   ),
                 ),
               ],
             ).box.outerShadowMd.white.make() ,

              const Divider(),

              10.heightBox,
              "Order Products".text.size(16).color(darkFontGrey).fontFamily(semibold).make(),
              10.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data["orders"].length, (index){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlacedDetails(
                        title1: "${data["orders"][index]["title"]}",
                        title2: "${data["orders"][index]["tprice"]}",
                        d1: "${data["orders"][index]['qty']}x",
                        d2: "Refundable",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: 30,
                          height: 10,
                          color: Color(data['orders'][index]['color']),
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                }).toList(),
              ).box.outerShadowMd.white.margin(const EdgeInsets.only(bottom: 4)).make(),
              20.heightBox,



            ],
          ),
        ),
      ),
    );
  }
}
