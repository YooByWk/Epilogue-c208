import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/screens/memorial/memorial_photo_upload.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_detail_phototab_viewmodel.dart';
import 'package:provider/provider.dart';

class PhotoTabCard extends StatelessWidget {
  final _storage = FlutterSecureStorage();

  final String photoPath;
  final int index;
  final int photoSeq;

  PhotoTabCard({
    Key? key,
    required this.photoPath,
    required this.index,
    required this.photoSeq,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OverlayEntry? overlayEntry;

    return Card(
      child: GestureDetector(
        // 카드 누를 때 storage에 저장해서 api 요청에 사용할 거에용~
        onTap: () {
          _storage.write(key: 'photoSeq', value: photoSeq.toString());
          Navigator.pushNamed(context, '/memorialPhotoDetail', arguments: {
            'index': photoSeq,
          });
        },
        onLongPress: () {
          overlayEntry = OverlayEntry(
            builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.1,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(photoPath),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
            ),
          );
          Overlay.of(context).insert(overlayEntry!);
        },
        onLongPressEnd: (details) {
          overlayEntry?.remove();
        },
        child:
        Image.network(photoPath),
      ),
    );
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
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        if (index == 0) {
                          return Card(
                              child: InkWell(
                                  onTap: () async {
                                        // debugPrint('add Photo Button Clicked'),
                                        bool uploaded = await (Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MemorialPhotoUpload(),
                                          ),
                                        ));
                                        if (uploaded == true) {
                                          viewModel.loadInitialData();
                                        };
                                        
                                      },
                                  child: Center(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                        Icon(Icons.add),
                                        SizedBox(height: 15),
                                        Text('추모관 사진 추가')
                                      ]))));
                        } else {
                          return PhotoTabCard(
                            key: ValueKey(index),
                            photoPath: viewModel.photos[index - 1].s3url,
                            index: index,
                            photoSeq: viewModel.photos[index - 1].memorialPhotoSeq,
                          );
                        }
                      },
                      childCount: viewModel.photos.length + 1,
                    ),
                  ),
                ],
              ));
        }));
  }
}
