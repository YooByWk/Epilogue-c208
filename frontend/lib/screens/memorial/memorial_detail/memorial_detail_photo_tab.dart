import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_detail_phototab_viewmodel.dart';
import 'package:provider/provider.dart';

class PhotoTabCard extends StatelessWidget {
  final String photoPath;
  final int index;

  PhotoTabCard({
    Key? key,
    required this.photoPath,
    required this.index,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(child: Image.asset(photoPath));
  }
}

/////////////////////////////////

class PhotoTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => PhotoTabViewModel(),
        child:
            Consumer<PhotoTabViewModel>(builder: (context, viewModel, child) {
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent - 50) {
                viewModel.loadMore();
              }
              return false;
            },
            child: 
            CustomScrollView( 
              slivers: <Widget>[
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                    if (index == 0) {
                      return Card(
                        child : InkWell(
                          onTap: () => {
                            debugPrint('add Photo Button Clicked'),
                            viewModel.testAPI()
                          } ,

                          child : Center(                        child : Column ( 
                            mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Icon(Icons.add),
                        SizedBox(height: 15),
                        Text('추모관 사진 추가')
                          ])
                      )
                  ));
                  } 
               else { return PhotoTabCard(
                  key : ValueKey(index),
                  photoPath: viewModel.photos[index],
                  index: index,
                );
             }}
              , childCount: viewModel.photos.length,
              ),
            ),
            ],)
          );
        }));
  }
}
