import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/main.dart';
import 'package:frontend/view_models/will_view_models/viewer_viewmodel.dart';
import 'package:provider/provider.dart';

class WillViewerWidget extends StatelessWidget {
  final ViewerViewModel viewModel;


  WillViewerWidget({
    required this.viewModel,

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 10,
          ),
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.9,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: themeColour3.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 20),
                    Text(
                      '성함',
                      style: TextStyle(
                        fontSize: 20,
                        color: themeColour4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) => viewModel.setViewerName(value),
                        style: TextStyle(
                          decorationThickness: 0,
                          fontSize: 20,
                          color: themeColour5,
                        ),
                        decoration: InputDecoration(
                          hintText: '이싸피',
                          hintStyle: TextStyle(
                              color: themeColour4.withOpacity(0.8)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 20),
                    Text(
                      '번호',
                      style: TextStyle(
                        fontSize: 20,
                        color: themeColour4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) => viewModel.setViewerMobile(value),
                        style: TextStyle(
                          decorationThickness: 0,
                          fontSize: 20,
                          color: themeColour5,
                        ),
                        decoration: InputDecoration(
                          hintText: '01012345678',
                          hintStyle: TextStyle(
                              color: themeColour4.withOpacity(0.8)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 20),
                    Text(
                      '이메일',
                      style: TextStyle(
                        fontSize: 20,
                        color: themeColour4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) => viewModel.setViewerEmail(value),
                        style: TextStyle(
                          decorationThickness: 0,
                          fontSize: 20,
                          color: themeColour5,
                        ),
                        decoration: InputDecoration(
                          hintText: 'ssafy@samsung.com',
                          hintStyle: TextStyle(
                              color: themeColour4.withOpacity(0.8)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
