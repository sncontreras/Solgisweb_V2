import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DropDownButtonSheet extends StatelessWidget {

  final List<Widget> widgets;
  final String textLabel;
  final String textTitle;

  const DropDownButtonSheet({
    super.key, 
    required this.widgets, 
    required this.textLabel, 
    required this.textTitle
  });

  @override
  Widget build(BuildContext context) {
    final size =  MediaQuery.of(context).size;

    return Stack(

      children: [

        GestureDetector(

          onTap: () async {
            await showMaterialModalBottomSheet(
              context: context,
              expand: false,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return Material(
                  child: SafeArea(
                    top: false,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: widgets,
                      ),
                    ),
                  )
                );
              }
            );
          },

          child: Container(
            width:  size.width * .9,
            height: size.height * .065,
            margin: EdgeInsets.symmetric(vertical: size.height * .01),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Colors.grey.shade400,
                width: 2,
              )
            ),
            child: Text(textLabel)
          ),

        ),

        Positioned(
          left: 20,
          top: 2,
          child: Container(
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            color: const Color(0xffFAFAFA),
            child: Text(
              textTitle,
              style: const TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
        ),

      ],
    );
  }

}